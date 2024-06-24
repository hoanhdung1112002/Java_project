/**
 * show error message
 * @param {*} mess
 */
function showMessage(type = 'success', mess = null, callback = function () {}, appTime = 1500) {
    $('#alert-error').addClass('d-none');
    // $('html').animate({
    //     scrollTop: $(".main").offset().top
    // });

    if(type === 'success' && mess === null) {
        mess = "Cập nhật thông tin thành công";
    }

    if(type === 'error' && mess === null) {
        mess = "Thất bại! Đã có lỗi xảy ra";
    }

    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: appTime,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });

    Toast.fire({
        icon: type,
        title: mess
    }).then(() => {
        callback();
    });
}

/**
 * HandleErrorValid 
 */
function handleErrorValid(xhr) {
    $('.error-message').remove();
    if (xhr.status === 400 && xhr.responseJSON.errors) {
        const errorMessages = xhr.responseJSON.errors;

        for (let fieldName in errorMessages) {
            const input = $(`#${fieldName}`);

            let item = $('<label>', {
                'class': 'mt-1 w-100 text-danger error-message',
                html: errorMessages[fieldName][0]
            });

            input.css('border', '1px solid red');
            input.after(item);
        }
    } else {
        showMessage("error");
    }
}

/**
 * Focus remove error messages
 */
$(document).ready(function () {
    $(document).on('focus', 'input, textarea', function () {
        $(this).next('.error-message').remove();
        $(this).css('border', '');
    });
});

 
// Not edit common library
/**
 * Common dataTables
 */
$(document).ready(function () {
    const dataTables = $('.data-tables');
    if (dataTables.length > 0) {
        dataTables.DataTable({
            "language": {
                "search": "Tìm kiếm: ",
                "info": "Từ _START_ đến _END_ trong tổng _TOTAL_ mục",
                "lengthMenu": "Hiển thị _MENU_ mục",
                "paginate": {
                    "previous": "Trước",
                    "next": "Tiếp",
                },
                "emptyTable": "Không có nội dung",
                "zeroRecords": "Không có nội dung"
            },
            "lengthMenu": [[5, 10, 20, 50, -1], [5, 10, 20, 50, "Tất cả"]],
        });
    }
});

/**
 * Common dataTables
 */
$(document).ready(function () {
    const tiny = $('.tinymce-editor');
    if (tiny.length > 0) {
        tinymce.init({
            selector: '.tinymce-editor',
            plugins: 'preview importcss searchreplace autolink directionality code visualblocks visualchars fullscreen image link media template codesample table charmap pagebreak nonbreaking anchor insertdatetime advlist lists wordcount help charmap quickbars emoticons',
            editimage_cors_hosts: ['picsum.photos'],
            menubar: 'file edit view insert format tools table help',
            toolbar: 'undo redo | bold italic underline strikethrough | fontfamily fontsize blocks | alignleft aligncenter alignright alignjustify | outdent indent |  numlist bullist | forecolor backcolor removeformat | pagebreak | charmap emoticons | fullscreen  preview print | insertfile image media template link anchor codesample | ltr rtl',
            toolbar_sticky: true,
            placeholder: 'Mời bạn nhập nội dung',
            highlight_on_focus: false,
            min_height: 300,
            height: 300,
            resize: true,
            image_title: true,
            automatic_uploads: true,
            file_picker_types: 'image',
            file_picker_callback: function (cb, value, meta) {
                var input = document.createElement('input');
                input.setAttribute('type', 'file');
                input.setAttribute('accept', 'image/*');
                input.onchange = function () {
                    var file = this.files[0];
                    var reader = new FileReader();
    
                    reader.onload = function () {
                        var id = 'blobid' + (new Date()).getTime();
                        var blobCache = tinymce.activeEditor.editorUpload.blobCache;
                        var base64 = reader.result.split(',')[1];
                        var blobInfo = blobCache.create(id, file, base64);
                        blobCache.add(blobInfo);
                        cb(blobInfo.blobUri(), { title: file.name });
                    };
                    reader.readAsDataURL(file);
                };
                input.click();
            },
            setup: function (editor) {
                editor.on('focusin', function (e) {
                    if ($(e.target).closest(".tox-tinymce-aux, .moxman-window, .tam-assetmanager-root").length) {
                        e.stopImmediatePropagation();
                    }
                });
            }
        });
    }
});
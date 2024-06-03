window.grab = () => {
  getDrawContext().canvas.toBlob((blob) => {
    const a = document.createElement('a');
    document.body.appendChild(a);
    a.href = window.URL.createObjectURL(blob);
    a.download = 'canvas.png';
    a.click();
  });
};

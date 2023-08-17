if (document.URL.match(/new/)){
  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {  
      const imageElement = document.getElementById('new-image'); 
    }; 
    
    
    document.getElementById('event_event_image').addEventListener('change', (e) =>{
     const file = e.target.files[0];  
      const blob = window.URL.createObjectURL(file); 
      createImageHTML(blob); 
    });
  });
}
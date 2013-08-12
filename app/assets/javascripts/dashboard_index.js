function reescalaDivCompetencias(){
    var heightBandeiras = $('#container_bandeiras_rodape').height();
    var heightContainer = $('#container_competencias_e_bandeiras').height();
    $('#container_colunas_competencias').height(heightContainer - heightBandeiras);
};

window.onload = function()
{
	reescalaDivCompetencias();
	$(window).resize(reescalaDivCompetencias);
};
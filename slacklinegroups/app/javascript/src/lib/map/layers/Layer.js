/**
 * Base class which defines basic functionality for any given layer on the map.
 */
class Layer
{
  // Supported events that a layer can subscribe to by overriding 'get subscribedEvents()'
  static get CLICK () { return 'click'; }
  static get ZOOMEND () { return 'zoomend'; }

  get layerId () { throw new Error('layerId must be defined'); }
  get subscribedEvents () { throw new Error('You must define what events the layer should subscribe to. Return [] in the case of no events'); }

  /**
   * Returns a configuration object to be used my mapboxgl.Map#addLayer
   * 
   * @param {string} sourceId the unique ID of the source to be used
   * @returns {Object}
   * 
   * @see https://docs.mapbox.com/mapbox-gl-js/api/map/#map#addlayer
   */
  config(sourceId) { throw new Error('config() must be implemented'); }

  /**
   * Function factory for delegating events to handlers defined in a layer
   *
   * @param {string} eventType 
   * @param {mapboxgl.Map} map 
   */
  getEventHandler(eventType, map) {
    if (!this.subscribedEvents.includes(eventType)) {
      throw new Error(`Layer ${this.layerId} is attempting to handle an event it does not subscribe to: ${eventType}`);
    }

    switch (eventType) {
      case Layer.CLICK:
        return this.handleClick.bind(this, map);
      case Layer.ZOOMEND:
        return this.handleZoomEnd.bind(this, map);
    }
  }

  /**
   * Handler called when 'get subscribedEvents()' returns Layer.CLICK
   *
   * @param {mapboxgl.Map} map 
   * @param {Object} event
   */
  handleClick(map, event) { throw new Error('handleClick() must be implemented when subscribed'); }

  /**
   * Handler called when 'get subscribedEvents()' returns Layer.ZOOMEND
   *
   * @param {mapboxgl.Map} map 
   * @param {Object} event 
   */
  handleZoomEnd(map, event) { throw new Error('handleZoomEnd() must be implemented when subscribed'); }
}

export default Layer;
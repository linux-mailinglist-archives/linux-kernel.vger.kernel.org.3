Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340705A6D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiH3T2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiH3T2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:28:00 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4F852816
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jw/BMXkk2bSHu/Tn+I+6WJ+P0/BJrbEZIqETssOewfE=; b=FepPHpMH52mF3S0z0Dm1b4Eacx
        9+AXytqqf2FpuKYbi23zay3TpsN1Qa5Q9ZkzqxJjCttzr9TbuU3Y1j/0qcm5VAs+WPWFBSs8c7qjs
        Ow5sr31xj7N3A3bvEX668fQGtcUvcKdM7cSj52sWE9TkD0gMAMWjUAfsp32+l7lCQ85m/Me1gusc1
        Bijp7ApUsaRAyASgzl0JpYLAKf134opQ/OVT9w+laZNSwPdSYEqPkUXnZ6oc+o6ps0anvP72eR/Hi
        lxMQf2MbxPx9Kg5GtUca4Efma7JwlR1CB4y7YhlP5O2HKvik27Ie2kJPKAzIuX4xEJIwxTGRSCnOv
        X+uONqhA==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=64134)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oT6tW-0001t3-6u; Tue, 30 Aug 2022 21:27:30 +0200
Message-ID: <8d99b275-d0c2-c7be-5abc-8db17f8792ad@tronnes.org>
Date:   Tue, 30 Aug 2022 21:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 06/41] drm/connector: Rename legacy TV property
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-6-459522d653a7@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-6-459522d653a7@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.08.2022 15.11, skrev Maxime Ripard:
> The current tv_mode has driver-specific values that don't allow to
> 
> easily share code using it, either at the userspace or kernel level.
> 
> 
> 
> Since we're going to introduce a new, generic, property that fit the
> 
> same purpose, let's rename this one to legacy_tv_mode to make it
> 
> obvious we should move away from it.
> 
> 
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 

> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> 
> index 1d5e3cccb9e3..5cfad8b6ad83 100644
> 
> --- a/include/drm/drm_connector.h
> 
> +++ b/include/drm/drm_connector.h
> 
> @@ -695,7 +695,7 @@ struct drm_connector_tv_margins {
> 
>   * @select_subconnector: selected subconnector
> 
>   * @subconnector: detected subconnector
> 
>   * @margins: TV margins
> 
> - * @mode: TV mode
> 
> + * @legacy_mode: Legacy TV mode, driver specific value
> 
>   * @brightness: brightness in percent
> 
>   * @contrast: contrast in percent
> 
>   * @flicker_reduction: flicker reduction in percent
> 
> @@ -707,7 +707,7 @@ struct drm_tv_connector_state {
> 
>  	enum drm_mode_subconnector select_subconnector;
> 
>  	enum drm_mode_subconnector subconnector;
> 
>  	struct drm_connector_tv_margins margins;
> 
> -	unsigned int mode;
> 
> +	unsigned int legacy_mode;

I suggest you do a build of the affected drivers after adding this patch
to make sure you have changed all mode -> legacy_mode occurrences
_before_ adding back mode in a later patch.

A simple grep gave me these:

drivers/gpu/drm/vc4/vc4_vec.c:
vc4_vec_tv_modes[state->tv.mode].mode);
drivers/gpu/drm/vc4/vc4_vec.c:  vec->tv_mode =
&vc4_vec_tv_modes[conn_state->tv.mode];
drivers/gpu/drm/vc4/vc4_vec.c:  vec_mode =
&vc4_vec_tv_modes[conn_state->tv.mode];
drivers/gpu/drm/i915/display/intel_tv.c:        int format =
conn_state->tv.mode;
drivers/gpu/drm/i915/display/intel_tv.c:
connector->state->tv.mode = i;
drivers/gpu/drm/i915/display/intel_tv.c:        if (old_state->tv.mode
!= new_state->tv.mode ||
drivers/gpu/drm/i915/display/intel_tv.c:        state->tv.mode =
initial_mode;
drivers/gpu/drm/i915/display/intel_tv.c:
   state->tv.mode);
drivers/gpu/drm/i915/display/intel_sdvo.c:      format_map = 1 <<
conn_state->tv.mode;
drivers/gpu/drm/i915/display/intel_sdvo.c:      format_map = 1 <<
conn_state->tv.mode;
drivers/gpu/drm/i915/display/intel_sdvo.c:                      if
(state->tv.mode == intel_sdvo_connector->tv_format_supported[i]) {
drivers/gpu/drm/i915/display/intel_sdvo.c:              state->tv.mode =
intel_sdvo_connector->tv_format_supported[val];
drivers/gpu/drm/i915/display/intel_sdvo.c:
intel_sdvo_connector->base.base.state->tv.mode =
intel_sdvo_connector->tv_format_supported[0];

Not so easy to grep for is this in gud:

static unsigned int *gud_connector_tv_state_val(u16 prop, struct
drm_tv_connector_state *state)
{
	switch (prop) {
...
	case GUD_PROPERTY_TV_MODE:
		return &state->mode;

Noralf.

> 
>  	unsigned int brightness;
> 
>  	unsigned int contrast;
> 
>  	unsigned int flicker_reduction;
> 
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> 
> index 6b5e01295348..35a827175c24 100644
> 
> --- a/include/drm/drm_mode_config.h
> 
> +++ b/include/drm/drm_mode_config.h
> 
> @@ -714,11 +714,13 @@ struct drm_mode_config {
> 
>  	 * between different TV connector types.
> 
>  	 */
> 
>  	struct drm_property *tv_select_subconnector_property;
> 
> +
> 
>  	/**
> 
> -	 * @tv_mode_property: Optional TV property to select
> 
> +	 * @legacy_tv_mode_property: Optional TV property to select
> 
>  	 * the output TV mode.
> 
>  	 */
> 
> -	struct drm_property *tv_mode_property;
> 
> +	struct drm_property *legacy_tv_mode_property;
> 
> +
> 
>  	/**
> 
>  	 * @tv_left_margin_property: Optional TV property to set the left
> 
>  	 * margin (expressed in pixels).
> 
> 
> 

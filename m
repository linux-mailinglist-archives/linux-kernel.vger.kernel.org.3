Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F6577D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiGRIhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiGRIhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:37:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE6219290
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658133463; x=1689669463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=svJzOs7lLK8VfxKlVR9L8K4CdAyx/d3LOgCV8X0yj/I=;
  b=jUZ0yddl+qDU9XG0LJsyVmbSXVFr7vb4uhke7t09/5NlVBHB1S+zAHKY
   paPZul8Aq+g9jcimWGRgbp4g9bb7g2UopmVQ9ojP68Lu7JhZ9hUCJUyvd
   +pvE31E2sO7NIp16gKkCSIsOI25gTMBpt+MBTxAg/3BI6SWwxZx9RE7ZU
   AyI6EaMtNxf5IWl9FWfzUkxx5DSSn+qFySIwhbEZDk1PPkhs2lMjQdEoK
   1GYnvO6gHSN1imb/ssVNvQPZhOnF1jx+eL3qwC/DNsKigvZrLpG/Vz0tW
   DC2Uoj0nUjOiwKMyiR0MlrR7C/UvsF2u077xdwAp0wKK5Gcp40dlhXJa0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269191076"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="269191076"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 01:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="739385494"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 18 Jul 2022 01:37:31 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Jul 2022 11:37:31 +0300
Date:   Mon, 18 Jul 2022 11:37:31 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_typec: Rename port altmode
 array
Message-ID: <YtUbyy4j/23XgsIc@kuha.fi.intel.com>
References: <20220712210318.2671292-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712210318.2671292-1-pmalani@chromium.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 09:03:17PM +0000, Prashant Malani wrote:
> Rename "p_altmode" to "port_altmode" which is a less ambiguous name for
> the port_altmode struct array.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index d6088ba447af..b9848e80f372 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -60,8 +60,7 @@ struct cros_typec_port {
>  	uint8_t mux_flags;
>  	uint8_t role;
>  
> -	/* Port alt modes. */
> -	struct typec_altmode p_altmode[CROS_EC_ALTMODE_MAX];
> +	struct typec_altmode port_altmode[CROS_EC_ALTMODE_MAX];
>  
>  	/* Flag indicating that PD partner discovery data parsing is completed. */
>  	bool sop_disc_done;
> @@ -282,16 +281,16 @@ static void cros_typec_register_port_altmodes(struct cros_typec_data *typec,
>  	struct cros_typec_port *port = typec->ports[port_num];
>  
>  	/* All PD capable CrOS devices are assumed to support DP altmode. */
> -	port->p_altmode[CROS_EC_ALTMODE_DP].svid = USB_TYPEC_DP_SID;
> -	port->p_altmode[CROS_EC_ALTMODE_DP].mode = USB_TYPEC_DP_MODE;
> +	port->port_altmode[CROS_EC_ALTMODE_DP].svid = USB_TYPEC_DP_SID;
> +	port->port_altmode[CROS_EC_ALTMODE_DP].mode = USB_TYPEC_DP_MODE;
>  
>  	/*
>  	 * Register TBT compatibility alt mode. The EC will not enter the mode
>  	 * if it doesn't support it, so it's safe to register it unconditionally
>  	 * here for now.
>  	 */
> -	port->p_altmode[CROS_EC_ALTMODE_TBT].svid = USB_TYPEC_TBT_SID;
> -	port->p_altmode[CROS_EC_ALTMODE_TBT].mode = TYPEC_ANY_MODE;
> +	port->port_altmode[CROS_EC_ALTMODE_TBT].svid = USB_TYPEC_TBT_SID;
> +	port->port_altmode[CROS_EC_ALTMODE_TBT].mode = TYPEC_ANY_MODE;
>  
>  	port->state.alt = NULL;
>  	port->state.mode = TYPEC_STATE_USB;
> @@ -431,7 +430,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
>  		data.enter_vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
>  
>  	if (!port->state.alt) {
> -		port->state.alt = &port->p_altmode[CROS_EC_ALTMODE_TBT];
> +		port->state.alt = &port->port_altmode[CROS_EC_ALTMODE_TBT];
>  		ret = cros_typec_usb_safe_state(port);
>  		if (ret)
>  			return ret;
> @@ -473,7 +472,7 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
>  	/* Configuration VDO. */
>  	dp_data.conf = DP_CONF_SET_PIN_ASSIGN(pd_ctrl->dp_mode);
>  	if (!port->state.alt) {
> -		port->state.alt = &port->p_altmode[CROS_EC_ALTMODE_DP];
> +		port->state.alt = &port->port_altmode[CROS_EC_ALTMODE_DP];
>  		ret = cros_typec_usb_safe_state(port);
>  		if (ret)
>  			return ret;
> -- 
> 2.37.0.144.g8ac04bfd2-goog

-- 
heikki

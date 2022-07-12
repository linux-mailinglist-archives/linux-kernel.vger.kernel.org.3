Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC7571486
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiGLI3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiGLI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:29:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A83140E6;
        Tue, 12 Jul 2022 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657614539; x=1689150539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XeOqU0GsgbobhhFBODuKDEdesvFbYh9RlThqOP3A6o=;
  b=KRhvto4DJINPx1F3yxgQTss1hydhsL0UTj6hxq+DFZ1wPqwADbJVa8wV
   sOVcCdjN3uFmdbFa+LwAahwmwSZy6eAIsqHWHvJmNGRCezLAkjNdebDO2
   5b6+UztS2n1cGjtNJvTrfIsi/8T1HJZH1l9Fv8nrxNBvhaUsfA6eyVq3e
   oYvRE895NXBSkoy2jY7EDqBj+NUa2o1VtVZ/2D2QnJ8RF5TplCB1tgkGP
   qwmiba36jyssog1PJJ61IuM9e6Cihn//qZIg6e06P5S0d8zU1SwyxLHKs
   sZehcrltqmjhFvf0d8QQyIeepv30dKQsRP/6We7X/+OtlQOj8LE558C77
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="267912349"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="267912349"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="737401342"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Jul 2022 01:28:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Jul 2022 11:28:51 +0300
Date:   Tue, 12 Jul 2022 11:28:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v4 2/9] usb: typec: Add retimer handle to port
Message-ID: <Ys0ww4E7X7NjN4Lu@kuha.fi.intel.com>
References: <20220711072333.2064341-1-pmalani@chromium.org>
 <20220711072333.2064341-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711072333.2064341-3-pmalani@chromium.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 11, 2022 at 07:22:56AM +0000, Prashant Malani kirjoitti:
> Similar to mux and orientation switch, add a handle for registered
> retimer to the port, so that it has handles to the various switches
> connected to it.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes since v3:
> - No changes.
> 
> Changes since v2:
> - No changes.
> 
> Changes since v1:
> - Relinquish retimer reference during typec_release.
> 
>  drivers/usb/typec/class.c | 9 +++++++++
>  drivers/usb/typec/class.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 9062836bb638..f08e32d552b4 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/usb/pd_vdo.h>
>  #include <linux/usb/typec_mux.h>
> +#include <linux/usb/typec_retimer.h>
>  
>  #include "bus.h"
>  #include "class.h"
> @@ -1736,6 +1737,7 @@ static void typec_release(struct device *dev)
>  	ida_destroy(&port->mode_ids);
>  	typec_switch_put(port->sw);
>  	typec_mux_put(port->mux);
> +	typec_retimer_put(port->retimer);
>  	kfree(port->cap);
>  	kfree(port);
>  }
> @@ -2249,6 +2251,13 @@ struct typec_port *typec_register_port(struct device *parent,
>  		return ERR_PTR(ret);
>  	}
>  
> +	port->retimer = typec_retimer_get(&port->dev);
> +	if (IS_ERR(port->retimer)) {
> +		ret = PTR_ERR(port->retimer);
> +		put_device(&port->dev);
> +		return ERR_PTR(ret);
> +	}
> +
>  	ret = device_add(&port->dev);
>  	if (ret) {
>  		dev_err(parent, "failed to register port (%d)\n", ret);
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index 43fcf9e37a8c..673b2952b074 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -55,6 +55,7 @@ struct typec_port {
>  	enum typec_orientation		orientation;
>  	struct typec_switch		*sw;
>  	struct typec_mux		*mux;
> +	struct typec_retimer		*retimer;
>  
>  	const struct typec_capability	*cap;
>  	const struct typec_operations   *ops;
> -- 
> 2.37.0.144.g8ac04bfd2-goog

-- 
heikki

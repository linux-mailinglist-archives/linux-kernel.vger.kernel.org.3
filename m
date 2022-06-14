Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DAB54AB75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354861AbiFNIKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiFNIKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:10:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D523B396B1;
        Tue, 14 Jun 2022 01:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655194209; x=1686730209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zv1KKzmF6zXtKfqHFutKI0fiY58cScPq9J52k7YOFMU=;
  b=eN1hKDq3fGMNKKqv2fIyECvqDjA9otw7muewl9cQllYlNGUhQ4rCiqPc
   52klE795k8uippoOsO9sDxsuUvMpVg2p4AErfO18BfXWN1TLoVaTvTZ5p
   1JtmP3kWa2h7+g+2bELdV8x3S8hA7t60eQyOY7A2vs6dQmhhe2S5tBsfO
   qi2k7XWb/1hdSYRcvqGTkh4YPSFmzrI8b6HtSLnYV6/Go9JPYcRhDsp+g
   yCbXUiq3P6hWgqhpgIBGsTNdzwVeVQcDTcCQhqAQVVO8eoMICq1fNH36u
   HKbWqnJcDncRKrLWBF8OpFGP8FNKAKdLFKSFubD4ACAaRnYx795S39qUV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258379471"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258379471"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:10:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="726704202"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Jun 2022 01:10:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Jun 2022 11:10:01 +0300
Date:   Tue, 14 Jun 2022 11:10:01 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        kernel test robot <lkp@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH v2 2/7] usb: typec: mux: Add CONFIG guards for functions
Message-ID: <YqhCWXOpuOjxwpwp@kuha.fi.intel.com>
References: <20220609181106.3695103-1-pmalani@chromium.org>
 <20220609181106.3695103-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609181106.3695103-3-pmalani@chromium.org>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 09, 2022 at 06:09:41PM +0000, Prashant Malani wrote:
> There are some drivers that can use the Type C mux API, but don't have
> to. Introduce CONFIG guards for the mux functions so that drivers can
> include the header file and not run into compilation errors on systems
> which don't have CONFIG_TYPEC enabled. When CONFIG_TYPEC is not enabled,
> the Type C mux functions will be stub versions of the original calls.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes since v1:
> - Added static inline to stub functions.
> - Updated function signature of stub functions from "struct typec_mux"
>   to "struct typec_mux_dev" in accordance with updates from commit
>   713fd49b430c ("usb: typec: mux: Introduce indirection")
> 
>  include/linux/usb/typec_mux.h | 38 +++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
> index ee57781dcf28..9eda6146fd26 100644
> --- a/include/linux/usb/typec_mux.h
> +++ b/include/linux/usb/typec_mux.h
> @@ -58,6 +58,8 @@ struct typec_mux_desc {
>  	void *drvdata;
>  };
>  
> +#if IS_ENABLED(CONFIG_TYPEC) || IS_MODULE(CONFIG_TYPEC)
> +
>  struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
>  				       const struct typec_altmode_desc *desc);
>  void typec_mux_put(struct typec_mux *mux);
> @@ -76,4 +78,40 @@ void typec_mux_unregister(struct typec_mux_dev *mux);
>  void typec_mux_set_drvdata(struct typec_mux_dev *mux, void *data);
>  void *typec_mux_get_drvdata(struct typec_mux_dev *mux);
>  
> +#else
> +
> +static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
> +				       const struct typec_altmode_desc *desc)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}

The mux is optional resource for the drivers - fwnode_typec_mux_get()
returns NULL if there is no mux for the caller - so it's better to
just return NULL from this stub.

> +static inline void typec_mux_put(struct typec_mux *mux) {}
> +
> +static inline int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
> +{
> +	return -EOPNOTSUPP;
> +}

Return 0 in this case. That way this stub matches the function
behaviour:

        ...
        if (IS_ERR_OR_NULL(mux))
                return 0;
        ...

> +static inline struct typec_mux *
> +typec_mux_get(struct device *dev, const struct typec_altmode_desc *desc)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}

You don't need this one. Just leave the original outside of the ifdef.
It's already an inline wrapper function.

> +static inline struct typec_mux_dev *
> +typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline void typec_mux_unregister(struct typec_mux_dev *mux) {}
> +
> +static inline void typec_mux_set_drvdata(struct typec_mux_dev *mux, void *data) {}
> +static inline void *typec_mux_get_drvdata(struct typec_mux_dev *mux)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +#endif /* CONFIG_TYPEC */
> +
>  #endif /* __USB_TYPEC_MUX */

thanks,

-- 
heikki

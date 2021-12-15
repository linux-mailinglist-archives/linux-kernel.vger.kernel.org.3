Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19034475496
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbhLOIun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:50:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231282AbhLOIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639558241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlFmq0lWb+QEzLX+6e0PsTY43Gj00mSLJ9F7c04n+vM=;
        b=iGu0O3ClyybLUQWCmEihvAR+CgLMATmptQhPnN80b6aQoRnw7WwfEfl4bQWZkM+ATrtMB+
        FonPURlRIxkJic/aCiM3oXXAW+JSQbmRGgglTGOkJ3y8XmuIlQs4kYxbtl/iMDLvZi3OgS
        Uab7R0OOPPzsaLV1nWebWpLe49Ep0uA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-bfMllSuDNK-jnfnzjvk5sw-1; Wed, 15 Dec 2021 03:50:39 -0500
X-MC-Unique: bfMllSuDNK-jnfnzjvk5sw-1
Received: by mail-wm1-f72.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso14326552wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 00:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mlFmq0lWb+QEzLX+6e0PsTY43Gj00mSLJ9F7c04n+vM=;
        b=UkrhS2ToI2AnMbcHq9yyyLcTUkThVwTYEMrdO9Yphk5xhffnhgt9JqqBKGcdaKfEfN
         +zLyo/jzpbgMHDVTG+CHveDrHzqqmrdQAezoNyDMU+1pk8/BjWnoTQiClEHBqP+f2sl1
         FLsvknSkz5LKyGZzVyMx19+FDZTMSVcckEejP8zrSc/cEBs0ZbFsE/7tFzSzEVtphaLJ
         ZTGXax8OdTmSA+IKacZ4cAIAgeuQuC+MYA76lVJt25DGWWFxeuoA5o/xXf8l8PHBfnQO
         kbUjkGnodJtaVgiywT4BsHoiSASMcc7JSXLQaeWFjx0eUM8nWeErYH/bOhR6jsAQOKjA
         ocvw==
X-Gm-Message-State: AOAM530S/wmTTxBNSo6i2A5QhzJyFEIuYyzOI66/hFPqUjQDk0V0lpEk
        TAl0VqkgVBjP77jNCpxcP6a28b0fEMM6ST+Wy5ZDsyRKpbWX45UAxcqDm2SASZ5w40cpdp+da0r
        7d7Jvy7oCl69+QIz1JFpbWPFd
X-Received: by 2002:a05:600c:1d89:: with SMTP id p9mr1640349wms.66.1639558238137;
        Wed, 15 Dec 2021 00:50:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwz185jzSF9LFh9vHyZZeDFt7zAt+IajPb1sNvr1OFvur6Y5tN1PcPTxCNgP0SRmhsVAe9I1Q==
X-Received: by 2002:a05:600c:1d89:: with SMTP id p9mr1640329wms.66.1639558237854;
        Wed, 15 Dec 2021 00:50:37 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r17sm4708773wmq.5.2021.12.15.00.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 00:50:37 -0800 (PST)
Message-ID: <1c1aeb13-6e90-ed2b-08db-11ceaa8d0de0@redhat.com>
Date:   Wed, 15 Dec 2021 09:50:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/60] drm: Make all drivers to honour the nomodeset
 parameter
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Alison Wang <alison.wang@nxp.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Lechner <david@lechnology.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Emma Anholt <emma@anholt.net>,
        Erico Nunes <nunes.erico@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Inki Dae <inki.dae@samsung.com>, Joel Stanley <joel@jms.id.au>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <sean@poorly.run>,
        Stefan Agner <stefan@agner.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
 <58d00cac-dbf1-9704-3c0b-16fd837a5b6b@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <58d00cac-dbf1-9704-3c0b-16fd837a5b6b@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 12/15/21 09:31, Thomas Zimmermann wrote:
> Hi Javier,
> 
> nothing wrong with your patches, but I'd like to propose slightly 
> differnt solution.
> 
> For many USB drivers, you put the drm_firmware_drivers_only() call into 
> the probe function. For registering, these drivers use 
> module_usb_driver(), which expands to generic device-register functions.
> 
> I'd like to propose a similar macro for DRM drivers that includes the 
> test for drm_firmware_drivers_only().
> 
> In drm_drv.h :
> 
>    #if defined(USB)
>    static int drm_usb_register(struct usb_driver *usb)
>    {
> 	if (drm_firmware_drivers_only())
> 		return -ENODEV;
> 	return usb_register_driver(usb);
>    }
>    #define drm_module_usb_driver(__usb)
> 	module_driver(drm_usb_register, usb_deregister)
>    #endif
> 
> In each of the USB-based DRM drivers, replace module_usb_driver with 
> drm_module_usb_driver.
> 
> And then there's PCI [3] and platform drivers, [4] which can be handled 
> similarly. Many PCI drivers open-code the module init and device 

Thanks for the suggestion. I actually thought about this approach as well,
since seems unnecessary to have all that duplicated logic in every driver.

But at the end decided to just do the less intrusive change, because can't
do any testing for most of the drivers.

> registering with the driver-specific enable parameter. Maybe adding a 
> driver-specific register function would make sense.
>

If I understood you correctly, suggested something similar in #dri-devel but
danvet's suggestion [0] was to keep it simple:

16:32 javierm: danvet: yes, I don't think we would be able to do it at this point. I'll add a function pointer
                       param to the check function so drivers can also define their own check besides nomodeset
16:33 danvet: javierm, uh that sounds a bit like overkill? just keep that part of the check in drivers?
16:33 javierm: danvet: Ok. Wanted to get rid of the duplicated code but I'm indeed over engineering this :)

[0]: https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&date=2021-11-02

> Best regards
> Thomas
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat


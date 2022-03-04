Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2571D4CD528
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbiCDNbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiCDNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:31:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB8C1B7570
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:30:49 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so7224823wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 05:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cPfkU0KHxPREtnhaJp4z/04k/a3Q7j3VHmpgeJr2Xjo=;
        b=F9TM2fZFsUTKDOJZ7Nvqk/hMKf3/T64t4VwUCOwqk+IHpMUt6/zptX/+Eom2mqgLWP
         KVVPIpafw1WPFnWMYcIAXkB36KdhhDRJHDBsnyWf/PGKwoXrZ90CNp2LtEswHY+tzBLZ
         s59LW9W3lAJE52KTd+pI4KcfSrl/ZYx4vYQnSZ5jaKZ7rq49/JLed6SlBEyHFY69iwSr
         MQS7nu1Sqm9etzceS8dIpb9CNHzPRDIlFE3r3wN5gC3viJX9oi3XJOD9/p06j9/vpQcr
         wVvbJDETlWru+dkfBzWhYsvsr6YGb5SqrO9B7jXJlgdbil+oX6I2YClWFS2KOinssV4S
         8DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cPfkU0KHxPREtnhaJp4z/04k/a3Q7j3VHmpgeJr2Xjo=;
        b=7p5bfIynZVtm93DPTNaJkB59UCHAGJEyx/UV/AZA0n18ckU3VOdT6hrfW3PnL3iA0n
         fWo/axpsXCp+8iveq8vsnDglShvISwlIC2mMIqrtPtlc+CRLTzd6AJfXPC3VudPjI0+O
         u1V/6inBfi5elSD7s78e8sbdsWIFsAIFh5BZ+FxLIMMbUeZ6PmLUKv2C9k3AwxZuDGBW
         W+zm89cS91f2x11NI7FoeDKPFirsTC/xtePT+7vrJ8HTjDqgoVFxnspYomeqNBJvp+qo
         VGhVOAiDFKI4nUYqgtBfZ9JyNeQ3ARB99p3mS8ItXcPOROg414E2nlDvgUhy3P8AeqtJ
         ROEQ==
X-Gm-Message-State: AOAM530VbLiRfIAe4wREK2/mIMIuzizUFmqJH4+BAan69xd+AL0kSqro
        ufybKEvp/HbmrMYVanWxwDckTw==
X-Google-Smtp-Source: ABdhPJwpgV4INtmhuZOx8hDaBaPG7q4meQfKqdjqRFwCmDbpm/iIJfcmGSw4CJtxETTxmxdQkD+Cgw==
X-Received: by 2002:a7b:cd90:0:b0:389:7e42:b5d1 with SMTP id y16-20020a7bcd90000000b003897e42b5d1mr2483095wmj.55.1646400647711;
        Fri, 04 Mar 2022 05:30:47 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:520f:a3ed:d47d:90c8? ([2001:861:44c0:66c0:520f:a3ed:d47d:90c8])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b00380fc02ff76sm5524384wms.15.2022.03.04.05.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 05:30:47 -0800 (PST)
Message-ID: <a52702bd-c929-8170-8896-d34ba82aba3c@baylibre.com>
Date:   Fri, 4 Mar 2022 14:30:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Letux-kernel] [PATCH v16 1/4] drm/bridge: dw-hdmi: introduce
 dw_hdmi_enable_poll()
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <cover.1645895582.git.hns@goldelico.com>
 <e54838849f80454b863f9f5634dd10f79ef7bb8f.1645895582.git.hns@goldelico.com>
 <983e9064-17ad-e646-f37d-ca9173ba0967@baylibre.com>
 <C8AE9A7A-E288-4637-ACAD-40CD33CD5F8C@goldelico.com>
 <3E620AF4-402E-45EA-9D92-92EAEA9647F5@goldelico.com>
 <SHH68R.Z3J9KSY0GQVA2@crapouillou.net>
 <ABC1BD09-383B-4499-B034-340CE88725B3@goldelico.com>
 <RUI68R.Z009SPJAAD8N1@crapouillou.net>
 <F0F8F36B-3A0A-476C-8C7D-566255C629C6@goldelico.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <F0F8F36B-3A0A-476C-8C7D-566255C629C6@goldelico.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/03/2022 18:59, H. Nikolaus Schaller wrote:
> Hi Paul, Neil,
> 
>> Am 03.03.2022 um 18:20 schrieb Paul Cercueil <paul@crapouillou.net>:
>>
>> Hi Nikolaus,
>>
>> [snip]
>>
>>>> Well he said "the Ingenic DRM core" aka ingenic-drm-drv.c. You do have access to the main drm_device in the ingenic_drm_bind() function, so you can add it there (with a cleanup function calling drm_kms_helper_poll_fini() registered with drmm_add_action_or_reset()).
>>> Well, do you really want to mix HPD detection between connector, Synopsys bridge and Ingenic DRM core? These are independent...
>>> Or should be accessed only through the bridge chain pointers.
>>> IMHO we should keep separate functions separate.
>>
>> The drm_kms_helper_poll_init() just says "this DRM device may have connectors that need to be polled" so it very well fits inside the main driver, IMHO.
> 
> As far as I understand, it has the side-effect to always set dev->mode_config.poll_enabled and
> schedule_delayed_work() for all devices.
> I am not sure if this is intended for arbitrary ingenic-drm devices. But you know better than me.
> 
> 
> Hm. But wait, I think I now finally remember why I have proposed it the way it is!
> It is always better to go back to requirements and find the least invasive solution.
> 
> - HPD IRQ works and calls dw_hdmi_irq() [as can be shown by adding printk()]
> - it is just that the udevd is only notified if poll_enabled = true (but no polling takes place!).
> 
> An earlier version (v4) to fix this proposed to add an explicit call to drm_kms_helper_hotplug_event()
> in dw_hdmi_irq() but that was rejected a while ago because drm_helper_hpd_irq_event() will already call it:
> 
> 	https://www.spinics.net/lists/dri-devel/msg316846.html
> 
> Since this did not take into account that dev->mode_config.poll_enabled must be set true, I then proposed the
> enable_poll() mechanism just to set this bit for the ingenic-dw-hdmi specialization.
> 
> So a HPD event is delivered to the dw-hdmi driver as dw_hdmi_irq() and that calls drm_helper_hpd_irq_event()
> but not drm_kms_helper_hotplug_event() and user-space is not getting aware.
> 
> It is all a hack because we mix the dw-hdmi driver which originally did register its own connector
> with an explicit connector...
> 
> In summary I now thing that the v4 patch is the simplest and least invasive solution.
> 
> We neither have to introduce a dw_hdmi_enable_poll() function or call drm_kms_helper_poll_init() anywhere.
> 
> It is just a single line to add to dw-hdmi. And neither touches ingenic-dw-hdmi nor ingenic-drm-drv.
> 
> So let's go back to v4 version (just modify commit message to better describe why we have to call
> drm_kms_helper_hotplug_event() explicitly) and forget about alternatives.

Please don't and add drm_kms_helper_poll_init() from the ingenic-drm-drv.c like every other DRM driver.

Adding drm_kms_helper_hotplug_event() in dw-hdmi will impact other drivers using dw-hdmi but correctly
calling drm_kms_helper_poll_init().

Neil

> 
> BR,
> Nikolaus


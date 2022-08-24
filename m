Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A9959FFED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbiHXQ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbiHXQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:59:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB56E8A9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:59:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m3so19160632lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc;
        bh=G82ihWj63KmrZTbNAM/UHivXSnuDSm1fupsjpoYLhDQ=;
        b=ftQ5CKHIBQWfNPo5g81XGiva+GwFlrcerSnJrQBQCJJeoaidvCPKD6uXoTh/koiu2i
         IJMMx3aVbOysnPqfl8kMWBhLA0YYhCEdMwB6db5hAcjW6KG31Q6CvL3nSbLrkrMBOu6m
         KQNymPiBiKVm3hs6kVoF0nCKXmyRBEQT1+7X1MSCGyIRK4fM1mZVzooY6bu3fIP+o+Pq
         uVO0e6XYDC8GXCtTIfEZkjhEtcvE7BJTJg/aCByHvv3hMnCoaKFm85qay6Fp9JCzyLMu
         qiEJ6OUFKRQeVmhhCoOVhb4GNPttwjvS0pIocjNxF74S8pp45y4eQ40da0WCDzUJosWj
         VJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc;
        bh=G82ihWj63KmrZTbNAM/UHivXSnuDSm1fupsjpoYLhDQ=;
        b=MqGPF97H3UZm3FlbMwxnXAOnddMtqBZt2CB40OovZzEoZxudQ7bqiP+iciIPQ+F10y
         AYFnpGrp96QG+7+ipoiCCfBzUD2i6ZqqBHWQitVxAcP7LiXISQqoJVM+HFf1HxPwfsHm
         2zopqr7IO74TI8YUcuVHd7IDa1sWmGDFUu3XI6nxSFHWbPUFDWTQT2Bayb0EW4NTVQAI
         ntYpaVamqJAl19r76e38itS0j22LS7+4BHW+jjDbVc3Q9byg2ikfTrYJaZPgEZMIKj+D
         g6RxlefZggd4p0DgSBS/b10Lfm+opimEZlitANnHIxsacZzQXu4hx1Hz1bZIEQvntKJk
         xlrA==
X-Gm-Message-State: ACgBeo3Kbt8D2MJdLRvgRk+BxBqih8C5XQ1wlU+DJpxR1Kp7YhU5MnuD
        mtvZ1A00xqnsBF+7kbbdiDw=
X-Google-Smtp-Source: AA6agR7fnL/ZvcDcHwypYRSYkpoEHzQlH2Kbb9U7WlU6MfPD9bSoUMZqe83drqSNUCrLLqJYv5uOuQ==
X-Received: by 2002:a05:6512:3e09:b0:492:f8e5:5eb5 with SMTP id i9-20020a0565123e0900b00492f8e55eb5mr2552048lfv.498.1661360358306;
        Wed, 24 Aug 2022 09:59:18 -0700 (PDT)
Received: from [10.10.53.53] (81-18-220-16.static.chello.pl. [81.18.220.16])
        by smtp.googlemail.com with ESMTPSA id k4-20020a05651210c400b0048d1101d0d6sm3941lfg.121.2022.08.24.09.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 09:59:17 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <b5b458bd-ec4b-0144-5ae2-378fda723ecf@gmail.com>
Date:   Wed, 24 Aug 2022 18:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 24/35] drm/vc4: vec: Add support for more analog TV
 standards
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-24-3d53ae722097@cerno.tech>
 <0e7bebe2-3f45-0a1b-a4b6-bb783f8de7b6@gmail.com>
 <20220815083702.ipcmdwzkh2fxvdp7@houat>
In-Reply-To: <20220815083702.ipcmdwzkh2fxvdp7@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

W dniu 15.08.2022 o 10:37, Maxime Ripard pisze:
> Hi,
>
> On Fri, Jul 29, 2022 at 07:55:30PM +0200, Mateusz Kwiatkowski wrote:
>> Hi Maxime,
>>
>> I think that declaring PAL-B and SECAM-B as the only supported 576i
>> norms is a bit random.
>
> Starting with this patch, PAL-N should be supported as well, right?

Oh, sure. I forgot about it. My brain was too focused on the "standard PAL"
modes, which excludes PAL-N.

>
>> Norms B, D, G, H, I, K, K1 and L (for both PAL and SECAM) are
>> essentially identical if we're talking about baseband signals, AFAIK
>> they only differ when those are modulated as RF signals. I'm not sure
>> if there's a point to differentiating those (that's more about patch
>> 05/35) unless we need to deal with some device that actually features
>> an RF modulator.
>
> What I was aiming for is to have all the cases we have in all the
> drivers covered so that we can make that property generic. i915
> declares and uses all those variants:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/i915/display/intel_sdvo.c#L68
>
> Especially since it's i915 and it's pretty much the standard as far as
> the uAPI goes, I'd rather avoid any regression there.

OK, if there are already drivers that differentiate those, then it doesn't make
sense to introduce regressions. And yes, there is plenty of software already out
there that differentiate between those modes in the context of composite video.
It still doesn't make much sense from the engineering point of view, though.

>
>> But if we do want to have all those norms separate, then I'd say that
>> VC4 should declare support for all of those, and all should map to the
>> same VEC settings. Some users from e.g. the UK might think that they
>> won't get proper picture if PAL-I is not on the list of supported
>> norms. Same goes for e.g. SECAM-D/K in the former Soviet territories,
>> and so on.
>
> I'd be open to it, but we can always extend vc4 to support those modes
> later on. The work you did to make that easier should make it trivial.

Doing that in the future is OK as well. I just wanted to point out that
PAL-B/D/G/H/I/K/K1/L (and same for SECAM) is the same exact thing as far as
baseband composite video is concerned, so declaring only one of those as
supported is potentially misleading for anybody who is not aware of that fact.

>
> Maxime

Best regards,
Mateusz Kwiatkowski

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E894C6F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiB1OTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiB1OTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:19:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C067A25EA3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:18:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v21so15689789wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0pWKGzc1QGnlWJ7r+DVlrppysa/FNwAKcHpfFi7QI+0=;
        b=mWFC0RgVVVEnPrrnSOZ6rSduLtgN2AAjdqME+r3OuWaLryf4ZvjGIRhEuCuB3K2pbJ
         UcE+xdZ6Asyj0UWqym7ZF+fEyTZYMJN/O0bnou1jLqmqRlE5CdYQXijZtps/wyBdtpMS
         EhstuHJKDem74wrLsw3BF5ShaD3gdWZ7qqyhdsHhM50ZbBptpUttgBXODqWIfHhbpmIX
         7/BZpaFhFYNnl2PoY+Tw4/tf9kRhDnScAAbSR0Izb5S8X/Pr73EkX+MWZnRKjeIwyueq
         SBg1FHCjMoBv9TqjhMfdTV6vdRLkVbfsMBgvOzIWAaRUKHlejNVEIXknZQzBu1ULs+Rs
         Hy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0pWKGzc1QGnlWJ7r+DVlrppysa/FNwAKcHpfFi7QI+0=;
        b=JDs5FWadM7LRhxjVVDcAG8Ix7RsL5alavqNXG+k5DiXdj36eqQi4ZatXl0Ik2yV4XU
         T/qKtNYgcCZIa2zPelzMpJtmcqCnxJkhakEH83FSjoXtTqvIu+7y5G7yQKlyxdv6sOni
         Swqu90caITqelybqoYcorHAkg3vvVf+E/H93NfZiBPCrPLzZB9WTTiejqPKTMbgLkvsW
         kZSJLjGqQS3EPAgCwX1i8pa4t9pLrm2IU0UJJ3pLntcYUN0MlLrzqVx/zoln7E3SOLM4
         cyhTaVyEjXVqJEkexwaBIAIjMccD3HE9Ttf5u534HH42L8Vhjs511V09zFys5jEpeMId
         VEbw==
X-Gm-Message-State: AOAM533Vp+5hIwcYdpqkajBY3XBqtHVZY8uTNOknD10Mx8w/3crwZxPg
        jHOBw+mHNsJCaI/EUUSVc786QQ==
X-Google-Smtp-Source: ABdhPJz6CAiN5uoDI/GIMmfKhOZ9vlU5f8pyRnmCUdki+ZEhESDrFSf05c4PuXfRbM8VvRQcajoH5A==
X-Received: by 2002:a05:6000:1e17:b0:1ef:d2b0:5624 with SMTP id bj23-20020a0560001e1700b001efd2b05624mr3920084wrb.598.1646057917250;
        Mon, 28 Feb 2022 06:18:37 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:6431:1dc7:b58f:6282? ([2001:861:44c0:66c0:6431:1dc7:b58f:6282])
        by smtp.gmail.com with ESMTPSA id m11-20020adff38b000000b001ef879a5930sm7224744wro.61.2022.02.28.06.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:18:36 -0800 (PST)
Message-ID: <4fb2c485-a489-574e-9445-dbeede79d343@baylibre.com>
Date:   Mon, 28 Feb 2022 15:18:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V5 0/2] Power: meson-s4: add s4 power domain driver
Content-Language: en-US
To:     Shunzhou Jiang <shunzhou.jiang@amlogic.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        jianxin.pan@amlogic.com
References: <20220228033542.3594861-1-shunzhou.jiang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220228033542.3594861-1-shunzhou.jiang@amlogic.com>
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

On 28/02/2022 04:35, Shunzhou Jiang wrote:
> This patchset adds Power controller driver support for Meson-S4 SoC
> Likes Meson-A1, the power domains register only can access in secure world

You sent another "v5" version of this same patchset at https://lore.kernel.org/r/20220228032803.3305649-1-shunzhou.jiang@amlogic.com

Which one is the right "v5" ?

Please also add the changelog (changes between your patchset version) in this cover letter,
otherwise we can't track the changes VS the review comments of the different patchset versions.

Thanks,
Neil

> 
> Shunzhou Jiang (2):
>    dt-bindings: power: add Amlogic s4 power domains bindings
>    soc: s4: Add support for power domains controller
> 
>   .../power/amlogic,meson-sec-pwrc.yaml         |  3 ++-
>   drivers/soc/amlogic/meson-secure-pwrc.c       | 22 +++++++++++++++++++
>   include/dt-bindings/power/meson-s4-power.h    | 19 ++++++++++++++++
>   3 files changed, 43 insertions(+), 1 deletion(-)
>   create mode 100644 include/dt-bindings/power/meson-s4-power.h
> 
> 
> base-commit: 3448a018ded03ccd4093d6675f4a39eb2d1a18ef


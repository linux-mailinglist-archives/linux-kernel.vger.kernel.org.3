Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF04C86A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiCAIkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiCAIkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:40:02 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B56888ED
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:39:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r10so19242192wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Ys5RUn00UTk4/HM+/VQ1d9YYoz2PP5VEAgLxVeBItuo=;
        b=bsBXup8JXuMjq5m2R4LX5YZYwB4jv3c8gplZTEkaXEYlZDxabb+wInQkLSxBHDveUe
         EftLA3G/0WpO65ThsVXgcKSeLo5Fau9t2AheK+c6CajAO2uphaVq4QP2TyILrolSyDE5
         De18sMJRe1PnKmAsotxRKuLSdeDBYvhPkuunybLWLfnKhpec560dY78BjxUdj5Z4nFOG
         KIUDDgZxwSgCyiG1PrQbEChQV0bnSts9xk8M8CeB8LWFT4s/6JCWLRIAMvcZAgLi0anQ
         5B/OyXff9XWaQCMChL5HbyJaJG3YnDXNzxy1u9bmTaAhqjTZFVxfy0Mjtw5mBewuOjak
         /UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Ys5RUn00UTk4/HM+/VQ1d9YYoz2PP5VEAgLxVeBItuo=;
        b=lgE60HVl3XfchMbaoj0FRFwiqN7XuZxv3VmeMkCYeVRTjj9hjfp4OlYcz+VtJTJHUl
         r/P/3+GZ2BGrdfS+aYNv0ty/TM3G2PJKsJmBzK/f8tOB+InitzzYu/P5D3wOlSj+ahWP
         x7lFvciID3svgHMc6mX8nW1qxTIwMCiMSyYeTiAtEx+gj1uMgTutrvuJqqNq7eWutAJo
         /XJ48xjY3DD7fVUhBWDm61Ppu8E6pY2jF80ayJf4+kB7Pnx7TiXMISw8QLPdpTICa5pF
         +l40RX/T2hZEkGQ2ENqrHXs75rupz3IeZVepI0flvmDB7HP2IvCq1hrW0N9INdDmtxxN
         IZgQ==
X-Gm-Message-State: AOAM5309W7mXpzjaqX279sC65ZZvjZW2vV6dx/xp5tiwXuxtUGP0wIXu
        h65mjszPKSAeddashWhuMEDfUA==
X-Google-Smtp-Source: ABdhPJyHAAq6QqkvDXe+8kSp+Zv0Q+HGeMEuNrHEz11ZtnWxrAxvw7R+lXq+tS3APcaKgFuL9J/7jQ==
X-Received: by 2002:a5d:6083:0:b0:1ef:761f:521f with SMTP id w3-20020a5d6083000000b001ef761f521fmr14275331wrt.238.1646123960395;
        Tue, 01 Mar 2022 00:39:20 -0800 (PST)
Received: from [10.1.3.188] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p190-20020a1c29c7000000b00381227166b2sm2488649wmp.41.2022.03.01.00.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:39:20 -0800 (PST)
Message-ID: <9c35b653-6cf4-a13e-ce7b-b186cf4b68f4@baylibre.com>
Date:   Tue, 1 Mar 2022 09:39:19 +0100
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
References: <20220301015849.827634-1-shunzhou.jiang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220301015849.827634-1-shunzhou.jiang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/03/2022 02:58, Shunzhou Jiang wrote:
> This patchset adds Power controller driver support for Meson-S4 SoC
> Likes Meson-A1, the power domains register only can access in secure world
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

I think you have an issue with your mail setup, you sent 5 times the same "[PATCH V5 0/2] Power: meson-s4: add s4 power domain driver" patchset.

Please fix it and maker it doesn't happen again.

Thanks,
Neil

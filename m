Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A614C554F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359343AbiFVP0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiFVP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:26:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F439162;
        Wed, 22 Jun 2022 08:26:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cf14so14646728edb.8;
        Wed, 22 Jun 2022 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iUzY4nbnMghL5U5lbC9orjTiyOqHbnNJpaguJ2BvQ0I=;
        b=AEoeVrOdTGpW8f5/WdP1QJAyvtpZm3Rcmw/2pg+2BxRLGzEojWTu72Nhl8OIUZA6ru
         flVFlEbrYE/DcKVLppgHHckPgzgR9oQ2UPcRWuOg31W3w/7nD3LHRB44VyloGTUigePI
         Qkjdl3z98ZLPlb8kHaXW97f90vPmQvnREWKb7ae8TQGQGnYP1T3aDPLA7zSkV6kCJ5m0
         aWV2UuYVWT0nh5GX9cWFwNCcEJIWrUjLiMWSD9Km8S26cSBVh0Z6mhE+FlO9q4bAp15h
         0AJzCPpCiw8UxLo+OkoR1DvNr1on0LycHZ3wquvsxBXWxKcxggF4UmnPK65I1nbZqgRu
         qu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iUzY4nbnMghL5U5lbC9orjTiyOqHbnNJpaguJ2BvQ0I=;
        b=HPJ3LwqmvFFtwTTGdLd8ruOYJsJLU8vOo4EEm+cGJSHui/WIRJf5uMQyDjZgqXrd3K
         iSOFLaeDUKceabYZvuW7GVEmPY/9NkZLPorrLkhwHkAsBDRV+2T/NPNMLW5olhJXcJfK
         nwAT/FjG4DkwvSyess2IQ4ka4Y3ApbvgiTdwAn20ktEO0UaqSV4tQfznjXmIAHsBhcnh
         LIbQyi3UKzxOvfKFwBmoE8z5LyEQOHvNN8TqrN87HSjjuw5jlrgv8HESiqZJPQugH/FZ
         AyfPBtGRDk8IuXr3jSOx6cHGStPPl9+/Okay4j7rfwniLK/ajkzC5GfHqAtR6t3Ahr+c
         iBjw==
X-Gm-Message-State: AJIora+XYEG7gLqEXSY2NDqudxw3JG0jJTQHEwjHas+7n25ihQVK3NWx
        FcD4pTLAcr9iBJmwxe6FJAg=
X-Google-Smtp-Source: AGRyM1vgpTRl9gQqy9pZt2ocx7au56m3oMlaDtHNIMEQagwDUpJU7dK3BCZgg8DRywhG7QCBvmtPPQ==
X-Received: by 2002:a05:6402:414c:b0:435:1e2a:2c7f with SMTP id x12-20020a056402414c00b004351e2a2c7fmr4719527eda.132.1655911566341;
        Wed, 22 Jun 2022 08:26:06 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id e7-20020a50ec87000000b0043561e0c9adsm12665751edr.52.2022.06.22.08.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 08:26:05 -0700 (PDT)
Message-ID: <d1dcedbb-413e-48ee-fdbc-e4d77465b62c@gmail.com>
Date:   Wed, 22 Jun 2022 17:26:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 00/10] MediaTek Helio X10 MT6795 - Devicetree, part 1
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220609112303.117928-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220609112303.117928-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2022 13:22, AngeloGioacchino Del Regno wrote:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series modernizes the devicetree of the MT6795 SoC and adds a
> couple of nodes that are supported by this SoC.
> 
> In my local tree I have much more than that (including the dts for
> that Xperia M5 smartphone that I always mention...), but I decided
> to push the devicetree commits in multiple parts, as to get these
> in sooner than later because that reduces my delta, and this makes
> upstreaming a bit easier, especially when having to rebase things
> around, which happens a lot.
> 
> So, this series *does NOT* depends on any of the other series that
> I've pushed and is mergeable in parallel.

Applied, thanks!

> 
> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
> 
> Changes in v2:
>   - Split fixed-clocks addition/removal patch for readability
>   - Added patches for pinctrl controller node and vGIC interrupt
> 
> AngeloGioacchino Del Regno (10):
>    arm64: dts: mediatek: mt6795: Create soc bus node and move mmio
>      devices
>    arm64: dts: mediatek: mt6795: Add cpu-map and L2 cache
>    arm64: dts: mediatek: mt6795: Add Cortex A53 PMU nodes
>    arm64: dts: mediatek: mt6795: Add watchdog node to avoid timeouts
>    arm64: dts: mediatek: mt6795: Add fixed clocks for 32kHz and 26MHz XOs
>    arm64: dts: mediatek: mt6795: Remove incorrect fixed-clocks
>    arm64: dts: mediatek: mt6795: Add general purpose timer node
>    arm64: dts: mediatek: mt6795: Add ARM CCI-400 node and assign to CPUs
>    arm64: dts: mediatek: mt6795: Add pinctrl controller node
>    arm64: dts: mediatek: mt6795: Specify interrupts for vGIC
> 
>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 260 ++++++++++++++++++-----
>   1 file changed, 205 insertions(+), 55 deletions(-)
> 

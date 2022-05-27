Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C603535954
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbiE0G2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243636AbiE0G2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:28:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547523DA76;
        Thu, 26 May 2022 23:28:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h186so3161657pgc.3;
        Thu, 26 May 2022 23:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpmmuYOXBkBP9By6R6nKTLgZB5DybQG//UzfVx711Q0=;
        b=a2HrE1/SvaCrCtKv6DERQl7xsr/JdXo+y6Kv7qkTXnE0KniWXHqc+04IujKvcX4vMK
         oIYyuxqY8S6rDGpmnSwbm9vH8LxLWEepZEd/O2/f6++bTuZQi0ceMqbXKrHXogqSJJcC
         Pg/3g7z1QQorrNnnhDNoR/wPiwF7tM1tZ85CNg+1kj1Tyc3BM+IQsWXBHZu/ygdAm/VY
         SZL9GWWNH0u7OvDRqdHQC43DJxTsrCLQni6ROX9JSYxi7HwWvJfL2RBIQsNzBl682pRW
         6E5VfvsGwSLJLjTaXW4luYoHHsIS4y/Y+hkxk7JJp1Gpm+x9jEfATHnKSm16iVCGA10m
         gd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpmmuYOXBkBP9By6R6nKTLgZB5DybQG//UzfVx711Q0=;
        b=a96u0/kd1MFbBDuRqX5mF0fzyYGGvNtWoZ1cmd+XdH7qUORDNg5GALz9nlAfVWKHce
         5yoSOu1PAZXVDgqkzHssJRUE1U+4/mYgrOwzSr8cdg1/YgaAdh6/xp9RzBjphx7qjjnq
         aTcKp+TN4mnYRraYT2KDMScrm1xJ49OIvcRJjG4BSbZJfhCFzQuWlQFInaaBb8uSuvF9
         9VfB2YSnvC4FJ2q62oi2/OcclZ6/aLzhSUNUNyH1tPVwZsJ+/ihdbu2Nv7QWT8hLSt/y
         +lKKQ6k2vnLAkDa+3ME813iM5LEpOzC3PlaSPIHfZYyNCFmCKG1z86QDQFazDF/C9ANB
         oIXQ==
X-Gm-Message-State: AOAM532UWRmxwG7gnKtV2vXSzQ/h9aOWcODL2+hv3QKjdg+WrggIegWj
        OSwvHLnQIYaby2npIgh0l81CFRuBkMT2/KUTEOo=
X-Google-Smtp-Source: ABdhPJzBjOQT3REuxrp043mRJ2tOI4cMLlRM9bIyjSl1sP2f6OlLXS00jjixA0RZnsy5AjDGCgciWveo9vvjC7l7PuQ=
X-Received: by 2002:a05:6a00:14d4:b0:518:b918:fae4 with SMTP id
 w20-20020a056a0014d400b00518b918fae4mr20076157pfu.55.1653632915852; Thu, 26
 May 2022 23:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220526204152.831948-1-krzysztof.kozlowski@linaro.org> <CA+H2tpGipB4faYDEdJZ82kjTak5ewW_cp=3LO+JkDa=hYiqZJw@mail.gmail.com>
In-Reply-To: <CA+H2tpGipB4faYDEdJZ82kjTak5ewW_cp=3LO+JkDa=hYiqZJw@mail.gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Fri, 27 May 2022 14:28:24 +0800
Message-ID: <CA+H2tpECYtgJAgJbwfgmu++ZVmk+nuoRmK=fX=4pquTFSFyzhg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sprd: adjust whitespace around '='
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 12:35 PM Orson Zhai <orsonzhai@gmail.com> wrote:
>
> Hi Krzysztof,
>
> On Fri, May 27, 2022 at 4:42 AM Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Fix whitespace coding style: use single space instead of tabs or
>> multiple spaces around '=' sign in property assignment.  No functional
>> changes (same DTB).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>
> Thanks for your patch.
>
> We have a plan to reconstruct the device tree of SPRD into modular form.
> sc9836 has been in status of EOL for years and I believe no one will need to run it anymore.
> We want to remove it as well.
>
> But your patch is fine.
> It could be taken in advance.
>
> Reviewed-by: Orson Zhai <orsonzhai@gmail.com>

Sorry, re-send for my getting failure...

-Orson

>
>> ---
>>
>> Output compared with dtx_diff and fdtdump.
>> ---
>>  arch/arm64/boot/dts/sprd/sc9836.dtsi  | 10 +++++-----
>>  arch/arm64/boot/dts/sprd/sc9863a.dtsi |  4 ++--
>>  arch/arm64/boot/dts/sprd/whale2.dtsi  |  2 +-
>>  3 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi b/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> index 231436be0e3f..8bb8a70966d2 100644
>> --- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> +++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
>> @@ -207,11 +207,11 @@ gic: interrupt-controller@12001000 {
>>         };
>>
>>         psci {
>> -               compatible      = "arm,psci";
>> -               method          = "smc";
>> -               cpu_on          = <0xc4000003>;
>> -               cpu_off         = <0x84000002>;
>> -               cpu_suspend     = <0xc4000001>;
>> +               compatible = "arm,psci";
>> +               method = "smc";
>> +               cpu_on = <0xc4000003>;
>> +               cpu_off = <0x84000002>;
>> +               cpu_suspend = <0xc4000001>;
>>         };
>>
>>         timer {
>> diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
>> index 8cf4a6575980..22d81ace740a 100644
>> --- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
>> +++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
>> @@ -552,7 +552,7 @@ ap-ahb {
>>                         ranges;
>>
>>                         sdio0: sdio@20300000 {
>> -                               compatible  = "sprd,sdhci-r11";
>> +                               compatible = "sprd,sdhci-r11";
>>                                 reg = <0 0x20300000 0 0x1000>;
>>                                 interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>>
>> @@ -568,7 +568,7 @@ sdio0: sdio@20300000 {
>>                         };
>>
>>                         sdio3: sdio@20600000 {
>> -                               compatible  = "sprd,sdhci-r11";
>> +                               compatible = "sprd,sdhci-r11";
>>                                 reg = <0 0x20600000 0 0x1000>;
>>                                 interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
>>
>> diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
>> index 79b9591c37aa..957b2658e1fb 100644
>> --- a/arch/arm64/boot/dts/sprd/whale2.dtsi
>> +++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
>> @@ -132,7 +132,7 @@ ap_dma: dma-controller@20100000 {
>>                         };
>>
>>                         sdio3: sdio@50430000 {
>> -                               compatible  = "sprd,sdhci-r11";
>> +                               compatible = "sprd,sdhci-r11";
>>                                 reg = <0 0x50430000 0 0x1000>;
>>                                 interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>>
>> --
>> 2.34.1
>>

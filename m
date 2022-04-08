Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6744F8F73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiDHHY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDHHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:24:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459792D8648
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:22:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z1so11488739wrg.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+i3M7I/si8nBTwp4HQFlyF6kBw/Y86O3UtaIOhQqSgw=;
        b=njMPMNppMly5ssPAOWWTMzALhM0HuSZ4dOHB+/r2gqxGyi/nQQNRlus2x/AzAuQrKq
         xCilly7J5UpWytTYHGj/BJaOyWPPe6iScw8BQ1a/oUCPMMw4Yp1CxsDEGRWKgFfd+ykL
         ZGMozqHk83wJ5DmDgszP1Z35wW+R9WleLoi+DIx2nvUQDCefq/HcPuchXIBbwRZ+7wiL
         XuBSOvjFLXquYJb4WPbu2gZnDc+YANvNfHJ9gPYnGlX8f4IANQYMlBC+yG/mThiAUJat
         luu6g5f9FuWplQUkrgYlMMRm0SWFJTby6uL48HZSa1aiYsry0+sbc1tk2fR9A8EfCOiz
         vbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+i3M7I/si8nBTwp4HQFlyF6kBw/Y86O3UtaIOhQqSgw=;
        b=OJNfgd+B1lwZkN57Sfg6FFKZVNCN+mL5OReKBMrkLq1HqFjGeVcOaUMls3n1N+laR4
         or0Yr/C3TIuBldjHqAou3BiGN/3OHc0zu/HRLMHkjsw6Swvc9hZclhMX8j4WIdOu1rPP
         q5RvNF71fJBaABuoZYzHVl824IjfHpnOc3PxebaJqZmyi3hC1D2admkzew/cQ3E7s25d
         irZ8OszeVRtzyaofzt9nEzQ70b4MpeFSRDcEKrEd4ZkhLE7ZxqapHqLoZy12Gk/5/D7l
         I7v3Qr+dLftQLHCBFEhEKLSGemljZwNcCtBbQYa1J0NXKhIuYHw7wgFTHcGZ6SIJEHlM
         bj5w==
X-Gm-Message-State: AOAM533wFNU1Wn6o4mNHi19Sv/XeZQ4twhaJPrFyti90EMV4DK55sJ09
        QKqQ8+wn2axcuNK3Tip9/P5orQ==
X-Google-Smtp-Source: ABdhPJzgZitTrYz3M9Cl0bidcrh0p0LPFm7YGEXMIsJOsY8wQ5D2NRTazZW7HoEvc0P98B75WWK8dg==
X-Received: by 2002:a5d:44ca:0:b0:206:893:6b5c with SMTP id z10-20020a5d44ca000000b0020608936b5cmr13623307wrr.145.1649402540310;
        Fri, 08 Apr 2022 00:22:20 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:eacd:ce6:e294:acd1? ([2001:861:44c0:66c0:eacd:ce6:e294:acd1])
        by smtp.gmail.com with ESMTPSA id m7-20020adfe0c7000000b002060e7bbe49sm17924124wri.45.2022.04.08.00.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 00:22:19 -0700 (PDT)
Message-ID: <e704bdfd-7b09-6549-5efc-a2088e3490f1@baylibre.com>
Date:   Fri, 8 Apr 2022 09:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: remove cpu compatible "arm,armv8" for s4
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20220408070901.26446-1-xianwei.zhao@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220408070901.26446-1-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 09:09, Xianwei Zhao wrote:
> Amlogic s4 device is already applied, but cpu compatible 'arm,armv8'
> is only valid for software models, so we remove it.
> 
> Fixes: ac4dfd0d1d35 ("arm64: dts: add support for S4 based Amlogic AQ222")
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index bf9ae1e1016b..480afa2cc61f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -13,28 +13,28 @@ cpus {
>   
>   		cpu0: cpu@0 {
>   			device_type = "cpu";
> -			compatible = "arm,cortex-a35","arm,armv8";
> +			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
>   		};
>   
>   		cpu1: cpu@1 {
>   			device_type = "cpu";
> -			compatible = "arm,cortex-a35","arm,armv8";
> +			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x1>;
>   			enable-method = "psci";
>   		};
>   
>   		cpu2: cpu@2 {
>   			device_type = "cpu";
> -			compatible = "arm,cortex-a35","arm,armv8";
> +			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x2>;
>   			enable-method = "psci";
>   		};
>   
>   		cpu3: cpu@3 {
>   			device_type = "cpu";
> -			compatible = "arm,cortex-a35","arm,armv8";
> +			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x3>;
>   			enable-method = "psci";
>   		};
> 
> base-commit: fd86d85401c2049f652293877c0f7e6e5afc3bbc

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

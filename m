Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4460252EA17
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiETKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348239AbiETKlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:41:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB557B1E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:41:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o22so9190877ljp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SB+D3CGwo0pbc8xttBgtC8uSkjrvnUEhDJqv8xqmDZo=;
        b=GMV4wBKfG8nvPGawBAoiuCjrKRq6Tif1CBo/IdKIsAOXvCDE2ssBxkS6Du6w7L+1HL
         eaOUBevRKmbEJm8K4qWxqdCqejZY99lLO+qp/j/X7cl8+y4jKDH2heItod7zqqvXtHAd
         DOw6nipTz5VtZFn1WQ/CfBYaSPL3d8qLry9TKC2d/htVjH0T8krZWOhK4DlEU0i7Laib
         ITvTt3/Q9A1SC3LceFqGfra7XtmoZI25F8vveFB2cJaEfJCFKEJpTisXYFnJzjNEKKUu
         n+4kPOE1LnXydYxbTp4Q7im0tWvfFz0GYi2wL7TmPqTmFsH3JNWky9koSqsZiIhytZIx
         Jyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SB+D3CGwo0pbc8xttBgtC8uSkjrvnUEhDJqv8xqmDZo=;
        b=VpIj1qwuksmXphpQz/38TVNkplWr7/+QsE1oO3Tim+ypBNoGX1mBm2KvMclOgFVMAi
         xb5eiyCuG0tQkMHDPqbWU96rC14+1Ls2lq5DbhBg4MjQOkX4hzTlczyFJf7eLehG71B1
         FESLVPALpVMdzqO0eGorTIBuhU81KquJ2+VpkIjarDLy4402N5ez6S6LRpk9AjiF5hA3
         8zT2L4+TcZPifGBiDDAyrS28dHxJFsaflVlJ4bHfYA0P/6JKpo21cFWDfQRBJCbZTRwA
         UJ8OYyQoC1lFPffp7eLIEOE2XlYqlpRo5sftu/Wer2Cq2pKY9FWRaDpEQZaVTD7u2u/F
         sAcQ==
X-Gm-Message-State: AOAM530wD8FEKxD4aXnjfVyN9FNVqcqebbZ70lsTF88Sytc4T6iLCVZG
        oacGxlpmn0mF4hQpfKsx2Myy9g==
X-Google-Smtp-Source: ABdhPJxmldLmcme4ZF1aCcBy1Y197uqILKC6MPWTXxX9kjtHygv+A7vCyvKfcv7WDbVid5s5mEnJfQ==
X-Received: by 2002:a05:651c:1a12:b0:253:d897:dea1 with SMTP id by18-20020a05651c1a1200b00253d897dea1mr3533403ljb.479.1653043308615;
        Fri, 20 May 2022 03:41:48 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j16-20020a2e8250000000b0024f3d1dae9bsm269013ljh.35.2022.05.20.03.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 03:41:48 -0700 (PDT)
Message-ID: <e0572030-c715-4af2-87d9-8a87755bebf2@linaro.org>
Date:   Fri, 20 May 2022 12:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add
 support for Xiaomi Mi 5s Plus
Content-Language: en-US
To:     Alec Su <ae40515@yahoo.com.tw>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com
References: <20220520065013.25808-1-ae40515@yahoo.com.tw>
 <20220520065013.25808-3-ae40515@yahoo.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520065013.25808-3-ae40515@yahoo.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 08:50, Alec Su wrote:
> Add the device tree for Xiaomi Mi 5s Plus (natrium).
> 
> Signed-off-by: Alec Su <ae40515@yahoo.com.tw>
> Reviewed-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  | 416 ++++++++++++++++++
>  2 files changed, 417 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2f8aec2cc6db..3ae7ecd369fb 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -37,6 +37,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-dora.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-kagura.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-keyaki.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-gemini.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-natrium.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-scorpio.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-asus-novago-tp370ql.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-fxtec-pro1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
> new file mode 100644
> index 000000000000..c16dc96e7049
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
> @@ -0,0 +1,416 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Alec Su <ae40515@yahoo.com.tw>
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8996-xiaomi-common.dtsi"
> +#include "pmi8996.dtsi"
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
> +
> +/ {
> +	model = "Xiaomi Mi 5s Plus";
> +	compatible = "xiaomi,natrium", "qcom,msm8996";
> +	chassis-type = "handset";
> +	qcom,msm-id = <305 0x10000>;
> +	qcom,board-id = <47 0>;
> +};
> +
> +&adsp_pil {
> +	firmware-name = "qcom/msm8996/natrium/adsp.mbn";
> +};
> +
> +&blsp2_i2c6 {
> +	synaptics@20 {

Generic node name, so this is a touchpad? touchscreen?

Best regards,
Krzysztof

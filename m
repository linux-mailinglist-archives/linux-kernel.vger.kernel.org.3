Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC3A59D9A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 12:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346083AbiHWJ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240930AbiHWJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:54:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5369F76F
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:46:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m5so8063403lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mDJdLmDh7T+sgYfQaoB0rv3PTQp6t8v++tQo3R9rjBM=;
        b=PJmCi3gmqXBwu9NZSuf1sX/qLu5JNkaEDtHWybkWrrJYNlTb7SLUl2kh2pPknLCNVo
         kigefusDwBu8bJtOXBYCGAoZQrjxJ8TkWevNSro1LAy2tqwz/mpLnS3J+RgEwx+60sqF
         MCo+Rp+DD6zUB5Y2PB/g5372dnqsc/RDpQPt4qLvRhF6PWs8MvW0bvLHpupMhiZyVAqT
         xvYBti5u6pj3myvEQAbKLE3n4nONKgccg/9nG+JhhRb4MrITU8q2RgqpogSV7z9QckSU
         YUBHuV6Obk2RTQ/ULm1FXQu+twOTmlzHwVv5bQWIZLkf1e5FaUnnhbvsmMr8pdBvO3G1
         eDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mDJdLmDh7T+sgYfQaoB0rv3PTQp6t8v++tQo3R9rjBM=;
        b=zr9A02RO3pDzhToOIOKRnqrI5gzmL14LNG24h0htEaIR69TogEdX8O1pXyOqTa66E0
         iCPlrHvaVxeP8P8c+eu8gnjmw3sMjsRgy3/wxo+0mt0deiDATpAzZUE8uurGn98z6fT1
         H3/YE9eE+tDwJ2ow2jp9SOjbKK18yGwkfUUvAot/n/R0TfF9i1ZF2vNdW3sQVGbCLMgf
         1o9wurP6cXz60VtaKzLvrEAAcRqWmgh5yEhkxyZHFnod5Ks+ePeXtrkE8RUzmXZRx0Fe
         t2VoIxayur2Ty0bNaLJ3HCdoTKWasRViRkvu4nDUpFgA4HOKCiiW6LyBF2bfZk350+9F
         w0HA==
X-Gm-Message-State: ACgBeo3s1BghZ8E7FuBe4ApgFRfJmJdbzRtiBW1e9beUKjWc67KktWSV
        AIuA0DCH6P1bQrUBj3UdIloMnQ==
X-Google-Smtp-Source: AA6agR7Nq2AoAEGywDXYOyXtRoPVy5JyJcqHXZSpTRIDEZdX/31PgBVnoMZTmlWLvkRo+uqS17BH0Q==
X-Received: by 2002:a05:6512:169e:b0:492:ebf7:7dd3 with SMTP id bu30-20020a056512169e00b00492ebf77dd3mr2420124lfb.33.1661244372109;
        Tue, 23 Aug 2022 01:46:12 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id n20-20020a05651203f400b0048a85bd4429sm1097971lfq.126.2022.08.23.01.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:46:10 -0700 (PDT)
Message-ID: <ddb805c6-940b-d25f-9fca-380d70f9f1f3@linaro.org>
Date:   Tue, 23 Aug 2022 11:46:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/4] arm64: dts: allwinner: h6: Add GPU OPP table
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220821173051.155038-1-peron.clem@gmail.com>
 <20220821173051.155038-4-peron.clem@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220821173051.155038-4-peron.clem@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2022 20:30, Clément Péron wrote:
> Add an Operating Performance Points table for the GPU to
> enable Dynamic Voltage & Frequency Scaling on the H6.
> 
> The voltage range is set with minival voltage set to the target
> and the maximal voltage set to 1.2V. This allow DVFS framework to
> work properly on board with fixed regulator.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> new file mode 100644
> index 000000000000..a66204243515
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2022 Clément Péron <peron.clem@gmail.com>
> +
> +/ {
> +	gpu_opp_table: gpu-opp-table {

I don't think you tested the change with dtbs_check. This does not match
the bindings.

> +		compatible = "operating-points-v2";
> +
> +		opp@216000000 {
> +			opp-hz = /bits/ 64 <216000000>;
> +			opp-microvolt = <810000 810000 1200000>;
> +		};
> +
> +		opp@264000000 {
> +			opp-hz = /bits/ 64 <264000000>;
> +			opp-microvolt = <810000 810000 1200000>;
> +		};
> +
> +		opp@312000000 {
> +			opp-hz = /bits/ 64 <312000000>;
> +			opp-microvolt = <810000 810000 1200000>;
> +		};
> +
> +		opp@336000000 {
> +			opp-hz = /bits/ 64 <336000000>;
> +			opp-microvolt = <810000 810000 1200000>;
> +		};
> +
> +		opp@360000000 {
> +			opp-hz = /bits/ 64 <360000000>;
> +			opp-microvolt = <820000 820000 1200000>;
> +		};
> +
> +		opp@384000000 {
> +			opp-hz = /bits/ 64 <384000000>;
> +			opp-microvolt = <830000 830000 1200000>;
> +		};
> +
> +		opp@408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <840000 840000 1200000>;
> +		};
> +
> +		opp@420000000 {
> +			opp-hz = /bits/ 64 <420000000>;
> +			opp-microvolt = <850000 850000 1200000>;
> +		};
> +
> +		opp@432000000 {
> +			opp-hz = /bits/ 64 <432000000>;
> +			opp-microvolt = <860000 860000 1200000>;
> +		};
> +
> +		opp@456000000 {
> +			opp-hz = /bits/ 64 <456000000>;
> +			opp-microvolt = <870000 870000 1200000>;
> +		};
> +
> +		opp@504000000 {
> +			opp-hz = /bits/ 64 <504000000>;
> +			opp-microvolt = <890000 890000 1200000>;
> +		};
> +
> +		opp@540000000 {
> +			opp-hz = /bits/ 64 <540000000>;
> +			opp-microvolt = <910000 910000 1200000>;
> +		};
> +
> +		opp@576000000 {
> +			opp-hz = /bits/ 64 <576000000>;
> +			opp-microvolt = <930000 930000 1200000>;
> +		};
> +
> +		opp@624000000 {
> +			opp-hz = /bits/ 64 <624000000>;
> +			opp-microvolt = <950000 950000 1200000>;
> +		};
> +
> +		opp@756000000 {
> +			opp-hz = /bits/ 64 <756000000>;
> +			opp-microvolt = <1040000 1040000 1200000>;
> +		};
> +	};
> +

No need for such blank lines.


Best regards,
Krzysztof

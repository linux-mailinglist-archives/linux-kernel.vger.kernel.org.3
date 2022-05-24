Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FEE5328C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiEXLVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiEXLUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:20:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD2C32068
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:20:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu29so30342845lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o0ipq/ShCYUCx7T0j2hDbwMvjVrSO06ejM4Vx5wMRA4=;
        b=a0smWsTTZGvc6UapwKxaTefFqOyo/PWRyNCBFTCSsp58rpQhR5hlmdqgHGyZsDjgTX
         0MqMXMdsS2cM1nIzQOQN7x4GM6XvfRHR355gPfAzvlKZl3vRrP5kM+wXsJB4Y9RtPR2H
         Q8SPOo8A5WGGi0CiFZKl6ZMR15RirGr/U9hTCfCwsxaYqRPt5DsUsh842U9MixV0ynVG
         SQTtmTiSMrPtt8xlZzvFNLnFHT6Pav/VRl0Ov5zmVla/gGYg1X96hVRzszOrsU9zzJzX
         GhqH2nbbOQV09W4XRi0wwlzPlEdAgcURw0S8i4acqqUGdvH/Xcf1r10zgmNmCvu++8FD
         9Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o0ipq/ShCYUCx7T0j2hDbwMvjVrSO06ejM4Vx5wMRA4=;
        b=RpMAnXaOIWcgFGGnHolXI0cAtoSVLbpUry7w+EFejwSyokDAz5TriyWthngTBGl0YI
         6WVkfRg/RXoZ4ecl5HLAXPB2dUeHkiolD0QrI8CUKL5m5QlRHwV+2M9ZhhRmdX5KWeYQ
         dOdcTKgUNze/9wNzX10CclzNRqcMp4zRQbDp5zJULQvvH36vDzItXuYgH29vts67hjNQ
         sbtmLxq+3gFLZpm7R4zGb4dgV79OdYYGnZyfD8juAQ2ySut5bcBqxnmZD+TDzvrkRkS+
         +bri+OrRkrxP0sWYnLulio3HrryJaCXF/7jJ5KYbtO4Bkj8HB+WT3U1fVGmAjo8MxTf3
         7BAA==
X-Gm-Message-State: AOAM532cWGs7WnFMwIgiHZhzmEzCsdBGLrrjziwSRjob3Chl8ueSDVUy
        23EfSq3ULQPVS895Dyb+d5kWlw==
X-Google-Smtp-Source: ABdhPJyB7Ei7mNpGQu8r7QxsoIIjxzWsoKjaWtjD6ClhGPmm4PW3/5gzOu+fxPOBGh5co1kNAgfGZA==
X-Received: by 2002:a19:ac42:0:b0:478:593c:e6fe with SMTP id r2-20020a19ac42000000b00478593ce6femr13183600lfc.254.1653391252470;
        Tue, 24 May 2022 04:20:52 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id x14-20020a0565123f8e00b00478641f62c0sm1553314lfa.28.2022.05.24.04.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 04:20:51 -0700 (PDT)
Message-ID: <383a3fe0-b608-0fc4-be3f-a391120a7972@linaro.org>
Date:   Tue, 24 May 2022 13:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 7/7] arm64: dts: imx93: add mediamix blk ctrl node
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
 <20220523113029.842753-8-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220523113029.842753-8-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 13:30, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 mediamix blk ctrl node
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 85686b684966..454c605303e4 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -348,5 +348,25 @@ gpio1: gpio@47400080 {
>  			#interrupt-cells = <2>;
>  			gpio-ranges = <&iomuxc 0 0 32>;
>  		};
> +
> +		media_blk_ctrl: blk-ctrl@4ac10000 {

Generic node names as well, please.


Best regards,
Krzysztof

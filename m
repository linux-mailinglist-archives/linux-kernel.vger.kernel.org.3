Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB1357311D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiGMI3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiGMI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:29:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA661CE15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:29:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r9so9875893lfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b/K0bJPiP1IyBMjzSdHmTMvuIUPxJ5n8xtEUFv6wetw=;
        b=H94ipJrjZLI4NZ938hH626pwqaM0iL9zkihgIbyqEeKS4rJT7xeIimPUUoR2p9olb7
         owmyBfKgbc5B8QTzq5+JIe3PUbVZgIXBXgBbcRewFYcji+6DX5Tprsvhguhc0zzLU6Ay
         oxdOo3JJcD3Wy6yHjTQo9mW/5JIVZhCh8lhgaGahfHHZo8U8PqyphHTHp8VXZfyitBOw
         7cGivsQeJZC1+UvLN+Yu7U+SRVUNf1+vCOUbVaJRd5MirXeYQiCZn96bluvbPEoWXSVm
         nb4j06tcsnRS1tKpJXZhIPvKMzq2u7DpbIy1Uq4kr2aC1zSmea3KW64B4tZG4PrKgIZ3
         wGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b/K0bJPiP1IyBMjzSdHmTMvuIUPxJ5n8xtEUFv6wetw=;
        b=LAjJKV0mwMTJfZXhLTnWHAaW1LSO5tDCp5dKtw0nGYrHFcWRfXET2zJbkj9xtofrgb
         j1sJr3V7OfYJMgKvACxyhdafFUkin4EcPKgUQScjDQ9fTJJtiTwbc8Bj+aDWkdQNuhS1
         agrBUKSU++LZuNOBWQkhtov1ANDb6w7FyGgfh6Tu5RkdQNEtiiAG16EniXwIloIZveDw
         P9FTCeG/SXjQTIrvullfNEpeatcjNgEjJA3ITKIjNWZwjH9NOeUT7C50xdMfFEZ9ugBE
         U1sg0MTNFLT7xEbYP4apTlv0feTBM0IczG4qO/Wl0spGh8dWm2v6ZnbDFn/ztfMEssi5
         ZstQ==
X-Gm-Message-State: AJIora9caqguTgP6HyYASRSkg3z0/BqJ1joSrvZvslvbBWjatNAHdJpa
        RNdtjOZCrjvU4rOGAaWc71eHwA==
X-Google-Smtp-Source: AGRyM1uC60E1c+Lkg7ekKCBTMSmjyTdeTZiQtu15ZUZD4azYzppFHMCeF9UldnYGFseZy09wi4R8EA==
X-Received: by 2002:a05:6512:e9b:b0:489:e034:cfc9 with SMTP id bi27-20020a0565120e9b00b00489e034cfc9mr1258341lfb.366.1657700966183;
        Wed, 13 Jul 2022 01:29:26 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025d6930d014sm1218702ljc.87.2022.07.13.01.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 01:29:25 -0700 (PDT)
Message-ID: <52c0d236-49c6-7c31-abd8-2a083ca7ef8c@linaro.org>
Date:   Wed, 13 Jul 2022 10:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
 <20220713063653.2584488-3-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713063653.2584488-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 08:36, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP VPU blk ctrl module has similar design as i.MX8MM, so reuse
> the i.MX8MM VPU blk ctrl yaml file. And add description for the items.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 93 ++++++++++++++++---
>  include/dt-bindings/power/imx8mp-power.h      |  4 +
>  2 files changed, 86 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
> index 26487daa64d9..d05930f61f95 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
> @@ -28,24 +28,15 @@ properties:
>  
>    power-domains:
>      minItems: 4
> -    maxItems: 4

This is not correct. maxItems must stay, but you could drop minItems,
prefferrably in separate patch.

>  
>    power-domain-names:
> -    items:
> -      - const: bus
> -      - const: g1
> -      - const: g2
> -      - const: h1
> +    minItems: 4

maxItems instead

>  
>    clocks:
>      minItems: 3
> -    maxItems: 3

Same error...

Best regards,
Krzysztof

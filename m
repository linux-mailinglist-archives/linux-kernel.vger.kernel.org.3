Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19065540746
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348440AbiFGRpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348185AbiFGRbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:31:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60F311E4AB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:29:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o7so3323115eja.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Qly2UIyOE8jeV4UIMO9/cbT7m/yg5zZN4spcrrGBuY=;
        b=Y6qrBUmNyxndVHvDEdVrGGkau8+wN4t82cmUBnOQFk3GEGZj6VNhHZUy22YizV9ln6
         EFsltomJCd6kyFokxtvKBcGaDI3XoW2hTCU1g89CMyqfp4I5GvB/LufsevPe/s4XMKV/
         1pkd5q3lbyqGAHxTmcNE9SFRVJVNGBXW2DAjOBJZ9aFZc9IT6WNWAxXBF3wpngkudFcw
         bHdeCnMOKba9yc57Rr6ibZtDPGEbb81jC25TjQjc8rJcIiBry7MwafG5Qi5cOHs3S3c0
         zanlP8LX+2O5fao7T22B3tFmD0l7d4L6JsfPGHojTJQ+urPLihkg0NsLAksVlpDCD368
         NueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Qly2UIyOE8jeV4UIMO9/cbT7m/yg5zZN4spcrrGBuY=;
        b=ebZSkSDEgSe7aeM8da+/ak2NkEFdSK9ODcV3YmadaEjoAlFpaz+3+AERMkP1ntgJbw
         4znFO6S5mA/UfBmKXe2rLbKVrfk1aLNVVlrhjGInYrSpcY8lqHLOMG55RQ5sGpWMAqkz
         Ng33YYVfiXou/kPM3zN7KLgr57dARJDP+Ncvl+EaLVCF9RI6KbJ5VkI0j2KTFR+aQ2p7
         hLDPLJ1FGHKI9BFl+2YoRTeX1uwnT9TEfXgRgy91V5zVwFJ0QEyLI/JcNt5mSaA2t7x4
         Y7eAUbra7LMDrkeewqVqz2GeBMfqUOQDD/QHBoAi4yghoi6h5muxoxRUwvVc5Cxsljsv
         fdbg==
X-Gm-Message-State: AOAM531nwwdQOTPMj4/Yc/IYZPtOjZ26ZBSNzGcUyB2dlKP5bJglikr0
        8Ug7VcaRc10GQuDFpIIyA5JAgQ/w1NrmGQ==
X-Google-Smtp-Source: ABdhPJxQllnLp5MdeAtv1dMJ/Mnqk9ZmQf9PtgCRrHGxsCtsV8I4AO0a7NAAkrbukOGwiVxtIhFLiw==
X-Received: by 2002:a17:907:16a1:b0:6fe:ffd9:b14f with SMTP id hc33-20020a17090716a100b006feffd9b14fmr27532053ejc.573.1654622982983;
        Tue, 07 Jun 2022 10:29:42 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090691c500b006feaa22e367sm7948656ejx.165.2022.06.07.10.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 10:29:42 -0700 (PDT)
Message-ID: <0549347e-1906-a293-ee7a-824578a00227@linaro.org>
Date:   Tue, 7 Jun 2022 19:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/10] dt-bindings: arm: freescale: Add fsl,scu-pd yaml
 file
Content-Language: en-US
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
 <20220607105951.1821519-7-abel.vesa@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607105951.1821519-7-abel.vesa@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 12:59, Abel Vesa wrote:
> This documents separately the PD child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,scu-pd.yaml    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-pd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-pd.yaml
> new file mode 100644
> index 000000000000..154a63495436
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-pd.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-pd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - Power domain bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +  Power domain bindings based on SCU Message Protocol
> +  This binding for the SCU power domain providers uses the generic power
> +  domain binding (Documentation/devicetree/bindings/power/power-domain.yaml)

Using of other bindings is reflected by '$ref'. Mentioning it in
description means nothing and it is not helpful. Reference the proper
schema instead.

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx8qm-scu-pd
> +          - fsl,imx8qxp-scu-pd
> +      - const: fsl,scu-pd
> +  '#power-domain-cells':
> +    const: 1
> +
> +additionalProperties: false

Use the same order as in example-schema.yaml, so for regular case:
properties+required+additionalProperties

when referencing other schema, without any if-then-else:
allOf:properties+required+additionalProperties

When having if-then-else:
properties+required+allOf+additionalProperties

> +
> +required:
> +  - compatible
> +  - '#power-domain-cells'


Best regards,
Krzysztof

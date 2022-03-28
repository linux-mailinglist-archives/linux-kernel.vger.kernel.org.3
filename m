Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72BE4E8E91
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiC1HE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiC1HE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:04:27 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2878C51323;
        Mon, 28 Mar 2022 00:02:47 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id r7so17817727wrc.0;
        Mon, 28 Mar 2022 00:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ttzi/tDXrHm8JXfwRNFC5cPrcAGFAj+WYkjayZngCu8=;
        b=JVN4QyL20AT+Hwp0tSCc566U7FRCbZ+Hd+6UR9/bDVzr7ob9OpI5bSteMatd2zLl60
         FrAQsoHYYYbsrLKy4ACGsY7Qpb6n2u3YWTlc5AdxcmL2BPfkItCh4o63yUSr9UMlfHtw
         MfcmDXikbCfaUXesbDrz9ZfRVVjTlIbjaQceri7C2IBHc12SGhJr4ovIVtGtEQhHLDxE
         EDoopj79pl1SPJQki6R2XtPKTEju/XOKzwlXsLQxyWFZhIAhBDrUVpqYgW2liiH6ZUs0
         ns0mw+y83FPubNg8JWQiJyOrh4PxnVfBa9RLiKRZxWj6RtvEpqGPepE1OvmGF/hPmP32
         yX8Q==
X-Gm-Message-State: AOAM533TIdGagTebpfxPu1NL2yiNiHiZqaldjE+jE8Sy01ldQMn8Nydq
        SWMiDIlguF7b/iAHoRhC6vY=
X-Google-Smtp-Source: ABdhPJzjQh8l8F30AwLVGvdhwBI0GFK0s4dzdv71thdlAp7gQee5x5HSXWJtKK4cj5Qf2Sh6uz7HCQ==
X-Received: by 2002:a5d:6487:0:b0:205:7c2b:b6ba with SMTP id o7-20020a5d6487000000b002057c2bb6bamr20807179wri.283.1648450965246;
        Mon, 28 Mar 2022 00:02:45 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id p8-20020a5d59a8000000b00204178688d3sm12528434wrr.100.2022.03.28.00.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 00:02:44 -0700 (PDT)
Message-ID: <04430db8-da9e-fcf0-c86a-6ef4c0d5408c@kernel.org>
Date:   Mon, 28 Mar 2022 09:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 1/6] ASoC: dt-bindings: Convert rt5659 bindings to
 YAML schema
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     oder_chiou@realtek.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
 <1648448050-15237-2-git-send-email-spujar@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1648448050-15237-2-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2022 08:14, Sameer Pujar wrote:
> Convert rt5659.txt DT binding to YAML schema. This binding is applicable
> to rt5658 and rt5659 audio CODECs.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Oder Chiou <oder_chiou@realtek.com>
> ---
>  .../devicetree/bindings/sound/realtek,rt5659.yaml  | 112 +++++++++++++++++++++
>  Documentation/devicetree/bindings/sound/rt5659.txt |  89 ----------------
>  2 files changed, 112 insertions(+), 89 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/rt5659.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
> new file mode 100644
> index 0000000..3bd9b6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/realtek,rt5659.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RT5658 and RT5659 audio CODECs
> +
> +description: This device supports I2C only.
> +
> +maintainers:
> +  - Oder Chiou <oder_chiou@realtek.com>
> +
> +allOf:
> +  - $ref: name-prefix.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,rt5658
> +      - realtek,rt5659
> +
> +  reg:
> +    description: The I2C address of the device

Skip the description, it's obvious.

> +    maxItems: 1
> +
> +  interrupts:
> +    description: The CODEC's interrupt output

Ditto.

> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Master clock (MCLK) to the CODEC
> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +
> +  realtek,in1-differential:
> +    description: MIC1 input is differntial and not single-ended.

typo (differential)

> +    type: boolean
> +
> +  realtek,in3-differential:
> +    description: MIC3 input is differntial and not single-ended.
> +    type: boolean
> +
> +  realtek,in4-differential:
> +    description: MIC3 input is differntial and not single-ended.

MIC4?

> +    type: boolean
> +
> +  realtek,dmic1-data-pin:
> +    description: DMIC1 data pin usage
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 # dmic1 is not used
> +      - 1 # using IN2N pin as dmic1 data pin
> +      - 2 # using GPIO5 pin as dmic1 data pin
> +      - 3 # using GPIO9 pin as dmic1 data pin
> +      - 4 # using GPIO11 pin as dmic1 data pin
> +
> +  realtek,dmic2-data-pin:
> +    description: DMIC2 data pin usage
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 # dmic2 is not used
> +      - 1 # using IN2P pin as dmic2 data pin
> +      - 2 # using GPIO6 pin as dmic2 data pin
> +      - 3 # using GPIO10 pin as dmic2 data pin
> +      - 4 # using GPIO12 pin as dmic2 data pin
> +
> +  realtek,jd-src:
> +    description: Jack detect source
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 # No JD is used
> +      - 1 # using JD3 as JD source
> +      - 2 # JD source for Intel HDA header
> +
> +  realtek,ldo1-en-gpios:
> +    description: The GPIO that controls the CODEC's LDO1_EN pin.

maxItems

> +
> +  realtek,reset-gpios:
> +    description: The GPIO that controls the CODEC's RESET pin.

maxItems

What about the ports node?


Best regards,
Krzysztof

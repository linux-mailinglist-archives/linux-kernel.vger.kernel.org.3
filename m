Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA557E731
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiGVTS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiGVTSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:18:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D55E31F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:18:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id k19so6513782lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kjnz9jnBzE7TgHYD4icOZx+MB0ePlqFO/pSn3BcmO+0=;
        b=zrdZV1N8rcljnnm792VSjQ58hdKWLtfgPqKQdfcSLXzUErMw+skmwdSXV2F1TitH/J
         NXuvWrAerVaTlGh64K45PDLNZTuQHps12d5me3DX8ZH+ldaHlB9pjB4/jMARTYbq1mDC
         At2wOShU5RXVlK1WMDpuOxXf0+b8seAI639XdkJnWGDlUJNVEw+NrXluQNBlMVrgHYFu
         IoQENpAAY67ayReLSP6wxkz7wKMI734bKY81eb6+d64imahKqTz7wNKWoTii6KD+qhKv
         T30tdvfqWDd7ikzgol6ERulCLyJ/niszNvhehaE7QBt7nMOzDRKQQL0F61U4Ospmw5FP
         rqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kjnz9jnBzE7TgHYD4icOZx+MB0ePlqFO/pSn3BcmO+0=;
        b=dv8QsfmbdAPJAbU9JLHcBrIly/vcovhsYtNZW1FtpZlSEvRnzKNnFK0gn2zReH45ry
         9ZnFh2y88ZurVbsKKC5yKHwNYc5plJVzJotFbSmcMYpHkR2tFsrzaW7WllyBFcDqzm3K
         HbAyrfr6VA6hIlRl+hgtPE5POElxLb25CMmKGmpttKEe3MhTTX/S7jlhE7erdjajCT4p
         80RHyKbvjm0yfnnTQIbAbYrH7chE5gKdre+QLsSI7zPVzLeFhWTUJRx8hj8OV8VLLnRw
         1DfkK6hV/GEPvMkWj/1cSK3QvKfSHyzZT4lbcIHiYhkB4pWOLv3xd6sjjFDu2Ffz8Xfu
         6MPA==
X-Gm-Message-State: AJIora/31b9bqIUrf+q9M23p2SbA8C/8I5QQT00iHG8qS/2bP1fWkFHR
        FU1gq2V5wr0PPZBWAGbUJcz8VA==
X-Google-Smtp-Source: AGRyM1tCLElgP8uPh4Z9md/fxoYz+LRieaRoF2qyv6YfjK5RUT+HTsr3Y0dq0yujq9NNuHAuCiG6qg==
X-Received: by 2002:a05:651c:20e:b0:25d:521d:66e2 with SMTP id y14-20020a05651c020e00b0025d521d66e2mr517200ljn.258.1658517532596;
        Fri, 22 Jul 2022 12:18:52 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id o8-20020ac24e88000000b00484edac69ccsm1214228lfr.43.2022.07.22.12.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 12:18:52 -0700 (PDT)
Message-ID: <85199046-b1ff-0b41-0938-172c55b7a4c5@linaro.org>
Date:   Fri, 22 Jul 2022 21:18:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: memory-controller: Document Broadcom STB
 MEMC
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220722184138.2666241-1-f.fainelli@gmail.com>
 <20220722184138.2666241-2-f.fainelli@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722184138.2666241-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 20:41, Florian Fainelli wrote:
> Document the Broadcom STB memory controller which is a trivial binding
> for now with a set of compatible strings and single register.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../memory-controllers/brcm,memc.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml b/Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml
> new file mode 100644
> index 000000000000..a629734f0cd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/brcm,memc.yaml#

Filename like first compatible, so: brcm,brcmstb-memc-ddr.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Memory controller (MEMC) for Broadcom STB
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,brcmstb-memc-ddr-rev-b.1.x
> +          - brcm,brcmstb-memc-ddr-rev-b.2.0
> +          - brcm,brcmstb-memc-ddr-rev-b.2.1
> +          - brcm,brcmstb-memc-ddr-rev-b.2.2
> +          - brcm,brcmstb-memc-ddr-rev-b.2.3
> +          - brcm,brcmstb-memc-ddr-rev-b.2.5
> +          - brcm,brcmstb-memc-ddr-rev-b.2.6
> +          - brcm,brcmstb-memc-ddr-rev-b.2.7
> +          - brcm,brcmstb-memc-ddr-rev-b.2.8
> +          - brcm,brcmstb-memc-ddr-rev-b.3.0
> +          - brcm,brcmstb-memc-ddr-rev-b.3.1
> +          - brcm,brcmstb-memc-ddr-rev-c.1.0
> +          - brcm,brcmstb-memc-ddr-rev-c.1.1
> +          - brcm,brcmstb-memc-ddr-rev-c.1.2
> +          - brcm,brcmstb-memc-ddr-rev-c.1.3
> +          - brcm,brcmstb-memc-ddr-rev-c.1.4
> +      - const: brcm,brcmstb-memc-ddr
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    memory-controller@9902000 {
> +        compatible = "brcm,brcmstb-memc-ddr-rev-c.1.1",
> +                        "brcm,brcmstb-memc-ddr";

Could you align it with previous quote "?

Other than that, looks ok, but anyway this will have to wait for merge
window to finish.

> +        reg = <0x9902000 0x600>;
> +    };


Best regards,
Krzysztof

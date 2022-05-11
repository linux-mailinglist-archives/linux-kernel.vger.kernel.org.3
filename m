Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AF0523AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbiEKQwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbiEKQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:52:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E8E63BD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:52:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ch13so5221756ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=fJMrUxecDMgBluXgdeiExZun38GRKFbcmLUZIGmMcu4=;
        b=GH1/AcFtV52HHv73C7PZgBr3qe/HUYqY2Tv4q8Dco12i8SqISC3UcXhGwcytiZXbal
         bScMqGXMYhiE0jlT1IFCSq9UFJvss9iXv5HFeI1VdH8JaCL1hPYbn2w2iz3WlS0JbqW7
         rqIT9exhQjO99SPDqT6uTMUGH/vW6q6QURdtcTL/bQ1jFhmNqPUvKol2F7T3RHljJKME
         shI+UnDSLzGgET18G6hpyrV5tdV82V+/fL4iwcXLq3MJy7m7N4QiJNoF2hPlcPHiq5Zs
         +ufpVOyXt21mywbFg3M11Msv9vWRvjgtFov2QLDIfN2uTIIcGyKB+iFQmad73luqcXJK
         vvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fJMrUxecDMgBluXgdeiExZun38GRKFbcmLUZIGmMcu4=;
        b=PMBBCKWPr80gNcXhhR9Pkcb6g8ymSXY+JugbaRMg7IiQUWOkamDfygGFSOHThs+vxa
         QZrJL5jzvqeVSEXej8z1d0qyop8e1OpXwv3uxzj6JrKDXgNBgGCE6MStCIw24oKnig9q
         r2+MZRqtKKijZ0OBBGIbdTnpHhuKJg55+erdF1gTAE27MhMr0w2u++ydQNMIbQCM/Vzl
         MjE1C3X+7/ryD5+F4SqbgO4Z92FGUknkSyaeAq4LkGYVHHI4GK1HiCcMliPqrgdUv5DJ
         Cx3ZRwXrRda+YXJTA/dwtMsDTdqpUPu8i/DnL7dL02uHpm3BsH/VYNLJNC6rJ2ZO+/D1
         XmVg==
X-Gm-Message-State: AOAM533XXNDk1c3Nzi59dZHcUmvJShDDfr668zw0KUP2LVGlQ24MgSQg
        N0Id4jygzMc/gns7ga+PzibiRg==
X-Google-Smtp-Source: ABdhPJwcAGyOx0j3QQFP2Vd5OOE0tFXzzlUpfWzLlZ6E4ig9i5LV4PCs8o3lbJzhmp1a4Vv9V7lJDA==
X-Received: by 2002:a17:907:3e04:b0:6f5:1132:59de with SMTP id hp4-20020a1709073e0400b006f5113259demr26862519ejc.755.1652287965166;
        Wed, 11 May 2022 09:52:45 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y13-20020a056402134d00b0042617ba63d6sm1405282edw.96.2022.05.11.09.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:52:44 -0700 (PDT)
Message-ID: <0815f581-ca5b-6fb6-a59e-f5d0a3686caa@linaro.org>
Date:   Wed, 11 May 2022 18:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 02/11] dt-bindings: marvell: convert Armada 37xx
 compatibles to YAML
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pali@kernel.org, marek.behun@nic.cz
References: <20220510124929.91000-1-robert.marko@sartura.hr>
 <20220510124929.91000-2-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510124929.91000-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 14:49, Robert Marko wrote:

Thank you for your patch. There is something to discuss/improve.

> -
> - - compatible: must contain "cznic,turris-mox"
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> new file mode 100644
> index 000000000000..3f41ef2c6f3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/marvell/armada-37xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Armada 37xx Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Armada 3710 SoC
> +        items:
> +          - const: marvell,armada3710

This does not look correct. The SoC usually cannot be used by itself,
it's always a part of some product, SoM, board.

> +
> +      - description: Armada 3720 SoC
> +        items:
> +          - enum:
> +              - marvell,armada-3720-db
> +              - globalscale,espressobin
> +              - cznic,turris-mox
> +              - methode,udpu

Order by name.

> +          - const: marvell,armada3720
> +          - const: marvell,armada3710
> +
> +      - description: Globalscale Espressobin boards
> +        items:
> +          - enum:
> +              - globalscale,espressobin-emmc
> +              - globalscale,espressobin-ultra
> +              - globalscale,espressobin-v7
> +          - const: globalscale,espressobin
> +          - const: marvell,armada3720
> +          - const: marvell,armada3710
> +
> +      - description: Globalscale Espressobin V7 boards
> +        items:
> +          - enum:
> +              - globalscale,espressobin-v7-emmc
> +          - const: globalscale,espressobin-v7
> +          - const: globalscale,espressobin
> +          - const: marvell,armada3720
> +          - const: marvell,armada3710
> +
> +additionalProperties: true


Best regards,
Krzysztof

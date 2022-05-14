Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70E7527405
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 22:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiENUlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 16:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiENUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 16:41:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A117E13D23
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 13:41:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b32so14004222ljf.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3iGzxhbVDLQZMgpEjJUgXyEyHAViP8oVHF1txcdlmV8=;
        b=N5MEGBb3bmfvLt1/VDR6ABuN7P+f9Tl+Bxv6+Q10oz9k6BZjpxCxTVG1ogxADxZEVK
         H+F6YZmN8Sc2NfAzdP7wCkmz2ppvmZ+fPwE53G10Roc4XXFAU7KHLlqmFx26bEgHYWSs
         AJMXNfa9t6QcsVrfjwnYJENCWd99ZM0lyolA4iWVr9CV9i3sjq/LI2cztTT5XXJ35D8x
         IH/IvnpsT2xS/dXXjtOBpXQaflHYwWGu/QknuGyuv6fVyiuomHC0cTWAOYIQlW/zZFmN
         aIDp5Ssp1R85gu8/sksKG+wAV9NE96tAO2fcEZ+FJc8MaMTEN1YiXa9pxcxSp68wT31A
         ueUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3iGzxhbVDLQZMgpEjJUgXyEyHAViP8oVHF1txcdlmV8=;
        b=IGxsK3kMOUVZ78RDTO58t9IIaCKF3yC4jWTRPuD7TqSYUYpkM3El5XnoyqKllMUyQH
         uEKe5uuG9VdKG2Tz/WHDc2YafSpzrGqSZf0sNlP2ZNmgDWESgP5n0hFm+1ggzI2srP7T
         PtIcFaoOEyowsNjmtN32/rJAq62XpjlY0wSYEl9A2BTbPpKZwul+CJjAo7CRoR26vDOk
         ZKLunJFcdFbTj2sogZ/g4NDCiTvQpuIMYy9iGHadZNmCg1cO+pJj0SJL2rQGFObDPSs0
         YHKKSlMFNVC0nLEXDnHcU2R1DYxV/ddkESUOWNVHRRv4DjoCqNeOv+3MludCYtsl/0P+
         01ZQ==
X-Gm-Message-State: AOAM531/7Z1Qv7HDlU9IIzTKhDaNBvbd4U6sRYAT+IbhMImPvrg/jekV
        C5qs/Vdv7tn9njRTfB/ris88IQIhxd1Q+os8
X-Google-Smtp-Source: ABdhPJwMF2agC7adkE7LOWfQCIhtnfSu8UkDs0sf2IPbdLJ15Vg9UmKKnsHofQjhK629bnaqat+Yrw==
X-Received: by 2002:a2e:b00a:0:b0:24f:e0f:dd1f with SMTP id y10-20020a2eb00a000000b0024f0e0fdd1fmr6651385ljk.221.1652560890936;
        Sat, 14 May 2022 13:41:30 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v10-20020a2e504a000000b0024f3d1dae93sm945554ljd.27.2022.05.14.13.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 13:41:30 -0700 (PDT)
Message-ID: <440a7dc6-7ec4-d7a9-0c56-3b3dc15b79d0@linaro.org>
Date:   Sat, 14 May 2022 22:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/3] media: dt-binding: media: Add rockchip-vepu
 binding
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220514133604.174905-1-frattaroli.nicolas@gmail.com>
 <20220514133604.174905-2-frattaroli.nicolas@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220514133604.174905-2-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2022 15:36, Nicolas Frattaroli wrote:
> The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
> encoding. This patch adds a new binding to describe it, as it
> does not really fit the rockchip-vpu binding, since there is no
> decoder.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  .../bindings/media/rockchip-vepu.yaml         | 64 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip-vepu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip-vepu.yaml b/Documentation/devicetree/bindings/media/rockchip-vepu.yaml
> new file mode 100644
> index 000000000000..b7ba5bf3517a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/rockchip-vepu.yaml

Filename: vendor,device (not hyphen)
It would be actually better if it followed the first compatible, so
"rockchip,rk3568-vepu.yaml"


> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/media/rockchip-vepu.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Hantro G1 VPU encoders implemented on Rockchip SoCs
> +
> +maintainers:
> +  - Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> +
> +description:
> +  Hantro G1 video encode-only accelerators present on Rockchip SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3568-vepu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk

Since these are new bindings, it would be good to follow DT convention
and not add common "clk" prefix to clocks. Just like DMA is "tx" not
"txdma". However clock names "a" and "h" are also not good and maybe
this is already shared implementation?

> + 
> +  power-domains:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/clock/rk3568-cru.h>

Indentation starts at "|" (so four spaces)

> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        #include <dt-bindings/power/rk3568-power.h>
> +
> +        vepu: video-codec@fdee0000 {

four spaces.

> +                compatible = "rockchip,rk3568-vepu";
> +                reg = <0x0 0xfdee0000 0x0 0x800>;
> +                interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
> +                clock-names = "aclk", "hclk";
> +                iommus = <&vepu_mmu>;
> +                power-domains = <&power RK3568_PD_RGA>;
> +        };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ce78f2275dc..f901a42e5d0f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8637,6 +8637,7 @@ L:	linux-media@vger.kernel.org
>  L:	linux-rockchip@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> +F:	Documentation/devicetree/bindings/media/rockchip-vepu.yaml
>  F:	Documentation/devicetree/bindings/media/rockchip-vpu.yaml
>  F:	drivers/staging/media/hantro/
>  


Best regards,
Krzysztof

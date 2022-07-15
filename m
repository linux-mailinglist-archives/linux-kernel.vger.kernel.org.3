Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24631575CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiGOH5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiGOH5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:57:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173A87D7B3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:57:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v15so1121657ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pVS+MTH1XwU1cvawHiiTO1k5At4xPOvBRcWn0E0JKnQ=;
        b=nPbUHaxTybTz+hSdJPP6CMy/vM/46yKwRrdEcsM8O2DT/PEmEm8ExTH8fb2rzJxdNf
         xjorId7Lq1mqbvJSYX2eyWQlr2irAmSAS6rnsqJDpmwkL+6QGJrJDDAQyzR9Iy8xuw+W
         G2Ytl4E09lz7ry/bTjvMUCO5DGdJuNBD5GGICRvvIb1oJkkbuio9/j0nVaKx0WPjH71e
         +AvFWG+fw+j8KIMVJGW2e2zw/kH23rcpmVVe6i5I+58UpQ0pAGEMQ0Ab8I1eatNJjP6W
         PSc5bjLGmcyTLTiBxDZGy1rct8c9+FJxaOOz8NoDM7ZjauLPS6uNYjJzZUgZotVcLO5+
         wEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pVS+MTH1XwU1cvawHiiTO1k5At4xPOvBRcWn0E0JKnQ=;
        b=al8uDcXZl2rFb+wIk0muwflKVvY0NM0JxvHq7EQfLMJYl5RZkcFvU4icRUMGXbmwww
         Eu0y3N8cskxg1WMxTOQbblgLURuJRsd77H3M1JFgcbzZszZz1fSCtDShsR/zR4ZvGLgg
         1hGOIyWCae0TPMTcL1By96VC5a0xw/iSzSXgVZvXyVI+J61FkwjTVT7nmW84z7fbQWW0
         9XL52oBRr+GQoCN/HYtpACwdyhy/Y/XNDN0ij1gtRFUZaeG3IHtpIC/hN+VRzLU+na/v
         mBHA8ZrDvC78JXcET7uiSRIB/zaiqIKRnVqt8DOY+myNwJX9gClmqCn2bbY6gFSRbYRK
         DbxA==
X-Gm-Message-State: AJIora/RR2TtfiyFuDNXKKlPpN5Opn/VjT90DdVR26+axcqVqOLqTkJT
        BvyxyZvyFEYxQzpbosRSGcWVVA==
X-Google-Smtp-Source: AGRyM1ulJRngwtrHtmZz4bY0FMFRN0qrWGaMpBxRh+yPkwrRe6nsqVmc0rblcJXm/KEw4Ov5c3GRWw==
X-Received: by 2002:a2e:9854:0:b0:25d:883d:faf2 with SMTP id e20-20020a2e9854000000b0025d883dfaf2mr6010968ljj.223.1657871838444;
        Fri, 15 Jul 2022 00:57:18 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id b13-20020a056512070d00b0048960b581e3sm778642lfs.8.2022.07.15.00.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 00:57:17 -0700 (PDT)
Message-ID: <46df4ad5-5102-b5fe-95b7-5b157fb28f01@linaro.org>
Date:   Fri, 15 Jul 2022 09:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/19] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-4-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714122837.20094-4-tinghan.shen@mediatek.com>
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

On 14/07/2022 14:28, Tinghan Shen wrote:
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,scpsys.yaml         | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> new file mode 100644
> index 000000000000..a8b9220f2f27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,scpsys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek System Control Processor System
> +
> +maintainers:
> +  - MandyJH Liu <mandyjh.liu@mediatek.com>
> +
> +description:
> +  MediaTek System Control Processor System (SCPSYS) has several
> +  power management tasks. The tasks include MTCMOS power
> +  domain control, thermal measurement, DVFS, etc.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,scpsys
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-controller:
> +    $ref: /schemas/power/mediatek,power-controller.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    syscon@10006000 {
> +        compatible = "mediatek,scpsys", "syscon", "simple-mfd";

This should be a SoC-specific compatible (and filename).

> +        reg = <0x10006000 0x100>;
> +
> +        spm: power-controller {

I think you created before less-portable, quite constrained bindings for
power controller. You now require that mt8195-power-controller is always
a child of some parent device which will share its regmap/MMIO with it.

And what if in your next block there is no scpsys block and power
controller is the scpsys alone? It's not possible with your bindings.

Wouldn't it be better to assign some address space to the
power-controller (now as an offset from scpsys)?

This is just wondering (Rockchip did the same...) and not a blocker as
power-controller bindings are done.

Best regards,
Krzysztof

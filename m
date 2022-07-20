Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6757BCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiGTRf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGTRfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:35:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F426566
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:35:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y11so31448752lfs.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+VUY7671QYRMc/cXgTi22UTEvLQKFmkZ4mq/8MUBSOU=;
        b=WuhbcQGCM07g8PxlzDwXWu4Q0+gU6wXSleBaqwNSxpr4ez0Tl6UiELTxqOPsY5XJCL
         c9m6kJlYoosF/pUBt5g7dM7Hx5Jw0osbPFB2tgrlWLUJUi0vij7aDkF03mICIwuOUj1j
         T20UQGIoZOwDlWmfK0TgR6rAmei8GXfFtrt54LIIS0Xtye9hLNehKqO46XrbEvPxCM1t
         kCVq9EdbDB8DXAstlBCN5hcK0GTT+9bDhl9wZvJ3UNgIfQ+LSSMFLOO05xSeum5+UNbu
         q4UWhkwr+hVvqaCBjloRBJ+ti+ejZYCVNA++cGK0nqzLObHCfBOxzdVvoJC2Inku+kAY
         TGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+VUY7671QYRMc/cXgTi22UTEvLQKFmkZ4mq/8MUBSOU=;
        b=a9Rzc81UWLxWqxBkGFAHYqGpkN/VO2GcYokUINVuCqS44pDGhtva5oHfaOrfVQchj2
         +1qYVgXlHJuWUqf9vR2UhPkVKzOdtPkI/MfW/TMoSvYGoyIe3zjNbyq3Mysw9DYx9EnW
         K5ZLlV/hL1CCOm9OC4jlKbjPGH0VcGxkVD3d89Q9Bw3+uxjYopX+19JKT0SsEhquhByn
         SQh8DCf4bOVItWl86QX1s2q1F4+ODLaVUMsugyJYBrVo4aQJ7fhpA3KXybeo6XxUTPOE
         Ai8PtuSTPya9bLW+28wyrvKxuQeMWUQdyqbLzP8UU/iX1j7WaozxWcUKW/LDGOiNKVTI
         MWFA==
X-Gm-Message-State: AJIora+UrSDP6xq95gLnN34REYU5c2a8cs6cI01EcvhyXZzuUTpDvZsu
        1AxZHvYJkUNXx5OZ/SrlMP+eLA==
X-Google-Smtp-Source: AGRyM1uY3bw40ky2fyHO3gLmhER9ViMzHUUQc2mqlW923j48d+elYuxDaT6AIwbrPqOqmiWkdx13Wg==
X-Received: by 2002:a05:6512:3452:b0:486:eff:739c with SMTP id j18-20020a056512345200b004860eff739cmr20214593lfr.549.1658338551068;
        Wed, 20 Jul 2022 10:35:51 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id u17-20020ac258d1000000b00478a311d399sm3918205lfo.0.2022.07.20.10.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:35:50 -0700 (PDT)
Message-ID: <57b0cf62-0312-05cf-31ff-d38f83a35578@linaro.org>
Date:   Wed, 20 Jul 2022 19:35:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-7-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720123023.13500-7-tinghan.shen@mediatek.com>
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

On 20/07/2022 14:30, Tinghan Shen wrote:
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> new file mode 100644
> index 000000000000..4117a6dbc19c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
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
> +      - enum:
> +          - mediatek,mt8167-scpsys
> +          - mediatek,mt8173-scpsys
> +          - mediatek,mt8183-scpsys
> +          - mediatek,mt8192-scpsys
> +          - mediatek,mt8195-scpsys
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^power-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/power/mediatek,power-controller.yaml#

We talked that unit address might be useful but it was with an
assumption that you will actually use it. I think you don't use it, so
it is kind of meaningless now... unless you plan to use it?

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
> +        compatible = "mediatek,mt8195-scpsys", "syscon", "simple-mfd";
> +        reg = <0x10006000 0x100>;
> +
> +        spm: power-controller {
> +            compatible = "mediatek,mt8195-power-controller";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #power-domain-cells = <1>;
> +
> +            /* sample of power domain nodes */
> +            power-domain@MT8195_POWER_DOMAIN_PCIE_PHY {
> +                    reg = <MT8195_POWER_DOMAIN_PCIE_PHY>;

Wrong indentation.


Best regards,
Krzysztof

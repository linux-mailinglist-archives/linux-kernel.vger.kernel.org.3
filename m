Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D5955AC92
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiFYU3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiFYU3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:29:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119A4DF54
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:29:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eq6so7858321edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CyZdIB+a3zmI9o7okjV52QU2Tq6j8r50F7h1g1/ZmqM=;
        b=jh1P9SHTYiAY6bJeR6u5NXLil88CtmmVqCbzHotLRzOL2Uckkj8zWG4OGOELTd5s60
         yyymcNJwXxFkpHnuqFpuqtjPJL7L8GVR6j1Yv+mxzhTqDuUWsXXe4Xq73f9dU6gJsT2M
         9RC5dc6PF4Tfjrg64GyzSY2T3uIe9dS97Ybx6dQbikZ2qEUz2mgkL6UYSL1lZcVn1bVU
         NXpkl29vfd+iHN4xvmv0MnSxr/ln8wSE1K46AKqhsv2Lhu+XDwHNJ6WRqssjIlzBUaAf
         b6wVTAGq38CTBfNUF6dGDhRdnjWD4ebbw0MOTLuHr/bfGtYMKiCegkxvdAipfPMbeESd
         Lm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CyZdIB+a3zmI9o7okjV52QU2Tq6j8r50F7h1g1/ZmqM=;
        b=eIWLiqvXlM+Hko4E93ROgxhdazLtyrD2OBx/BANtkNQk1mHsmd78c3QuHQ9+1mf+Hd
         2owRp2oo3Xu+Wx0h68qohsG3HgzJzZR9K8pLLWTw7ngHgYZ4qNKsfaU2hoNGl4Z8fOz3
         M7mnOAWXKcnI73yACj5hy3TH18HWk9nMiNHe/BeqrO+1x/yygGy3ElhlS1vVBuPFkuCl
         4Dj62SOct1sMl+brfZ39QKLw3CxWZpanoFXnvw1ffrdx9maD/jnAOkX2sMmMe1x1w1uL
         gNhp65HuHQCD1LeGciuXFo/4C8+mjMhTLqS2Jn8iEgehqkIYLZ0Ua5Ml6TpQODigbM2M
         YXaQ==
X-Gm-Message-State: AJIora/UxgQ0DSeu/9+74Ly5gCPojuffgz0Wk61ThT+VF7tNha4TnAP3
        nVWQP4VF6ha7IK1n7maOXJJ47w==
X-Google-Smtp-Source: AGRyM1v6ZQH0/qOeo1s9JIO2lBEu0I3AR8lap3IT4Akxx776t9v/QxwM3w6b6PhwZmfK4m5bsV8r/A==
X-Received: by 2002:a05:6402:e0c:b0:435:25cd:6088 with SMTP id h12-20020a0564020e0c00b0043525cd6088mr6989495edh.60.1656188949672;
        Sat, 25 Jun 2022 13:29:09 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jw14-20020a170906e94e00b007263481a43fsm2644762ejb.81.2022.06.25.13.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:29:09 -0700 (PDT)
Message-ID: <cea65d6a-7d9b-7b14-9984-bcd7f115da47@linaro.org>
Date:   Sat, 25 Jun 2022 22:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/7] dt-bindings: clock: mediatek: Add clock driver
 bindings for MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com>
 <20220624093525.243077-5-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624093525.243077-5-angelogioacchino.delregno@collabora.com>
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

On 24/06/2022 11:35, AngeloGioacchino Del Regno wrote:
> Add the bindings for the clock drivers of the MediaTek Helio X10
> MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/clock/mediatek,mt6795-clock.yaml | 66 +++++++++++++++++
>  .../clock/mediatek,mt6795-sys-clock.yaml      | 74 +++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
> new file mode 100644
> index 000000000000..795fb18721c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/mediatek,mt6795-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek Functional Clock Controller for MT6795
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description: |
> +  The clock architecture in MediaTek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The devices provide clock gate control in different IP blocks.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6795-mfgcfg
> +      - mediatek,mt6795-vdecsys
> +      - mediatek,mt6795-vencsys
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mfgcfg: clock-controller@13000000 {
> +            compatible = "mediatek,mt6795-mfgcfg";
> +            reg = <0 0x13000000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +
> +        vdecsys: clock-controller@16000000 {
> +            compatible = "mediatek,mt6795-vdecsys";
> +            reg = <0 0x16000000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +
> +        vencsys: clock-controller@18000000 {
> +            compatible = "mediatek,mt6795-vencsys";
> +            reg = <0 0x18000000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> new file mode 100644
> index 000000000000..44b96af9ceaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/mediatek,mt6795-sys-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek System Clock Controller for MT6795
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The Mediatek system clock controller provides various clocks and system configuration

Wrap according to Linux coding convention, so at 80.

> +  like reset and bus protection on MT6795.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt6795-apmixedsys
> +          - mediatek,mt6795-infracfg
> +          - mediatek,mt6795-pericfg
> +          - mediatek,mt6795-topckgen
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        topckgen: clock-controller@10000000 {
> +            compatible = "mediatek,mt6795-topckgen", "syscon";
> +            reg = <0 0x10000000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +
> +        infracfg: power-controller@10001000 {
> +            compatible = "mediatek,mt6795-infracfg", "syscon";
> +            reg = <0 0x10001000 0 0x1000>;
> +            #clock-cells = <1>;
> +            #reset-cells = <1>;

No need for four examples of the same. They differ only by compatible,
so this is just unnecessary code... which as you can see does not pass
the checks. This also has to be fixed.

Maybe keep it as clock-controller?


Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E83D528BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344278AbiEPR21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiEPR2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:28:23 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147C91EEFF;
        Mon, 16 May 2022 10:28:22 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id m25so19453523oih.2;
        Mon, 16 May 2022 10:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wPpscCa2GIFkySmjw5GUwkyZ+UiIs3l9izNHfq7Aa2M=;
        b=j63O0KR9lmcfHBr9Dlv6hwDTYyNFqSLVPBBvd45EAcXMvUXhG8PwwzCPmy03TcqT/+
         DriWEVB+AG2ey8eiXo/A3TMUj6CB3o08/vTc1nfK9I1tkweIUFLp6Fe9YkknhihiM3GT
         NiH7bVHLuO7t1VQWaYRytCQaYzOv3+nkNGnPVXthR7XmA4FLQPBen4pLcqH/RE5n/KQC
         45h74b9F86yydXyHM+e/MG8rTgI97u0/P6BaC7V2+bY4flMoaHRcOcWvJ/u9RC6Lop0U
         9V9Ze+2OoDXSSaHBefZakVo+3BuFE6dxrwzJeAHHnc0c5yWTGTQpuy9yQRJFGRqnxwu0
         QHng==
X-Gm-Message-State: AOAM531k9qyi6sTWeOVcS9AlosyVnmHP6vd3TFHxy9KncAnF/8Cc54FZ
        1TTHs+tXVkrSROPuVS5cIw==
X-Google-Smtp-Source: ABdhPJwUrisBSYtA1OrplifhC1XpMjP+Aq57zo5rc2g+9vWodKCKsoozbjCrFXi567TNb0emYI/VXA==
X-Received: by 2002:a05:6808:1b2c:b0:326:6bc9:4070 with SMTP id bx44-20020a0568081b2c00b003266bc94070mr8220903oib.248.1652722101353;
        Mon, 16 May 2022 10:28:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u7-20020a056871058700b000e686d13876sm5795033oan.16.2022.05.16.10.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:28:20 -0700 (PDT)
Received: (nullmailer pid 2941200 invoked by uid 1000);
        Mon, 16 May 2022 17:28:19 -0000
Date:   Mon, 16 May 2022 12:28:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
Subject: Re: [PATCH 4/5] dt-bindings: arm: mediatek: Add clock driver
 bindings for MT6795
Message-ID: <20220516172819.GA2938099-robh@kernel.org>
References: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com>
 <20220513165050.500831-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513165050.500831-5-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 06:50:49PM +0200, AngeloGioacchino Del Regno wrote:
> Add the bindings for the clock drivers of the MediaTek Helio X10
> MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../arm/mediatek/mediatek,mt6795-clock.yaml   | 67 +++++++++++++++++
>  .../mediatek/mediatek,mt6795-sys-clock.yaml   | 73 +++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-sys-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml
> new file mode 100644
> index 000000000000..b7d96d0ed867
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt6795-clock.yaml#"
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
> +    items:

Don't need 'items' if only 1 item.

> +      - enum:
> +          - mediatek,mt6795-mfgcfg
> +          - mediatek,mt6795-vdecsys
> +          - mediatek,mt6795-vencsys

blank line.

> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg

Why is #clock-cells optional? 

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@13000000 {
> +            compatible = "mediatek,mt6795-mfgcfg";
> +            reg = <0 0x13000000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +
> +        clock-controller@16000000 {
> +            compatible = "mediatek,mt6795-vdecsys";
> +            reg = <0 0x16000000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +
> +        clock-controller@18000000 {
> +            compatible = "mediatek,mt6795-vdecsys";
> +            reg = <0 0x18000000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +    };
> +
> +
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-sys-clock.yaml
> new file mode 100644
> index 000000000000..389dd8e245ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-sys-clock.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt6795-sys-clock.yaml#"
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

#clock-cells?

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
> +        }
> +
> +        pericfg: power-controller@10003000 {
> +            compatible = "mediatek,mt6795-pericfg", "syscon";
> +            reg = <0 0x10003000 0 0x1000>;
> +            #clock-cells = <1>;
> +            #reset-cells = <1>;
> +        };
> +
> +        apmixedsys: clock-controller@10209000 {
> +            compatible = "mediatek,mt6795-apmixedsys", "syscon";
> +            reg = <0 0x10209000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +    };
> -- 
> 2.35.1
> 
> 

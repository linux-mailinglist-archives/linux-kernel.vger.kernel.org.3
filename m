Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95615510A63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354663AbiDZU2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354496AbiDZU21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:28:27 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5FD12094;
        Tue, 26 Apr 2022 13:25:17 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id l9-20020a056830268900b006054381dd35so13859528otu.4;
        Tue, 26 Apr 2022 13:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CDitmLcfe9Gh2apmzasOQHFfqUIRmgYygc4lrxKNp1k=;
        b=hFuh7U1GsZdyKssocyhqXxSBD3oo+7M/MMoliWhrJkcgnDIbtDHmW0H73fyOTh7Tte
         zRJseaswqoURA2mW1ij1ujkvN1LvuMu/QK9X8C8IYMAjyYf/S6Fht5RlD9YxxJJaduVH
         OjO+FPhe/gyY82EgLyEZ96irgw8VCRNimTwfACH0fENvr2epUGIo/LfLTywKzGo4thKi
         gCoFrIZ2x5SE5kvjpjKw7RWaG++uW/ozW9XYKi84fIVBVnD7YkrgoeQ/PawDFOeLK7Wp
         +QEAUQF0UWcTCTxUGvXmXToJmfOykt7I2XZXBPpCk28CBI7Bo8SPY1AMLV+h7HzPH2kQ
         foDQ==
X-Gm-Message-State: AOAM532+cFaB9tv946wMxcsDNmYZLdkTBAa5xahsU8fEVOsEykxou8Eb
        w9eMGXR0clE21LklL5pSpw==
X-Google-Smtp-Source: ABdhPJw9iFc8l60BaJ4s5XVbB0yJaQFye+gSvfzabI2OvFjb68bZLValzm4yQMtKR0Ucjg9se16hfQ==
X-Received: by 2002:a9d:7548:0:b0:605:54d7:44a2 with SMTP id b8-20020a9d7548000000b0060554d744a2mr8894946otl.23.1651004716564;
        Tue, 26 Apr 2022 13:25:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u7-20020a4a85c7000000b0035c12c8be73sm6105097ooh.29.2022.04.26.13.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:25:16 -0700 (PDT)
Received: (nullmailer pid 2477068 invoked by uid 1000);
        Tue, 26 Apr 2022 20:25:15 -0000
Date:   Tue, 26 Apr 2022 15:25:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        nancy.lin@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 3/5] dt-bindings: mediatek: add vdosys1 RDMA definition
 for mt8195
Message-ID: <YmhVKw/FQ/iQfLLD@robh.at.kernel.org>
References: <20220419033237.23405-1-rex-bc.chen@mediatek.com>
 <20220419033237.23405-4-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419033237.23405-4-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:32:35AM +0800, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 RDMA definition.

How does this compare to the mediatek,mt8183-mdp3-rdma or 
mediatek,mt8195-disp-rdma?

> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,mdp-rdma.yaml   | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> new file mode 100644
> index 000000000000..6ab773569462
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mdp-rdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MDP RDMA
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +description: |
> +  The mediatek MDP RDMA stands for Read Direct Memory Access.
> +  It provides real time data to the back-end panel driver, such as DSI,
> +  DPI and DP_INTF.
> +  It contains one line buffer to store the sufficient pixel data.
> +  RDMA device node must be siblings to the central MMSYS_CONFIG node.
> +  For a description of the MMSYS_CONFIG binding, see
> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml for details.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: mediatek,mt8195-vdo1-rdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    description: A phandle and PM domain specifier as defined by bindings of
> +      the power controller specified by phandle. See
> +      Documentation/devicetree/bindings/power/power-domain.yaml for details.
> +
> +  clocks:
> +    items:
> +      - description: RDMA Clock
> +
> +  iommus:
> +    description:
> +      This property should point to the respective IOMMU block with master port as argument,
> +      see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
> +
> +  mediatek,gce-client-reg:
> +    description:
> +      The register of display function block to be set by gce. There are 4 arguments,
> +      such as gce node, subsys id, offset and register size. The subsys id that is
> +      mapping to the register of display function blocks is defined in the gce header
> +      include/include/dt-bindings/gce/<chip>-gce.h of each chips.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - clocks
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +    #include <dt-bindings/gce/mt8195-gce.h>
> +    #include <dt-bindings/memory/mt8195-memory-port.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        vdo1_rdma0: mdp-rdma@1c104000 {
> +            compatible = "mediatek,mt8195-vdo1-rdma";
> +            reg = <0 0x1c104000 0 0x1000>;
> +            interrupts = <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>;
> +            clocks = <&vdosys1 CLK_VDO1_MDP_RDMA0>;
> +            power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +            iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>;
> +            mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x4000 0x1000>;
> +        };
> +    };
> -- 
> 2.18.0
> 
> 

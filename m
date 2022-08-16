Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BD596034
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiHPQ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiHPQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:27:06 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7A07B7B2;
        Tue, 16 Aug 2022 09:27:03 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id q74so4561856iod.9;
        Tue, 16 Aug 2022 09:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Zz0T4gIy7kUegqK8wikQ7+ezHFbCfs8YzoP1aT72UQs=;
        b=atq9lpasrPwNSLT2nbJhQKw574vkARqZRxuUXupuotaAYzXQFNLPI3T1tpGV0CvBaB
         IKbVKwKFlBqZlctD7xxwH4VIimd9SsfkQxNBBMf/riVlin8qTn3AJi5ZFl4s3aHrRaCu
         hh4g1pF5E6YxGs26nXuOtOoNU+nJKnhNNDglaaQOnmMdZG1YvqqOs4S8tuvevJEpzkdN
         VGoU3DEzYYUKqD3s5Khss1THNr9tHQRtzZYWaUWq95nVdhf0wUvGsL0IiluxRc9UyoNL
         Emw/bmmVDuDthI2qOVu9/UOeZ+mgiThhgAHkmCNhpukpmF3uzQJDddDZnvF7vawqGqLz
         dwAQ==
X-Gm-Message-State: ACgBeo2+UAE/2HkhQFTTCfMZuxWJ3RKGop9XNDz33rUnxyeNm3+fezi6
        Oehc9+hM+CF2gjrJhx4Yww==
X-Google-Smtp-Source: AA6agR7X5CuyHhjwtGZhIOksAHtXxYfsykPsT1Osf3XidFVfyLHpT86byQxklF0G4+/6CsHAnUcfzg==
X-Received: by 2002:a02:904c:0:b0:343:50f4:48a2 with SMTP id y12-20020a02904c000000b0034350f448a2mr10155030jaf.22.1660667222698;
        Tue, 16 Aug 2022 09:27:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v17-20020a056e020f9100b002dc2485d528sm1370649ilo.85.2022.08.16.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 09:27:02 -0700 (PDT)
Received: (nullmailer pid 2326662 invoked by uid 1000);
        Tue, 16 Aug 2022 16:27:00 -0000
Date:   Tue, 16 Aug 2022 10:27:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        kyrie wu <kyrie.wu@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com
Subject: Re: [V12,1/7] dt-bindings: mediatek: Add mediatek, mt8195-jpgenc
 compatible
Message-ID: <20220816162700.GA2325543-robh@kernel.org>
References: <20220729062630.5592-1-irui.wang@mediatek.com>
 <20220729062630.5592-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729062630.5592-2-irui.wang@mediatek.com>
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

On Fri, Jul 29, 2022 at 02:26:24PM +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgenc compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> ---
>  .../media/mediatek,mt8195-jpegenc.yaml        | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> new file mode 100644
> index 000000000000..d9133e6a92f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt8195-jpegenc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek JPEG Encoder Device Tree Bindings
> +
> +maintainers:
> +  - kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
> +
> +description:
> +  MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8195-jpgenc
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 4
> +    description:
> +      Points to the respective IOMMU block with master port as argument, see
> +      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
> +      Ports are according to the HW.
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +# Required child node:
> +patternProperties:
> +  "^jpgenc@[0-9a-f]+$":
> +    type: object
> +    description:
> +      The jpeg encoder hardware device node which should be added as subnodes to
> +      the main jpeg node.
> +
> +    properties:
> +      compatible:
> +        const: mediatek,mt8195-jpgenc-hw
> +
> +      reg:
> +        maxItems: 1
> +
> +      iommus:
> +        minItems: 1
> +        maxItems: 32
> +        description:
> +          List of the hardware port in respective IOMMU block for current Socs.
> +          Refer to bindings/iommu/mediatek,iommu.yaml.
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        items:
> +          - const: jpgenc
> +
> +      power-domains:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - iommus
> +      - interrupts
> +      - clocks
> +      - clock-names
> +      - power-domains
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - power-domains
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt8195-memory-port.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        jpgenc_master {
> +                compatible = "mediatek,mt8195-jpgenc";
> +                power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
> +                iommus = <&iommu_vpp M4U_PORT_L20_JPGENC_Y_RDMA>,
> +                <&iommu_vpp M4U_PORT_L20_JPGENC_C_RDMA>,
> +                <&iommu_vpp M4U_PORT_L20_JPGENC_Q_TABLE>,
> +                <&iommu_vpp M4U_PORT_L20_JPGENC_BSDMA>;
> +                #address-cells = <2>;
> +                #size-cells = <2>;

Same issue here as the decoder.

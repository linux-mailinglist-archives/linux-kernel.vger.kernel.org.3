Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB312477C29
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbhLPTEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:04:05 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43749 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhLPTED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:04:03 -0500
Received: by mail-ot1-f46.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so32701otu.10;
        Thu, 16 Dec 2021 11:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5/FblGQaJYZssbV69UJ4GBrUt2uvEHBBh4mxqSnBM3E=;
        b=L/Fehsr/5GeXq8TN/Uh0Rfhw1hicb1h4jB0NyAFg9N85+ovOw6wQOuheQD01yq2nxT
         GlSgcB9llb9HqczjhYTF4jrjAUNYfWYTUT2AETWakmWXL0CKix3Zb/r7WGz7QnKcpStU
         eyMNzNtY/7AsTM7b7aKNq2qLJHz1jMShiyR+9qxHlCux7LV9fMDx4cv47adtBFmXcmwA
         blYNmqdlnGS6Grax0iAJgjfeJvqeK60CvW0oSCuOrEtzNyy/VHcEPPYC/29m+OnXguGr
         Nj66I5FJ9Udxr8xEzgZ3Zqu/inVPDZQm3EJv9uCXFXaU2dPoG3OGnMJWEUqRFHrkr5Xt
         h11Q==
X-Gm-Message-State: AOAM532xrwkp2OPnVyKGxNg4PJTkI1PbQEjU5klii9MJ2jHcDLbBydYC
        +uI8O8tnq6+v37vCkVFrAA==
X-Google-Smtp-Source: ABdhPJylzhDYwAG/ANQ9sMz1+y1MrNz8yzIlAoSA+tfilj3ZOjyyjojSNkGMgpWF30qXQkkor7jaQQ==
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr13665614otl.85.1639681442381;
        Thu, 16 Dec 2021 11:04:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s26sm1164360oiw.19.2021.12.16.11.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 11:04:01 -0800 (PST)
Received: (nullmailer pid 575687 invoked by uid 1000);
        Thu, 16 Dec 2021 19:04:00 -0000
Date:   Thu, 16 Dec 2021 13:04:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, daniel.baluta@nxp.com,
        trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com
Subject: Re: [PATCH] dt-bindings: dsp: mediatek: add mt8195 dsp document
Message-ID: <YbuNoG3mw2/syi8+@robh.at.kernel.org>
References: <20211215031955.28244-1-yc.hung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215031955.28244-1-yc.hung@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:19:55AM +0800, YC Hung wrote:
> From: "yc.hung" <yc.hung@mediatek.com>
> 
> This patch adds mt8195 dsp document.
> 
> Signed-off-by: yc.hung <yc.hung@mediatek.com>
> ---
>  .../bindings/dsp/mtk,mt8195-dsp.yaml          | 116 ++++++++++++++++++

mediatek,mt8195-dsp.yaml

>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> new file mode 100644
> index 000000000000..33db11ee2336
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dsp/mtk,mt8195-dsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek mt8195 DSP core
> +
> +maintainers:
> +  - YC Hung <yc.hung@mediatek.com>
> +
> +description: |
> +  Some boards from mt8195 contain a DSP core used for
> +  advanced pre- and post- audio processing.

blank line

> +properties:
> +  compatible:
> +    const: mediatek,mt8195-dsp
> +
> +  reg:
> +    items:
> +      - description: Address and size of the DSP Cfg registers
> +      - description: Address and size of the DSP SRAM
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: sram
> +
> +  interrupts:
> +    items:
> +      - description: watchdog interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: wdt
> +
> +  clocks:
> +    items:
> +      - description: mux for audio dsp clock
> +      - description: 26M clock
> +      - description: mux for audio dsp local bus
> +      - description: default audio dsp local bus clock source
> +      - description: clock gate for audio dsp clock
> +      - description: mux for audio dsp access external bus
> +
> +  clock-names:
> +    items:
> +      - const: adsp_sel
> +      - const: clk26m_ck
> +      - const: audio_local_bus
> +      - const: mainpll_d7_d2
> +      - const: scp_adsp_audiodsp
> +      - const: audio_h
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mboxes:
> +    items:
> +      - description: a mailbox is ised for ipc reply between host and audio DSP.
> +      - description: a mailbox is ised for ipc reuqest between host and audio DSP.

typos

'a mailbox is ised for ' part can be dropped.


> +
> +  mbox-names:
> +    items:
> +      - const: mbox0
> +      - const: mbox1
> +
> +  memory-region:      
> +    items:
> +      - description: A phandle to a reserved memory region is used for dma buffer between host and DSP.   
> +      - description: A phandle to a reserved memory region is used for DSP system memory.

'A phandle to a reserved memory region is used for' part can be dropped.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - memory-region
> +  - power-domains
> +  - mbox-names
> +  - mboxes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    adsp: dsp@10803000 {

Drop unused labels.

> +       compatible =  "mediatek,mt8195-dsp";
> +       reg = <0x10803000  0x1000>,
> +             <0x10840000  0x40000>;
> +       reg-names = "cfg", "sram";
> +       interrupts = <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH 0>;
> +       interrupt-names = "wdt";
> +       clocks = <&topckgen 10>, //CLK_TOP_ADSP
> +                <&clk26m>,
> +                <&topckgen 107>, //CLK_TOP_AUDIO_LOCAL_BUS
> +                <&topckgen 136>, //CLK_TOP_MAINPLL_D7_D2
> +                <&scp_adsp 0>, //CLK_SCP_ADSP_AUDIODSP
> +                <&topckgen 34>; //CLK_TOP_AUDIO_H
> +       clock-names = "adsp_sel",
> +                     "clk26m_ck",
> +                     "audio_local_bus",
> +                     "mainpll_d7_d2",
> +                     "scp_adsp_audiodsp",
> +                     "audio_h";
> +       memory-region = <&adsp_dma_mem_reserved>,
> +                       <&adsp_mem_reserved>;
> +       power-domains = <&spm 6>; //MT8195_POWER_DOMAIN_ADSP
> +       mbox-names = "mbox0", "mbox1";
> +       mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
> +       };

Wrong indentation.

> -- 
> 2.18.0
> 
> 

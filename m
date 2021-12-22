Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A6D47D5A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbhLVRS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:18:29 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]:33445 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhLVRS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:18:28 -0500
Received: by mail-qv1-f49.google.com with SMTP id kk22so2970283qvb.0;
        Wed, 22 Dec 2021 09:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VwGJdZszDEBZ/haW/szM0MBy82aTvjUJCHaFFhvVrG0=;
        b=iKu0XcVhE7Zb6NnMZycLTmaBZcG5u562SzR2shhYDLOaxOdpxMh8BB9gaXyXiVldI0
         yarHUTXe+QEbqYVTzegfPAl9JK0gDQEU/n5j5462zcf0KVs+ixt7xhC4u+gVWm/5jDkb
         bP+UW5qvsqEf0JoSq8PnMn2ScpOaYP4wFVg1EkI6UfVJNSWCwqjK6WT+XYjFIw1EplxX
         fqWJZ2RXyzhND5DlWtuQG8G0TOPsyDdsdcMXguGSskd2r1IEOu8tc6i0ipzUA972I+BF
         rd0X0Y+G0yTMW7e9Y+HFVjLTyhdarb2ceYB6TsYES8uPt0uAG+/2xPbGFolVWEqnjd3L
         koyA==
X-Gm-Message-State: AOAM533DsvkIMQQuI+E4hQEVnPFrxp4I/OAEnx/lnO9sMl2pnnlM3rDc
        qCEFc4X4WAX5Vmlt8T5rv+kerL1ibgig
X-Google-Smtp-Source: ABdhPJyJ0bAGX2VL5tWgGbkPj8TCBhCWbSyDJ6PRFRs/4iibZv+H1Rhu7n1V0H4nZJGe1uhaZaf3Ow==
X-Received: by 2002:a05:6214:f04:: with SMTP id gw4mr3226167qvb.42.1640193508175;
        Wed, 22 Dec 2021 09:18:28 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id b2sm1436713qtq.95.2021.12.22.09.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:18:27 -0800 (PST)
Received: (nullmailer pid 2347804 invoked by uid 1000);
        Wed, 22 Dec 2021 17:18:25 -0000
Date:   Wed, 22 Dec 2021 13:18:25 -0400
From:   Rob Herring <robh@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, daniel.baluta@nxp.com,
        trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com
Subject: Re: [PATCH v2] dt-bindings: dsp: mediatek: add mt8195 dsp document
Message-ID: <YcNd4RXYldP8uWgg@robh.at.kernel.org>
References: <20211217070835.31709-1-yc.hung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217070835.31709-1-yc.hung@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 03:08:36PM +0800, YC Hung wrote:
> From: "yc.hung" <yc.hung@mediatek.com>

Should be 'YC Hung'?

> 
> This patch adds mt8195 dsp document.
> 
> Signed-off-by: yc.hung <yc.hung@mediatek.com>
> ---
> Changes since v1:
>   Rename yaml file name as mediatek,mt8195-dsp.yaml
>   Refine descriptions for mailbox, memory-region and drop unused labels
>   in examples.
> ---
>  .../bindings/dsp/mediatek,mt8195-dsp.yaml     | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> new file mode 100644
> index 000000000000..bde763191d86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dsp/mediatek,mt8195-dsp.yaml#
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
> +
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
> +      - description: ipc reply between host and audio DSP.
> +      - description: ipc reuqest between host and audio DSP.
> +
> +  mbox-names:
> +    items:
> +      - const: mbox0
> +      - const: mbox1
> +
> +  memory-region:      
> +    items:
> +      - description: dma buffer between host and DSP.   
> +      - description: DSP system memory.
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
> +    dsp@10803000 {
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
> +    };
> -- 
> 2.18.0
> 
> 

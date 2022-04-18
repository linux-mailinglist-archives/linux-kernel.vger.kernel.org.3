Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED782504C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 07:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiDRFar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 01:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiDRFaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:30:46 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B99C12AEB
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 22:28:07 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s16so1845503oie.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 22:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DgzO/pa67nPfiBA+VFEyWTBNJsOUG34PB2hcnwbIoc=;
        b=bd7K3fqHtTpDsDgDTYOvqsmdjMsec5ObOtdaj9zcjM8jz8dlxHRaRZSPjXBwSgWLNv
         nMLNffxgLORyfwQQefNwCqVdVg+BtluJuRHb23NbrtkL1sooIT80tL2rKo/iE8UOubXE
         A05na/OraG4ZhFZFQLXB8RrRvsCtdp6X2YPJARca0eTAoe/tLZYJpaM/xLSZBw6h9kr6
         uV0Crwx44CIClY/QIxPlvgp6m0G71jWNas+dZimSPynCJ5ZMGoCva3enZO07QjJmQrhS
         xqxMOKoW2wB8U5M50EPh6qsWF5CQcsbWPGz1rR9YwTQYHMqZ3SPuFch6weG4Lkwpv821
         KGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DgzO/pa67nPfiBA+VFEyWTBNJsOUG34PB2hcnwbIoc=;
        b=JNsLG7ogT2ryKU1lSdW0mkoFjtOYFxIyYmXQsVlpjSE3TpuonE5NojZzB+WBOA/EZv
         n87f78vbL2wjYz81xDugCViqwDNvJXj7YupiXOr+ne9+qCFrjz3vjyEGrZOzw/dOly9o
         18y10YfOV3hTbqjgHevdfxeJGWW0SokbP4VBeBW/WEEJojkW8wonRlOQQkSPCPz6Wl3o
         YOYWFk0JPx4o3su5XIm177J56VT4mfau/E61JyrHMZZoq4U5mm0qHMYA2kseqbU4L50P
         jHikil5SyAPo9eCGG6lqm1S9TazERGYbAQAk1M7qEDT2dwbdNqoSyUKmP5CRwPB1iI4u
         kIMA==
X-Gm-Message-State: AOAM531KSk17Yw37JLb9VDl7ur3nc9QFc4juoml+1yi8Bm7LI1cNPexb
        F427gxh0ZCxx/VCLcB2iCVk9hINr3piQpv97JPDgn5D/G3IMJA==
X-Google-Smtp-Source: ABdhPJwTmeemQ1FlD7kIucZJFielIhrz/iqz0jntpX5/XzAFZlSiCfDlDHE/Kfrf67Mxbfm59seuG3cv3yukIX8Cbwg=
X-Received: by 2002:a05:6808:1287:b0:2da:5cea:fb11 with SMTP id
 a7-20020a056808128700b002da5ceafb11mr4227916oiw.147.1650259686315; Sun, 17
 Apr 2022 22:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com> <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
In-Reply-To: <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 18 Apr 2022 10:57:55 +0530
Message-ID: <CAH=2Ntx1D8C6xu+RysO0o5OkG5kPMMJ-Xr+B-udLtizY+4HiaQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA binding
 to json format
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuldeep,

On Sun, 10 Apr 2022 at 23:21, Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
>
> Convert Qualcomm BAM DMA controller binding to DT schema format using
> json schema.

Please see <https://lore.kernel.org/lkml/20220211214941.f55q5yksittut3ep@amazon.com/T/#m6700c2695ee78e79060ac338d208ffd08ac39592>,
I already have an effort ongoing for converting qcom bam DMA bindings
to YAML format.

I will send a new version of the same shortly. Please try and use the same.

Thanks,
Bhupesh

> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
>  .../devicetree/bindings/dma/qcom,bam-dma.yaml | 94 +++++++++++++++++++
>  .../devicetree/bindings/dma/qcom_bam_dma.txt  | 52 ----------
>  2 files changed, 94 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
>
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> new file mode 100644
> index 000000000000..b32175d54dca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/qcom,bam-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies Inc BAM DMA controller
> +
> +maintainers:
> +  - Andy Gross <agross@kernel.org>
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,bam-v1.3.0
> +      - qcom,bam-v1.4.0
> +      - qcom,bam-v1.7.0
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: bam_clk
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  iommus:
> +    minItems: 1
> +    maxItems: 4
> +
> +  num-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates supported number of DMA channels in a remotely controlled bam.
> +
> +  qcom,controlled-remotely:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates that the bam is controlled by remote proccessor i.e. execution
> +      environment.
> +
> +  qcom,ee:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates the active Execution Environment identifier (0-7) used in the
> +      secure world.
> +
> +  qcom,num-ees:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates supported number of Execution Environments in a remotely
> +      controlled bam.
> +
> +  qcom,powered-remotely:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates that the bam is powered up by a remote processor but must be
> +      initialized by the local processor.
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#dma-cells"
> +  - interrupts
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
> +
> +    dma-controller@f9944000 {
> +        compatible = "qcom,bam-v1.4.0";
> +        reg = <0xf9944000 0x15000>;
> +        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&gcc GCC_BLSP2_AHB_CLK>;
> +        clock-names = "bam_clk";
> +        #dma-cells = <1>;
> +        qcom,ee = <0>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> deleted file mode 100644
> index 6e9a5497b3f2..000000000000
> --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -QCOM BAM DMA controller
> -
> -Required properties:
> -- compatible: must be one of the following:
> - * "qcom,bam-v1.4.0" for MSM8974, APQ8074 and APQ8084
> - * "qcom,bam-v1.3.0" for APQ8064, IPQ8064 and MSM8960
> - * "qcom,bam-v1.7.0" for MSM8916
> -- reg: Address range for DMA registers
> -- interrupts: Should contain the one interrupt shared by all channels
> -- #dma-cells: must be <1>, the cell in the dmas property of the client device
> -  represents the channel number
> -- clocks: required clock
> -- clock-names: must contain "bam_clk" entry
> -- qcom,ee : indicates the active Execution Environment identifier (0-7) used in
> -  the secure world.
> -- qcom,controlled-remotely : optional, indicates that the bam is controlled by
> -  remote proccessor i.e. execution environment.
> -- qcom,powered-remotely : optional, indicates that the bam is powered up by
> -  a remote processor but must be initialized by the local processor.
> -- num-channels : optional, indicates supported number of DMA channels in a
> -  remotely controlled bam.
> -- qcom,num-ees : optional, indicates supported number of Execution Environments
> -  in a remotely controlled bam.
> -
> -Example:
> -
> -       uart-bam: dma@f9984000 = {
> -               compatible = "qcom,bam-v1.4.0";
> -               reg = <0xf9984000 0x15000>;
> -               interrupts = <0 94 0>;
> -               clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> -               clock-names = "bam_clk";
> -               #dma-cells = <1>;
> -               qcom,ee = <0>;
> -       };
> -
> -DMA clients must use the format described in the dma.txt file, using a two cell
> -specifier for each channel.
> -
> -Example:
> -       serial@f991e000 {
> -               compatible = "qcom,msm-uart";
> -               reg = <0xf991e000 0x1000>
> -                       <0xf9944000 0x19000>;
> -               interrupts = <0 108 0>;
> -               clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
> -                       <&gcc GCC_BLSP1_AHB_CLK>;
> -               clock-names = "core", "iface";
> -
> -               dmas = <&uart-bam 0>, <&uart-bam 1>;
> -               dma-names = "rx", "tx";
> -       };
> --
> 2.25.1
>

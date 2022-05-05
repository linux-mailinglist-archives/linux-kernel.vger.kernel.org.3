Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E27B51CA9B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385880AbiEEUd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385873AbiEEUdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:33:24 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E595FF27
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:29:40 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e656032735so5379878fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E79Hu+ASO7VIz4yIiTZ0/hvo5NTf0z2XjOcP52stTCU=;
        b=PM1xqkEuWXZbfVjShwF21/MTzOGMRiFid042Gy0UVHlyXci4EeALcCFpZNo0p6IGCp
         umzxSTNhFV9/rKVE/o+/21/Kg2HzGj+L2+KyaBhE75kzz7FkAXNlJmpyjV+BOOYJFQVw
         VEWwE7/6H1QcpyDuze9/LP8A10ndTkrY6q4rUZ6fvQWHaCjb3pxyujRnRLLideQHgyk3
         lei603yId0wclXOtWMNSJ07euMGpwnIAhl6fod7exC0MIuN/6yAGiC/P4KSVIBoilzEv
         azX01NjQ6yOXkyHTrgpvhm5E+1tGkW7edkEqjYc1ro2DOkFSTFcEVVVdL1NTd6nYPEsJ
         eKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E79Hu+ASO7VIz4yIiTZ0/hvo5NTf0z2XjOcP52stTCU=;
        b=D6ff2Jk4bXt66iHF3nBQMWrF8SgEJpmg/vH+IsaerPlr/B95PSEcLoN2A+uLlcMoDo
         b8pX3BatCc6kR4OOUsszI+5VFuaZLSWW20fAmAubZxVV/60Mz7/PrkHhFsALwvG2xTZe
         be1zNiygyaQy/e1I0nTiXMTKeUSqLFlNgdhiLgZWd6ZXckzoJwyRUW8IyKyRQl4tsi7x
         LTR41rUsL/JDYQF5jIhQ6xGAX39E8QKjqOyQ0y6Btr8x68OZQid3cgyhVGlTIyyC6NsD
         4ltqNXTrC9dpkCopFMkKHFAs2nMWtN55DCpeXqgal+RRduBvtCT1R592iSk0dAynMlQH
         R5cg==
X-Gm-Message-State: AOAM533juY+/uCJLmWqxnJEg7/LCwyhbaM3j+XOqhipuy73Z5JlB46Pf
        zfcazMy4lEwCHApjLkdW5wP3zkF5s8C7uwLDvgx3nQ==
X-Google-Smtp-Source: ABdhPJztXKRlu4CCk3zbEqE9ZgBLuFCcb46GasGSAhdiYfMxEL0ccAvbf5Suni3bphRx3xrrej00DSq9xGmsJ3tvUMY=
X-Received: by 2002:a05:6870:b50d:b0:ed:e8f5:b1cd with SMTP id
 v13-20020a056870b50d00b000ede8f5b1cdmr11448oap.147.1651782579552; Thu, 05 May
 2022 13:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
 <20220429220833.873672-2-bhupesh.sharma@linaro.org> <YnLmNCwNfoqZln12@robh.at.kernel.org>
 <CAPDyKFrJPHnKi+XGP8U-OJM_uf5fM8eAJT9-z3NL6bP=7MAVug@mail.gmail.com>
In-Reply-To: <CAPDyKFrJPHnKi+XGP8U-OJM_uf5fM8eAJT9-z3NL6bP=7MAVug@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 6 May 2022 01:59:26 +0530
Message-ID: <CAH=2NtwKuG8579JFM1GLO0882FB6Jhdn349aPVWgudcA7J8huA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mmc/sdhci-msm: Convert bindings to yaml
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org
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

Hi Ulf and Rob,

On Thu, 5 May 2022 at 14:00, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 4 May 2022 at 22:46, Rob Herring <robh@kernel.org> wrote:
> >
> > On Sat, Apr 30, 2022 at 03:38:30AM +0530, Bhupesh Sharma wrote:
> > > Convert Qualcomm sdhci-msm devicetree binding to YAML.
> > >
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > >  .../devicetree/bindings/mmc/sdhci-msm.txt     | 123 -----------
> > >  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 192 ++++++++++++++++++
> > >  2 files changed, 192 insertions(+), 123 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > >  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > > deleted file mode 100644
> > > index 6216ed777343..000000000000
> > > --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > > +++ /dev/null
> > > @@ -1,123 +0,0 @@
> > > -* Qualcomm SDHCI controller (sdhci-msm)
> > > -
> > > -This file documents differences between the core properties in mmc.txt
> > > -and the properties used by the sdhci-msm driver.
> > > -
> > > -Required properties:
> > > -- compatible: Should contain a SoC-specific string and a IP version string:
> > > -     version strings:
> > > -             "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
> > > -             "qcom,sdhci-msm-v5" for sdcc version 5.0
> > > -             For SDCC version 5.0.0, MCI registers are removed from SDCC
> > > -             interface and some registers are moved to HC. New compatible
> > > -             string is added to support this change - "qcom,sdhci-msm-v5".
> > > -     full compatible strings with SoC and version:
> > > -             "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
> > > -             "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4"
> > > -             "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4"
> > > -             "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
> > > -             "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
> > > -             "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
> > > -             "qcom,msm8994-sdhci", "qcom,sdhci-msm-v4"
> > > -             "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
> > > -             "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
> > > -             "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
> > > -             "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
> > > -             "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
> > > -             "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
> > > -             "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
> > > -     NOTE that some old device tree files may be floating around that only
> > > -     have the string "qcom,sdhci-msm-v4" without the SoC compatible string
> > > -     but doing that should be considered a deprecated practice.
> > > -
> > > -- reg: Base address and length of the register in the following order:
> > > -     - Host controller register map (required)
> > > -     - SD Core register map (required for controllers earlier than msm-v5)
> > > -     - CQE register map (Optional, CQE support is present on SDHC instance meant
> > > -                         for eMMC and version v4.2 and above)
> > > -     - Inline Crypto Engine register map (optional)
> > > -- reg-names: When CQE register map is supplied, below reg-names are required
> > > -     - "hc" for Host controller register map
> > > -     - "core" for SD core register map
> > > -     - "cqhci" for CQE register map
> > > -     - "ice" for Inline Crypto Engine register map (optional)
> > > -- interrupts: Should contain an interrupt-specifiers for the interrupts:
> > > -     - Host controller interrupt (required)
> > > -- pinctrl-names: Should contain only one value - "default".
> > > -- pinctrl-0: Should specify pin control groups used for this controller.
> > > -- clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
> > > -- clock-names: Should contain the following:
> > > -     "iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
> > > -     "core"  - SDC MMC clock (MCLK) (required)
> > > -     "bus"   - SDCC bus voter clock (optional)
> > > -     "xo"    - TCXO clock (optional)
> > > -     "cal"   - reference clock for RCLK delay calibration (optional)
> > > -     "sleep" - sleep clock for RCLK delay calibration (optional)
> > > -     "ice" - clock for Inline Crypto Engine (optional)
> > > -
> > > -- qcom,ddr-config: Certain chipsets and platforms require particular settings
> > > -     for the DDR_CONFIG register. Use this field to specify the register
> > > -     value as per the Hardware Programming Guide.
> > > -
> > > -- qcom,dll-config: Chipset and Platform specific value. Use this field to
> > > -     specify the DLL_CONFIG register value as per Hardware Programming Guide.
> > > -
> > > -Optional Properties:
> > > -* Following bus parameters are required for interconnect bandwidth scaling:
> > > -- interconnects: Pairs of phandles and interconnect provider specifier
> > > -              to denote the edge source and destination ports of
> > > -              the interconnect path.
> > > -
> > > -- interconnect-names: For sdhc, we have two main paths.
> > > -             1. Data path : sdhc to ddr
> > > -             2. Config path : cpu to sdhc
> > > -             For Data interconnect path the name supposed to be
> > > -             is "sdhc-ddr" and for config interconnect path it is
> > > -             "cpu-sdhc".
> > > -             Please refer to Documentation/devicetree/bindings/
> > > -             interconnect/ for more details.
> > > -
> > > -Example:
> > > -
> > > -     sdhc_1: sdhci@f9824900 {
> > > -             compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
> > > -             reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
> > > -             interrupts = <0 123 0>;
> > > -             bus-width = <8>;
> > > -             non-removable;
> > > -
> > > -             vmmc-supply = <&pm8941_l20>;
> > > -             vqmmc-supply = <&pm8941_s3>;
> > > -
> > > -             pinctrl-names = "default";
> > > -             pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
> > > -
> > > -             clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
> > > -             clock-names = "core", "iface";
> > > -             interconnects = <&qnoc MASTER_SDCC_ID &qnoc SLAVE_DDR_ID>,
> > > -                             <&qnoc MASTER_CPU_ID &qnoc SLAVE_SDCC_ID>;
> > > -             interconnect-names = "sdhc-ddr","cpu-sdhc";
> > > -
> > > -             qcom,dll-config = <0x000f642c>;
> > > -             qcom,ddr-config = <0x80040868>;
> > > -     };
> > > -
> > > -     sdhc_2: sdhci@f98a4900 {
> > > -             compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
> > > -             reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
> > > -             interrupts = <0 125 0>;
> > > -             bus-width = <4>;
> > > -             cd-gpios = <&msmgpio 62 0x1>;
> > > -
> > > -             vmmc-supply = <&pm8941_l21>;
> > > -             vqmmc-supply = <&pm8941_l13>;
> > > -
> > > -             pinctrl-names = "default";
> > > -             pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data>;
> > > -
> > > -             clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
> > > -             clock-names = "core", "iface";
> > > -
> > > -             qcom,dll-config = <0x0007642c>;
> > > -             qcom,ddr-config = <0x80040868>;
> > > -     };
> > > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > > new file mode 100644
> > > index 000000000000..c33f173e3b6c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > > @@ -0,0 +1,192 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/mmc/sdhci-msm.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Qualcomm SDHCI controller (sdhci-msm)
> > > +
> > > +maintainers:
> > > +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > +
> > > +description:
> > > +  Secure Digital Host Controller Interface (SDHCI) present on
> > > +  Qualcomm SOCs supports SD/MMC/SDIO devices.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - qcom,apq8084-sdhci
> > > +              - qcom,msm8226-sdhci
> > > +              - qcom,msm8953-sdhci
> > > +              - qcom,msm8974-sdhci
> > > +              - qcom,msm8916-sdhci
> > > +              - qcom,msm8992-sdhci
> > > +              - qcom,msm8994-sdhci
> > > +              - qcom,msm8996-sdhci
> > > +              - qcom,qcs404-sdhci
> > > +              - qcom,sc7180-sdhci
> > > +              - qcom,sc7280-sdhci
> > > +              - qcom,sdm630-sdhci
> > > +              - qcom,sdm845-sdhci
> > > +              - qcom,sdx55-sdhci
> > > +              - qcom,sm6125-sdhci
> > > +              - qcom,sm6350-sdhci
> > > +              - qcom,sm8250-sdhci
> > > +          - enum:
> > > +              - qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
> > > +              - qcom,sdhci-msm-v5 # for sdcc version 5.0
> >
> > This should be split up between v4 and v5.
> >
> > > +      - items:
> > > +          - const: qcom,sdhci-msm-v4 # Deprecated (only for backward compatibility)
> > > +                                     # for sdcc versions less than 5.0
> >
> >            deprecated: true
> >
> > > +
> > > +  reg:
> > > +    minItems: 1
> > > +    items:
> > > +      - description: Host controller register map
> > > +      - description: SD Core register map
> > > +      - description: CQE register map
> > > +      - description: Inline Crypto Engine register map
> > > +
> > > +  clocks:
> > > +    minItems: 3
> > > +    items:
> > > +      - description: Main peripheral bus clock, PCLK/HCLK - AHB Bus clock
> > > +      - description: SDC MMC clock, MCLK
> > > +      - description: TCXO clock
> > > +      - description: clock for Inline Crypto Engine
> > > +      - description: SDCC bus voter clock
> > > +      - description: reference clock for RCLK delay calibration
> > > +      - description: sleep clock for RCLK delay calibration
> > > +
> > > +  clock-names:
> > > +    minItems: 2
> > > +    items:
> > > +      - const: iface
> > > +      - const: core
> > > +      - const: xo
> > > +      - const: ice
> > > +      - const: bus
> > > +      - const: cal
> > > +      - const: sleep
> > > +
> > > +  interrupts:
> > > +    maxItems: 2
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: hc_irq
> > > +      - const: pwr_irq
> > > +
> > > +  pinctrl-names:
> > > +    minItems: 1
> > > +    items:
> > > +      - const: default
> > > +      - const: sleep
> > > +
> > > +  pinctrl-0:
> > > +    description:
> > > +      Should specify pin control groups used for this controller.
> > > +
> > > +  qcom,ddr-config:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: platform specific settings for DDR_CONFIG reg.
> > > +
> > > +  qcom,dll-config:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: platform specific settings for DLL_CONFIG reg.
> > > +
> > > +  iommus:
> > > +    minItems: 1
> > > +    maxItems: 8
> > > +    description: |
> > > +      phandle to apps_smmu node with sid mask.
> > > +
> > > +  interconnects:
> > > +    items:
> > > +      - description: data path, sdhc to ddr
> > > +      - description: config path, cpu to sdhc
> > > +
> > > +  interconnect-names:
> > > +    items:
> > > +      - const: sdhc-ddr
> > > +      - const: cpu-sdhc
> > > +
> > > +  power-domains:
> > > +    description: A phandle to sdhci power domain node
> > > +    maxItems: 1
> > > +
> > > +patternProperties:
> > > +  '^opp-table(-[a-z0-9]+)?$':
> > > +    if:
> > > +      properties:
> > > +        compatible:
> > > +          const: operating-points-v2
> > > +    then:
> > > +      patternProperties:
> > > +        '^opp-?[0-9]+$':
> > > +          required:
> > > +            - required-opps
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - interrupts
> > > +
> > > +additionalProperties: true
> >
> > Not valid except for common (incomplete) schemas. Instead you need:
> >
> > allOf:
> >   - $ref: mmc-controller.yaml#
> >
> > unevaluatedProperties: false
> >
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/clock/qcom,gcc-sm8250.h>
> > > +    #include <dt-bindings/clock/qcom,rpmh.h>
> > > +    #include <dt-bindings/power/qcom-rpmpd.h>
> > > +
> > > +    sdhc_2: sdhci@8804000 {
> >
> > This will be an error then.
> >
> > > +      compatible = "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5";
> > > +      reg = <0 0x08804000 0 0x1000>;
>
>
> [...]
>
> Bhupesh, I realized that I was a little too quick to apply @subject
> patch. Although, rather than dropping it from my branch, can you
> please address Rob's comments and send an incremental patch on top?

Sure, no problem. I am preparing the incremental patch and will share
it shortly.

Thanks,
Bhupesh

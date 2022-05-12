Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDC252496F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352288AbiELJvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352263AbiELJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:51:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EBF31DDA;
        Thu, 12 May 2022 02:51:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x18so4382725plg.6;
        Thu, 12 May 2022 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=4NJrwbxffeYDZrdPHnUFz3blJ9z2zgCKgJWyIgZv1eU=;
        b=WpgTjXzLTr6W78QEuVWNBlAcXbX472mWQOXHoLTBp6FDd6t1Bh0D9aEbhuDqsQayHz
         2VBN71/9QkZ+ua6iNLNtMn4FENYlGAuUEdL2385DHZ4QHPH6tlAdPbORYge98O49ivbX
         Dq0jVgI62t3PUNJp123+UE9mdyX/4/eOUBKPzUbPydwYdcdZ85MgSQ1M304mqZGQg1zN
         1YpiEHAvtZkJOLEANfROBXMy2QCUc4dlbLyq94xjH7sYGXlraT6tiWYm/CP1Y2vLGlEZ
         ytYmHX2Ui9z2LTb9NB5hrnyWC20J/2lDJubI2jb+J8dVWQCgALwwiVqYyhWmTXryXmZj
         NJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=4NJrwbxffeYDZrdPHnUFz3blJ9z2zgCKgJWyIgZv1eU=;
        b=MEx5GmI7/SJmNFBuAEpGw8wRPo37GU0RM6XcV4CD0Kqy09mVaGICK65oqOSmSqc05K
         00rU+oj9tVSmu+XX6A8VaxRROiMK69jaR43DeINmjuWSAIDP8rypcfZJ2zQgYeLKj7l8
         wJqqU2MLTSCeHZWiJrw6vkwXJKvBeMyyi4VzKMTPU+P3hOLDvk36E7IW9gxD/7+dm0Xp
         7gCE+byYYKaWNE0Dh4rseZLzYxg78dk3DokMHa2CgnjJscAud6IVgVMzhUHmayMfiiiA
         QRGK4MtGDlDLCftY+ma/ZGt3s3UPpaMdCrg/nn0ap72yuBp5TaBOK4EQlzOtg3VXyScI
         XHOQ==
X-Gm-Message-State: AOAM533nTxr7H/pmL8iBEFzODL9Mqo8kOOKkoaoewbPOmBz32SEDieWY
        iukoBnsh0SBW9raR3QxCpag=
X-Google-Smtp-Source: ABdhPJxoU+4/VddtIt9QOPzSGKGZA3aPMncpEK9MzApZ1EABMMwEnNv9XbYU4Ru4g5XEwD2+0e/oFQ==
X-Received: by 2002:a17:903:288:b0:15f:a13:dfd5 with SMTP id j8-20020a170903028800b0015f0a13dfd5mr20741140plr.55.1652349066169;
        Thu, 12 May 2022 02:51:06 -0700 (PDT)
Received: from localhost ([49.204.239.218])
        by smtp.gmail.com with ESMTPSA id n24-20020a056a0007d800b0050dc7628150sm3316295pfu.42.2022.05.12.02.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 02:51:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 May 2022 15:20:59 +0530
Message-Id: <CJXOUUY3IV5I.33259TNMB50JG@skynet-linux>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 6/9] dt-bindings: remoteproc: qcom: mss: Convert
 bindings to YAML
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
X-Mailer: aerc 0.9.0
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-7-sireeshkodali1@gmail.com>
 <29a8871f-59ab-05f2-d258-eea52b7ac6ee@linaro.org>
In-Reply-To: <29a8871f-59ab-05f2-d258-eea52b7ac6ee@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 11, 2022 at 11:20 PM IST, Krzysztof Kozlowski wrote:
> On 11/05/2022 18:15, Sireesh Kodali wrote:
> > Convert the bindings to YAML from txt. The bindings follow a similar
> > schema to `qcom,adsp.yaml`.
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > ---
> >  .../bindings/remoteproc/qcom,q6v5.txt         | 302 --------
> >  .../bindings/remoteproc/qcom,q6v5.yaml        | 702 ++++++++++++++++++
> >  2 files changed, 702 insertions(+), 302 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,q=
6v5.txt
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,q=
6v5.yaml
>
> Same comments as for patch 4 apply here. Some of them seems fixed so it
> makes me wonder - why you wrote two bindings in entirely different way?
>

This was largely based on the existing qcom,adsp.yaml. That's probably
why there are less mistakes.
> > +  This document defines the binding for a component that loads and boo=
ts firmware
> > +  on the Qualcomm Hexagon core.
> > +
> > +properties:
> > +  compatible:
> > +    # Special case, because older platforms like MSM8916 use both comp=
atibles together
> > +    minItems: 1
> > +    maxItems: 2
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - qcom,msm8916-mss-pil
> > +          - enum:
> > +              - qcom,q6v5-pil
>
> Everywhere - same comments as in patch 4.
>
Will be fixed in v2.
> > +      - items:
> > +          - enum:
> > +              - qcom,q6v5-pil
> > +              - qcom,ipq8074-wcss-pil
> > +              - qcom,qcs404-wcss-pil
> > +              - qcom,msm8916-mss-pil
> > +              - qcom,msm8974-mss-pil
> > +              - qcom,msm8996-mss-pil
> > +              - qcom,msm8998-mss-pil
> > +              - qcom,sc7180-mss-pil
> > +              - qcom,sc7280-mss-pil
> > +              - qcom,sdm845-mss-pil
> > +
> > +  reg:
> > +    description: must specify the base address and size of the qdsp6 a=
nd rmb
> > +      register blocks
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: qdsp6
> > +      - const: rmb
> > +
> > +  interrupts-extended:
> > +    minItems: 5
> > +    maxItems: 6
> > +
> > +  interrupt-names:
> > +    minItems: 5
> > +    maxItems: 6
> > +
> > +  firmware-name:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    description: List the relative firmware image paths for the mba an=
d
> > +      modem. They are used for booting and authenticating the Hexagon =
core.
> > +    maxItems: 2
> > +
> > +  clocks:
> > +    minItems: 4
> > +    maxItems: 10
> > +
> > +  clock-names:
> > +    minItems: 4
> > +    maxItems: 10
> > +
> > +  resets:
> > +    description: Reference to the reset-controllwer for the modem subs=
ystem
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  reset-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  memory-region:
> > +    maxItems: 1
> > +    description: Reference to the reserved-memory for the mba region f=
ollowed
> > +      by the mpss region. Required if the mba and mpss sub-nodes are n=
ot
> > +      specified.
> > +
> > +  cx-supply:
> > +    description: Phandle to the CX regulator
> > +
> > +  mx-supply:
> > +    description: Phandle to the MX regulator
> > +
> > +  pll-supply:
> > +    description: Phandle to the PLL regulator, to be held on behalf of=
 the
> > +      booting Hexagon core
> > +
> > +  mss-supply:
> > +    description: Phandle to the mss regulator, to be held on behalf of=
 the
> > +      booting Hexagon core
>
> s/Phandle to//, everywhere.
>
> > +
> > +  power-domains:
> > +    minItems: 1
> > +    maxItems: 4
> > +
> > +  power-domain-names:
> > +    minItems: 1
> > +    maxItems: 4
> > +
> > +  qcom,qmp:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Reference to the AOSS side-channel message RAM.
> > +
> > +  qcom,smem-states:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: States used by the AP to signal the Hexagon core
> > +    items:
> > +      - description: Stop the modem
> > +
> > +  qcom,smem-state-names:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    description: The names of the state bits used for SMP2P output
> > +    items:
> > +      - const: stop
> > +
> > +  qcom,halt-regs:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Phandle reference to a syscon representing TCSR followed by the
> > +      three offsets within syscon for q6, modem and nc halt registers.
> > +
> > +  qcom,spare-regs:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      A phandle reference to a syscon representing TCSR followed by th=
e
> > +      offset within syscon for conn_box_spare0 register used by the mo=
dem
> > +      sub-system running on SC7180 SoC.
> > +
> > +  qcom,ext-regs:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Two phandle references to syscons representing TCSR_REG and TCSR
> > +      register space followed by the two offsets within the syscon to
> > +      force_clk_en/rscc_disable and axim1_clk_off/crypto_clk_off regis=
ters
> > +      respectively.
> > +
> > +  qcom,qaccept-regs:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      A phandle reference to a syscon representing TCSR followed by th=
e three
> > +      offsets within syscon for mdm, cx and axi qaccept registers used=
 by the
> > +      modem sub-system running on SC7280 SoC.
> > +
> > +  iommus:
> > +    description:
> > +      Only required on platforms that do not have TrustZone.
> > +
> > +  smd-edge:
> > +    type: object
> > +    description:
> > +      Qualcomm Shared Memory subnode which represents communication ed=
ge,
> > +      channels and devices related to the ADSP.
> > +
> > +  glink-edge:
> > +    type: object
> > +    description:
> > +      Qualcomm G-Link subnode which represents communication edge, cha=
nnels
> > +      and devices related to the ADSP.
> > +
> > +  mba:
> > +    type: object
>
> description needed.
>
> > +    properties:
> > +      memory-region:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - memory-region
> > +
> > +  mpss:
>
> description needed.
>
> > +    type: object
> > +    properties:
> > +      memory-region:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - memory-region
> > +
> > +required:
> > +  - compatible
> > +  - clocks
> > +  - clock-names
> > +  - interrupts-extended
> > +  - interrupt-names
> > +  - qcom,smem-states
> > +  - qcom,smem-state-names
> > +
> > +additionalProperties: false
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,ipq8074-wcss-pil
> > +    then:
> > +      properties:
> > +        clocks: false
> > +        clock-names: false
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,qcs404-wcss-pil
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: GCC_AHBS_CBCR clock
> > +            - description: GCC_AXIM_CBCR clock
> > +            - description: LCC_AHBFABRIC_CBC clock
> > +            - description: TCSR_LCC_CBC clock
> > +            - description: LCC_AHBS_CBC clock
> > +            - description: LCC_TCM_SLAVE_CBC clock
> > +            - description: LCC_ABHM_CBC clock
> > +            - description: LCC_AXIM_CBC clock
> > +            - description: LCC_BCR_SLEEP clock
> > +            - description: XO clock
> > +        clock-names:
> > +          items:
> > +            - const: gcc_ahbs_cbcr
> > +            - const: gcc_axim_cbcr
> > +            - const: lcc_ahbfabric_cbc
> > +            - const: tcsr_lcc_cbc
> > +            - const: lcc_abhs_cbc
> > +            - const: lcc_tcm_slave_cbc
> > +            - const: lcc_abhm_cbc
> > +            - const: lcc_axim_cbc
> > +            - const: lcc_bcr_sleep
> > +            - const: xo
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,q6v5-pil
> > +              - qcom,msm8916-mss-pil
> > +              - qcom,msm8974-mss-pil
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: Interface clock
> > +            - description: Bus clock
> > +            - description: Memory clock
> > +            - description: XO clock
> > +        clock-names:
> > +          items:
> > +            - const: iface
> > +            - const: bus
> > +            - const: mem
> > +            - const: xo
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,msm8996-mss-pil
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: Interface clock
> > +            - description: Bus clock
> > +            - description: Memory clock
> > +            - description: GPLL0_MSS clock
> > +            - description: SNOC_AXI clock
> > +            - description: MNOC_AXI clock
> > +            - description: PNOC clock
> > +            - description: QDSS clock
> > +            - description: XO clock
> > +        clock-names:
> > +          items:
> > +            - const: iface
> > +            - const: bus
> > +            - const: mem
> > +            - const: gpll0_mss
> > +            - const: snoc_axi
> > +            - const: mnoc_axi
> > +            - const: pnoc
> > +            - const: qdss
> > +            - const: xo
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,msm8998-mss-pil
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: Interface clock
> > +            - description: Bus clock
> > +            - description: Memory clock
> > +            - description: GPLL0_MSS clock
> > +            - description: SNOC_AXI clock
> > +            - description: MNOC_AXI clock
> > +            - description: QDSS clock
> > +            - description: XO clock
> > +        clock-names:
> > +          items:
> > +            - const: iface
> > +            - const: bus
> > +            - const: mem
> > +            - const: gpll0_mss
> > +            - const: snoc_axi
> > +            - const: mnoc_axi
> > +            - const: qdss
> > +            - const: xo
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,sc7180-mss-pil
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: Interface clock
> > +            - description: Bus clock
> > +            - description: NAV clock
> > +            - description: SNOC_AXI clock
> > +            - description: MNOC_AXI clock
> > +            - description: XO clock
> > +        clock-names:
> > +          items:
> > +            - const: iface
> > +            - const: bus
> > +            - const: nav
> > +            - const: snoc_axi
> > +            - const: mnoc_axi
> > +            - const: xo
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,sc7280-mss-pil
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: Interface clock
> > +            - description: Offline clock
> > +            - description: SNOC_AXI clock
> > +            - description: PKA clock
> > +            - description: XO clock
> > +        clock-names:
> > +          items:
> > +            - const: iface
> > +            - const: offline
> > +            - const: snoc_axi
> > +            - const: pka
> > +            - const: xo
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,sdm845-mss-pil
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: Interface clock
> > +            - description: Bus clock
> > +            - description: Memory clock
> > +            - description: GPLL0_MSS clock
> > +            - description: SNOC_AXI clock
> > +            - description: MNOC_AXI clock
> > +            - description: PRNG clock
> > +            - description: XO clock
> > +        clock-names:
> > +          items:
> > +            - const: iface
> > +            - const: bus
> > +            - const: mem
> > +            - const: gpll0_mss
> > +            - const: snoc_axi
> > +            - const: mnoc_axi
> > +            - const: prng
> > +            - const: xo
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,q6v5-pil
> > +              - qcom,ipq8074-wcss-pil
> > +              - qcom,qcs404-wcss-pil
> > +              - qcom,msm8916-mss-pil
> > +              - qcom,msm8974-mss-pil
> > +    then:
> > +      properties:
> > +        interrupts-extended:
>
> No extended.
>
> > +          items:
> > +            - description: Watchdog interrupt
> > +            - description: Fatal interrupt
> > +            - description: Ready interrupt
> > +            - description: Handover interrupt
> > +            - description: Stop acknowledge interrupt
> > +        interrupt-names:
> > +          items:
> > +            - const: wdog
> > +            - const: fatal
> > +            - const: ready
> > +            - const: handover
> > +            - const: stop-ack
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,msm8996-mss-pil
> > +              - qcom,msm8998-mss-pil
> > +              - qcom,sc7180-mss-pil
> > +              - qcom,sc7280-mss-pil
> > +              - qcom,sdm845-mss-pil
> > +    then:
> > +      properties:
> > +        interrupts-extended:
> > +          items:
> > +            - description: Watchdog interrupt
> > +            - description: Fatal interrupt
> > +            - description: Ready interrupt
> > +            - description: Handover interrupt
> > +            - description: Stop acknowledge interrupt
> > +            - description: Shutdown acknowledge interrupt
> > +        interrupt-names:
> > +          items:
> > +            - const: wdog
> > +            - const: fatal
> > +            - const: ready
> > +            - const: handover
> > +            - const: stop-ack
> > +            - const: shutdown-ack
>
> Both ifs should be written differently. Move the bigger list to
> properties with minItems: 5. For qcom,q6v5-pil you set maxItems:5. For
> qcom,msm8996-mss-pil you set minItems:6.
>
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - const: qcom,q6v5-pil
> > +            - const: qcom,msm8916-mss-pil
> > +            - const: qcom,msm8974-mss-pil
> > +    then:
> > +      properties:
> > +        cx-supply:
> > +          deprecated: true
> > +        mx-supply:
> > +          deprecated: true
> > +
> > +      required:
> > +        - pll-supply
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - qcom,msm8916-mss-pil
> > +            - qcom,msm8974-mss-pil
> > +            - qcom,msm8996-mss-pil
> > +            - qcom,msm8998-mss-pil
> > +    then:
> > +      properties:
> > +        power-domains:
> > +          items:
> > +            - description: CX power domain
> > +            - description: MX power domain
> > +        power-domain-names:
> > +          items:
> > +            - const: cx
> > +            - const: mx
> > +
> > +      required:
> > +        - power-domains
> > +        - power-domain-names
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - const: qcom,msm8996-mss-pil
> > +    then:
> > +      properties:
> > +        cx-supply: false
> > +        mx-supply: false
> > +
> > +      required:
> > +        - pll-supply
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - const: qcom,qcs404-wcss-pil
> > +    then:
> > +      required:
> > +        - cx-supply
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,sdm845-mss-pil
> > +              - qcom,sc7180-mss-pil
> > +    then:
> > +      properties:
> > +        power-domains:
> > +          items:
> > +            - description: CX power domain
> > +            - description: MX power domain
> > +            - description: MSS power domain
> > +        power-domain-names:
> > +          items:
> > +            - const: cx
> > +            - const: mx
> > +            - const: mss
> > +
> > +      required:
> > +        - power-domains
> > +        - power-domain-names
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,sc7280-mss-pil
> > +    then:
> > +      properties:
> > +        power-domains:
> > +          items:
> > +            - description: CX power domain
> > +            - description: MSS power domain
> > +        power-domain-names:
> > +          items:
> > +            - const: cx
> > +            - const: mss
> > +
> > +      required:
> > +        - power-domains
> > +        - power-domain-names
> > +        - qcom,ext-regs
> > +        - qcom,qaccept-regs
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,q6v5-pil
> > +              - qcom,msm8916-mss-pil
> > +              - qcom,msm8974-mss-pil
> > +              - qcom,msm8996-mss-pil
> > +              - qcom,msm8998-mss-pil
> > +    then:
> > +      properties:
> > +        resets:
> > +          items:
> > +            - description: MSS reset
> > +        reset-names:
> > +          items:
> > +            - const: mss_restart
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,ipq8074-wcss-pil
> > +              - qcom,qcs404-wcss-pil
> > +    then:
> > +      properties:
> > +        resets:
> > +          items:
> > +            - description: WCSS Always On restart
> > +            - description: WCSS reset
> > +            - description: WCSS Q6 reset
> > +        reset-names:
> > +          items:
> > +            - const: wcss_aon_restart
> > +            - const: wcss_reset
> > +            - const: wcss_q6_reset
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,sc7180-mss-pil
> > +              - qcom,sc7280-mss-pil
> > +              - qcom,sdm845-mss-pil
> > +    then:
> > +      properties:
> > +        resets:
> > +          items:
> > +            - description: MSS restart
> > +            - description: PDC reset
> > +        reset-names:
> > +          items:
> > +            - const: mss_restart
> > +            - const: pdc_reset
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,q6v5-pil
> > +              - qcom,ipq8074-wcss-pil
> > +              - qcom,qcs404-wcss-pil
> > +              - qcom,msm8916-mss-pil
> > +              - qcom,msm8974-mss-pil
> > +              - qcom,msm8996-mss-pil
> > +              - qcom,msm8998-mss-pil
> > +    then:
> > +      properties:
> > +        qcom,qmp: false
> > +        iommus: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,rpmcc.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
> > +    #include <dt-bindings/reset/qcom,gcc-msm8974.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    modem-rproc@fc880000 {
>
> Generic node name, so "remoteproc"

Will fix in v2

>
> > +        compatible =3D "qcom,q6v5-pil";
> > +        reg =3D <0xfc880000 0x100>,
> > +              <0xfc820000 0x020>;
> > +        reg-names =3D "qdsp6", "rmb";
> > +
> > +        interrupts-extended =3D <&intc GIC_SPI 24 IRQ_TYPE_EDGE_RISING=
>,
> > +                              <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>=
,
> > +                              <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>=
,
> > +                              <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>=
,
> > +                              <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>=
;
> > +        interrupt-names =3D "wdog",
> > +                          "fatal",
> > +                          "ready",
> > +                          "handover",
> > +                          "stop-ack";
> > +
> > +        clocks =3D <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
> > +                 <&gcc GCC_MSS_CFG_AHB_CLK>,
> > +                 <&gcc GCC_BOOT_ROM_AHB_CLK>,
> > +                 <&xo_board>;
> > +        clock-names =3D "iface", "bus", "mem", "xo";
> > +
> > +        qcom,halt-regs =3D <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
>
> Does this pass the tests? Did you test the bindings?
Yes, both dtbs_check and dt_binding_check
>
> > +
> > +        resets =3D <&gcc GCC_MSS_RESTART>;
> > +        reset-names =3D "mss_restart";
> > +
> > +        cx-supply =3D <&pm8841_s2>;
> > +        mss-supply =3D <&pm8841_s3>;
> > +        mx-supply =3D <&pm8841_s1>;
> > +        pll-supply =3D <&pm8941_l12>;
> > +
> > +        qcom,smem-states =3D <&modem_smp2p_out 0>;
> > +        qcom,smem-state-names =3D "stop";
> > +
> > +        mba {
> > +                memory-region =3D <&mba_region>;
>
> Wrong indentation.
>
Will fix in v2
> > +        };
> > +
> > +        mpss {
> > +                memory-region =3D <&mpss_region>;
> > +        };
> > +
> > +        smd-edge {
> > +                interrupts =3D <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
> > +
> > +                qcom,ipc =3D <&apcs 8 12>;
> > +                qcom,smd-edge =3D <0>;
> > +
> > +                label =3D "modem";
> > +        };
> > +    };
>
>
> Best regards,
> Krzysztof

Thanks,
Sireesh Kodali

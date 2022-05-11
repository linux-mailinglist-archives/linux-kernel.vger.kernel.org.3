Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C1523BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbiEKRvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345812AbiEKRuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:50:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DECE032
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:50:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ch13so5512849ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f21nQo2EfXJr+qfsORqvN3j1OiLfyIFncqC+B2UHzFk=;
        b=soGX7OX8douaI5TIhUsZ7Pynh5JqxGkiYG0eW1DNu/GC18Ya6ewtXsXhXUm6wRycOs
         VWwPr2MjV81lD28eeYN1hGlSceXKKKuv5tUIfYdmx8RWL01o/5Ho5zLd40ij7V/yqiw4
         NUwG5EPQrf216755g1/SbtoEQl2dgKu5yQ1tmfVb4Hs3Pcg2A+0Z7YqiAg97hUh7wDbk
         IQHBPVG1nR06NQFVII4QeyFVJSnjA/fAyiq9/YvVlD1P6BZWCRPF1MNUrbbILPOxhrLI
         mJ3D2TvF8XhzEATu478uSMYkD14wQFt4Blk6JX5BybP5pY2ykDUHyyqSy+LkFmJfFFSO
         qcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f21nQo2EfXJr+qfsORqvN3j1OiLfyIFncqC+B2UHzFk=;
        b=NfP5kDS/Kfh9GtjPbPtkfVDzc0PG93akThMJYD8w8SIpoFTtL81jk08htICSM6tHQp
         3s9Oi8yzmTsqgoZscLDqt+5yyTbF4acJqzoDoLK2EMsq4zJnQ1qDH2VU8SwnpG2R7a2R
         7asqbLsXgp1Rgoz25d5KzUxuoaoNHkUlcgs06Z+2CIOgYFDT8DKoLQfJVFYqsTifuS4r
         e06N3VzaOs5gNck/v3PEmWV4LRqN/kpS6Sdj++n4idfuM5RrQ9rmsZgJqHJwbU12HxAp
         ydsukZcDmbuvrp4iVjUjvreNQgUZsBh5zWvlNpd4Ivf5+J+BPEcdJCGs1VhSuKLixzpy
         hxoA==
X-Gm-Message-State: AOAM5319rJAseioaQbRxE7a12GrFbnx0nynOJf54iOXihZxfPteeuU5F
        u9ljbjQsfpY7nzLKPc5ZTPJ7qg==
X-Google-Smtp-Source: ABdhPJy+NAb2j/B7JTCOdya68vUCdUE+UL9pOOKCU7CVAvYNBSZVhjzCNB/1MWTT/O/+yEn9vAdQ9g==
X-Received: by 2002:a17:906:9b96:b0:6f5:cdd:9bf2 with SMTP id dd22-20020a1709069b9600b006f50cdd9bf2mr25936445ejc.364.1652291449449;
        Wed, 11 May 2022 10:50:49 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709067e4a00b006f3ef214dfdsm1241176ejr.99.2022.05.11.10.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:50:49 -0700 (PDT)
Message-ID: <29a8871f-59ab-05f2-d258-eea52b7ac6ee@linaro.org>
Date:   Wed, 11 May 2022 19:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 6/9] dt-bindings: remoteproc: qcom: mss: Convert bindings
 to YAML
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-7-sireeshkodali1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511161602.117772-7-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 18:15, Sireesh Kodali wrote:
> Convert the bindings to YAML from txt. The bindings follow a similar
> schema to `qcom,adsp.yaml`.
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>  .../bindings/remoteproc/qcom,q6v5.txt         | 302 --------
>  .../bindings/remoteproc/qcom,q6v5.yaml        | 702 ++++++++++++++++++
>  2 files changed, 702 insertions(+), 302 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml

Same comments as for patch 4 apply here. Some of them seems fixed so it
makes me wonder - why you wrote two bindings in entirely different way?

> +  This document defines the binding for a component that loads and boots firmware
> +  on the Qualcomm Hexagon core.
> +
> +properties:
> +  compatible:
> +    # Special case, because older platforms like MSM8916 use both compatibles together
> +    minItems: 1
> +    maxItems: 2
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,msm8916-mss-pil
> +          - enum:
> +              - qcom,q6v5-pil

Everywhere - same comments as in patch 4.

> +      - items:
> +          - enum:
> +              - qcom,q6v5-pil
> +              - qcom,ipq8074-wcss-pil
> +              - qcom,qcs404-wcss-pil
> +              - qcom,msm8916-mss-pil
> +              - qcom,msm8974-mss-pil
> +              - qcom,msm8996-mss-pil
> +              - qcom,msm8998-mss-pil
> +              - qcom,sc7180-mss-pil
> +              - qcom,sc7280-mss-pil
> +              - qcom,sdm845-mss-pil
> +
> +  reg:
> +    description: must specify the base address and size of the qdsp6 and rmb
> +      register blocks
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: qdsp6
> +      - const: rmb
> +
> +  interrupts-extended:
> +    minItems: 5
> +    maxItems: 6
> +
> +  interrupt-names:
> +    minItems: 5
> +    maxItems: 6
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: List the relative firmware image paths for the mba and
> +      modem. They are used for booting and authenticating the Hexagon core.
> +    maxItems: 2
> +
> +  clocks:
> +    minItems: 4
> +    maxItems: 10
> +
> +  clock-names:
> +    minItems: 4
> +    maxItems: 10
> +
> +  resets:
> +    description: Reference to the reset-controllwer for the modem subsystem
> +    minItems: 1
> +    maxItems: 3
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  memory-region:
> +    maxItems: 1
> +    description: Reference to the reserved-memory for the mba region followed
> +      by the mpss region. Required if the mba and mpss sub-nodes are not
> +      specified.
> +
> +  cx-supply:
> +    description: Phandle to the CX regulator
> +
> +  mx-supply:
> +    description: Phandle to the MX regulator
> +
> +  pll-supply:
> +    description: Phandle to the PLL regulator, to be held on behalf of the
> +      booting Hexagon core
> +
> +  mss-supply:
> +    description: Phandle to the mss regulator, to be held on behalf of the
> +      booting Hexagon core

s/Phandle to//, everywhere.

> +
> +  power-domains:
> +    minItems: 1
> +    maxItems: 4
> +
> +  power-domain-names:
> +    minItems: 1
> +    maxItems: 4
> +
> +  qcom,qmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the AOSS side-channel message RAM.
> +
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: States used by the AP to signal the Hexagon core
> +    items:
> +      - description: Stop the modem
> +
> +  qcom,smem-state-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: The names of the state bits used for SMP2P output
> +    items:
> +      - const: stop
> +
> +  qcom,halt-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandle reference to a syscon representing TCSR followed by the
> +      three offsets within syscon for q6, modem and nc halt registers.
> +
> +  qcom,spare-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A phandle reference to a syscon representing TCSR followed by the
> +      offset within syscon for conn_box_spare0 register used by the modem
> +      sub-system running on SC7180 SoC.
> +
> +  qcom,ext-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Two phandle references to syscons representing TCSR_REG and TCSR
> +      register space followed by the two offsets within the syscon to
> +      force_clk_en/rscc_disable and axim1_clk_off/crypto_clk_off registers
> +      respectively.
> +
> +  qcom,qaccept-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A phandle reference to a syscon representing TCSR followed by the three
> +      offsets within syscon for mdm, cx and axi qaccept registers used by the
> +      modem sub-system running on SC7280 SoC.
> +
> +  iommus:
> +    description:
> +      Only required on platforms that do not have TrustZone.
> +
> +  smd-edge:
> +    type: object
> +    description:
> +      Qualcomm Shared Memory subnode which represents communication edge,
> +      channels and devices related to the ADSP.
> +
> +  glink-edge:
> +    type: object
> +    description:
> +      Qualcomm G-Link subnode which represents communication edge, channels
> +      and devices related to the ADSP.
> +
> +  mba:
> +    type: object

description needed.

> +    properties:
> +      memory-region:
> +        maxItems: 1
> +
> +    required:
> +      - memory-region
> +
> +  mpss:

description needed.

> +    type: object
> +    properties:
> +      memory-region:
> +        maxItems: 1
> +
> +    required:
> +      - memory-region
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - interrupts-extended
> +  - interrupt-names
> +  - qcom,smem-states
> +  - qcom,smem-state-names
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq8074-wcss-pil
> +    then:
> +      properties:
> +        clocks: false
> +        clock-names: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,qcs404-wcss-pil
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: GCC_AHBS_CBCR clock
> +            - description: GCC_AXIM_CBCR clock
> +            - description: LCC_AHBFABRIC_CBC clock
> +            - description: TCSR_LCC_CBC clock
> +            - description: LCC_AHBS_CBC clock
> +            - description: LCC_TCM_SLAVE_CBC clock
> +            - description: LCC_ABHM_CBC clock
> +            - description: LCC_AXIM_CBC clock
> +            - description: LCC_BCR_SLEEP clock
> +            - description: XO clock
> +        clock-names:
> +          items:
> +            - const: gcc_ahbs_cbcr
> +            - const: gcc_axim_cbcr
> +            - const: lcc_ahbfabric_cbc
> +            - const: tcsr_lcc_cbc
> +            - const: lcc_abhs_cbc
> +            - const: lcc_tcm_slave_cbc
> +            - const: lcc_abhm_cbc
> +            - const: lcc_axim_cbc
> +            - const: lcc_bcr_sleep
> +            - const: xo
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,q6v5-pil
> +              - qcom,msm8916-mss-pil
> +              - qcom,msm8974-mss-pil
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Interface clock
> +            - description: Bus clock
> +            - description: Memory clock
> +            - description: XO clock
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bus
> +            - const: mem
> +            - const: xo
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8996-mss-pil
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Interface clock
> +            - description: Bus clock
> +            - description: Memory clock
> +            - description: GPLL0_MSS clock
> +            - description: SNOC_AXI clock
> +            - description: MNOC_AXI clock
> +            - description: PNOC clock
> +            - description: QDSS clock
> +            - description: XO clock
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bus
> +            - const: mem
> +            - const: gpll0_mss
> +            - const: snoc_axi
> +            - const: mnoc_axi
> +            - const: pnoc
> +            - const: qdss
> +            - const: xo
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8998-mss-pil
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Interface clock
> +            - description: Bus clock
> +            - description: Memory clock
> +            - description: GPLL0_MSS clock
> +            - description: SNOC_AXI clock
> +            - description: MNOC_AXI clock
> +            - description: QDSS clock
> +            - description: XO clock
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bus
> +            - const: mem
> +            - const: gpll0_mss
> +            - const: snoc_axi
> +            - const: mnoc_axi
> +            - const: qdss
> +            - const: xo
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc7180-mss-pil
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Interface clock
> +            - description: Bus clock
> +            - description: NAV clock
> +            - description: SNOC_AXI clock
> +            - description: MNOC_AXI clock
> +            - description: XO clock
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bus
> +            - const: nav
> +            - const: snoc_axi
> +            - const: mnoc_axi
> +            - const: xo
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc7280-mss-pil
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Interface clock
> +            - description: Offline clock
> +            - description: SNOC_AXI clock
> +            - description: PKA clock
> +            - description: XO clock
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: offline
> +            - const: snoc_axi
> +            - const: pka
> +            - const: xo
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdm845-mss-pil
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Interface clock
> +            - description: Bus clock
> +            - description: Memory clock
> +            - description: GPLL0_MSS clock
> +            - description: SNOC_AXI clock
> +            - description: MNOC_AXI clock
> +            - description: PRNG clock
> +            - description: XO clock
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bus
> +            - const: mem
> +            - const: gpll0_mss
> +            - const: snoc_axi
> +            - const: mnoc_axi
> +            - const: prng
> +            - const: xo
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,q6v5-pil
> +              - qcom,ipq8074-wcss-pil
> +              - qcom,qcs404-wcss-pil
> +              - qcom,msm8916-mss-pil
> +              - qcom,msm8974-mss-pil
> +    then:
> +      properties:
> +        interrupts-extended:

No extended.

> +          items:
> +            - description: Watchdog interrupt
> +            - description: Fatal interrupt
> +            - description: Ready interrupt
> +            - description: Handover interrupt
> +            - description: Stop acknowledge interrupt
> +        interrupt-names:
> +          items:
> +            - const: wdog
> +            - const: fatal
> +            - const: ready
> +            - const: handover
> +            - const: stop-ack
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8996-mss-pil
> +              - qcom,msm8998-mss-pil
> +              - qcom,sc7180-mss-pil
> +              - qcom,sc7280-mss-pil
> +              - qcom,sdm845-mss-pil
> +    then:
> +      properties:
> +        interrupts-extended:
> +          items:
> +            - description: Watchdog interrupt
> +            - description: Fatal interrupt
> +            - description: Ready interrupt
> +            - description: Handover interrupt
> +            - description: Stop acknowledge interrupt
> +            - description: Shutdown acknowledge interrupt
> +        interrupt-names:
> +          items:
> +            - const: wdog
> +            - const: fatal
> +            - const: ready
> +            - const: handover
> +            - const: stop-ack
> +            - const: shutdown-ack

Both ifs should be written differently. Move the bigger list to
properties with minItems: 5. For qcom,q6v5-pil you set maxItems:5. For
qcom,msm8996-mss-pil you set minItems:6.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - const: qcom,q6v5-pil
> +            - const: qcom,msm8916-mss-pil
> +            - const: qcom,msm8974-mss-pil
> +    then:
> +      properties:
> +        cx-supply:
> +          deprecated: true
> +        mx-supply:
> +          deprecated: true
> +
> +      required:
> +        - pll-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,msm8916-mss-pil
> +            - qcom,msm8974-mss-pil
> +            - qcom,msm8996-mss-pil
> +            - qcom,msm8998-mss-pil
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: CX power domain
> +            - description: MX power domain
> +        power-domain-names:
> +          items:
> +            - const: cx
> +            - const: mx
> +
> +      required:
> +        - power-domains
> +        - power-domain-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - const: qcom,msm8996-mss-pil
> +    then:
> +      properties:
> +        cx-supply: false
> +        mx-supply: false
> +
> +      required:
> +        - pll-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - const: qcom,qcs404-wcss-pil
> +    then:
> +      required:
> +        - cx-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdm845-mss-pil
> +              - qcom,sc7180-mss-pil
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: CX power domain
> +            - description: MX power domain
> +            - description: MSS power domain
> +        power-domain-names:
> +          items:
> +            - const: cx
> +            - const: mx
> +            - const: mss
> +
> +      required:
> +        - power-domains
> +        - power-domain-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc7280-mss-pil
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: CX power domain
> +            - description: MSS power domain
> +        power-domain-names:
> +          items:
> +            - const: cx
> +            - const: mss
> +
> +      required:
> +        - power-domains
> +        - power-domain-names
> +        - qcom,ext-regs
> +        - qcom,qaccept-regs
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,q6v5-pil
> +              - qcom,msm8916-mss-pil
> +              - qcom,msm8974-mss-pil
> +              - qcom,msm8996-mss-pil
> +              - qcom,msm8998-mss-pil
> +    then:
> +      properties:
> +        resets:
> +          items:
> +            - description: MSS reset
> +        reset-names:
> +          items:
> +            - const: mss_restart
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq8074-wcss-pil
> +              - qcom,qcs404-wcss-pil
> +    then:
> +      properties:
> +        resets:
> +          items:
> +            - description: WCSS Always On restart
> +            - description: WCSS reset
> +            - description: WCSS Q6 reset
> +        reset-names:
> +          items:
> +            - const: wcss_aon_restart
> +            - const: wcss_reset
> +            - const: wcss_q6_reset
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc7180-mss-pil
> +              - qcom,sc7280-mss-pil
> +              - qcom,sdm845-mss-pil
> +    then:
> +      properties:
> +        resets:
> +          items:
> +            - description: MSS restart
> +            - description: PDC reset
> +        reset-names:
> +          items:
> +            - const: mss_restart
> +            - const: pdc_reset
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,q6v5-pil
> +              - qcom,ipq8074-wcss-pil
> +              - qcom,qcs404-wcss-pil
> +              - qcom,msm8916-mss-pil
> +              - qcom,msm8974-mss-pil
> +              - qcom,msm8996-mss-pil
> +              - qcom,msm8998-mss-pil
> +    then:
> +      properties:
> +        qcom,qmp: false
> +        iommus: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
> +    #include <dt-bindings/reset/qcom,gcc-msm8974.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    modem-rproc@fc880000 {

Generic node name, so "remoteproc"

> +        compatible = "qcom,q6v5-pil";
> +        reg = <0xfc880000 0x100>,
> +              <0xfc820000 0x020>;
> +        reg-names = "qdsp6", "rmb";
> +
> +        interrupts-extended = <&intc GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
> +                              <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                              <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +                              <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +                              <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "wdog",
> +                          "fatal",
> +                          "ready",
> +                          "handover",
> +                          "stop-ack";
> +
> +        clocks = <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
> +                 <&gcc GCC_MSS_CFG_AHB_CLK>,
> +                 <&gcc GCC_BOOT_ROM_AHB_CLK>,
> +                 <&xo_board>;
> +        clock-names = "iface", "bus", "mem", "xo";
> +
> +        qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;

Does this pass the tests? Did you test the bindings?

> +
> +        resets = <&gcc GCC_MSS_RESTART>;
> +        reset-names = "mss_restart";
> +
> +        cx-supply = <&pm8841_s2>;
> +        mss-supply = <&pm8841_s3>;
> +        mx-supply = <&pm8841_s1>;
> +        pll-supply = <&pm8941_l12>;
> +
> +        qcom,smem-states = <&modem_smp2p_out 0>;
> +        qcom,smem-state-names = "stop";
> +
> +        mba {
> +                memory-region = <&mba_region>;

Wrong indentation.

> +        };
> +
> +        mpss {
> +                memory-region = <&mpss_region>;
> +        };
> +
> +        smd-edge {
> +                interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
> +
> +                qcom,ipc = <&apcs 8 12>;
> +                qcom,smd-edge = <0>;
> +
> +                label = "modem";
> +        };
> +    };


Best regards,
Krzysztof

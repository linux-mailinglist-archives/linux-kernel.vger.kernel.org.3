Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281C6592653
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 22:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiHNUfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 16:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiHNUfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 16:35:42 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E06DFA1;
        Sun, 14 Aug 2022 13:35:41 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so4287978oti.9;
        Sun, 14 Aug 2022 13:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1yzME1DKBmKpfgIqUmDwlH/CXThIbhy6bKBF4WvclaI=;
        b=6o1KA4Oc2nq2VZ4/Gfy67mNNGhmfx/Ux2W9dqoyx6iwQ9nXybi4hI2Cm86XJ2Gx4A0
         g2nZoB6gqwwvuavm7hKNjD/B2uky85w2XfaLS2Tkmwelq4PbhBFNlMnQDMFa3W91G8x8
         bZMUtmkrCgdExMvjt5yG6m8rLkoRwDMRtjXm5f74HAGGr+Ph2FJgnbg9BBbi+JliTvHP
         Cg0QnjaDkIH4auvYo8q9RNs7xovldSOrFXJU5koQgAmFvFDX5GnXnZfEoRXarL8rqJ05
         znBaL8RvuemRr8vmizsV9SyKib9P5TcrEMOI/fRhJLMEg2kBXXUYryrjci/iTa+sfFX0
         GgPQ==
X-Gm-Message-State: ACgBeo1crZDxh0wWkBtrCv6opsyFz0JttyxaQMWRGaxdDi/C8XfF8agO
        S5kfD96kIcAQvuWXDbN/nAO+G9zM8A==
X-Google-Smtp-Source: AA6agR7ybtZm2twC7AfEyUwsGD73uEy7PzXKYvjaxXY933LzdSWHnEX0L30Kig5wfM5Cny9cHKCd1g==
X-Received: by 2002:a05:6830:1450:b0:636:f7fe:e47b with SMTP id w16-20020a056830145000b00636f7fee47bmr5098197otp.156.1660509340519;
        Sun, 14 Aug 2022 13:35:40 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.176.57])
        by smtp.gmail.com with ESMTPSA id j3-20020a056830014300b0063725d33561sm1724376otp.73.2022.08.14.13.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 13:35:40 -0700 (PDT)
Received: (nullmailer pid 664149 invoked by uid 1000);
        Sun, 14 Aug 2022 20:35:30 -0000
Date:   Sun, 14 Aug 2022 14:35:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: remoteproc: qcom: Add SC7280 ADSP
 support
Message-ID: <20220814203530.GA640885-robh@kernel.org>
References: <1660308466-410-1-git-send-email-quic_srivasam@quicinc.com>
 <1660308466-410-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660308466-410-2-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 06:17:40PM +0530, Srinivasa Rao Mandadapu wrote:
> Add ADSP PIL loading support for SC7280 SoCs.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 189 +++++++++++++++++++++
>  1 file changed, 189 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> new file mode 100644
> index 0000000..e656cc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> @@ -0,0 +1,189 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-adsp-pil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SC7280 ADSP Peripheral Image Loader
> +
> +maintainers:
> +  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> +
> +description:
> +  This document defines the binding for a component that loads and boots firmware
> +  on the Qualcomm Technology Inc. ADSP.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc7280-adsp-pil
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: qdsp6ss register
> +      - description: efuse q6ss register
> +
> +  interrupts:
> +    items:
> +      - description: Watchdog interrupt
> +      - description: Fatal interrupt
> +      - description: Ready interrupt
> +      - description: Handover interrupt
> +      - description: Stop acknowledge interrupt
> +      - description: Shutdown acknowledge interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: wdog
> +      - const: fatal
> +      - const: ready
> +      - const: handover
> +      - const: stop-ack
> +      - const: shutdown-ack
> +
> +  clocks:
> +    items:
> +      - description: XO clock
> +      - description: GCC CFG NOC LPASS clock
> +      - description: LPASS AHBS AON clock
> +      - description: LPASS AHBM AON clock
> +      - description: QDSP XO clock
> +      - description: Q6SP6SS SLEEP clock
> +      - description: Q6SP6SS CORE clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +      - const: gcc_cfg_noc_lpass
> +      - const: lpass_ahbs_aon_cbcr
> +      - const: lpass_ahbm_aon_cbcr
> +      - const: qdsp6ss_xo
> +      - const: qdsp6ss_sleep
> +      - const: qdsp6ss_core
> +
> +  power-domains:
> +    items:
> +      - description: LCX power domain
> +
> +  resets:
> +    items:
> +      - description: PDC AUDIO SYNC RESET
> +      - description: CC LPASS restart
> +
> +  reset-names:
> +    items:
> +      - const: pdc_sync
> +      - const: cc_lpass
> +
> +  memory-region:
> +    maxItems: 1
> +    description: Reference to the reserved-memory for the Hexagon core
> +
> +  qcom,adsp-memory-regions:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description:
> +      Each entry consists of 4 integers and represents the
> +      list of memory regions accessed by ADSP firmware.
> +    items:
> +      items:
> +        - description: |
> +            "iova reg" indicates the address of virtual memory region.
> +        - description: |
> +            "physical reg" indicates the address of phyical memory region.
> +        - description: |
> +            "size" indicates the offset memory region.
> +        - description: |
> +            "access level" indicates the read, read and write access levels.
> +          minimum: 0
> +          maximum: 1
> +
> +  qcom,halt-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandle reference to a syscon representing TCSR followed by the
> +      three offsets within syscon for q6, modem and nc halt registers.

items: 
  - items:
      - description: phandle to TCSR
      - description: offset to q6 halt registers
      - ...

> +
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: States used by the AP to signal the Hexagon core
> +    items:
> +      - description: Stop the modem
> +
> +  qcom,smem-state-names:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: The names of the state bits used for SMP2P output
> +    items:
> +      - const: stop
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +  - qcom,halt-regs
> +  - memory-region
> +  - qcom,smem-states
> +  - qcom,smem-state-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
> +    #include <dt-bindings/clock/qcom,lpass-sc7280.h>
> +    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> +    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    remoteproc@3000000 {
> +        compatible = "qcom,sc7280-adsp-pil";
> +        reg = <0x03000000 0x5000>,
> +              <0x355B000 0x10>;
> +
> +        interrupts-extended = <&pdc 162 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> +
> +        interrupt-names = "wdog", "fatal", "ready",
> +                "handover", "stop-ack", "shutdown-ack";
> +
> +        clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                 <&gcc GCC_CFG_NOC_LPASS_CLK>,
> +                 <&lpasscc LPASS_Q6SS_AHBM_CLK>,
> +                 <&lpasscc LPASS_Q6SS_AHBS_CLK>,
> +                 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
> +                 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
> +                 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
> +        clock-names = "xo", "gcc_cfg_noc_lpass",
> +                "lpass_ahbs_aon_cbcr",
> +                "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
> +                "qdsp6ss_sleep", "qdsp6ss_core";
> +
> +        power-domains = <&rpmhpd SC7280_LCX>;
> +
> +        resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +                 <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +        reset-names = "pdc_sync", "cc_lpass";
> +
> +        qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
> +
> +        memory-region = <&adsp_mem>;
> +
> +        qcom,smem-states = <&adsp_smp2p_out 0>;
> +        qcom,smem-state-names = "stop";
> +
> +        qcom,adsp-memory-regions = <0x00100000 0x00100000 0x4000 0>,
> +                                   <0x00113000 0x00113000 0x1000 0>,
> +                                   <0x00117000 0x00117000 0x2000 1>;
> +    };
> -- 
> 2.7.4
> 
> 

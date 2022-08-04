Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9441258A183
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbiHDTtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbiHDTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:48:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6736E89B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:47:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so957242wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QlT7DqqIhp/KPt8AYXFlLmzKkm+SJZEvwWGK5U978as=;
        b=Ej+YlApkLVmQN+VjvK9aslfn+W0IWfglXj1gCvgdkrkZ/zEAC8fNXsTye9deOSm79p
         bDBlItY0x1YLhIQ7XJPlXTQm3CsdusO4eXPpdRhwOPS8/aGgWx4dIPVVTGkgiPvn38ig
         jrG/Ls4SFldrL4xIbCuMBZKmt9imaGlZQMS6ZPGC8ShkRAEHOikp+OmLsLSpRWgQE9BP
         niCdN04hLA3aJ1GSCZUiKJdepfon6ivhGimAabFcaCVyuIYfqe+O29cpp/P1AkuEgbDr
         7luOZjUexImBpmd7P5nLoXgJWZanWIu8B2+fjR992AgjfS6y7N0+8XW2gn4VrctYEnNh
         /A7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QlT7DqqIhp/KPt8AYXFlLmzKkm+SJZEvwWGK5U978as=;
        b=g8Lh8X9p4sX0Z3uqBv4Msp94XpYH5ZsBhvVWvF8HftEqYBdnwHcaLFk1vIQSiurH37
         HAlwRKuahQpZat8do4omyDUg+Lnl+VS92em/Zgik2YeZxcXRqKMAFigmPQwjMD/S4IUs
         +J+noNnmXH29p0r1bN6pKgrzgOtBkfYNptIeRRMjesZhVC3ZD9YZcDCHlK2nbG2M2SFK
         QqoEJ7g7Nh9ABLXJXQcu9ekjiGc+RuWVuYw9Rb+u+fsQYsRYFOJDnsZ6yM6G2Xzdf6tt
         tgBRJfhuqDh7VG2IhZUMSD8Hl5s3E1HJPS97HOaqoAimuO9XCDvQSeI8LP+EH3afX/2m
         wF6Q==
X-Gm-Message-State: ACgBeo3qEA7KuRLg7kHPeIuJ/CspXETm9kFl0r/zVMrxwokGkZOpltkW
        GkCPrAV+z412qKrMwvA/Mh41rg==
X-Google-Smtp-Source: AA6agR4KBKeJafzctEjHC4LXyH4OVEgAxIimdEUPkzTNZ3L1kV+nfkbNf8hLy9dIfgtIwgGNlb2udQ==
X-Received: by 2002:a5d:4601:0:b0:21d:8db4:37c with SMTP id t1-20020a5d4601000000b0021d8db4037cmr2327990wrq.390.1659642469447;
        Thu, 04 Aug 2022 12:47:49 -0700 (PDT)
Received: from [192.168.1.12] ([81.178.197.238])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b003a046549a85sm7285372wms.37.2022.08.04.12.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 12:47:48 -0700 (PDT)
Message-ID: <a59add1a-7e33-a47b-a804-b98c132d78f2@linaro.org>
Date:   Thu, 4 Aug 2022 20:47:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/8] dt-bindings: remoteproc: qcom: adsp: Make ADSP pil
 loader as generic
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <PLL_L3rk0As4iT923EpBfGe-uDR4XZZWQS3zFNrfS3m5TCPUtK0E58AEjofIncTglWcpEXVbYj2b1vWjEZgJBA==@protonmail.internalid>
 <1659536480-5176-2-git-send-email-quic_srivasam@quicinc.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <1659536480-5176-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
On 03/08/2022 15:21, Srinivasa Rao Mandadapu wrote:
> Rename sdm845 adsp pil bindings to generic name, for using same binings
> file for subsequent SoCs.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>   .../bindings/remoteproc/qcom,lpass-adsp-pil.yaml   | 160 +++++++++++++++++++++
>   .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml  | 160 ---------------------
>   2 files changed, 160 insertions(+), 160 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
>   delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
This should be a rename, I think passing the -M flag to "git format-patch" 
detects it.
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
> new file mode 100644
> index 0000000..9f11332
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,lpass-adsp-pil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm LPASS ADSP Peripheral Image Loader
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  This document defines the binding for a component that loads and boots firmware
> +  on the Qualcomm Technology Inc. ADSP.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sdm845-adsp-pil
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      The base address and size of the qdsp6ss register
> +
> +  interrupts:
> +    items:
> +      - description: Watchdog interrupt
> +      - description: Fatal interrupt
> +      - description: Ready interrupt
> +      - description: Handover interrupt
> +      - description: Stop acknowledge interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: wdog
> +      - const: fatal
> +      - const: ready
> +      - const: handover
> +      - const: stop-ack
> +
> +  clocks:
> +    items:
> +      - description: XO clock
> +      - description: SWAY clock
> +      - description: LPASS AHBS AON clock
> +      - description: LPASS AHBM AON clock
> +      - description: QDSP XO clock
> +      - description: Q6SP6SS SLEEP clock
> +      - description: Q6SP6SS CORE clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +      - const: sway_cbcr
> +      - const: lpass_ahbs_aon_cbcr
> +      - const: lpass_ahbm_aon_cbcr
> +      - const: qdsp6ss_xo
> +      - const: qdsp6ss_sleep
> +      - const: qdsp6ss_core
> +
> +  power-domains:
> +    items:
> +      - description: CX power domain
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
> +  qcom,halt-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandle reference to a syscon representing TCSR followed by the
> +      three offsets within syscon for q6, modem and nc halt registers.
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
> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +    #include <dt-bindings/clock/qcom,lpass-sdm845.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
> +    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> +    remoteproc@17300000 {
> +        compatible = "qcom,sdm845-adsp-pil";
> +        reg = <0x17300000 0x40c>;
> +
> +        interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "wdog", "fatal", "ready",
> +                "handover", "stop-ack";
> +
> +        clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                 <&gcc GCC_LPASS_SWAY_CLK>,
> +                 <&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
> +                 <&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
> +                 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
> +                 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
> +                 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
> +        clock-names = "xo", "sway_cbcr",
> +                "lpass_ahbs_aon_cbcr",
> +                "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
> +                "qdsp6ss_sleep", "qdsp6ss_core";
> +
> +        power-domains = <&rpmhpd SDM845_CX>;
> +
> +        resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +                 <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +        reset-names = "pdc_sync", "cc_lpass";
> +
> +        qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
> +
> +        memory-region = <&pil_adsp_mem>;
> +
> +        qcom,smem-states = <&adsp_smp2p_out 0>;
> +        qcom,smem-state-names = "stop";
> +    };
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
> deleted file mode 100644
> index 1535bbb..0000000
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
> +++ /dev/null
> @@ -1,160 +0,0 @@
> -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/remoteproc/qcom,sdm845-adsp-pil.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: Qualcomm SDM845 ADSP Peripheral Image Loader
> -
> -maintainers:
> -  - Bjorn Andersson <bjorn.andersson@linaro.org>
> -
> -description:
> -  This document defines the binding for a component that loads and boots firmware
> -  on the Qualcomm Technology Inc. ADSP.
> -
> -properties:
> -  compatible:
> -    enum:
> -      - qcom,sdm845-adsp-pil
> -
> -  reg:
> -    maxItems: 1
> -    description:
> -      The base address and size of the qdsp6ss register
> -
> -  interrupts:
> -    items:
> -      - description: Watchdog interrupt
> -      - description: Fatal interrupt
> -      - description: Ready interrupt
> -      - description: Handover interrupt
> -      - description: Stop acknowledge interrupt
> -
> -  interrupt-names:
> -    items:
> -      - const: wdog
> -      - const: fatal
> -      - const: ready
> -      - const: handover
> -      - const: stop-ack
> -
> -  clocks:
> -    items:
> -      - description: XO clock
> -      - description: SWAY clock
> -      - description: LPASS AHBS AON clock
> -      - description: LPASS AHBM AON clock
> -      - description: QDSP XO clock
> -      - description: Q6SP6SS SLEEP clock
> -      - description: Q6SP6SS CORE clock
> -
> -  clock-names:
> -    items:
> -      - const: xo
> -      - const: sway_cbcr
> -      - const: lpass_ahbs_aon_cbcr
> -      - const: lpass_ahbm_aon_cbcr
> -      - const: qdsp6ss_xo
> -      - const: qdsp6ss_sleep
> -      - const: qdsp6ss_core
> -
> -  power-domains:
> -    items:
> -      - description: CX power domain
> -
> -  resets:
> -    items:
> -      - description: PDC AUDIO SYNC RESET
> -      - description: CC LPASS restart
> -
> -  reset-names:
> -    items:
> -      - const: pdc_sync
> -      - const: cc_lpass
> -
> -  memory-region:
> -    maxItems: 1
> -    description: Reference to the reserved-memory for the Hexagon core
> -
> -  qcom,halt-regs:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> -    description:
> -      Phandle reference to a syscon representing TCSR followed by the
> -      three offsets within syscon for q6, modem and nc halt registers.
> -
> -  qcom,smem-states:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> -    description: States used by the AP to signal the Hexagon core
> -    items:
> -      - description: Stop the modem
> -
> -  qcom,smem-state-names:
> -    $ref: /schemas/types.yaml#/definitions/string
> -    description: The names of the state bits used for SMP2P output
> -    items:
> -      - const: stop
> -
> -required:
> -  - compatible
> -  - reg
> -  - interrupts
> -  - interrupt-names
> -  - clocks
> -  - clock-names
> -  - power-domains
> -  - resets
> -  - reset-names
> -  - qcom,halt-regs
> -  - memory-region
> -  - qcom,smem-states
> -  - qcom,smem-state-names
> -
> -additionalProperties: false
> -
> -examples:
> -  - |
> -    #include <dt-bindings/interrupt-controller/arm-gic.h>
> -    #include <dt-bindings/clock/qcom,rpmh.h>
> -    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> -    #include <dt-bindings/clock/qcom,lpass-sdm845.h>
> -    #include <dt-bindings/power/qcom-rpmpd.h>
> -    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
> -    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> -    remoteproc@17300000 {
> -        compatible = "qcom,sdm845-adsp-pil";
> -        reg = <0x17300000 0x40c>;
> -
> -        interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
> -                <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> -                <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> -                <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> -                <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> -        interrupt-names = "wdog", "fatal", "ready",
> -                "handover", "stop-ack";
> -
> -        clocks = <&rpmhcc RPMH_CXO_CLK>,
> -                 <&gcc GCC_LPASS_SWAY_CLK>,
> -                 <&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
> -                 <&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
> -                 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
> -                 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
> -                 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
> -        clock-names = "xo", "sway_cbcr",
> -                "lpass_ahbs_aon_cbcr",
> -                "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
> -                "qdsp6ss_sleep", "qdsp6ss_core";
> -
> -        power-domains = <&rpmhpd SDM845_CX>;
> -
> -        resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> -                 <&aoss_reset AOSS_CC_LPASS_RESTART>;
> -        reset-names = "pdc_sync", "cc_lpass";
> -
> -        qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
> -
> -        memory-region = <&pil_adsp_mem>;
> -
> -        qcom,smem-states = <&adsp_smp2p_out 0>;
> -        qcom,smem-state-names = "stop";
> -    };
> --
> 2.7.4
> 

-- 
Kind Regards,
Caleb (they/he)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF047C1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbhLUOm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:42:29 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46812 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhLUOm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:42:27 -0500
Received: by mail-qk1-f176.google.com with SMTP id a11so12661825qkh.13;
        Tue, 21 Dec 2021 06:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7hiTEgNKENcz/Y9G25D8gy7mCFSJcD5x99oF0W47Myw=;
        b=Naa0Cv8oYi/Lzwfi38Pr4UWmAgesfzENdSfnMUusTLzOu/fGmYwKO2gGv5242Xb9HA
         ksS95YcWxYWI1kPWMT3RITKzysxcYKOaqVYfAVDkLReCwsBOZ9IDG2sGZ0+ES7WZcASX
         ACmBSeoXq98GkuGdi/5VADq3JfSic/DNd604DYHSzA6c0AYNpS28TXbOQugVI8oXh5WE
         LWC+8ye4XtX3WMoRYfUR1XM6Gh2W6dM0KtK0l3aXADHmYBTE4odOCVWCCqbpbN4XauqL
         biaMtMKaLRBF5VZa647WPB0AUtn2XhlTWGP3DHYmvzjgReeh8zJuLYUHe76H3SkWyX0l
         RPMQ==
X-Gm-Message-State: AOAM531N/0OyFBf53ySmtwnKYFwHuErrhEAJp6baEcKBYXkdj9kKcRlP
        lFgGF+7VOfTf0ErUOQvahtOTGPfR1obl
X-Google-Smtp-Source: ABdhPJwefwise4M4dQhfkhkAbPvDIFfh6hQWFr1NCJJ+Qx/b4zISrml4k1oH97Xkq+loYAG110ZWEA==
X-Received: by 2002:a05:620a:2901:: with SMTP id m1mr2181584qkp.644.1640097746889;
        Tue, 21 Dec 2021 06:42:26 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id bi6sm14226390qkb.29.2021.12.21.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:42:26 -0800 (PST)
Received: (nullmailer pid 1376629 invoked by uid 1000);
        Tue, 21 Dec 2021 14:42:24 -0000
Date:   Tue, 21 Dec 2021 10:42:24 -0400
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        devicetree@vger.kernel.org, collinsd@codeaurora.org,
        subbaram@codeaurora.org, tglx@linutronix.de, maz@kernel.org
Subject: Re: [PATCH v4 11/11] dt-bindings: convert qcom,spmi-pmic-arb binding
 to YAML format
Message-ID: <YcHn0MLuqvMHbmuO@robh.at.kernel.org>
References: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com>
 <1640071211-31462-12-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640071211-31462-12-git-send-email-quic_fenglinw@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:20:09PM +0800, Fenglin Wu wrote:
> Convert the SPMI PMIC arbiter documentation to JSON/yaml.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  67 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 146 +++++++++++++++++++++
>  2 files changed, 146 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 

> diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> new file mode 100644
> index 0000000..df8cfb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spmi/qcom,spmi-pmic-arb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SPMI PMIC Arbiter
> +
> +maintainers:
> +  - Fenglin Wu <quic_fenglinw@quicinc.com>
> +  - Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
> +
> +description: |
> +  The SPMI PMIC Arbiter is found on Snapdragon chipsets. It is an SPMI
> +  controller with wrapping arbitration logic to allow for multiple
> +  on-chip devices to control a single SPMI master.
> +
> +  The PMIC Arbiter can also act as an interrupt controller, providing
> +  interrupts to slave devices.
> +
> +  See Documentation/devicetree/bindings/spmi/spmi.yaml for the generic
> +  SPMI controller binding requirements for child nodes.
> +
> +allOf:
> +  - $ref: spmi.yaml#
> +
> +properties:
> +  $nodename:
> +    pattern: "^spmi@.*"
> +
> +  compatible:
> +    const: qcom,spmi-pmic-arb
> +
> +  reg-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array

reg-names already has a type defined.

> +    anyOf:
> +      - minItems: 3
> +      - maxItems: 3
> +      - enum: ["core", "intr", "cnfg"]
> +
> +      - minItems: 5
> +      - maxItems: 5
> +      - enum: ["core", "intr", "cnfg", "chnls", "obsrvr"]

I think you want something like this:

minItems: 3
items:
  - const: core
  - const: intr
  - const: cnfg
  - const: chnls
  - const: obsrvr


> +
> +  reg:
> +    minItems: 3
> +    maxItems: 5
> +    description: |
> +      Specifies base physical address and size of the registers in SPMI PMIC
> +      Arbiter HW module, with the following order.
> +        - SPMI PMIC arbiter core registers (core)
> +        - SPMI PMIC arbiter interrupt controller registers (intr)
> +        - SPMI PMIC arbiter configuration registers (cnfg)
> +        - SPMI PMIC arbiter tx-channel per virtual slave registers (chnls)
> +        - SPMI PMIC arbiter rx-channel per virtual slave registers (obsrvr).
> +      Register for "chnls" and "obsrvr" are only applicable for PMIC arbiter
> +      with HW version greater than V2.
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 0
> +
> +  interrupts:
> +    description: The summary interrupt for the PMIC Arb controller.
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: periph_irq
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 4
> +    description: |
> +      Specifies the number of cells needed to encode any interrupt source.
> +      The 1st cell is the slave ID for the requested interrupt, its valid
> +      range is [0-15].
> +      The 2nd cell is the  peripheral ID for requested interrupt, its valid
> +      range is [0-255].
> +      The 3rd cell is the requested peripheral interrupt, its valid range
> +      is [0-7].
> +      The 4th cell is interrupt flags indicating level-sense information,
> +      as defined in dt-bindings/interrupt-controller/irq.h
> +
> +  qcom,ee:
> +    description: the active Execution Environment identifier
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5]
> +
> +  qcom,channel:
> +    description: which of the PMIC Arbiter provided channels to use for accesses
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5]
> +

> +patternProperties:
> +  "@[0-9a-f]$":
> +    description: up to 16 child PMIC nodes
> +    type: object
> +
> +    properties:
> +      reg:
> +        items:
> +          - minItems: 1
> +            items:
> +              - minimum: 0
> +                maximum: 0xf
> +              - enum: [ 0 ]
> +                description:
> +                  0 means user ID address. 1 is reserved for group ID
> +                  address.
> +
> +    required:
> +      - reg

All this should be covered by spmi.yaml

> +
> +required:
> +  - compatible
> +  - reg-names
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - qcom,ee
> +  - qcom,channel
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spmi@fc4cf000 {
> +          compatible = "qcom,spmi-pmic-arb";
> +          reg-names = "core", "intr", "cnfg";
> +          reg = <0xfc4cf000 0x1000>,
> +                <0xfc4cb000 0x1000>,
> +                <0xfc4ca000 0x1000>;
> +          interrupt-names = "periph_irq";
> +          interrupts = <0 190 0>;
> +          interrupt-controller;
> +          #interrupt-cells = <4>;
> +
> +          qcom,ee = <0>;
> +          qcom,channel = <0>;
> +
> +          #address-cells = <2>;
> +          #size-cells = <0>;
> +    };
> -- 
> 2.7.4
> 
> 

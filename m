Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D34FEC91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiDMByF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiDMByE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:54:04 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E73D28E21;
        Tue, 12 Apr 2022 18:51:44 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id g17-20020a9d6191000000b005e8d8583c36so243504otk.8;
        Tue, 12 Apr 2022 18:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UahXXLoHbUN/uWSsm7wZOky+dlLsgBSITuQWQ2zMJB0=;
        b=RbvW7rFnb0Pknhq2FRGDsFAOp4Z8bw9S2gR4ZyuMfUJaaF4y+tdoMYn06grL5yUEGb
         FRJScnnhtjM5/SBizzVsNEh/scGrJ3nUZ4nV3qakGupJZndI6iDACH3X+RAMN7U1rKiV
         DizDQLFbvOWbpPylQH1I8ErpWsFC5qBPk/SQLdAKAfzF/wLeIwMBdJK3Bo7HqU1fZBXe
         z9rEdf796krIkuOo6TJCqgNdCKfMcJId1T3QNPLLlU8Um1EpZ4ThyXvVoB2QVasensYS
         EQxtgOxsGuUS3CgKR7catle/1fPhgZUv3b0x1ZbjBTBQ2GkrJAiK5yxTKaBq0QVgg4EZ
         oKRw==
X-Gm-Message-State: AOAM533e/UG8C1JL2+d0BkwjOPqadLGHAjnnxTX46NpTPH4VT97UeiSO
        bS753WMCk7FADgVNPzvtiA==
X-Google-Smtp-Source: ABdhPJw1RVVGof7p+rbeor/PJIlx0j0Fab9RqC9/ogqwDg+JRpNnGN3tM2pm/LWQRd82XNA0BI7Bvg==
X-Received: by 2002:a9d:6c55:0:b0:5e9:200e:af9b with SMTP id g21-20020a9d6c55000000b005e9200eaf9bmr619549otq.351.1649814703406;
        Tue, 12 Apr 2022 18:51:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f44-20020a056871072c00b000e2b638a925sm4113661oap.49.2022.04.12.18.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 18:51:43 -0700 (PDT)
Received: (nullmailer pid 1411321 invoked by uid 1000);
        Wed, 13 Apr 2022 01:51:42 -0000
Date:   Tue, 12 Apr 2022 20:51:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V9 2/6] dt-bindings: mfd: pm8008: Add pm8008 regulator
 bindings
Message-ID: <YlYsrlAQv/zmipqt@robh.at.kernel.org>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-3-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649166633-25872-3-git-send-email-quic_c_skakit@quicinc.com>
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

On Tue, Apr 05, 2022 at 07:20:29PM +0530, Satya Priya wrote:
> Add bindings for pm8008 regulators device.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> Changes in V8:
>  - This is split from pm8008.yaml binding.
> 
> Changes in V9:
>  - Remove description for reg and drop unused phandle from example.
> 
>  .../bindings/mfd/qcom,pm8008-regulators.yaml       | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml
> new file mode 100644
> index 0000000..9a82a8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/qcom,pm8008-regulators.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. PM8008 Regulator bindings
> +
> +maintainers:
> +  - Satya Priya <quic_c_skakit@quicinc.com>
> +
> +description: |
> +  Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
> +  containing 7 LDO regulators. This binding specifies the PM8008
> +  regulator peripherals of PM8008 device.
> +
> +properties:
> +  compatible:
> +    const: qcom,pm8008-regulators
> +
> +  reg:
> +    maxItems: 1
> +

> +  "#address-cells":
> +    const: 0
> +
> +  "#size-cells":
> +    const: 0

Not needed, you don't have child nodes with 'reg'.

> +
> +  vdd_l1_l2-supply:
> +    description: Input supply phandle of ldo1 and ldo2 regulators.
> +
> +  vdd_l3_l4-supply:
> +    description: Input supply phandle of ldo3 and ldo4 regulators.
> +
> +  vdd_l5-supply:
> +    description: Input supply phandle of ldo5 regulator.
> +
> +  vdd_l6-supply:
> +    description: Input supply phandle of ldo6 regulator.
> +
> +  vdd_l7-supply:
> +    description: Input supply phandle of ldo7 regulator.
> +
> +patternProperties:
> +  "^ldo[1-7]$":
> +    type: object
> +    $ref: "../regulator/regulator.yaml#"

/schemas/regulator/...

> +    description: PM8008 regulator peripherals of PM8008 regulator device
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/mfd/qcom-pm8008.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pmic@9 {
> +        compatible = "qcom,pm8008-regulators";
> +        reg = <0x9>;
> +        #address-cells = <0>;
> +        #size-cells = <0>;
> +
> +        vdd_l1_l2-supply = <&vreg_s8b_1p2>;
> +        vdd_l3_l4-supply = <&vreg_s1b_1p8>;
> +        vdd_l5-supply = <&vreg_bob>;
> +        vdd_l6-supply = <&vreg_bob>;
> +        vdd_l7-supply = <&vreg_bob>;
> +
> +        pm8008_l1: ldo1 {
> +          regulator-name = "pm8008_l1";
> +          regulator-min-microvolt = <950000>;
> +          regulator-max-microvolt = <1300000>;
> +        };
> +      };
> +    };
> +...
> -- 
> 2.7.4
> 
> 

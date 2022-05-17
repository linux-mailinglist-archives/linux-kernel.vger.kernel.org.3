Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB95E52A52E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349187AbiEQOrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345654AbiEQOrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:47:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCEE2C643
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:47:43 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu29so31850378lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1ADxgiQLsadtlyBXATdenPql6kXUNh01JZHYbHtbt2s=;
        b=GwXLfClwt0cS9C6tPKOSNUhmAvTW7Fpc0cBtu2jd68ISufWBPfXfWtM2LnhA2EHzv9
         EVrU6QMWGs6Ouv3fDwufRVXaHMdA1vUDya9cqzIU4RdaPmLQtgFVLUtNvLQZJxXG0fIY
         EyqGx4JCY9IuNvC3LKKmJejHwhAU2pN8g6DdEVyLteo1Q9B8emWspxGUF/PEETR64TIR
         zu4l3ooJ4aOxDclP7kmfy/bVenz8Jtron//flLJMJZwFc34/6LS1zgJPTajwzOLsbqwM
         bcV1w8+Hd5V05DmU1yqBiBv9gTOsPx50YNDKu+ev4k6+l9QWoisevfCbJ+eVN02qxcKR
         hb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1ADxgiQLsadtlyBXATdenPql6kXUNh01JZHYbHtbt2s=;
        b=3+0U72nECzo3YO7f4VumyPuWnivRE7smyf+MXHb/hcGfRXbrQZymNQV5J5RwZmr6xT
         RvwKWYPCPeydTR0CmiXJl0B/7j/ri/cm1HSXChggOMgczwjr3cd3CEn5wVcRzKFeUWQx
         gwgjVZeShvrij0yOBA1rgWfq0W44iAPy6nv3vbc0h3S1ouS+E/zI2/y31sEBbpWdi8aT
         FyHzls/K2W5y+TQ2J3h/vhB/W/zd5BosFpAV9Bxi/B6wwnpC2WFD945QTYsMJWLL1Xkd
         X1rSUpzVj4L8nnUVe+4JE64mAgp7qf4+AHlLz8uwnTQwkfW/DnnE59RheHOXPDSEZ7Jx
         Z2CQ==
X-Gm-Message-State: AOAM530OhMCLgaVejEtfnao9c1vmt7mj2P1UrezPzKStmnpRC1Rg3f7j
        LRA2CnyN0Q+2kmpgLcYaQNgqag==
X-Google-Smtp-Source: ABdhPJz++Dw3u6FLC7L1iEHAkj0Zht1u9ltgRXEIYjoRNOdtnR6Zdy6f4erggd+4giiSUtk7Ke/sNw==
X-Received: by 2002:a05:6512:23a6:b0:477:943a:818d with SMTP id c38-20020a05651223a600b00477943a818dmr6826584lfv.644.1652798861331;
        Tue, 17 May 2022 07:47:41 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a19ee0a000000b0047255d211f9sm1599540lfb.296.2022.05.17.07.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:47:40 -0700 (PDT)
Message-ID: <12093e84-49b0-d36d-cfde-08ab8af3801c@linaro.org>
Date:   Tue, 17 May 2022 16:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/6] dt-bindings: regulator: qcom,spmi-regulator:
 Convert to dtschema
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220517120000.71048-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517120000.71048-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 13:59, Robert Marko wrote:
> Convert the bindings of Qualcomm SPMI regulators to DT schema.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> I am aware that syscon alone is not really acceptable, its converted
> directly from the old text bindings.
> 
> There is also the issue of some MSM8994, MSM8996 and APQ8096 devices using
> '#address-cells', '#size-cells', some even defining reg property for
> regulators.
> 
> Any advice on how to solve these issues is appreciated.
> 
> Changes in v2:

Changelog goes after ---




> * Remove the forgotten text bindings
> * Move allOf after patternProperties
> * Use my private email as the maintainer email
> ---
>  .../regulator/qcom,spmi-regulator.txt         | 347 ------------------
>  .../regulator/qcom,spmi-regulator.yaml        | 176 +++++++++
>  2 files changed, 176 insertions(+), 347 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> deleted file mode 100644
> index c2a39b121b1b..000000000000
> --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> +++ /dev/null
> @@ -1,347 +0,0 @@
> -Qualcomm SPMI Regulators
> -
> -- compatible:
> -	Usage: required
> -	Value type: <string>
> -	Definition: must be one of:
> -			"qcom,pm8004-regulators"
> -			"qcom,pm8005-regulators"
> -			"qcom,pm8226-regulators"
> -			"qcom,pm8841-regulators"
> -			"qcom,pm8916-regulators"
> -			"qcom,pm8941-regulators"
> -			"qcom,pm8950-regulators"
> -			"qcom,pm8994-regulators"
> -			"qcom,pmi8994-regulators"
> -			"qcom,pm660-regulators"
> -			"qcom,pm660l-regulators"
> -			"qcom,pms405-regulators"
> -
> -- interrupts:
> -	Usage: optional
> -	Value type: <prop-encoded-array>
> -	Definition: List of OCP interrupts.
> -
> -- interrupt-names:
> -	Usage: required if 'interrupts' property present
> -	Value type: <string-array>
> -	Definition: List of strings defining the names of the
> -		    interrupts in the 'interrupts' property 1-to-1.
> -		    Supported values are "ocp-<regulator_name>", where
> -		    <regulator_name> corresponds to a voltage switch
> -		    type regulator.
> -
> -- vdd_s1-supply:
> -- vdd_s2-supply:
> -- vdd_s3-supply:
> -- vdd_s4-supply:
> -- vdd_s5-supply:
> -- vdd_s6-supply:
> -- vdd_s7-supply:
> -- vdd_s8-supply:
> -	Usage: optional (pm8841 only)
> -	Value type: <phandle>
> -	Definition: Reference to regulator supplying the input pin, as
> -		    described in the data sheet.
> -
> -- vdd_s1-supply:
> -- vdd_s2-supply:
> -- vdd_s3-supply:
> -- vdd_s4-supply:
> -- vdd_l1_l3-supply:
> -- vdd_l2-supply:
> -- vdd_l4_l5_l6-supply:
> -- vdd_l7-supply:
> -- vdd_l8_l11_l14_l15_l16-supply:
> -- vdd_l9_l10_l12_l13_l17_l18-supply:
> -	Usage: optional (pm8916 only)
> -	Value type: <phandle>
> -	Definition: Reference to regulator supplying the input pin, as
> -		    described in the data sheet.
> -
> -- vdd_s1-supply:
> -- vdd_s2-supply:
> -- vdd_s3-supply:
> -- vdd_l1_l3-supply:
> -- vdd_l2_lvs_1_2_3-supply:
> -- vdd_l4_l11-supply:
> -- vdd_l5_l7-supply:
> -- vdd_l6_l12_l14_l15-supply:
> -- vdd_l8_l16_l18_19-supply:
> -- vdd_l9_l10_l17_l22-supply:
> -- vdd_l13_l20_l23_l24-supply:
> -- vdd_l21-supply:
> -- vin_5vs-supply:
> -	Usage: optional (pm8941 only)
> -	Value type: <phandle>
> -	Definition: Reference to regulator supplying the input pin, as
> -		    described in the data sheet.
> -
> -- vdd_s1-supply:
> -- vdd_s2-supply:
> -- vdd_s3-supply:
> -- vdd_s4-supply:
> -- vdd_s4-supply:
> -- vdd_s5-supply:
> -- vdd_s6-supply:
> -- vdd_l1_l19-supply:
> -- vdd_l2_l23-supply:
> -- vdd_l3-supply:
> -- vdd_l4_l5_l6_l7_l16-supply:
> -- vdd_l8_l11_l12_l17_l22-supply:
> -- vdd_l9_l10_l13_l14_l15_l18-supply:
> -- vdd_l20-supply:
> -- vdd_l21-supply:
> -	Usage: optional (pm8950 only)
> -	Value type: <phandle>
> -	Definition: reference to regulator supplying the input pin, as
> -		    described in the data sheet
> -
> -- vdd_s1-supply:
> -- vdd_s2-supply:
> -- vdd_s3-supply:
> -- vdd_s4-supply:
> -- vdd_s5-supply:
> -- vdd_s6-supply:
> -- vdd_s7-supply:
> -- vdd_s8-supply:
> -- vdd_s9-supply:
> -- vdd_s10-supply:
> -- vdd_s11-supply:
> -- vdd_s12-supply:
> -- vdd_l1-supply:
> -- vdd_l2_l26_l28-supply:
> -- vdd_l3_l11-supply:
> -- vdd_l4_l27_l31-supply:
> -- vdd_l5_l7-supply:
> -- vdd_l6_l12_l32-supply:
> -- vdd_l8_l16_l30-supply:
> -- vdd_l9_l10_l18_l22-supply:
> -- vdd_l13_l19_l23_l24-supply:
> -- vdd_l14_l15-supply:
> -- vdd_l17_l29-supply:
> -- vdd_l20_l21-supply:
> -- vdd_l25-supply:
> -- vdd_lvs_1_2-supply:
> -	Usage: optional (pm8994 only)
> -	Value type: <phandle>
> -	Definition: Reference to regulator supplying the input pin, as
> -		    described in the data sheet.
> -
> -- vdd_s1-supply:
> -- vdd_s2-supply:
> -- vdd_s3-supply:
> -- vdd_l1-supply:
> -	Usage: optional (pmi8994 only)
> -	Value type: <phandle>
> -	Definition: Reference to regulator supplying the input pin, as
> -		    described in the data sheet.
> -
> -- vdd_l1_l6_l7-supply:
> -- vdd_l2_l3-supply:
> -- vdd_l5-supply:
> -- vdd_l8_l9_l10_l11_l12_l13_l14-supply:
> -- vdd_l15_l16_l17_l18_l19-supply:
> -- vdd_s1-supply:
> -- vdd_s2-supply:
> -- vdd_s3-supply:
> -- vdd_s5-supply:
> -- vdd_s6-supply:
> -	Usage: optional (pm660 only)
> -	Value type: <phandle>
> -	Definition: Reference to regulator supplying the input pin, as
> -		    described in the data sheet.
> -
> -- vdd_l1_l9_l10-supply:
> -- vdd_l2-supply:
> -- vdd_l3_l5_l7_l8-supply:
> -- vdd_l4_l6-supply:
> -- vdd_s1-supply:
> -- vdd_s2-supply:
> -- vdd_s3-supply:
> -- vdd_s4-supply:
> -- vdd_s5-supply:
> -	Usage: optional (pm660l only)
> -	Value type: <phandle>
> -	Definition: Reference to regulator supplying the input pin, as
> -		    described in the data sheet.
> -
> -- vdd_l1_l2-supply:
> -- vdd_l3_l8-supply:
> -- vdd_l4-supply:
> -- vdd_l5_l6-supply:
> -- vdd_l10_l11_l12_l13-supply:
> -- vdd_l7-supply:
> -- vdd_l9-supply:
> -- vdd_s1-supply:
> -- vdd_s2-supply:
> -- vdd_s3-supply:
> -- vdd_s4-supply:
> -- vdd_s5-supply
> -	Usage: optional (pms405 only)
> -	Value type: <phandle>
> -	Definition: Reference to regulator supplying the input pin, as
> -		    described in the data sheet.
> -
> -- qcom,saw-reg:
> -	Usage: optional
> -	Value type: <phandle>
> -	Description: Reference to syscon node defining the SAW registers.
> -
> -
> -The regulator node houses sub-nodes for each regulator within the device. Each
> -sub-node is identified using the node's name, with valid values listed for each
> -of the PMICs below.
> -
> -pm8004:
> -	s2, s5
> -
> -pm8005:
> -	s1, s2, s3, s4
> -
> -pm8841:
> -	s1, s2, s3, s4, s5, s6, s7, s8
> -
> -pm8916:
> -	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
> -	l14, l15, l16, l17, l18
> -
> -pm8941:
> -	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
> -	l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, lvs1, lvs2, lvs3,
> -	5vs1, 5vs2
> -
> -pm8994:
> -	s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3, l4, l5,
> -	l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20,
> -	l21, l22, l23, l24, l25, l26, l27, l28, l29, l30, l31, l32, lvs1, lvs2
> -
> -pmi8994:
> -	s1, s2, s3, l1
> -
> -The content of each sub-node is defined by the standard binding for regulators -
> -see regulator.txt - with additional custom properties described below:
> -
> -- regulator-initial-mode:
> -	Usage: optional
> -	Value type: <u32>
> -	Description: 2 = Set initial mode to auto mode (automatically select
> -		    between HPM and LPM); not available on boost type
> -		    regulators.
> -
> -		    1 = Set initial mode to high power mode (HPM), also referred
> -		    to as NPM. HPM consumes more ground current than LPM, but
> -		    it can source significantly higher load current. HPM is not
> -		    available on boost type regulators. For voltage switch type
> -		    regulators, HPM implies that over current protection and
> -		    soft start are active all the time.
> -
> -		    0 = Set initial mode to low power mode (LPM).
> -
> -- qcom,ocp-max-retries:
> -	Usage: optional
> -	Value type: <u32>
> -	Description: Maximum number of times to try toggling a voltage switch
> -		     off and back on as a result of consecutive over current
> -		     events.
> -
> -- qcom,ocp-retry-delay:
> -	Usage: optional
> -	Value type: <u32>
> -	Description: Time to delay in milliseconds between each voltage switch
> -		     toggle after an over current event takes place.
> -
> -- qcom,pin-ctrl-enable:
> -	Usage: optional
> -	Value type: <u32>
> -	Description: Bit mask specifying which hardware pins should be used to
> -		     enable the regulator, if any; supported bits are:
> -			0 = ignore all hardware enable signals
> -			BIT(0) = follow HW0_EN signal
> -			BIT(1) = follow HW1_EN signal
> -			BIT(2) = follow HW2_EN signal
> -			BIT(3) = follow HW3_EN signal
> -
> -- qcom,pin-ctrl-hpm:
> -	Usage: optional
> -	Value type: <u32>
> -	Description: Bit mask specifying which hardware pins should be used to
> -		     force the regulator into high power mode, if any;
> -		     supported bits are:
> -			0 = ignore all hardware enable signals
> -			BIT(0) = follow HW0_EN signal
> -			BIT(1) = follow HW1_EN signal
> -			BIT(2) = follow HW2_EN signal
> -			BIT(3) = follow HW3_EN signal
> -			BIT(4) = follow PMIC awake state
> -
> -- qcom,vs-soft-start-strength:
> -	Usage: optional
> -	Value type: <u32>
> -	Description: This property sets the soft start strength for voltage
> -		     switch type regulators; supported values are:
> -			0 = 0.05 uA
> -			1 = 0.25 uA
> -			2 = 0.55 uA
> -			3 = 0.75 uA
> -
> -- qcom,saw-slave:
> -	Usage: optional
> -	Value type: <boo>
> -	Description: SAW controlled gang slave. Will not be configured.
> -
> -- qcom,saw-leader:
> -	Usage: optional
> -	Value type: <boo>
> -	Description: SAW controlled gang leader. Will be configured as
> -		     SAW regulator.
> -
> -Example:
> -
> -	regulators {
> -		compatible = "qcom,pm8941-regulators";
> -		vdd_l1_l3-supply = <&s1>;
> -
> -		s1: s1 {
> -			regulator-min-microvolt = <1300000>;
> -			regulator-max-microvolt = <1400000>;
> -		};
> -
> -		...
> -
> -		l1: l1 {
> -			regulator-min-microvolt = <1225000>;
> -			regulator-max-microvolt = <1300000>;
> -		};
> -
> -		....
> -	};
> -
> -Example 2:
> -
> -	saw3: syscon@9A10000 {
> -		compatible = "syscon";
> -		reg = <0x9A10000 0x1000>;
> -	};
> -
> -	...
> -
> -	spm-regulators {
> -		compatible = "qcom,pm8994-regulators";
> -		qcom,saw-reg = <&saw3>;
> -		s8 {
> -			qcom,saw-slave;
> -		};
> -		s9 {
> -			qcom,saw-slave;
> -		};
> -		s10 {
> -			qcom,saw-slave;
> -		};
> -		pm8994_s11_saw: s11 {
> -			qcom,saw-leader;
> -			regulator-always-on;
> -			regulator-min-microvolt = <900000>;
> -			regulator-max-microvolt = <1140000>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> new file mode 100644
> index 000000000000..5c747c832529
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> @@ -0,0 +1,176 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/qcom,spmi-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SPMI Regulators
> +
> +maintainers:
> +  - Robert Marko <robimarko@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm660-regulators
> +      - qcom,pm660l-regulators
> +      - qcom,pm8004-regulators
> +      - qcom,pm8005-regulators
> +      - qcom,pm8226-regulators
> +      - qcom,pm8841-regulators
> +      - qcom,pm8916-regulators
> +      - qcom,pm8941-regulators
> +      - qcom,pm8950-regulators
> +      - qcom,pm8994-regulators
> +      - qcom,pmi8994-regulators
> +      - qcom,pms405-regulators
> +

You miss here interrupts+names.

> +  qcom,saw-reg:
> +    description: Reference to syscon node defining the SAW registers
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

No quotes around this.

> +
> +patternProperties:
> +  ".*-supply$":

We should not allow any supply, but rather a strictly defined pattern.

What I actually prefer is to see something like this:
https://lore.kernel.org/all/20220426105501.73200-3-krzysztof.kozlowski@linaro.org/
but that's not a requirement. Some specific pattern is enough.

> +    description: Input supply phandle(s) for this node
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +  "^((s|l|lvs|5vs)[0-9]*)$":

s1111 should not be a valid regulator. :)
Neither s000000.



Best regards,
Krzysztof

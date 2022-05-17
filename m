Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E92752AD28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352927AbiEQU6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbiEQU6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:58:32 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35005532C6;
        Tue, 17 May 2022 13:58:30 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id v14so301543qtc.3;
        Tue, 17 May 2022 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6M8MD85L5UIxWhXOozbt3pALkeE+11GMex5LaHsMzps=;
        b=JOZ7L4lLhs0MnpSSws4GQ0TBhJsK/7TgIzQOUkSD5G/qiZNRG+VqetQ4xZVJy73YAG
         hL17y8MtzvPmT+mTozmQkRdlB1E+Yei8u/p+0zSFW1DBBqqJjDDUdHnImhrUElieBPZq
         AtD+Ff6MLMnXPLeDJLEriG9LiFiCma+gBWDQrRyE4LSngO37RCvQV61VXKht2VBMAJB6
         V1zRjSVE4NjN6siYNLnnKFcP0Lhk47wYxa+t6GvkKZMtFlr4BJ/O7lihKbqCqFKh5QBJ
         OFG3tpt+MA6d8f3fU4gu7HiUacDtWD2gO5jGV2nsZq3ub3K7/NhFwvl6x8UvC3v2rXfk
         JF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6M8MD85L5UIxWhXOozbt3pALkeE+11GMex5LaHsMzps=;
        b=asq34ED91yF7kBS8klPJaLGKCkQ67bgb6xGuOza77J+TFzk0D/MAONku66kUNcWNoi
         GK5F3lo2l+ElzOF3pLDcwR3roOLMuleITAAF8wxgeoc+mhfibdDgTLzOf5dQj6T+R8ib
         4GnIOJLhP4L1QAK4bCct+bcRhW41aM7jnAYOYAYA9a7KxT8V8weJVpeHHRb1jCkO98R8
         v6Zx+/rAKhR0TJyQsdcSmBGe2ST3H+KMq0cTptUJgANWcgBP1PoMnBbIiRs68z8xu5ai
         T8i4bUItNzUmOEv0VxB7ubSGuFu5/XEy3eO2l/MbQ4GQam401GM5RelG3xzLkpWvDBpy
         AT6A==
X-Gm-Message-State: AOAM533hPh1wDknzScJOQR+gF6YGrOspvC2EfZbKgWiLsprXY/AVmpUk
        x9sZSJuSp1sJmlZEPw/H61F4iKRYrz8Jb+Bxr34=
X-Google-Smtp-Source: ABdhPJxkYpXzeoMb1N+v8d0dEfS4YsQTMINKntlr7/azToPi+F/6JC436DAqcd0gVtiATyfDFLckxn/MNA6ZwyUavOE=
X-Received: by 2002:ac8:5dcb:0:b0:2f3:e079:8d66 with SMTP id
 e11-20020ac85dcb000000b002f3e0798d66mr20908222qtx.318.1652821109192; Tue, 17
 May 2022 13:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220517120000.71048-1-robimarko@gmail.com> <12093e84-49b0-d36d-cfde-08ab8af3801c@linaro.org>
In-Reply-To: <12093e84-49b0-d36d-cfde-08ab8af3801c@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 17 May 2022 22:58:18 +0200
Message-ID: <CAOX2RU4PpTQJUNkDremkhfdPG-=1NbG5xLmu22zFSOrqKMce5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: regulator: qcom,spmi-regulator:
 Convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 at 16:47, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/05/2022 13:59, Robert Marko wrote:
> > Convert the bindings of Qualcomm SPMI regulators to DT schema.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > I am aware that syscon alone is not really acceptable, its converted
> > directly from the old text bindings.
> >
> > There is also the issue of some MSM8994, MSM8996 and APQ8096 devices using
> > '#address-cells', '#size-cells', some even defining reg property for
> > regulators.
> >
> > Any advice on how to solve these issues is appreciated.
> >
> > Changes in v2:
>
> Changelog goes after ---

Ok, will fix up in v3.

While we are here,
any ideas about the DTS-s that use reg and #address/size-cells for
regulator subnodes and syscon?

>
>
>
>
> > * Remove the forgotten text bindings
> > * Move allOf after patternProperties
> > * Use my private email as the maintainer email
> > ---
> >  .../regulator/qcom,spmi-regulator.txt         | 347 ------------------
> >  .../regulator/qcom,spmi-regulator.yaml        | 176 +++++++++
> >  2 files changed, 176 insertions(+), 347 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> >  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > deleted file mode 100644
> > index c2a39b121b1b..000000000000
> > --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > +++ /dev/null
> > @@ -1,347 +0,0 @@
> > -Qualcomm SPMI Regulators
> > -
> > -- compatible:
> > -     Usage: required
> > -     Value type: <string>
> > -     Definition: must be one of:
> > -                     "qcom,pm8004-regulators"
> > -                     "qcom,pm8005-regulators"
> > -                     "qcom,pm8226-regulators"
> > -                     "qcom,pm8841-regulators"
> > -                     "qcom,pm8916-regulators"
> > -                     "qcom,pm8941-regulators"
> > -                     "qcom,pm8950-regulators"
> > -                     "qcom,pm8994-regulators"
> > -                     "qcom,pmi8994-regulators"
> > -                     "qcom,pm660-regulators"
> > -                     "qcom,pm660l-regulators"
> > -                     "qcom,pms405-regulators"
> > -
> > -- interrupts:
> > -     Usage: optional
> > -     Value type: <prop-encoded-array>
> > -     Definition: List of OCP interrupts.
> > -
> > -- interrupt-names:
> > -     Usage: required if 'interrupts' property present
> > -     Value type: <string-array>
> > -     Definition: List of strings defining the names of the
> > -                 interrupts in the 'interrupts' property 1-to-1.
> > -                 Supported values are "ocp-<regulator_name>", where
> > -                 <regulator_name> corresponds to a voltage switch
> > -                 type regulator.
> > -
> > -- vdd_s1-supply:
> > -- vdd_s2-supply:
> > -- vdd_s3-supply:
> > -- vdd_s4-supply:
> > -- vdd_s5-supply:
> > -- vdd_s6-supply:
> > -- vdd_s7-supply:
> > -- vdd_s8-supply:
> > -     Usage: optional (pm8841 only)
> > -     Value type: <phandle>
> > -     Definition: Reference to regulator supplying the input pin, as
> > -                 described in the data sheet.
> > -
> > -- vdd_s1-supply:
> > -- vdd_s2-supply:
> > -- vdd_s3-supply:
> > -- vdd_s4-supply:
> > -- vdd_l1_l3-supply:
> > -- vdd_l2-supply:
> > -- vdd_l4_l5_l6-supply:
> > -- vdd_l7-supply:
> > -- vdd_l8_l11_l14_l15_l16-supply:
> > -- vdd_l9_l10_l12_l13_l17_l18-supply:
> > -     Usage: optional (pm8916 only)
> > -     Value type: <phandle>
> > -     Definition: Reference to regulator supplying the input pin, as
> > -                 described in the data sheet.
> > -
> > -- vdd_s1-supply:
> > -- vdd_s2-supply:
> > -- vdd_s3-supply:
> > -- vdd_l1_l3-supply:
> > -- vdd_l2_lvs_1_2_3-supply:
> > -- vdd_l4_l11-supply:
> > -- vdd_l5_l7-supply:
> > -- vdd_l6_l12_l14_l15-supply:
> > -- vdd_l8_l16_l18_19-supply:
> > -- vdd_l9_l10_l17_l22-supply:
> > -- vdd_l13_l20_l23_l24-supply:
> > -- vdd_l21-supply:
> > -- vin_5vs-supply:
> > -     Usage: optional (pm8941 only)
> > -     Value type: <phandle>
> > -     Definition: Reference to regulator supplying the input pin, as
> > -                 described in the data sheet.
> > -
> > -- vdd_s1-supply:
> > -- vdd_s2-supply:
> > -- vdd_s3-supply:
> > -- vdd_s4-supply:
> > -- vdd_s4-supply:
> > -- vdd_s5-supply:
> > -- vdd_s6-supply:
> > -- vdd_l1_l19-supply:
> > -- vdd_l2_l23-supply:
> > -- vdd_l3-supply:
> > -- vdd_l4_l5_l6_l7_l16-supply:
> > -- vdd_l8_l11_l12_l17_l22-supply:
> > -- vdd_l9_l10_l13_l14_l15_l18-supply:
> > -- vdd_l20-supply:
> > -- vdd_l21-supply:
> > -     Usage: optional (pm8950 only)
> > -     Value type: <phandle>
> > -     Definition: reference to regulator supplying the input pin, as
> > -                 described in the data sheet
> > -
> > -- vdd_s1-supply:
> > -- vdd_s2-supply:
> > -- vdd_s3-supply:
> > -- vdd_s4-supply:
> > -- vdd_s5-supply:
> > -- vdd_s6-supply:
> > -- vdd_s7-supply:
> > -- vdd_s8-supply:
> > -- vdd_s9-supply:
> > -- vdd_s10-supply:
> > -- vdd_s11-supply:
> > -- vdd_s12-supply:
> > -- vdd_l1-supply:
> > -- vdd_l2_l26_l28-supply:
> > -- vdd_l3_l11-supply:
> > -- vdd_l4_l27_l31-supply:
> > -- vdd_l5_l7-supply:
> > -- vdd_l6_l12_l32-supply:
> > -- vdd_l8_l16_l30-supply:
> > -- vdd_l9_l10_l18_l22-supply:
> > -- vdd_l13_l19_l23_l24-supply:
> > -- vdd_l14_l15-supply:
> > -- vdd_l17_l29-supply:
> > -- vdd_l20_l21-supply:
> > -- vdd_l25-supply:
> > -- vdd_lvs_1_2-supply:
> > -     Usage: optional (pm8994 only)
> > -     Value type: <phandle>
> > -     Definition: Reference to regulator supplying the input pin, as
> > -                 described in the data sheet.
> > -
> > -- vdd_s1-supply:
> > -- vdd_s2-supply:
> > -- vdd_s3-supply:
> > -- vdd_l1-supply:
> > -     Usage: optional (pmi8994 only)
> > -     Value type: <phandle>
> > -     Definition: Reference to regulator supplying the input pin, as
> > -                 described in the data sheet.
> > -
> > -- vdd_l1_l6_l7-supply:
> > -- vdd_l2_l3-supply:
> > -- vdd_l5-supply:
> > -- vdd_l8_l9_l10_l11_l12_l13_l14-supply:
> > -- vdd_l15_l16_l17_l18_l19-supply:
> > -- vdd_s1-supply:
> > -- vdd_s2-supply:
> > -- vdd_s3-supply:
> > -- vdd_s5-supply:
> > -- vdd_s6-supply:
> > -     Usage: optional (pm660 only)
> > -     Value type: <phandle>
> > -     Definition: Reference to regulator supplying the input pin, as
> > -                 described in the data sheet.
> > -
> > -- vdd_l1_l9_l10-supply:
> > -- vdd_l2-supply:
> > -- vdd_l3_l5_l7_l8-supply:
> > -- vdd_l4_l6-supply:
> > -- vdd_s1-supply:
> > -- vdd_s2-supply:
> > -- vdd_s3-supply:
> > -- vdd_s4-supply:
> > -- vdd_s5-supply:
> > -     Usage: optional (pm660l only)
> > -     Value type: <phandle>
> > -     Definition: Reference to regulator supplying the input pin, as
> > -                 described in the data sheet.
> > -
> > -- vdd_l1_l2-supply:
> > -- vdd_l3_l8-supply:
> > -- vdd_l4-supply:
> > -- vdd_l5_l6-supply:
> > -- vdd_l10_l11_l12_l13-supply:
> > -- vdd_l7-supply:
> > -- vdd_l9-supply:
> > -- vdd_s1-supply:
> > -- vdd_s2-supply:
> > -- vdd_s3-supply:
> > -- vdd_s4-supply:
> > -- vdd_s5-supply
> > -     Usage: optional (pms405 only)
> > -     Value type: <phandle>
> > -     Definition: Reference to regulator supplying the input pin, as
> > -                 described in the data sheet.
> > -
> > -- qcom,saw-reg:
> > -     Usage: optional
> > -     Value type: <phandle>
> > -     Description: Reference to syscon node defining the SAW registers.
> > -
> > -
> > -The regulator node houses sub-nodes for each regulator within the device. Each
> > -sub-node is identified using the node's name, with valid values listed for each
> > -of the PMICs below.
> > -
> > -pm8004:
> > -     s2, s5
> > -
> > -pm8005:
> > -     s1, s2, s3, s4
> > -
> > -pm8841:
> > -     s1, s2, s3, s4, s5, s6, s7, s8
> > -
> > -pm8916:
> > -     s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
> > -     l14, l15, l16, l17, l18
> > -
> > -pm8941:
> > -     s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
> > -     l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, lvs1, lvs2, lvs3,
> > -     5vs1, 5vs2
> > -
> > -pm8994:
> > -     s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3, l4, l5,
> > -     l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20,
> > -     l21, l22, l23, l24, l25, l26, l27, l28, l29, l30, l31, l32, lvs1, lvs2
> > -
> > -pmi8994:
> > -     s1, s2, s3, l1
> > -
> > -The content of each sub-node is defined by the standard binding for regulators -
> > -see regulator.txt - with additional custom properties described below:
> > -
> > -- regulator-initial-mode:
> > -     Usage: optional
> > -     Value type: <u32>
> > -     Description: 2 = Set initial mode to auto mode (automatically select
> > -                 between HPM and LPM); not available on boost type
> > -                 regulators.
> > -
> > -                 1 = Set initial mode to high power mode (HPM), also referred
> > -                 to as NPM. HPM consumes more ground current than LPM, but
> > -                 it can source significantly higher load current. HPM is not
> > -                 available on boost type regulators. For voltage switch type
> > -                 regulators, HPM implies that over current protection and
> > -                 soft start are active all the time.
> > -
> > -                 0 = Set initial mode to low power mode (LPM).
> > -
> > -- qcom,ocp-max-retries:
> > -     Usage: optional
> > -     Value type: <u32>
> > -     Description: Maximum number of times to try toggling a voltage switch
> > -                  off and back on as a result of consecutive over current
> > -                  events.
> > -
> > -- qcom,ocp-retry-delay:
> > -     Usage: optional
> > -     Value type: <u32>
> > -     Description: Time to delay in milliseconds between each voltage switch
> > -                  toggle after an over current event takes place.
> > -
> > -- qcom,pin-ctrl-enable:
> > -     Usage: optional
> > -     Value type: <u32>
> > -     Description: Bit mask specifying which hardware pins should be used to
> > -                  enable the regulator, if any; supported bits are:
> > -                     0 = ignore all hardware enable signals
> > -                     BIT(0) = follow HW0_EN signal
> > -                     BIT(1) = follow HW1_EN signal
> > -                     BIT(2) = follow HW2_EN signal
> > -                     BIT(3) = follow HW3_EN signal
> > -
> > -- qcom,pin-ctrl-hpm:
> > -     Usage: optional
> > -     Value type: <u32>
> > -     Description: Bit mask specifying which hardware pins should be used to
> > -                  force the regulator into high power mode, if any;
> > -                  supported bits are:
> > -                     0 = ignore all hardware enable signals
> > -                     BIT(0) = follow HW0_EN signal
> > -                     BIT(1) = follow HW1_EN signal
> > -                     BIT(2) = follow HW2_EN signal
> > -                     BIT(3) = follow HW3_EN signal
> > -                     BIT(4) = follow PMIC awake state
> > -
> > -- qcom,vs-soft-start-strength:
> > -     Usage: optional
> > -     Value type: <u32>
> > -     Description: This property sets the soft start strength for voltage
> > -                  switch type regulators; supported values are:
> > -                     0 = 0.05 uA
> > -                     1 = 0.25 uA
> > -                     2 = 0.55 uA
> > -                     3 = 0.75 uA
> > -
> > -- qcom,saw-slave:
> > -     Usage: optional
> > -     Value type: <boo>
> > -     Description: SAW controlled gang slave. Will not be configured.
> > -
> > -- qcom,saw-leader:
> > -     Usage: optional
> > -     Value type: <boo>
> > -     Description: SAW controlled gang leader. Will be configured as
> > -                  SAW regulator.
> > -
> > -Example:
> > -
> > -     regulators {
> > -             compatible = "qcom,pm8941-regulators";
> > -             vdd_l1_l3-supply = <&s1>;
> > -
> > -             s1: s1 {
> > -                     regulator-min-microvolt = <1300000>;
> > -                     regulator-max-microvolt = <1400000>;
> > -             };
> > -
> > -             ...
> > -
> > -             l1: l1 {
> > -                     regulator-min-microvolt = <1225000>;
> > -                     regulator-max-microvolt = <1300000>;
> > -             };
> > -
> > -             ....
> > -     };
> > -
> > -Example 2:
> > -
> > -     saw3: syscon@9A10000 {
> > -             compatible = "syscon";
> > -             reg = <0x9A10000 0x1000>;
> > -     };
> > -
> > -     ...
> > -
> > -     spm-regulators {
> > -             compatible = "qcom,pm8994-regulators";
> > -             qcom,saw-reg = <&saw3>;
> > -             s8 {
> > -                     qcom,saw-slave;
> > -             };
> > -             s9 {
> > -                     qcom,saw-slave;
> > -             };
> > -             s10 {
> > -                     qcom,saw-slave;
> > -             };
> > -             pm8994_s11_saw: s11 {
> > -                     qcom,saw-leader;
> > -                     regulator-always-on;
> > -                     regulator-min-microvolt = <900000>;
> > -                     regulator-max-microvolt = <1140000>;
> > -             };
> > -     };
> > diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> > new file mode 100644
> > index 000000000000..5c747c832529
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> > @@ -0,0 +1,176 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/qcom,spmi-regulator.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm SPMI Regulators
> > +
> > +maintainers:
> > +  - Robert Marko <robimarko@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,pm660-regulators
> > +      - qcom,pm660l-regulators
> > +      - qcom,pm8004-regulators
> > +      - qcom,pm8005-regulators
> > +      - qcom,pm8226-regulators
> > +      - qcom,pm8841-regulators
> > +      - qcom,pm8916-regulators
> > +      - qcom,pm8941-regulators
> > +      - qcom,pm8950-regulators
> > +      - qcom,pm8994-regulators
> > +      - qcom,pmi8994-regulators
> > +      - qcom,pms405-regulators
> > +
>
> You miss here interrupts+names.
>
> > +  qcom,saw-reg:
> > +    description: Reference to syscon node defining the SAW registers
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
>
> No quotes around this.

Ok, I will remove them, it's a bit confusing as most bindings use
quotes around refs.
>
> > +
> > +patternProperties:
> > +  ".*-supply$":
>
> We should not allow any supply, but rather a strictly defined pattern.
>
> What I actually prefer is to see something like this:
> https://lore.kernel.org/all/20220426105501.73200-3-krzysztof.kozlowski@linaro.org/
> but that's not a requirement. Some specific pattern is enough.

I have implemented this style of supply matching per compatible in v3 as
trying to regex does not seem to cover matching them properly.

>
> > +    description: Input supply phandle(s) for this node
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > +
> > +  "^((s|l|lvs|5vs)[0-9]*)$":
>
> s1111 should not be a valid regulator. :)
> Neither s000000.

Got it, have implemented a much stricter regex in v3.

Regards,
Robert
>
>
>
> Best regards,
> Krzysztof

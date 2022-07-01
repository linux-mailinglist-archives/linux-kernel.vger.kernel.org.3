Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0398056394E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiGASrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGASq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:46:57 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9DC344C6;
        Fri,  1 Jul 2022 11:46:53 -0700 (PDT)
Date:   Fri, 01 Jul 2022 18:46:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1656701209; x=1656960409;
        bh=Y5fzhHEQzXr1TjcKrd5HowR3mxV+jXMy30QqWAFASuc=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=P5naxX4WrHW2BtWg1QCbMy/x6OzFDeVzSApY8zpSnbpKwrb+fOwzBEuT40W5Ij7XS
         oRBUBYdS9gJbohKTt4SeUkR0D13zG6XIcjdTICgfBvObZRssTOHnjsdHOaMrndt2hL
         kyie3FqxV0w2WD6MdhN5Wh5Vm6zzngwtjJoXS4QI=
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: Add LPG to pm8916, pm8994, pmi8994 and pmi8998
Message-ID: <2e506766-39f3-b70f-b91e-ce120293d05e@connolly.tech>
In-Reply-To: <20220505022706.1692554-2-bjorn.andersson@linaro.org>
References: <20220505022706.1692554-1-bjorn.andersson@linaro.org> <20220505022706.1692554-2-bjorn.andersson@linaro.org>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2022 03:27, Bjorn Andersson wrote:
> Add PWM/LPG nodes to the PMICs currently supported by the binding.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
fwiw:
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>   arch/arm64/boot/dts/qcom/pm8916.dtsi  |  8 ++++++++
>   arch/arm64/boot/dts/qcom/pm8994.dtsi  | 10 ++++++++++
>   arch/arm64/boot/dts/qcom/pmi8994.dtsi | 10 ++++++++++
>   arch/arm64/boot/dts/qcom/pmi8998.dtsi | 11 ++++++++++-
>   4 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/q=
com/pm8916.dtsi
> index d58902432812..99bf8387bfb6 100644
> --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> @@ -125,6 +125,14 @@ pm8916_1: pmic@1 {
>   =09=09#address-cells =3D <1>;
>   =09=09#size-cells =3D <0>;
>
> +=09=09pm8916_pwm: pwm {
> +=09=09=09compatible =3D "qcom,pm8916-pwm";
> +
> +=09=09=09#pwm-cells =3D <2>;
> +
> +=09=09=09status =3D "disabled";
> +=09=09};
> +
>   =09=09pm8916_vib: vibrator@c000 {
>   =09=09=09compatible =3D "qcom,pm8916-vib";
>   =09=09=09reg =3D <0xc000>;
> diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/q=
com/pm8994.dtsi
> index 5ab46117d737..ab342397fcd8 100644
> --- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
> @@ -135,6 +135,16 @@ pmic@1 {
>   =09=09#address-cells =3D <1>;
>   =09=09#size-cells =3D <0>;
>
> +=09=09pm8994_lpg: lpg {
> +=09=09=09compatible =3D "qcom,pm8994-lpg";
> +
> +=09=09=09#address-cells =3D <1>;
> +=09=09=09#size-cells =3D <0>;
> +=09=09=09#pwm-cells =3D <2>;
> +
> +=09=09=09status =3D "disabled";
> +=09=09};
> +
>   =09=09pm8994_spmi_regulators: regulators {
>   =09=09=09compatible =3D "qcom,pm8994-regulators";
>   =09=09};
> diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/=
qcom/pmi8994.dtsi
> index 6e7c252568e6..b1b50c99ada2 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
> @@ -27,6 +27,16 @@ pmic@3 {
>   =09=09#address-cells =3D <1>;
>   =09=09#size-cells =3D <0>;
>
> +=09=09pmi8994_lpg: lpg {
> +=09=09=09compatible =3D "qcom,pmi8994-lpg";
> +
> +=09=09=09#address-cells =3D <1>;
> +=09=09=09#size-cells =3D <0>;
> +=09=09=09#pwm-cells =3D <2>;
> +
> +=09=09=09status =3D "disabled";
> +=09=09};
> +
>   =09=09pmi8994_spmi_regulators: regulators {
>   =09=09=09compatible =3D "qcom,pmi8994-regulators";
>   =09=09=09#address-cells =3D <1>;
> diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/=
qcom/pmi8998.dtsi
> index 0fef5f113f05..7af106683f8d 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> @@ -42,6 +42,16 @@ lab: lab {
>   =09=09=09};
>   =09=09};
>
> +=09=09pmi8998_lpg: lpg {
> +=09=09=09compatible =3D "qcom,pmi8998-lpg";
> +
> +=09=09=09#address-cells =3D <1>;
> +=09=09=09#size-cells =3D <0>;
> +=09=09=09#pwm-cells =3D <2>;
> +
> +=09=09=09status =3D "disabled";
> +=09=09};
> +
>   =09=09pmi8998_wled: leds@d800 {
>   =09=09=09compatible =3D "qcom,pmi8998-wled";
>   =09=09=09reg =3D <0xd800 0xd900>;
> @@ -52,6 +62,5 @@ pmi8998_wled: leds@d800 {
>
>   =09=09=09status =3D "disabled";
>   =09=09};
> -
>   =09};
>   };
> --
> 2.35.1
>

--
Kind Regards,
Caleb


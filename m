Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EEA4ECB20
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349579AbiC3R47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349546AbiC3R4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:56:55 -0400
X-Greylist: delayed 170 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 10:55:10 PDT
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54623192A2;
        Wed, 30 Mar 2022 10:55:10 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:55:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1648662908;
        bh=V2SrfTQKBm6/OaCcLYaU3wWb8ZcfGO9vBwQtfG0vV5o=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=Utwrwg1+5Qb3EeKwn0cptvsRVCdxetXfxSbISlgAngkJtIpk505c5eRLiIL4PgeuE
         UiOlAyoqdVZdsqvv3iNEiP0HyeyOVmk0gmC8TZdzswEvge+ysebF50BanqY+Y8UyHI
         LO7nNnvPJuu39C6DLPfk7e91QwJGZx+18+dfJp8E=
To:     Joel Selvaraj <jo@jsfamily.in>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable second wifi channel
Message-ID: <89237b04-0291-e7eb-49cc-910fa23a22af@connolly.tech>
In-Reply-To: <BY5PR02MB7009E2566F9000F338432761D91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
References: <20220330064505.243799-1-jo@jsfamily.in> <BY5PR02MB7009E2566F9000F338432761D91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2022 07:45, Joel Selvaraj wrote:
> Like the c630, the Poco F1 is also capable of using both antenna
> channels for 2.4 and 5ghz wifi, however unlike the c630 only the first
> channel is used for bluetooth. Similar to Oneplus 6.
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
>
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
> ---
>   arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/=
arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> index f97900e7797b..798fc72578a7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> @@ -185,6 +185,12 @@ vreg_l21a_2p95: ldo21 {
>   =09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>   =09=09};
>
> +=09=09vreg_l23a_3p3: ldo23 {
> +=09=09=09regulator-min-microvolt =3D <3300000>;
> +=09=09=09regulator-max-microvolt =3D <3312000>;
> +=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> +=09=09};
> +
>   =09=09vreg_l24a_3p075: ldo24 {
>   =09=09=09regulator-min-microvolt =3D <3088000>;
>   =09=09=09regulator-max-microvolt =3D <3088000>;
> @@ -547,6 +553,7 @@ &wifi {
>   =09vdd-1.8-xo-supply =3D <&vreg_l7a_1p8>;
>   =09vdd-1.3-rfa-supply =3D <&vreg_l17a_1p3>;
>   =09vdd-3.3-ch0-supply =3D <&vreg_l25a_3p3>;
> +=09vdd-3.3-ch1-supply =3D <&vreg_l23a_3p3>;
>   };
>
>   /* PINCTRL - additions to nodes defined in sdm845.dtsi */
> --
> 2.35.1
>

--
Kind Regards,
Caleb


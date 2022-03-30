Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B8D4ECB18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347091AbiC3RyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349466AbiC3RyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:54:09 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684A8B7EB;
        Wed, 30 Mar 2022 10:52:20 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:52:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1648662738;
        bh=n4vvBw0vQ2Jrjzs0eyHkrWrKsoCc4TdqIoM10kTGmE4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=ROxo9MjRnxzOcnkq7kh4LPl6+qfp5qkb/BhNLUxgzD979fqqlFD8B8I2xXaPeA5tR
         52CMWHFw5i7MaDw+6xk+newzfGftNbbxUP/8KG28KA6fFF82dZ12VMrDAySqCVIl/W
         ESlR2nAxnuSCaFDd47dIi0wZ8QDmrYQcaP+AaLqk=
To:     Joel Selvaraj <jo@jsfamily.in>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable qcom ipa driver
Message-ID: <fd83bd38-813b-40a0-4848-19b4467385b9@connolly.tech>
In-Reply-To: <BY5PR02MB7009405D7C06C0B480974063D91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
References: <20220330064505.243799-1-jo@jsfamily.in> <BY5PR02MB7009405D7C06C0B480974063D91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2022 07:45, Joel Selvaraj wrote:
> Enable Qualcomm IP Accelerator (IPA) driver for mobile data functionality
> which works by using ModemManager.
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
>
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
> ---
>   arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/=
arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> index 27ba9ad1ad02..801b8c5984a3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> @@ -292,6 +292,12 @@ &mss_pil {
>   =09firmware-name =3D "qcom/sdm845/beryllium/mba.mbn", "qcom/sdm845/bery=
llium/modem.mbn";
>   };
>
> +&ipa {
> +=09status =3D "okay";
> +=09memory-region =3D <&ipa_fw_mem>;
> +=09firmware-name =3D "qcom/sdm845/beryllium/ipa_fws.mbn";
> +};
> +
>   &pm8998_gpio {
>   =09vol_up_pin_a: vol-up-active {
>   =09=09pins =3D "gpio6";
> --
> 2.35.1
>

--
Kind Regards,
Caleb


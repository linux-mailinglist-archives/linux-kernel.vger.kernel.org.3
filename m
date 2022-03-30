Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC14ECB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349571AbiC3R4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349546AbiC3R4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:56:10 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBDCE29D5;
        Wed, 30 Mar 2022 10:54:24 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:54:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1648662860;
        bh=zfu4fLS+Esozp/33lopnN3OvnVhUttPxe/BUmeE6OLM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=M5BU02z1SXlE+K9yKTEgFlyOTyKwThPs118aP37zr6Cceur0KcsC5bNhdqfdh2pl9
         HsjG3NOYLo8imtFoFbvZJuhgfpo1T9EhuU2te/FbZRKEj1WKWOERj2joppl/A/yjlj
         zc8GD9EQ8+xU09YlRDwkbS5/+45YSp01PWKyKCpI=
To:     Joel Selvaraj <jo@jsfamily.in>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sdm845-xiaomi-beryllium: fix typo in panel's vddio-supply property
Message-ID: <90e1d193-8dc4-83b9-b5a8-83a5d4c836c3@connolly.tech>
In-Reply-To: <BY5PR02MB7009901651E6A8D5ACB0425ED91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
References: <20220330064505.243799-1-jo@jsfamily.in> <BY5PR02MB7009901651E6A8D5ACB0425ED91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
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



On 30/03/2022 07:45, Joel Selvaraj wrote:
> vddio is misspelled with a "0" instead of "o". Fix it.
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
>
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
> ---
>   arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/=
arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> index 801b8c5984a3..f97900e7797b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> @@ -218,7 +218,7 @@ &dsi0 {
>   =09panel@0 {
>   =09=09compatible =3D "tianma,fhd-video";
>   =09=09reg =3D <0>;
> -=09=09vddi0-supply =3D <&vreg_l14a_1p8>;
> +=09=09vddio-supply =3D <&vreg_l14a_1p8>;
>   =09=09vddpos-supply =3D <&lab>;
>   =09=09vddneg-supply =3D <&ibb>;
>
> --
> 2.35.1
>

--
Kind Regards,
Caleb


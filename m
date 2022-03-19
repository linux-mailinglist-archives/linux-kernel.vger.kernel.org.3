Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70104DEA1A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbiCSSbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiCSSbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:31:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDFE377C9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 11:29:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b24so13662477edu.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=buKp/c8UvzHPIAhRI7uXCYLONDKNZjnQ6ELqJjK7HuA=;
        b=k4nyBk88e6efJTjIm7EZ0GLZbtg/Onpo4+WFLft/j94NiAxeTzmwE1iruDGx6+mmCu
         JtsjzOM8sWpaaJwTpwuYUA/xsDqSTBMmdF7C8CS3/eKWOoAUUCZd1dKlQuyNXjg2vUfd
         GNjZXrz6e7ZxGQ9zOG75KLBqN3VfW0iOcHkUGnUot++W+3cG1nbub/zBeoC+bSuIT2is
         qhifnXLc+GXdQfGaF5B0iG4YoNynLZGIwRVXiYtZHRHH8pY/T01JyBbyS2+pIwHZEWVs
         E1tJWHzopRgkTTwym4ZYzNGyW8Q7eSf4wp4fDzHZM/cQLbXlAwDIpXp1gJxuH2TDbXMQ
         GnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=buKp/c8UvzHPIAhRI7uXCYLONDKNZjnQ6ELqJjK7HuA=;
        b=uNdLZrajV3xDMmj8oclH1b9XosRuYK5esqbWMRTqu8VYgVnGBCv6MCKVl55yw7vuzA
         wwZ7c2BpmyNY3eQjR5Bh4s7k67xrIZYoEkoMHFsuRoBsP5z3VLN0CO2KHTfNtCl0ZycE
         kvSdXpmpSiKuPiQWQx1rnekleL/iVc8ff/r+GW+exrf4v2SESyM/MXcNBv4xQfA8IEsE
         yUul92s2nE09LLfwjmVIDfr9HW+IC15xvpPu4IcLOyazTzQEBpsidEfUPm/iHx8jdleS
         gi5wxL4hzQP/TfHq9buN2E7QrpIrTXQ8lTrYHGaArOHWJ6fHDcU7ST+k4rkwFjSoisY7
         xU+A==
X-Gm-Message-State: AOAM530eHlvOvfb/s8vwe2jKJ5RlIJif1pPSqkUboniAoU8HPIoEgIbG
        GppcxfIE0wSWWsEEFIoY2fxHzA==
X-Google-Smtp-Source: ABdhPJwjUdqRL9meDgsEI/c6J8JDxqnmewgyL9kvXOXz29w8UM8JNz+OMI2GClNroTMk12KuO2svAQ==
X-Received: by 2002:a05:6402:289d:b0:419:437:ef4f with SMTP id eg29-20020a056402289d00b004190437ef4fmr11131838edb.110.1647714591776;
        Sat, 19 Mar 2022 11:29:51 -0700 (PDT)
Received: from localhost (a246182.upc-a.chello.nl. [62.163.246.182])
        by smtp.gmail.com with ESMTPSA id hg8-20020a1709072cc800b006d6e469fbf0sm5008422ejc.134.2022.03.19.11.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 11:29:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 19 Mar 2022 19:29:50 +0100
Message-Id: <CIO22P1JZY5F.1BYJF4HT2OOUW@otso>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzk@kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm6350: Add UFS nodes
References: <20220318183004.858707-1-luca.weiss@fairphone.com>
 <20220318183004.858707-6-luca.weiss@fairphone.com>
 <c88ed4b5-2e44-c3fd-ff2b-b4bee1354765@kernel.org>
In-Reply-To: <c88ed4b5-2e44-c3fd-ff2b-b4bee1354765@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sat Mar 19, 2022 at 3:43 PM CET, Krzysztof Kozlowski wrote:
> On 18/03/2022 19:30, Luca Weiss wrote:
> > Add the necessary nodes for UFS and its PHY.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6350.dtsi | 79 ++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts=
/qcom/sm6350.dtsi
> > index d7c9edff19f7..c5c93b6bcd2a 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > @@ -541,6 +541,85 @@ uart2: serial@98c000 {
> >  			};
> >  		};
> > =20
> > +		ufs_mem_hc: ufshc@1d84000 {
>
> Generic node name, so ufs.

With the node name changes UFS doesn't probe anymore.

[    1.893762] ufshcd-qcom 1d84000.ufs: ufshcd_variant_hba_init: variant qc=
om init failed err -19
[    1.902674] ufshcd-qcom 1d84000.ufs: Initialization failed
[    1.908391] ufshcd-qcom 1d84000.ufs: ufshcd_pltfrm_init() failed -19

I didn't debug this in detail but it's likely from the
androidboot.bootdevice=3D1d84000.ufshc parameter in cmdline that
ufs-qcom.c uses to fail probe with -ENODEV for all UFS other than the
selected one. Not sure why this behavior exists in mainline (didn't look
into this either).

This cmdline parameter (among many others) is added by the stock
bootloader and as far as I know there's no way to turn that off.


>
> > +			compatible =3D "qcom,sm6350-ufshc", "qcom,ufshc",
> > +				     "jedec,ufs-2.0";
> > +			reg =3D <0 0x01d84000 0 0x3000>,
> > +			      <0 0x01d90000 0 0x8000>;
> > +			reg-names =3D "std", "ice";
> > +			interrupts =3D <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> > +			phys =3D <&ufs_mem_phy_lanes>;
> > +			phy-names =3D "ufsphy";
> > +			lanes-per-direction =3D <2>;
> > +			#reset-cells =3D <1>;
> > +			resets =3D <&gcc GCC_UFS_PHY_BCR>;
> > +			reset-names =3D "rst";
> > +
> > +			power-domains =3D <&gcc UFS_PHY_GDSC>;
> > +
> > +			iommus =3D <&apps_smmu 0x80 0x0>;
> > +
> > +			clock-names =3D
>
> Drop unneeded blank line, start just after '=3D' and align next elements
> with it.

Sure.

>
> > +				"core_clk",
> > +				"bus_aggr_clk",
> > +				"iface_clk",
> > +				"core_clk_unipro",
> > +				"core_clk_ice",
> > +				"ref_clk",
> > +				"tx_lane0_sync_clk",
> > +				"rx_lane0_sync_clk",
> > +				"rx_lane1_sync_clk";
> > +			clocks =3D
>
> The same.

Sure. I also adjusted the clock name/order to match the bindings (thanks
for spotting the problems there!)

Regards
Luca

>
>
> Best regards,
> Krzysztof


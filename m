Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F44450BCAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359261AbiDVQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357434AbiDVQPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:15:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1735C85D;
        Fri, 22 Apr 2022 09:12:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu29so15173604lfb.0;
        Fri, 22 Apr 2022 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tUo95tRg9oswGTOGs7YDeTbiPQNo1Vj+yujmZ07iNkE=;
        b=FLa3FV0MSiyAgF2qyUNtURfbCSQxRppSlJuyLPRYJCUhCKwdEJcbnUznBjJaW5PmFQ
         clVb3BnSlvpBRd7Un9kv49I0jweeB9Q+IEw2idcC1n8H5og+XR/wZJ0ke4iZ3czRD5tQ
         cuMBls+ZtSi1BD4F4tL4AkioVEUE3qE/D0CIJLegjKlvgqlxGcltFPj3pqPEjdi+/tml
         vMM3PrkJKFsB8PNhcyCvgoZHcyQdBlmxb4xDmB+90ryGui/OoiYFKVi+XzrwMr/ypgJd
         z3dorO1J1uzxWOUJVO8+h15OWXkq5DN91Bt6+XYRmK/SD7vUICWns9iF64rBHwU2gXDk
         OTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tUo95tRg9oswGTOGs7YDeTbiPQNo1Vj+yujmZ07iNkE=;
        b=tygrQht4ELLDHJpMOrtrGKUPXLNvUXFid2hEee1NTk8rDXdKeakaL02tiujtbc8RHO
         JJX5EkYregSlsFiVC+Szy6U6AYbu9YSX8x05cPf+mX5IzVeYY8ty4/pjQboQ3fAy4kkn
         +d9BeajuyU2iHEPkAyuR7lM0wD1OaItMix7KqHsECE0xiVsLv/oW/kDQqHcf5faO/A0d
         9OzhKESA9WDPJY33Ca07Ugp/QjvvQiTqfc3qguozau0JtmFPr/7Xjp/Ob/2ZRxV96Mfe
         l6AaNABp/sJvrg8YnbMhzlobSz/+nEzvOh4e0/HB4Xb14RArs8W52DxM1ifmNJqe6sbD
         XeAg==
X-Gm-Message-State: AOAM533Vt4Bdol/14jIT3aOrV8ZjNg2SK+wpbefLKsWpBecsCaeCT6+f
        zanEtTbRHmVfKTqUt06IGm1sditgADM=
X-Google-Smtp-Source: ABdhPJyqLOH8nj96lV9crARCF1zTsrgpxWcFrXkyn1Y7RcoQRDIU1n10tbVDioOk+9ho+Nz5J1f6Ag==
X-Received: by 2002:a05:6512:34da:b0:46b:b7fd:1eca with SMTP id w26-20020a05651234da00b0046bb7fd1ecamr3619901lfr.481.1650643929213;
        Fri, 22 Apr 2022 09:12:09 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id s8-20020a2e9c08000000b0024af06d6674sm254891lji.61.2022.04.22.09.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:12:08 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:12:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        paul@crapouillou.net
Cc:     robh+dt@kernel.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mips: dts: ingenic: x1000: Add PWM device tree
 node
Message-ID: <YmLT1VA8ZL57CQkO@orome>
References: <20220224234133.15708-1-aidanmacdonald.0x0@gmail.com>
 <20220224234133.15708-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oqekWBq8aThw7qyZ"
Content-Disposition: inline
In-Reply-To: <20220224234133.15708-2-aidanmacdonald.0x0@gmail.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oqekWBq8aThw7qyZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 11:41:34PM +0000, Aidan MacDonald wrote:
> Copied from the jz4740 devicetree and trimmed to 5 timers, which
> is what the hardware supports.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

However I don't see this upstream yet, neither in Linus' tree nor in
linux-next. Paul, do you still have this on your radar?

Thierry

>=20
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/i=
ngenic/x1000.dtsi
> index 8bd27edef216..0dcf37527c8e 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -127,6 +127,19 @@ wdt: watchdog@0 {
>  			clocks =3D <&tcu TCU_CLK_WDT>;
>  			clock-names =3D "wdt";
>  		};
> +
> +		pwm: pwm@40 {
> +			compatible =3D "ingenic,x1000-pwm";
> +			reg =3D <0x40 0x80>;
> +
> +			#pwm-cells =3D <3>;
> +
> +			clocks =3D <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
> +				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
> +				 <&tcu TCU_CLK_TIMER4>;
> +			clock-names =3D "timer0", "timer1", "timer2",
> +				      "timer3", "timer4";
> +		};
>  	};
> =20
>  	rtc: rtc@10003000 {
> --=20
> 2.34.1
>=20

--oqekWBq8aThw7qyZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi09MACgkQ3SOs138+
s6FFpRAAuH7U4JXdUlpL70pOW1ieMwEBCfi6FD7Ek1vDFOOMpYKWTmbckzoBi3JW
nAbs6B3aKDgnopG7nui6lyS7XYosRXjgnvn05FIFdKApcAkE929MplQAG7x8JOuC
pCHfLXuTkh3pngiZtyvVpqJ4ymT1e2Z1IV7is215b8SmUhotOtAPFS1gpbRXQLWR
bTqfdaoxYHpmTHU5lcoZAzU3cqzAP28Ae/xhMoiSK+6ZaPpDGimC7MszBkGgJQZi
VQ2PvhbIthFk7tAaBekRj9pQiD6pdk2IA+bctSpOcUoVp9NRvudgmm5rBEEKPuOf
Sr7VNVd9/HNWGAiMtEGb3SbbUbBxzVXNxEWRz+NtO9Y6R4h8IpWmMIH/SMoR7fYy
+Ea3HdylX2TENnuH+wonQAdNqJ0t5w2hlkjltJLDJUOqgF3KkugdMylzhWMpv3Dj
anltpfr9KWN48c2N8VsBuUSfVlU0SZB6cV7dHq+8JTpucva/YtD+0gdwofl4cERF
czY9p20Bzw1vlfCIDaeH1qLv/e5e5jGlJVmF8GFAA6CyyhNWit/5uWO57GATvSqE
inSRdtOdmJkfnB91+bu2mpeirRIe5lM+8FfIW22OT4W0OXHSXC3ViLbLAa6w1zjm
oIJroWw1T0nFvfsz9+PRPGVIqfD1KllKDrj8awyEtowT5wDC2Wg=
=9GL8
-----END PGP SIGNATURE-----

--oqekWBq8aThw7qyZ--

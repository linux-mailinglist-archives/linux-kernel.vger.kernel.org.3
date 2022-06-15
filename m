Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6329F54C789
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348014AbiFOLcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347949AbiFOLcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:32:09 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945E53A4B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:32:07 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c144so8434897qkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zXQh9DHZln86JMnT9oZW4PYJFlIXU2zwTuhQKeHViMU=;
        b=zI6qf4L1zlgeNVGNB4IxTkI1t8VZ7sEdXcaymSOCdS6pC+CUlZBymcc0ml0qqfMQBX
         Fv2HRHlrLd0pCuOqn25CMkOiaxgEYEQgnV1hETKyYWOBNviIDjD9XFQ1zYwpPjb1ssrT
         7z8qMd96R/WNwXoRn2oMLEzjtRtnDwLuaHC1Mjprq8RoDJOJPHFUyf66TUSKxvIOx3wu
         jdAP1zClK/QnlALdSBGgojrxnewLwt9+/wG98ZZ5CaiugOr95s1J120c7yzogh1zG6Dz
         EvmckSyLQScb9rj4TaS8z8HPWP0Re5F1loIhhmDp6hM50CA2E5cBrlya7xzrlufgIUs9
         ilxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zXQh9DHZln86JMnT9oZW4PYJFlIXU2zwTuhQKeHViMU=;
        b=ZvtV1sZwFC/QW4ato/217QcNXdskw/Ln5B/FbRGUNAK/luJImNpamB8DW4xGW1tRTI
         aXkU4bixSa70IaeIKoSDHiRBv0UMia6YmZCR2uiN6XsylStavp0Fedb1FcOhg0JtjywG
         60paYGWNkksJs9CA5NuWJktah1ckQUgcd9fKQDX+CTUd87rztRTod8VhSARmTM5e9LKy
         nkZ7TIXKvPO5AB6y5soj+8HazVUzkMOPeBkVZsnFlOUi+Y8GQ+5y//3zUFwteh5gX1CU
         tubSDKVM6en7ocKoqpmHgC26BxeQRWRDBABtmNCSoFGFADMllrVJH4NaN7jsMhF4ti0v
         9ISQ==
X-Gm-Message-State: AOAM533qfkwh56RCKP5ZCIpF8FGQkX1YebcBzq7b674WoMa2jTTi4EXh
        SXdMFYxLow/29vRGvAh2RPo/kQ==
X-Google-Smtp-Source: ABdhPJxZTwGW26UEgQixxEQltx8vNW8wUZS8o4P6APm+hiysaI9wCRekoOjekukiwjP3eoWXjzS3rA==
X-Received: by 2002:a05:620a:1355:b0:6a6:be35:e22a with SMTP id c21-20020a05620a135500b006a6be35e22amr7489940qkl.700.1655292726856;
        Wed, 15 Jun 2022 04:32:06 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id c10-20020a05622a024a00b0030509143423sm9459261qtx.69.2022.06.15.04.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:32:06 -0700 (PDT)
Date:   Wed, 15 Jun 2022 07:32:04 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Zhi Song <zhi.song@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isa: put_device after failing to device_register
Message-ID: <YqnDNL/ComIpYYe1@fedora>
References: <20220614164710.1744680-1-zhi.song@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MX931KHt9URK+Zru"
Content-Disposition: inline
In-Reply-To: <20220614164710.1744680-1-zhi.song@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MX931KHt9URK+Zru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2022 at 12:47:10AM +0800, Zhi Song wrote:
> device_register() is used to register a device with the system.
> We need to call put_device() to give up the reference initialized
> in device_register() when it returns an error and this will clean
> up correctly.
>=20
> Signed-off-by: Zhi Song <zhi.song@bytedance.com>

Hi Zhi,

Would you add a Fixes tag line specifying the commit where this bug was
introduced. That will help us get this fix into previous kernel versions
as well.

Thanks,

William Breathitt Gray

> ---
> V1 -> V2: Fix up the changelog text correct.
> ---
>  drivers/base/isa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/isa.c b/drivers/base/isa.c
> index 55e3ee2da98f..cf88f3d77b7d 100644
> --- a/drivers/base/isa.c
> +++ b/drivers/base/isa.c
> @@ -173,8 +173,10 @@ static int __init isa_bus_init(void)
>  	error =3D bus_register(&isa_bus_type);
>  	if (!error) {
>  		error =3D device_register(&isa_bus);
> -		if (error)
> +		if (error) {
> +			put_device(&isa_bus);
>  			bus_unregister(&isa_bus_type);
> +		}
>  	}
>  	return error;
>  }
> --=20
> 2.30.2
>=20

--MX931KHt9URK+Zru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYqnDNAAKCRC1SFbKvhIj
K0QiAP9L6auH2eAVJESQER3EQmCmoRYlI+VkaUGscIs7m2A80QD6A70Y2fgat+EL
/ZyITyJ61LlUPc6EEf7nKpV2/6GwNg8=
=A2d+
-----END PGP SIGNATURE-----

--MX931KHt9URK+Zru--

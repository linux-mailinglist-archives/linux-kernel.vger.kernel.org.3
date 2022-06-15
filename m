Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1575554D430
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbiFOWEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiFOWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:04:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C1C562FD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:04:01 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 63so10307705qva.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MDS3WvI4YFumw+J0nlIpDcy+57+C4g6hoEFp0Oh4Mbg=;
        b=O9OEQD+3doDW4twViBJqKk381w6PggzugLkS97+21OVsnkhC0nfJtzXv5lm4qbDsC5
         IS+eEHNp6HiDpVKbh4nx0CZ8XX/jCYEbl2IBOR1UypJVQFcQP575bN9jQhVlRBzkHUbg
         RSrH5xfRkBFhcV7XfWX4bjfAHdJItUW+gud4jZVDnl6/zL1zT8yvFVgZiVYZnhV8lNWO
         ARDX0GWzX3qwrKLVBy6+3wB0VgU1QvFu0lWUn0b1M2570s3nVAPr7+rvYDDR4UECV1N7
         /IAB505xt90CQD/0ERtLzv9EJ9aICAOS1NMo0bnXUqqJC8nttVFJUaY1cLnT7GK8ni31
         0NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MDS3WvI4YFumw+J0nlIpDcy+57+C4g6hoEFp0Oh4Mbg=;
        b=rJ+0QVYDXDXXk/AcY3DrPbWyrxKA23/HbjqGAG4GuPzkbNMJmnUSEhXSWl+8E4KOQG
         fTCYeVnKNSfDMznhEsgQ0S//wQwV1AvY9B0eBZSCUmKM5cdy3Uz3hoVpDYsyw7noDRe0
         2K5y9BJvj7ywJImlr2OpHOBWV81nrgOgs3zvEBLQXVJLVPybWxS2BkvA4iZeOltIbjgk
         5p1TnlEjM7OdcUMEK0BQn444V17C70/+RB6F489auiyMjeObwA2Pg0hHFAmQoVlVLHel
         RJgq7gbz2PYJrqnVBZsBSE8WZ1QwzTQi0qJiLPxj2yWK0mQM9gmPHOu/8bzNE7OrG+0T
         zL3w==
X-Gm-Message-State: AJIora94CKfLTwkAGhA0biKHHKIdksiPq+JGrLduNdfC0W8v6VGqDwyE
        xJzVMkbhJBddN/sXNTl+nFY9IQ==
X-Google-Smtp-Source: AGRyM1sTWN3zHfbnxs6htd3ILckH8IVVrl/qj0Zod43G89DucO6m1YRA1RVicFHe/gmSCv5FKj3Pig==
X-Received: by 2002:ac8:598d:0:b0:305:25ad:2f1e with SMTP id e13-20020ac8598d000000b0030525ad2f1emr1553022qte.237.1655330640212;
        Wed, 15 Jun 2022 15:04:00 -0700 (PDT)
Received: from fedora ([23.82.142.207])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05622a228f00b00304ee15be24sm288340qtb.11.2022.06.15.15.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:03:59 -0700 (PDT)
Date:   Wed, 15 Jun 2022 18:03:57 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Zhi Song <zhi.song@bytedance.com>
Cc:     vilhelm.gray@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] isa: put_device after failing to device_register
Message-ID: <YqpXTVZmhOpBWt47@fedora>
References: <20220615151558.1766067-1-zhi.song@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4XgcVqWqYeVvtZwk"
Content-Disposition: inline
In-Reply-To: <20220615151558.1766067-1-zhi.song@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4XgcVqWqYeVvtZwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2022 at 11:15:58PM +0800, Zhi Song wrote:
> device_register() is used to register a device with the system.
> We need to call put_device() to give up the reference initialized
> in device_register() when it returns an error and this will clean
> up correctly.
>=20
> Fixes: a5117ba7da37 ("Driver model: add ISA bus")
> Signed-off-by: Zhi Song <zhi.song@bytedance.com>

Acked-by: William Breathitt Gray <william.gray@linaro.org>

> ---
> V1 -> V2: Fix up the changelog text correct.
> V2 -> V3: Add a fixes tag line specifying the commit where this bug was
> introduced.
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

--4XgcVqWqYeVvtZwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYqpXTQAKCRC1SFbKvhIj
K6oXAP9it6dONEFz8UMcG7tUCX+3SEGP0ZawFZUyA5G96L4FFwD+PYlhIrkL26NI
tT8nZDnbDHp2q7d0ZykuRCSpLU8VmQs=
=p1DT
-----END PGP SIGNATURE-----

--4XgcVqWqYeVvtZwk--

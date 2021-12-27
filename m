Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51CF47FCA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbhL0MaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbhL0MaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:30:16 -0500
X-Greylist: delayed 1652 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Dec 2021 04:30:15 PST
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6156C06173E;
        Mon, 27 Dec 2021 04:30:15 -0800 (PST)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1n1oi0-0007gR-Kw; Mon, 27 Dec 2021 13:02:32 +0100
Date:   Mon, 27 Dec 2021 13:01:48 +0100
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Chaofan Li <lichaofan@cdjrlc.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ssb: Use true and false for bool variable
Message-ID: <20211227130148.0fd19710@wiggum>
In-Reply-To: <20211227062159.22746-1-lichaofan@cdjrlc.com>
References: <20211227062159.22746-1-lichaofan@cdjrlc.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ewtc7_jKL/358o1fj2OylCA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ewtc7_jKL/358o1fj2OylCA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Dec 2021 14:21:59 +0800
Chaofan Li <lichaofan@cdjrlc.com> wrote:

> Signed-off-by: Chaofan Li <lichaofan@cdjrlc.com>
> ---
>  include/linux/ssb/ssb_driver_gige.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/ssb/ssb_driver_gige.h b/include/linux/ssb/ssb_=
driver_gige.h
> index 15ba0df1ee0d..28c145a51e57 100644
> --- a/include/linux/ssb/ssb_driver_gige.h
> +++ b/include/linux/ssb/ssb_driver_gige.h
> @@ -95,7 +95,7 @@ static inline bool ssb_gige_must_flush_posted_writes(st=
ruct pci_dev *pdev)
>  	struct ssb_gige *dev =3D pdev_to_ssb_gige(pdev);
>  	if (dev)
>  		return (dev->dev->bus->chip_id =3D=3D 0x4785);
> -	return 0;
> +	return false;
>  }
> =20
>  /* Get the device MAC address */


Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael
https://bues.ch/

--Sig_/Ewtc7_jKL/358o1fj2OylCA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmHJqywACgkQ9TK+HZCN
iw5ByQ//eeYeD/EWJrr0y6YdWL0G9X1yUgAUejS4A/A7qb4o8U82kcfwpjXHp1+1
d1nE6wWH9uevSGOMwmxqNPNMMXjOqCiCSey/9Vxn+yDBH6sRWOBoTQU2UkekwmOm
PJqWImE18+xy8VlcC0V+tsEPF7r5Yl7WYpwJIK6K9vqoBL+BUv9d0L6aMKEJdyon
zEnhsxPl5ykDbLzHFbifRD0/zGTb5FtvaIkq//jexG32DWLYHljniZdO8Q19CsCr
X99JPedrAXgZ2q6NHNs4Ahl5pMSGxJUvopcrdR0qSBcm9TDZnKYnRZ2RK4M5aLp0
b2gcsE1xxcv8EyV3RjFjApvpRdsYchJYe9JtmlMvwykJaxE2HDWhDOYtlf4FZyrC
Y3fqHtip/mELAabeC5t5RqqGS89hZHv7UZVX0HhsQ3AcGuWZnomccVid1plx5/Vo
G1YnkcuhXm0kzRHxw00tIufjvVmHIhsQDm+WOE1kwWy8lSvb08mt0prNQjW1lio4
kYgHsq8oGjX4w9qD3uCeEJmi7ePUzXtnY4eqUqSy5pKGon394vhT7j8P6+SIcVmF
mibtdBzBqIuBGdB7B6zwcLpBnzO9h7g4Q+Qcb8LLReOCVky3UF2Fvm++QqB/6Gjg
9sydgWEBpZlZZYN1EwhWvMb3cR5Drl0fWWNJajF1X+4Zm0SRkpg=
=K+ZT
-----END PGP SIGNATURE-----

--Sig_/Ewtc7_jKL/358o1fj2OylCA--

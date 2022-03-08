Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81984D213F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349463AbiCHTUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbiCHTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:20:05 -0500
Received: from post.munsonfam.org (post.munsonfam.org [172.104.17.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46CF4BBA6;
        Tue,  8 Mar 2022 11:19:07 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at munsonfam.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=munsonfam.org;
        s=20211029; t=1646767146;
        bh=WUDUq32+avV6AuvvB00/SiKeDAyjsl+E+09hOXUIlG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPlof2j+MkJzBhl0+6G8Np+VGzF2OkilZCdyG5jnY0vZ7fdBnrDOkjoEsKsOgjsu7
         JAVIDuc4OlFwcdaLBEYLqLWK+Ldu0ACLQhelvm5QUZFjbl1bddKmW18GU+ULZ4JsL6
         BdtD/I5WOe2UIobPWDf0lUl2C6BXj0X6M5us/yvHhladfaTsP2m4E7SfH1MY4cjitg
         JFiqFGpIkyny8qlrk8HViQFufwaUfpfkMjnEoeG/fS8b2XzU4jwHMg+0bdIg/SuPYh
         TipU7iL45fGIXO8f0yuoTHefu3p2Nu4NvhGwpa/zaqZk+e+jlY5wQU/DK6Pn+AOAAz
         PiGv9nCKzp/gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=munsonfam.org;
 s=20211029; t=1646767146;
 bh=WUDUq32+avV6AuvvB00/SiKeDAyjsl+E+09hOXUIlG8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nPlof2j+MkJzBhl0+6G8Np+VGzF2OkilZCdyG5jnY0vZ7fdBnrDOkjoEsKsOgjsu7
 JAVIDuc4OlFwcdaLBEYLqLWK+Ldu0ACLQhelvm5QUZFjbl1bddKmW18GU+ULZ4JsL6
 BdtD/I5WOe2UIobPWDf0lUl2C6BXj0X6M5us/yvHhladfaTsP2m4E7SfH1MY4cjitg
 JFiqFGpIkyny8qlrk8HViQFufwaUfpfkMjnEoeG/fS8b2XzU4jwHMg+0bdIg/SuPYh
 TipU7iL45fGIXO8f0yuoTHefu3p2Nu4NvhGwpa/zaqZk+e+jlY5wQU/DK6Pn+AOAAz
 PiGv9nCKzp/gA==
Received: by lappy-486.munsonfam.org (Postfix, from userid 1000)
 id 64F009E010E; Tue,  8 Mar 2022 14:19:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=munsonfam.org;
 s=20211029; t=1646767145;
 bh=WUDUq32+avV6AuvvB00/SiKeDAyjsl+E+09hOXUIlG8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZwjMrn6NAsHhSfg1/pTnEuCPuMWoBs7PQuU+vyf/u5jeSqEQa4ZZrUMaeoHr+NLVs
 auu6qlkuMUqdzTnWeYJXiNxIAGIc/4nRpJGTsXKfO/MP+aJl+PO6Rh+KM/ZfVPkcxe
 +njgSqYg+41OxdvqWKeaMyntLvzjEfp7XqXDde9piosKg3vkR6+cOZPYOa5kdv5DOU
 wMnoB2u7NFgU2kSYRHp+U9UjtYYd+aoWnaol/rvp33W3IWaPC6+pO7/8/b6VemY0Z4
 TXkn4NKescgF1Ri6bH5UGST40krqjpVIALxN/MsJ/4VyBsQvMOnyJ7NhTkaziaFam8
 ItYA3HL2nZ94w==
Date:   Tue, 8 Mar 2022 14:19:03 -0500
From:   Eric B Munson <eric@munsonfam.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Problem: Bluetooth stops connecting to paired devices after
 commit 6a98e3836fa207
Message-ID: <YiesJ4sLv010CpsA@munsonfam.org>
References: <Yh/HKSW05IfXCGbR@munsonfam.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+OQ+VktpKdL07tFC"
Content-Disposition: inline
In-Reply-To: <Yh/HKSW05IfXCGbR@munsonfam.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+OQ+VktpKdL07tFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 02 Mar 2022, Eric B Munson wrote:

> Hi,
>=20
> When testing the latest upstream this morning, my bluetooth mouse
> stopped working. Further inspection showed that my laptop is failing to
> connect, but I didn't see anything relevant in dmesg, the driver seemed
> to load firmware and intialize fine.
>=20
> A bisect turned up commit 6a98e3836fa207 as the first bad one, but
> unfortunately there was another problem discovered during the bisect
> where my bluetooth radio failed to come up at all.
>=20
> I am using a 5 year old Lenovo X1 carbon which is using the Intel
> Wireless 8265 / 8275 card and the btintel driver.
>=20
> I can easily reproduce, and would be happy to test patches or help
> diagnose if I can. Is this a known issue?
>=20
> Regards,
> Eric

This problem remains with the latest 5.17-rc7 kernel. Is there anything
I can offer to help pinpoint what the cause is?

Regards,
Eric

--+OQ+VktpKdL07tFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZ71cx3bfGX4kMtFBqEb2cZzVukkFAmInrB4ACgkQqEb2cZzV
ukkveQ//YkLwFAz9um8O0Zth3ajoyVf5iD34ftR9Tyx1IS7c6QHijhRCYhvDpsHm
h9B1aVk0e7vN9GRCZuZx06MgVrv0Iv8iCVX/vbfJrHuKM+nv4uu92b3Vzbwq7u6D
fxOFrtrbbyPBTzSSCb2YkNnvfX8NbkK9CoaP2quYflsOtxUGunJ3gtEcmuVC+f03
qPeRFIor/TOldxacj1Y8hewDo1wr4Wzk+EAio7FVlnk4QJ7vZ5pM3HJ1DpKCtIX+
rj5uWt/yyNVU89Af+woHECJIfRrgTrTGFpqcc2PIJBGSn1k4oOOfKD2JO8E0sfxp
C+D40fIlQ3Y/cVH+TcvyD0Si4CJ9IwhuFk22D/izoIGdkZgHW9Hjx4Gc6VFOaBIb
KYTnog/KDJGZNe3zfOqB4DXOw4ADWLE7QuL0E75oICj0Nb6oQJUsv3EKVKwzZfuG
Qi+yIdgrPf+xtTt4+IiWbq52sgFO6CCqMjoHS94LhdspYqcUrVkVJTCwtrzQ0S0v
RkIISpbauVezANNu7BXPq5xz3rSLVeUXEcDzIGbYeR1s9/Nt3LEfFnkwSdAlXz95
+P/kGSes/ZfZOZcKMGwFgfJVonuR8RjKeTzHkTFQJGSlgntcusR18TxlbaZF7P7+
KyiM5Q0CLSQSqfzpIbZAPxjTgoUBIdeqQTZ7EutvVMHFi2fCkIA=
=eAcx
-----END PGP SIGNATURE-----

--+OQ+VktpKdL07tFC--

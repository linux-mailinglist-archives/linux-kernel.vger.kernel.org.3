Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879A047A30E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 01:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhLTAA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 19:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhLTAA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 19:00:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F5C061574;
        Sun, 19 Dec 2021 16:00:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHKVZ2CKfz4xgt;
        Mon, 20 Dec 2021 11:00:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639958454;
        bh=XxtgiECl6eTEG2oWCXXzVDGiIpMfQhPi2bHRDXgSpz0=;
        h=Date:From:To:Cc:Subject:From;
        b=BCaQSsfBXuNW0mUHAQrbNc+RfYZdg0VTuqn19JcgDaVLUrtg2XkTgceUCfNC+FyDn
         c/hQEk8+ckQ3OpSKNWPiUTAjWnRJ6vD/PGt27AsMZLvqre9LIU7YMuA/6dK9HbsJZI
         Rr+qfeFEufqLMR+EhOkr9DFtwE1dKUEnPwPMslts0BRl3FQUKnTeIqsAStkdwxxFKH
         Ze/3Xd+b7QvcpTgr20ztZvOqJ2eoo/hf2bTGgIyDu7/OoM1f9Ura0VT3sjnXaE03uZ
         SbJLuUGw6TuQSTl39MGNquuf5N37IASOrLcw5YBTT7mCexuhf+Zq07F+woKUNMuIYI
         XDpYlMpeiUz4Q==
Date:   Mon, 20 Dec 2021 11:00:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Howard Chiu <howard.chiu@quantatw.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20211220110053.059b4bc0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J1jBXs.twosLSeSy+E=kJiu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J1jBXs.twosLSeSy+E=kJiu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: module mp5023 uses symbol pmbus_do_probe from namespace P=
MBUS, but does not import it.

Introduced by commit

  883cb06f2553 ("hwmon: (pmbus) Add support for MPS Multi-phase mp5023")

--=20
Cheers,
Stephen Rothwell

--Sig_/J1jBXs.twosLSeSy+E=kJiu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG/x7UACgkQAVBC80lX
0GzIUgf+JV04iFB6JVkH/A1yiKdcN1dmpNwwELIF2cd9jvcJ8344ePB8Xc4dMukh
cQ1wrEfkBG4nn+ZPAZSSXTcWxUeLI5k/BqaNv2Fc1//hiKMbHIyzSbAhTDM2qqFp
2Va5ES/Nas2MD2EptGj6UYh6jTHz7ZTi2AHeiBhn/loy68F7wV3n+efVv20lDsxM
oxieKlxJAoe7Vg2HWKgLzINSaxkfvsOALi1+cph11G5Nk4tWE7gEzm+pDGpdKunP
BLE43Ttmiy3qoYUZ6cRHLqvorxkiHM9TpLsp8dEpVUtjO+wPI700IK0C0YBKk515
wm0DYAqSXgJHAhGBDdUZ+S/snCkgCw==
=jCKm
-----END PGP SIGNATURE-----

--Sig_/J1jBXs.twosLSeSy+E=kJiu--

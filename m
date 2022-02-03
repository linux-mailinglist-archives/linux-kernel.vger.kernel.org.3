Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3414A82D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349785AbiBCLDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:03:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:37323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236576AbiBCLC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643886177;
        bh=dtuoNUKYd55ihTR8MNLq5bBgLKHrIBDb8lDYNxE6WvE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RCXEJayvilqgEYl8jQFYIeAps2+XLvKmgPFgOFg4TDLI6DTDzuwLsMbErxRw4pnpE
         EMjLQFGdRlhtMIdZ3B1GbJa6T3/Z2bbu9SNs8uyAH/8fqTJMXhH8UjLWaeAvHmGSOj
         YE6oiHyWOUHQo1quZdwMow9CyAIJQMaUZC9A1HtE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from genesis.localnet ([80.143.62.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUrx-1mHpZQ1nL7-00xtX2; Thu, 03
 Feb 2022 12:02:57 +0100
From:   Alois Wohlschlager <alois1@gmx-topmail.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ovl: warn if trusted xattr creation fails
Date:   Thu, 03 Feb 2022 12:02:46 +0100
Message-ID: <2783448.iqOl4yHqVZ@genesis>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2721792.dFq5vDo5FW"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:hQaQRD/tUj8dBRkhbSaEzZu9ABaoWdmdQ9xvCQBnLWVlyNAD9NO
 It342uC6uvsP02qYtiO1qSjDS0AeUTeesflSYPCvAy4ssrFnCLOq4LOUs5OVVbeEoH+loJC
 inVLZD7GeoSP1AeLwKuKK3Jz2IFQ8Me2KK3LXYrMdAyL4yqwstWkFQ34S+gOB2mo8QamJAS
 s7KCWbJU7nRkFsB0YTv3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hApSr45sbcw=:nRe/ccW0cO4EkCCJZrz4yB
 HdXRqM6wyznnEeAhNN+M/Zk6GLn1rlcQZ7NTNOMqvezeKgri2xnjankBkan11d/opZVubuSk5
 EEHuEYuCsImTQZ6eCXaOi8zqXNTaZltzfIs4WnBjv/LjXD3zXZWYgQIIHo2Bu9kJFV5FED21a
 yFYY1nmY98xjacV/5gvJY2Jvr2sn2UteeLyH9LFPYeAl1gyn4p1Vheh1jeZ9w6f7k2dkP/eqO
 2DNKfck/eK9ZeOXL174KRxTIttxwWpfz21idvu4CKM2AdCgTlAMYDNirGgCozAJ/PjSu+Zx10
 NuUff8RJkafcYaRGxFHi3vBnRCP4rYiObjm1IK2LsDjBPHgmPnsNL/g6HGdDS8JC8Ew/Tr6OO
 BOTMvXpVJa6hHmsfvqdPRMojb0vrc9II4u58cvRdJFmO0CNV4cu3XI6raX+QeSwEmDeKahLJc
 HlDimjF5fyIBA87J95xgR/hgFHgHv7dQrGakwiRnJVXp+9kz8afmpx8TK1t0JpRCCqC6isbCO
 kVRJbAsrmq54APY9xtHczfjWOL06p//XvrHKoI1dVowjNWF5jHq/JB3hUCs3zFRXSaf2CZlxh
 OT6Wc2mOct8ST1I30U1wCFp2jJJtjlLhLQDJboAzNpFyZIVbO86s/5Zw0SA5SNrGB1r9E+UmQ
 GoNj8Keu4sF/L1fBa7Imv9hO2LRFecXwGwyJDsrT/ZfR0aRJeZyR0AKCc88Wxe7Earb38sKPE
 6imYTVPkKvqJf0gcDwBfL7uPTtVtxWrI/T48E9LtQww+gEDP9VWiFL8wKAB7LPwQOVSHyJbJo
 IOCRUQaYhGKyMekDG5+1dCM4NJko1ahYBhtNbsJXRXs15SEKl7cU4g+focb5Wk3V7VL62jQ5K
 VtaFn0BWdExbPGUURL3ay2uxb+qgpO+ss3olpIRdBIOk8bKZsDHwX1AyV3OVgS/QU0ZFfnmg6
 hkEN/L5rlzdepI8QuHh0Kwh+i/3N33yfAVFyGjkmLPB8n/nHCKUH03hBTpPkYPMG0a4NsCPuu
 KZ4apCRaiKsZXUiQkayBVo4cLpZ2ihGbMkRqwNYC2gkMe1S/UHAEz26T2Rb0SXtuiMA2oa9hH
 EYmaCOiFWJqDpg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2721792.dFq5vDo5FW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Alois Wohlschlager <alois1@gmx-topmail.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ovl: warn if trusted xattr creation fails
Date: Thu, 03 Feb 2022 12:02:46 +0100
Message-ID: <2783448.iqOl4yHqVZ@genesis>

When mounting overlayfs in an unprivileged user namespace, trusted xattr
creation will fail. This will lead to failures in some file operations,
e.g. in the following situation:

  mkdir lower upper work merged
  mkdir lower/directory
  mount -toverlay -olowerdir=3Dlower,upperdir=3Dupper,workdir=3Dwork none =
merged
  rmdir merged/directory
  mkdir merged/directory

The last mkdir will fail:

  mkdir: cannot create directory 'merged/directory': Input/output error

The cause for these failures is currently extremely non-obvious and hard
to debug. Hence, warn the user and suggest using the userxattr mount
option, if it is not already supplied and xattr creation fails during
the self-check.

Signed-off-by: Alois Wohlschlager <alois1@gmx-topmail.de>
=2D--
 fs/overlayfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 7bb0a47cb615..11123fe967e0 100644
=2D-- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1427,6 +1427,8 @@ static int ovl_make_workdir(struct super_block *sb,
struct ovl_fs *ofs,
 			ofs->config.xino =3D OVL_XINO_OFF;
 			pr_warn("upper fs does not support xattr,
falling back to xino=3Doff.\n");
 		}
+		if (!ofs->config.userxattr)
+			pr_warn("trusted xattr creation not
supported, some file operations may fail. Try mounting with userxattr next
time.\n");
 		err =3D 0;
 	} else {
 		ovl_do_removexattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE);
=2D-
2.35.1


--nextPart2721792.dFq5vDo5FW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEypeoIv8kJdR0rz5L4PWepeUhaRQFAmH7tlYACgkQ4PWepeUh
aRTRcg/7BTj3iFqS6SXGn4uCVIP8gkf80PR712eTRoIu61G+giEKbNaBL1J8/Y0t
dTsvlkB/VRBSrjEQKXcD3aQWLpxGsahxD0noss9RfEXAR8FFMrIOhvHSK9uWi0WW
DB/obTfIhncQeYIycnEA6VwnPJMyXIDmNQ6YStvD23h/XtkdFrH8lb+0hpaiUqnf
gHG68t1li75xVHQNzt/otE3kVDluJxOCRDbw3NiDD1gNcIfPqJ5tR9q7YguFy7tU
ynIVh4I5UWcdMrA/us1tMxJ4AprDczdmBv56HDkBhJqXDZzX52ONj6ZRZFbcB3QB
GveTDZb/YloEUX3SaQZuaKgnPMty6XoEJAvpk+jHYM5HAVxNRO4a/U1bnNa0EARQ
GdwYkz9WQKXdgMapSk2n6K7fnCjejBzoLWo6mo97m+CnfJl9PvvFe50Z/JAuotry
MuSAGf2OFtnGQVIU0Fs+9jDaYVhoHWWBD/qplZnEMItoJYi7jibgjX5n3kyt4Ok9
ysz08lelHWkAIb3lXu19QPqfGakKXgwCcEckUtD1urlZCYIarXg9A01vO7algDF9
ZJVOtUprGmwUBBuR731Df4wXYxI8STGIXgBhctRoveHRttPM0q37SWmhQKVZ31SD
C0WTFycb7Cl4NilBwjf8RHZhQYYBY4pW+0KXGVlXn63CdLAETDU=
=dq/y
-----END PGP SIGNATURE-----

--nextPart2721792.dFq5vDo5FW--




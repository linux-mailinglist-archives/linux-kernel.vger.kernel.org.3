Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4D5A2B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiHZPb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbiHZPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:30:19 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FF73890
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661527772;
        bh=vybn/ViyNZp+SZt4R+o06lIHL1/q8XEV7JitarIyZUw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=FUbqtduUcGbzwwG/RlAdq2Iudaa+Ht+yirkgCZuksUHuemvMY/mB3Sgdc0o7RZGMm
         ph/q9N+xhqNDrgH9fSJv0KZy5yOLUZ+np/rsjoTDoi65nQgGKPiq8zU6JTSWQXV5kr
         Gnp2y1mauCt6TQwA4z1W3Q1sVz6UzY/MxVYW5T1c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.150.91]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoNV4-1pBeOy20Fc-00oiZn; Fri, 26
 Aug 2022 17:29:32 +0200
Date:   Fri, 26 Aug 2022 15:29:31 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     linux-um <linux-um@lists.infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] um: Cleanup compiler warning in arch/x86/um/tls_32.c
Message-ID: <20220826152931.5835fdf8@gecko>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LZycpH1Xjhw3hn5+7RWproQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:zRfBwWFCxLDu4xtAgPM58Sbn1rcr0fvj0TQWpsr2TlOF43NWZuA
 EQe8GTqssKt+x7JhGp0DNAWhk5QM0YwPYgGn6gHFGHlg1k6Kgn8JCRvGoHzb+oYmkJAJHk+
 7jt4tUq0hN8ArWbVXBQYX4sTur1nFVjOZSs0jQI6sS5kOps2i3Ra397XXeiZpkEIH/H27da
 DEWXxWxzxR0zloYCOqs/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wfGKSGR36wQ=:jwBIW4fn8rS/IBz1EQSFFe
 joylk/5JRyaS3iM5ChO0yigi/Yjj19wKHqHcFiMyxmrX8UDj9wYWT6feINqO6M7qow5kAHBf/
 Xrw/dSpau28uRT+JZuZTdQtMYO1sGKh00l/GMD/hHuP3jwfGat6axd42rzL1bmCAMGFyIxDXF
 udhlLiO4q8SEJwE37g157taapWMj9W1glutvoK7RqOJYz0c7moeklun9rYeyYUwOobwQ5KqwE
 ePCqJzMzglUuD8lx/HFwLa60xCaHDj2ng/o2f3/BjFHWaQJuEx2/w+YDK6s08F29ZbRGApq66
 WTON2wuDaHsyW34xvSltW4UM5X4K4Vb8lvWcrAZjqvGGNSnDeX7alZUpKXeguoJ7oxtmS/vWb
 gf1Bsm7fxwxkZRBXK5jSOlFnITmAPkL7gNYk/VFwQLSwmP0JiGtilYK9RtKJmFEHDGaQZboi+
 Uqf68VuGCBaObrLTjzXwTlGodHfgzBspSfcAz0QByZP7g0MJeM9lm7614AvzGRCA4HavpdO4U
 tTsHgDZ3D0ijSMyGAXRjs7WHbr6neQIIdrSKr7pY2MRBQvh9TR6UfaeWyF1Az0NUA393qVSIg
 5sW4H7ix/Rah/ZKnouONafuNK/4Oyyf8KoOSpxc5mX7uvIcg0N3EjL2iKaxDQW4v0CAwb7UH9
 JRBRRDLiSgPQ0Di64t+YkfHhML4BzUgWGTeEF7y9D8NeBr0tyBOCrMxPYgsLpouK1RIWGNrj/
 KZRkTGS6nqkfwVaFA8xGfJDrqBACVcJbzCoYIum8ZS+cQvsAj4DYiNgp6KHwGn4bKz6UTDMeA
 3NhcxmRe/0zuzYBXIELIPWltoaE/yKtBYSoDiqglWl6w/p7tInmZgT2U0aJi38LAunJFh9BlA
 ycECYW1by6f4Zj0IMxvfC6aTvju8sVM4/6e5WcP8sfw077JEeEqWJb9API734oSZNFDwS/YUs
 E0mvTfvlQQG4IGIETowCgIHOgVCkUgAH58ZWdCQJwYnHoksiD/YXg3i7Wa94ZZbLfJb48U7yF
 UNakweCgDzBpavM/bP8WBUk7rKq+dME8hili3VtkEmqXNhMF2RHPuZGGW0QtHtcgosgtOwvtF
 OfeP62gY2KXNymSeMiKLFnqCNcCDjCgdXRRgPSkONR2J4Rq9xD7RQ/sSA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LZycpH1Xjhw3hn5+7RWproQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

arch.tls_array is statically allocated so checking for NULL doesn't
make sense. This causes the compiler warning below.

Remove the checks to silence these warnings.

../arch/x86/um/tls_32.c: In function 'get_free_idx':
../arch/x86/um/tls_32.c:68:13: warning: the comparison will always evaluate=
 as 'true' for the address of 'tls_array' will never be NULL [-Waddress]
   68 |         if (!t->arch.tls_array)
      |             ^
In file included from ../arch/x86/um/asm/processor.h:10,
                 from ../include/linux/rcupdate.h:30,
                 from ../include/linux/rculist.h:11,
                 from ../include/linux/pid.h:5,
                 from ../include/linux/sched.h:14,
                 from ../arch/x86/um/tls_32.c:7:
../arch/x86/um/asm/processor_32.h:22:31: note: 'tls_array' declared here
   22 |         struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
      |                               ^~~~~~~~~
../arch/x86/um/tls_32.c: In function 'get_tls_entry':
../arch/x86/um/tls_32.c:243:13: warning: the comparison will always evaluat=
e as 'true' for the address of 'tls_array' will never be NULL [-Waddress]
  243 |         if (!t->arch.tls_array)
      |             ^
../arch/x86/um/asm/processor_32.h:22:31: note: 'tls_array' declared here
   22 |         struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
      |                               ^~~~~~~~~

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 arch/x86/um/tls_32.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
index ac8eee093f9c..66162eafd8e8 100644
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -65,9 +65,6 @@ static int get_free_idx(struct task_struct* task)
 	struct thread_struct *t =3D &task->thread;
 	int idx;
=20
-	if (!t->arch.tls_array)
-		return GDT_ENTRY_TLS_MIN;
-
 	for (idx =3D 0; idx < GDT_ENTRY_TLS_ENTRIES; idx++)
 		if (!t->arch.tls_array[idx].present)
 			return idx + GDT_ENTRY_TLS_MIN;
@@ -240,9 +237,6 @@ static int get_tls_entry(struct task_struct *task, stru=
ct user_desc *info,
 {
 	struct thread_struct *t =3D &task->thread;
=20
-	if (!t->arch.tls_array)
-		goto clear;
-
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
=20
--=20
2.37.2

--Sig_/LZycpH1Xjhw3hn5+7RWproQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmMI5tsACgkQNasLKJxd
sli3qRAAkgRBGEM2oxLpbfJhsLdW21G4iDuBKV5sUnRsRzt2Wgxx8osNg28GNg+k
xsM+8Fr2Qnjgqci8p5sIB4sqGxr5sAl3Lof7KTo2JfSs/i6pkAf4i2aXQo/8lmHd
8lQPxzmSn6oWkGyfLYNxSMZG3ax7B1sx4tjMomaAoqF6jp0pzU9m3Kx3+c5Pw2U0
waPRbj0R4pELzFzAinqW+tU815/UxtScYVGIJtGX5mNa0q1Nywm9iHdx7Ay2x2Bw
QmuhfjCOQIt3hvAebILiYFLV7GBLrr93pEvnQOaozW+oHjXsM1uEXM3qCuAD/7ti
BNpVoTTiCaNKO1PvnGpiYzky67WbsUchbSJrDcpBIPBL1NL9JDKr72B1Dg+WAUHH
ae55V9qaye07Bg8+MiEgzGoMvE6tb4lcA6m7zhO/4uaQVv2CpNpUHNX9jyY1i3/R
9PnR62D+kWkiqsRW5CL/bAA5mtDbkQ8gu+bov3M2IvceC9aAQe1sam5sxqcQqcFK
CQRqAcv6hcVUx30JqLv1clx7JZwdpVrXA3DE+N2O3IKnE8xO247uAoOQ0r2Db8v3
0964pe4JOjYprIDVyFrKAFFkntSvga5t+zJf0ZCVECn7t4IgN8xad7ar/+Yzcy2b
FX0PVBW9FG0Vces/8byR1B/+mBwjEbb96RFK5jvQ294gXRg9LsA=
=y+Wt
-----END PGP SIGNATURE-----

--Sig_/LZycpH1Xjhw3hn5+7RWproQ--

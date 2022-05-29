Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FB353701C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 09:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiE2G5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiE2G5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:57:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBBC3FBD6
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:57:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvCrD-0001Nl-TF; Sun, 29 May 2022 08:56:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvCr5-005D0y-Nd; Sun, 29 May 2022 08:56:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvCr3-00Cp8z-H3; Sun, 29 May 2022 08:56:49 +0200
Date:   Sun, 29 May 2022 08:56:37 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biederman <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-riscv@lists.infradead.org,
        kernel@pengutronix.de, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
Message-ID: <20220529065637.xgapqjp2342flbuj@pengutronix.de>
References: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kx2r5dh4j5uektvu"
Content-Disposition: inline
In-Reply-To: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kx2r5dh4j5uektvu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

on current linux-next ARCH=3Driscv allmodconfig breaks with:

  CC      arch/riscv/kernel/elf_kexec.o
arch/riscv/kernel/elf_kexec.c:345:5: error: redefinition of =E2=80=98arch_k=
exec_apply_relocations_add=E2=80=99
  345 | int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from arch/riscv/kernel/elf_kexec.c:16:
include/linux/kexec.h:236:1: note: previous definition of =E2=80=98arch_kex=
ec_apply_relocations_add=E2=80=99 with type =E2=80=98int(struct purgatory_i=
nfo *, Elf64_Shdr *, const Elf64_Shdr *, const Elf64_Shdr *)=E2=80=99 {aka =
=E2=80=98int(struct purgatory_info *, struct elf64_shdr *, const struct elf=
64_shdr *, const struct elf64_shdr *)=E2=80=99}
  236 | arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shd=
r *section,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(I think) because there is a conflict between the two commits:

233c1e6c319c kexec_file: drop weak attribute from arch_kexec_apply_relocati=
ons[_add]
838b3e28488f RISC-V: Load purgatory in kexec_file

And so next is broken starting from
164a9037b1d33f28ba27671c16ec1c23d4a11acf which merges the riscv tree.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kx2r5dh4j5uektvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKTGRsACgkQwfwUeK3K
7AmDxAf9Ggb6UqEX3OJcHfUAj6XII7Pgm7ANdk/sgjvS9u4KABETUJ4Dub8m44b7
YzTKjAz6Aoat5x0aX/BoeMEGOLKrO10yBqljertv1U3F28A0fvUejuJJoBHnmQHO
A2rACjr5HuulnTTeF3vSwtxdKVzyR5bT4ys1ELO0drRWIdeds63oFpM3vg/7Dhkm
6DGR26o5+bBCUsDlpnNlSTy4bqMaXAtqnImET8yrafbTbDhSXbwO57dOlfT0QmTC
p2LoUfw5d64itPHNimGmnAJxtoJEET/gGLFzTbZIJk84CEydkc+3/2DyFU3rwHTZ
DBh5qrnvrwgxqtYd5zu0HPAfvgDQMA==
=tj8R
-----END PGP SIGNATURE-----

--kx2r5dh4j5uektvu--

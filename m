Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7B5375A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiE3Hm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiE3HmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:42:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA1186D7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:42:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nva2d-0006ni-4F; Mon, 30 May 2022 09:42:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nva2W-005PS2-BU; Mon, 30 May 2022 09:42:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nva2T-00D2mA-SD; Mon, 30 May 2022 09:42:09 +0200
Date:   Mon, 30 May 2022 09:42:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Li Zhengyu <lizhengyu3@huawei.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     alex@ghiti.fr, aou@eecs.berkeley.edu, bjorn.topel@gmail.com,
        guoren@linux.alibaba.com, jszhang@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mick@ics.forth.gr,
        paul.walmsley@sifive.com, penberg@kernel.org,
        sunnanyong@huawei.com, wangkefeng.wang@huawei.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "liaochang (A)" <liaochang1@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Eric Biederman <ebiederm@xmission.com>, kernel@pengutronix.de,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Li Zhengyu <lizhengyu3@huawei.com>
Subject: [PATCH] RISC-V: Prepare dropping week attribute from
 arch_kexec_apply_relocations[_add]
Message-ID: <20220530074202.pydmbbgvbtaugw5j@pengutronix.de>
References: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
 <20220529065637.xgapqjp2342flbuj@pengutronix.de>
 <264786d9-7756-19e0-2742-8b8d17f5ace5@csgroup.eu>
 <20220529140655.bnd4fgggccrorj4t@pengutronix.de>
 <59e8faec-05fd-805d-7de0-4b0508f8467f@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="izltdsmj2dkmzuym"
Content-Disposition: inline
In-Reply-To: <59e8faec-05fd-805d-7de0-4b0508f8467f@huawei.com>
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


--izltdsmj2dkmzuym
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Without this change arch/riscv/kernel/elf_kexec.c fails to compile once
commit 233c1e6c319c ("kexec_file: drop weak attribute from
arch_kexec_apply_relocations[_add]") is also contained in the tree.
This currently happens in next-20220527.

Prepare the RISC-V similar to the s390 adaption done in 233c1e6c319c.
This is safe to do on top of the riscv change even without the change to
arch_kexec_apply_relocations.

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Looks-good-to: liaochang (A) <liaochang1@huawei.com>
Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---

On Mon, May 30, 2022 at 09:43:26AM +0800, liaochang (A) wrote:
> > I can confirm that doing
> >=20
> > diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/ke=
xec.h
> > index 206217b23301..eee260e8ab30 100644
> > --- a/arch/riscv/include/asm/kexec.h
> > +++ b/arch/riscv/include/asm/kexec.h
> > @@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
> > =20
> >  #ifdef CONFIG_KEXEC_FILE
> >  extern const struct kexec_file_ops elf_kexec_ops;
> > +
> > +struct purgatory_info;
> > +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> > +				     Elf_Shdr *section,
> > +				     const Elf_Shdr *relsec,
> > +				     const Elf_Shdr *symtab);
> > +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_=
add
> >  #endif
> > =20
> >  #endif
>=20
> LGTM, you could send a fixup patch to riscv, thanks.
>=20
> >=20
> > on top of 838b3e28488f results in a compilable tree. And when merging
> > 233c1e6c319c into this, it is still building.
> >=20
> > I'm not enough into kexec (and riscv) to judge if this is sensible, or
> > create a useful commit log but the obvious way forward is to apply the
> > above patch to the riscv tree before it hits Linus' tree.

Ok, here comes a patch with a generic commit log.=20

@riscv people: If you prefer, squash it into 838b3e28488f.

Best regards
Uwe

 arch/riscv/include/asm/kexec.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index 206217b23301..eee260e8ab30 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
=20
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops elf_kexec_ops;
+
+struct purgatory_info;
+int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+				     Elf_Shdr *section,
+				     const Elf_Shdr *relsec,
+				     const Elf_Shdr *symtab);
+#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
 #endif
=20
 #endif

base-commit: 838b3e28488f702e2b5477b393f009b2639d2b1a
--=20
2.36.1

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--izltdsmj2dkmzuym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKUdUEACgkQwfwUeK3K
7AnmPQf+IN+rB4o/lVwe+g3nQDfd/LaYheXdhsHmaXF/6uNO5ya9wxPbn66pESxt
l1koX5LbpqE0geRqIuHtWqxOxsRfhTp7TYNB0KRBuMKPMikGZ8zsd2halcf8DVzc
TYf7Iz1T49mUZCAOnzUozlX6DLLFWP1CrelQWBePufBtYUzqdFjNRXmoxMuRSUQP
rJnOFN8EWAokXC8ZCtmqHr/rGZka6+BVpxN7QGPBv2uxrRfEUfh7+JGw72f8BImg
KzYA7hXaR42x+gv+ilqDTe4h7MNy/6tmUzqToba0hIeG4WNCIhzqG+mBp4iBO3n2
yEwq9TSpGdW4uIr0YDQx9mp6hz4jwA==
=CgD8
-----END PGP SIGNATURE-----

--izltdsmj2dkmzuym--

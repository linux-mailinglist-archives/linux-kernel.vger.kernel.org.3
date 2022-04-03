Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30E44F0CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 00:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376554AbiDCW0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 18:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354800AbiDCW0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 18:26:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B429255AA;
        Sun,  3 Apr 2022 15:24:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KWpNR6ybVz4xNp;
        Mon,  4 Apr 2022 08:24:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649024651;
        bh=X+0elBUnL4FHnAItlKbF06a5s4/DKOEOh4RkYvb/qtU=;
        h=Date:From:To:Cc:Subject:From;
        b=ITnk1fpnKuxK/re6qh7pxChzgO61hdQOzLCDDg9+x8PuynBteD+sx6hj0U1+TaY0R
         uNHNp0ANF8Dz/srvd9BOPctQnNQM7Zl2SqFCP167V6ESGNx2pGZ+2uTQcVpeoDXIiu
         SWognNpDP36z7GKNSnY3ju0Yjq61NluZE2FOYDVCUMHx8ANrNajIHmDfj01GlvEc0L
         aRzuag33BepQja+5mCGCJzv66zqFwQiq4/ojiWRnUuqHBWqO8o2p+lTZYornz+wR6M
         66nL35N7k8eN80tPMzSyLrZwEpRxqQkZEQdraQMYwgPRlJLK1Okqd2AhBB2yAIJ9D0
         YwAgHIDw1miZw==
Date:   Mon, 4 Apr 2022 08:24:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Anup Patel <anup.patel@wdc.com>, Anup Patel <anup@brainfault.org>,
        Guo Ren <guoren@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the csky tree with Linus' tree
Message-ID: <20220404082320.1a397088@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ioRQzmm.sSS7OyDiNnd6nRs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ioRQzmm.sSS7OyDiNnd6nRs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the csky tree got a conflict in:

  arch/riscv/configs/rv32_defconfig

between commits:

  d56201d9440d ("riscv: defconfig: enable hugetlbfs option")
  f6e64b66629e ("RISC-V: Enable CPU_IDLE drivers")
  c5179ef1ca0c ("RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt ma=
chine")
  2e7451fb5763 ("RISC-V: Enable profiling by default")
  6f562570b9c5 ("RISC-V: defconfig: Drop redundant SBI HVC and earlycon")

from Linus' tree and commit:

  0f6ffeaeed8f ("riscv: Fixup difference with defconfig")

from the csky tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

I am trying to figure out why all these commits affecting the riscv
architecture have suddenly turned up in the csky tree (and just before
the merge window closed).



--=20
Cheers,
Stephen Rothwell

--Sig_/ioRQzmm.sSS7OyDiNnd6nRs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJKHocACgkQAVBC80lX
0GxYEAf+I/QQyseZMLjRRdnzQgxe50iANpPsbJmKeF1u33Ne40Iy5DY95V2iW2pw
TGEqonNAxS41HqueKYCG8MC1NxJRNlZTmL9T06p+Dqi0F1STRHDksQ7F69d0fvMJ
u3cO0JOYLJZCr+YEVgpL3z/896OzfzQg+VvrtKd2lmFQJKyAHwRPisaCTEq3kBqk
O1ml3mKzB8+Kyamok8RSnEspi/QeZG5/9RCy2FaLJ4aGcMyN/NdF8sF/ml/2ALwG
L91bhUgCqsL58e2/iA7Y51LGDQ9TxpdUGUEso29V9tqFnY9Itep1VxNUO9VGosHN
PQG3yQ2X5/Urea8WD1XToua+RYwCtw==
=dzHr
-----END PGP SIGNATURE-----

--Sig_/ioRQzmm.sSS7OyDiNnd6nRs--

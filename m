Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B4F4D9596
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbiCOHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345578AbiCOHt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:49:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C212AB9;
        Tue, 15 Mar 2022 00:48:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHls46bHmz4xLQ;
        Tue, 15 Mar 2022 18:48:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647330521;
        bh=PjW0biCXKc+qhAUU1W64I2QO1DH1Q3qwwuBjyuH73l0=;
        h=Date:From:To:Cc:Subject:From;
        b=oTNgpjOLSzbXg6giVOWNixTiYAiVltCaD6UUs8oVbDpSvkDOexSujsrODeqNe2rPF
         QQ8tLRtEj4HyEjOxK9gWn05ypDCH0AkkKbDaHnrqoiBOc2QONiEuUu8vdRNZGmCgaA
         6Ub9oXaVz1p1lA4EbXIbVn2CYeJnaqxIHpx/du22bwmOHtQviZ+VTKZrrlnCmV5LG7
         G2YoPb2pbISHNyNY4//RHnPvNLAj/xSG7b2ZzFwyEXhjVrjJrtbrBvumAFLFNHGpS0
         91SdZTBmd2GNrBv/Jvx9M0/brvFwY+HTb0Tv8thlkW9uabdASclLI4pzB0lkYHbWCt
         snZDi5Na7L1jg==
Date:   Tue, 15 Mar 2022 18:48:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Alan Kao <alankao@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the userns tree with the asm-generic
 tree
Message-ID: <20220315184840.506dd8bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D+yOLGB9bBd3vZbGt7X1f2z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D+yOLGB9bBd3vZbGt7X1f2z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the userns tree got conflicts in:

  arch/nds32/include/asm/syscall.h
  arch/nds32/kernel/ptrace.c
  arch/nds32/kernel/signal.c

between commit:

  aec499c75cf8 ("nds32: Remove the architecture")

from the asm-generic tree and commits:

  153474ba1a4a ("ptrace: Create ptrace_report_syscall_{entry,exit} in ptrac=
e.h")
  03248addadf1 ("resume_user_mode: Move to resume_user_mode.h")

from the userns tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/D+yOLGB9bBd3vZbGt7X1f2z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwRNgACgkQAVBC80lX
0GyiYAf8C3TK+RMjoQI/hU4mMA2keWDe+NgKM0pZT13sfLgGarm3kOheRDW52+pX
epFS5BlqufPbF5IjQRr8ZySNnVa1CgLOrvbnTLa9yYBpLEi64DObqoHANR5D/TFp
k3A6ka2MGJBhd+a9qKaXhHPf1ww0MoGCYPTS/9BA0dFtkIdSeg284WRXPpe+o80q
iYL9iHvK0BISk1IG3b3LFDCxV4+j6c0K5Pk9UtNhzL5+l0oonCoVD+zR27UEmrOx
uk0C7XyZj9RoRKfiWUbAlZVLWr/kXZ0HnubYs5XlOh7SKtMK0wz7fPAMyFvqE/nK
s+2Q0sLdP1xBTU5NAPsRStJgaLoYoA==
=2Rid
-----END PGP SIGNATURE-----

--Sig_/D+yOLGB9bBd3vZbGt7X1f2z--

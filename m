Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259584D0922
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbiCGVCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiCGVB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:01:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BCF506E0;
        Mon,  7 Mar 2022 13:01:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KC9q107zbz4xcl;
        Tue,  8 Mar 2022 08:01:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646686861;
        bh=CkSAho3XJU7iOyUDUQPlGZNbUtzr0VBnZQddMlegR/4=;
        h=Date:From:To:Cc:Subject:From;
        b=pL9QPa6p0DqyFxZuocxM/aQRUY5uP5IGhpw5RZOvdt7Yj8+rRzVEkkb3rQ2/9dkpm
         NWcoLeBCDMob9RQdPedLQMJu9ZRE0pgwgfJ76RgM0cK75pFALhxMqlqQloa9X0ZMv8
         LUtwMBXO6i55fywUpTtwapyzq0yayI8W0kfnTQZLzydsxEWdd/c8D9OR1n48FvlZRs
         KbPSTAB21/3d08OJPqnyPx4P2O4kgH3pWjHG+mEcwiDk42WZWlASea3rO6O2miBqna
         TXoACLMxaCkl0L+V4XFa6rdK49zyxBqPSDBU27axGWyMtyU5U2bpLYBffiSFUkd8bO
         tUyiXT3Lrj/bw==
Date:   Tue, 8 Mar 2022 08:01:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Message-ID: <20220308080100.7bee0e45@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Xy1iwReg_B3DSG71kt0uTb/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xy1iwReg_B3DSG71kt0uTb/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  56cb61f70e54 ("media: cx88-mpeg: clear interrupt status register before s=
treaming video")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Xy1iwReg_B3DSG71kt0uTb/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmImcowACgkQAVBC80lX
0GyG0ggApjjlunFvOAvnPi20aL/UbaxXbX593qU3M43yCcKDGW0EUTcFaZM3kYSz
COpYHyoB1mf1zjuE1CfKXwuEUEwpzULtMbIW3ucoevQzvCn5LzmpkcQinloNmzYJ
CoAgijBZng9AvXKJoiDXdz3isJX0RAnOOXdIrYjUx3EVlkSoeiwncGbUzef7TVb/
1mwLjOJMTPG0dV96jjekkwOA5X1sJxzLT0FSdnahmuuyh4yHCmbo4WSJb35QeNgL
yZkGo5tM2jomoO911HkElrRw9OEDtXyYiTuTpbYLju0WRMBUjBhcXwsYmGGIZAXw
z77/bBJHj5NqM6pnHyz+bcTHGX6dUA==
=AMLD
-----END PGP SIGNATURE-----

--Sig_/Xy1iwReg_B3DSG71kt0uTb/--

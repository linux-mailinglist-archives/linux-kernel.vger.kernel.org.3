Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C14D6CF9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 07:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiCLGCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 01:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLGC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 01:02:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E221DFDD5;
        Fri, 11 Mar 2022 22:01:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFscX1lDSz4xLY;
        Sat, 12 Mar 2022 17:01:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647064877;
        bh=41w6y2r5QAjNyF6nZ1jwGIZMskgm+pQ8JahVE8MVD3k=;
        h=Date:From:To:Cc:Subject:From;
        b=HFpHaRNjU2Qhoksp6SORRxS6WOAPu4LEGKoK+NPuCR/1qc7W/OUnaj0ZsldImyTaf
         w9pB1Hcms/VEPeU1Nf4vtSlBC+3X2PBZYLvQb973yVd8cg0Rs5HeiKVNePS4vz5I29
         G104TVQ8I78pMFQcNxo33dCsNvLXHMn9QnF3nsOVmfDzoX1OyT5UAjPTyG7BDgu7iS
         X70Uk86XjT7wGJUp6sFNypx/ivcfHeHXxE7wrU8/01USWbN9YwD8r9E89zV4nUwHgs
         sLm+PHDZYgFhJKVE/r5JUCgOgM9AksvTQ98OKCyXn9oZDW+6qjoPqtAA2aEXiISuma
         Zki8Ji4tjL3yw==
Date:   Sat, 12 Mar 2022 17:01:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20220312170115.6b2c8951@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KikO8NnjhyYlCDxynBsnI5v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KikO8NnjhyYlCDxynBsnI5v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  58ab8f3f37d0 ("tools/objtool: Check for use of the ENQCMD instruction in =
the kernel")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/KikO8NnjhyYlCDxynBsnI5v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIsNysACgkQAVBC80lX
0GwRjggAn6JNsekpeS+6naipzkyhL7U5Lo1gm1r6Vplxtj/9PYr9EH83yTvPF61t
bQtzLGjpkkT2CdusAJzvV4temcbzdZka2EFG/XnQr+0ejMP9gBlQHfhQzC7epwFD
g6DPqEz3Q9eYgFNpDwCx4xhMLsJMzgKDyYyWcNFgKTQbXF0jbSQFEQ6wKFEgj3SA
6qBlBJZH/7ZsPBaB6iE2O09ky9sOK/DWV+YNr3rzeW5Bbv46Kcj+NrGnU4WK4fAU
NClx8H/kDGebyf43hXwY5xBhyaeg5HScZbR1M2IxCdnRKQnoVtCx76wvSLVLx0ZS
ayuywIigeNRvYUdWfxcFTXd3wE/RTg==
=bYaB
-----END PGP SIGNATURE-----

--Sig_/KikO8NnjhyYlCDxynBsnI5v--

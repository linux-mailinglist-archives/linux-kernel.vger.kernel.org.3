Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB67E4E37B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiCVDwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiCVDwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:52:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1E631F;
        Mon, 21 Mar 2022 20:51:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KMyFn3MMyz4xc3;
        Tue, 22 Mar 2022 14:51:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647921069;
        bh=WmtZDWKsmdUvEAhIKxLwwO8UN0TlexArmdJbXO5pm4Y=;
        h=Date:From:To:Cc:Subject:From;
        b=hL57UHxZXDMChAuQKWNdDvmjwjQnyIDYt3sXIB28r2LOsyqKN6CQf0Yq0RSM0/qhE
         ulMokn7sTHbnY0u+nu1ko77tHklGwOx6ski93cK6taefhhZePFDhNlff8FgnsWc9xv
         rs70cq7aQruvp6FS3vcb2cUGHqibcT13kGPsCyMZ5ZhYphdEHzkiOsZgDmx0/oc6Pp
         keQdxQfy8P0fuuz1p2LTeGy02b2fI8e+pMse3XIS98158pAyLdAP7Xbun5CVi4YC+G
         5kMKm8y+bR/b5CtPI0W4hfVJ/POIaz1xM1gGY50+rSmKNwg/do5PIEAcL7j2eWhKu9
         y2803n/wlrEtQ==
Date:   Tue, 22 Mar 2022 14:51:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tip tree
Message-ID: <20220322145108.2878ed64@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lx+4g/ktsC9hxSGiz=8tMvI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lx+4g/ktsC9hxSGiz=8tMvI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
produced these warnings:

WARNING: modpost: EXPORT symbol "device_match_devt" [vmlinux] version ...
Is "device_match_devt" prototyped in <asm/asm-prototypes.h>?

I get thousands like this :-(

I don't know what has done this, but there is a new Kbuild and modpost
change:

  2f35e67f621f ("kbuild: Fixup the IBT kbuild changes")

--=20
Cheers,
Stephen Rothwell

--Sig_/lx+4g/ktsC9hxSGiz=8tMvI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI5R6wACgkQAVBC80lX
0Gw+HggAnP1DWAK94BPAdF4tDv8L6k/774AWzdL1qVrYdQ0yujlHAm7ugc26jQcY
fXFKePsBOZxZ0eRUF8yXYBJXZZtnByTzYV4KsPEpIIuPuSZUBQgtQqGlNcMi7mma
b4WBo+ufs4wynotJPXjbZpzJ0YtpYu+lkbwh7F+C0ZDXlQ23QA8e3V7SbpjZ1vNT
I7A5h3B7fXqnIj8psu2mrpdVtic2WKxhepNdDCF6gscO78HJXlXfzjCHXjw8IxDY
jRnxtv3d9CYEst11yLcAgPKueaYq50DPh2FHKAv4WymYuRXb0GkIdScx53TB0gPy
k34tvoNMpipmKPnxkHe99XhK+WhXug==
=KVQe
-----END PGP SIGNATURE-----

--Sig_/lx+4g/ktsC9hxSGiz=8tMvI--

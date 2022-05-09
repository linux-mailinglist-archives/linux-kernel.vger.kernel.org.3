Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE751F332
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiEIEK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiEIEDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:03:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F211F10CE;
        Sun,  8 May 2022 20:59:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxS8w60j7z4xXS;
        Mon,  9 May 2022 13:59:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652068754;
        bh=K0BtskxGgh2mFMiuNHFadADNgH7vgn0DNay7wcDVbes=;
        h=Date:From:To:Cc:Subject:From;
        b=CmLxqi1TQ7CFJur/NEoClUFa85uiYc6+dT2JF0Iz0MHpA23NcNx4fOV9PSsICUp8H
         X0nSblhEtqMDRFa1wOb25Rif5zsUBJqB21bE54cplR+0Og2qXjx4n6mX9Sj865/NtB
         R08DDgvveBngHflDdssavPnwt+Us/U/sp1IEDRD4X9f62lEubLlDMWZgC80vLlH33K
         goGPpFUE9u1Y/TXiVD9YVRWxNUloz8mWsc4Qmju95jmDCsIjsLCabm40Urw9Rnt7M7
         yfVBTuyQhBBJSL8MxSq9U986RNsCeRUs6YN+MHZsKNoYUai+QNR/4QvTv2z8GysSmg
         AGFLKQJjhhVGA==
Date:   Mon, 9 May 2022 13:59:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sandipan Das <sandipan.das@amd.com>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20220509135910.400c648e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pz=lCNkEJJ0Iz=APFtMFE/a";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pz=lCNkEJJ0Iz=APFtMFE/a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/kvm/cpuid.c

between commit:

  5a1bde46f98b ("kvm: x86/cpuid: Only provide CPUID leaf 0xA if host has ar=
chitectural PMU")

from Linus' tree and commit:

  202c3484768b ("kvm: x86/cpuid: Fix CPUID leaf 0xA")

from the tip tree.

I fixed it up (I (arbitrarily) chose to use the latter) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/pz=lCNkEJJ0Iz=APFtMFE/a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ4kY4ACgkQAVBC80lX
0GzPgwf/a6t+dB7Thxs5OKY5C11H0B+Dygk63nzTIHN4wtgc2KwPVGa0MdoOhgEt
CDqjviyi0pBYH2X8pe9AUb0ZNMxU3PdgH0QxGA41J+Z12DNsu4ptn7gNuFvtAKF4
g9BoYdveCJFqXHmlrB4ValUls0ULWJ76yiyrM7FUrVPS1JQ1sSlnx/pL1nd2Ezvo
D+kH6vCzX6Y0EmL4wm2yfoYJRZtzna5OtIPlz/rCsYskPYryjvj/14HHnrssh2bm
xUzVIJ47pV6QoD47d785t8tycfxadCtFGLq7bE1RmMvDbJDcOPwdQ/JGCY4frsEo
ZV8IDw/8XPP/3O2q9031aWTc+xhSrw==
=C/4q
-----END PGP SIGNATURE-----

--Sig_/pz=lCNkEJJ0Iz=APFtMFE/a--

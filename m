Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E155061E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbiDSB61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiDSB6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:58:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48802E9C4;
        Mon, 18 Apr 2022 18:55:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kj6MX4hDdz4xNl;
        Tue, 19 Apr 2022 11:55:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650333338;
        bh=DXbIa55Wy/Q3nGx/SPf/fBwL+pHFUPSShfZOOhiLSCo=;
        h=Date:From:To:Cc:Subject:From;
        b=VmS7r/jcStB5KCYGzttMloQbfjRE8knnbbn+GMWWwkxWr27Km0RZQB+0sJVXMrfkr
         EqQJw3hXOyZkLsjMKQKxExliaP8pat8A+G6uJ/3ue8M4UjD71JQP/5R+aKbA1E6tZd
         rgjO35KHSC7o1JbC0u3ZlrB/ml1ngjqE2hpCC75XuQiCg42hnBOqPIafW1GRtM+rak
         beaU1a1zwEeuQ1ZhMhH1Q2DQKgTy1h3NQw49Xcj+DJVRfTF1tZFB4QhRgGTDl3yO2u
         RYws7gCJSSGZIgPohPQsGt/Q+AaaHItAs5XmTJbrcVFLR64AvVowITpr3ql3vg6/jy
         jUccgEY753WzA==
Date:   Tue, 19 Apr 2022 11:55:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Borislav Petkov <bp@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: manual merge of the tip tree with the jc_docs tree
Message-ID: <20220419115535.742377e6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BT7HPQP2FC/M2SpREFVN7S2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BT7HPQP2FC/M2SpREFVN7S2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  Documentation/admin-guide/kernel-parameters.txt

between commits:

  d2fc83c149a7 ("Docs/admin: alphabetize some kernel-parameters (part 1)")

from the jc_docs tree and commits:

  f8858b5eff30 ("x86/cpu: Remove "noclflush"")
  1625c833db93 ("x86/cpu: Allow feature bit names from /proc/cpuinfo in cle=
arcpuid=3D")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/admin-guide/kernel-parameters.txt
index 7ca823a3d5ba,269be339d738..000000000000
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@@ -563,20 -563,6 +563,25 @@@
 =20
  	cio_ignore=3D	[S390]
  			See Documentation/s390/common_io.rst for details.
 +
- 	clearcpuid=3DBITNUM[,BITNUM...] [X86]
++	clearcpuid=3DX[,X...] [X86]
 +			Disable CPUID feature X for the kernel. See
 +			arch/x86/include/asm/cpufeatures.h for the valid bit
- 			numbers. Note the Linux specific bits are not necessarily
- 			stable over kernel options, but the vendor specific
++			numbers X. Note the Linux-specific bits are not necessarily
++			stable over kernel options, but the vendor-specific
 +			ones should be.
++			X can also be a string as appearing in the flags: line
++			in /proc/cpuinfo which does not have the above
++			instability issue. However, not all features have names
++			in /proc/cpuinfo.
++			Note that using this option will taint your kernel.
 +			Also note that user programs calling CPUID directly
 +			or using the feature without checking anything
 +			will still see it. This just prevents it from
 +			being used by the kernel or shown in /proc/cpuinfo.
 +			Also note the kernel might malfunction if you disable
 +			some critical bits.
 +
  	clk_ignore_unused
  			[CLK]
  			Prevents the clock framework from automatically gating
@@@ -3463,8 -3444,8 +3468,6 @@@
 =20
  	nocache		[ARM]
 =20
- 	noclflush	[BUGS=3DX86] Don't use the CLFLUSH instruction
 -	delayacct	[KNL] Enable per-task delay accounting
--
  	nodsp		[SH] Disable hardware DSP at boot time.
 =20
  	noefi		Disable EFI runtime services support.

--Sig_/BT7HPQP2FC/M2SpREFVN7S2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJeFpcACgkQAVBC80lX
0Gwt3Qf/Y0xuhRdgYrGPOPLeNKdJh6pU3N7kPs9ph7fHf0XQoX+tVwg4D427s5uh
22+nV9aHclTuaSb31q+ofk9xoPUObybWaTeG0RH1DUgOzuLJxAbSJIqdYJ29ppTL
fI9XxEL2wZnvPk/z1MxZoglPVz9VV1tMfu1Vb2ifnfTRQg4eqrlq4cDXPWBhiWBJ
/ZgmcRrkJ3KfHfeA9WWpz4a/ZNmWazz7xuLFse0aFTTHP1yJYW6UEvOnIOV4ct5R
HGHfTWl9oWiPmX8D/5UhSKu6Rjq7jrQtwcCgFN/lJL6F8uAGCl56lddg5MFk/Pbc
cfKR04Mbi01/Z7rlRMcsqlC4t9ExWQ==
=KIGV
-----END PGP SIGNATURE-----

--Sig_/BT7HPQP2FC/M2SpREFVN7S2--

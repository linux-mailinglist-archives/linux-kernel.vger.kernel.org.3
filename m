Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF904AB44D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiBGFuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351851AbiBGEky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:40:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FC5C043181;
        Sun,  6 Feb 2022 20:40:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JsYNz1HsNz4xcZ;
        Mon,  7 Feb 2022 15:40:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644208851;
        bh=PDkMNGz9lzSvYPAAsjozPtMokUKhqT2nnJaS3aMjUNQ=;
        h=Date:From:To:Cc:Subject:From;
        b=iDHwA+zs11NYDTPW/eWNgXbNE9x9/nqL8MWJBSuvgfD79Co3eVp3fG1/HWmpDRLd5
         zUBOgoth5M5cNG3eTaVp+h3LMApV7O2QG1DqbWrbK1McY1QqpjTF0IFUyQAZIqtMoR
         Wgi3xt/sA3tzP5BmWokJG7uZigCOmrO+kMYaSrv2rzvfqPJJ5gYP1VOY+DD94xunPL
         P/ZL28egOBm8UbnffoBGB9GTo26/2DA5+xzZcK7t2EeA7DHsNhNGy+Hp38dYkV30EG
         jKGUYvwYZJh2rU2xePMacsGBSP8xrW3NOS7H0DRtYlD2EmmvoJwK/y2NJnLP5/y7jl
         vPAAifGHyPGtA==
Date:   Mon, 7 Feb 2022 15:40:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 7
Message-ID: <20220207154050.13d1af27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jVFwx2E0D7Sudvk.Vw=RnML";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jVFwx2E0D7Sudvk.Vw=RnML
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220204:

The folio tree gained a build failure so I used the version from
next-20220204.

Non-merge commits (relative to Linus' tree): 3686
 4056 files changed, 155617 insertions(+), 54888 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386,
arm64, sparc and sparc64 defconfig and htmldocs. And finally, a simple
boot test of the powerpc pseries_le_defconfig kernel in qemu (with and
without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 345 trees (counting Linus' and 93 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

--Sig_/jVFwx2E0D7Sudvk.Vw=RnML
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIAotIACgkQAVBC80lX
0GwNUAgApW2/1Vg+WiSp8fljJDDVmucZylGkbsl0QFRT+L6l5b+hKy5ibIgbcU4B
Z2Axyv+OTJI8so9tGhOH1aIDsS98EQDCvCouskkytBSgV2FSgPuJRWdx1YPSmKBI
pbyVxiZL/2vbESDX3R3oJ3hbBor5khgRSd2lY0q0XpJOEYbToZYVsyskomfPozja
oyDOabD9PKkPPQtWfOfPlAJyS6c8QmzKACumWm6HkKf5tQX5f98/Wkh7tC+cgBAV
bZxC/ulxiuDNMVGiYHsQw4ySQEdiFWWtJMXn6Za4+ESDonsbe7iAiC9MHD04aDhQ
s5FjC4cLV/L5CAEhr8ij3SM/YPy7Pw==
=yP5A
-----END PGP SIGNATURE-----

--Sig_/jVFwx2E0D7Sudvk.Vw=RnML--

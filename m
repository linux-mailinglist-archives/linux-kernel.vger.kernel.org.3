Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4259CFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiHWDyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbiHWDyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:54:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA3B32DAE;
        Mon, 22 Aug 2022 20:54:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MBb2Y6lNcz4x3w;
        Tue, 23 Aug 2022 13:54:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661226870;
        bh=tOg80obzLJyz/HlPXodBDUbz4IxbnV2JBGcDwt1/+TM=;
        h=Date:From:To:Cc:Subject:From;
        b=iK78Bgyq+Aj9KdvR+r6XH2VZ7DKSoJxQxKpccUqRoREotYd2m52vJqE6k3snKjIxD
         NtTA01AB7EBEdE4bP1ne4v9dT/su+S/r3797pkd9ic8MQFSqgD2yOj+GWCC51J4Pjf
         XiqrFXmIE/MG7k9EvKk42w5FtfVQYulh4Jw4VKsyjFUhYXp7ZDT/03BoIsamLeO2Ky
         Qsm9d0Xte5GnIQ1EmNVZdHentLR+mfMm0Bc5buNjG+w2OdwaJYotY4WMdzVqP020l1
         CrQ+HqobPzbSkbRvXxQsUlVcehYNmlvaUagzgK2P7i1NKG+C0Ynt8css7COoCEICNw
         +N3cWC32vjxmA==
Date:   Tue, 23 Aug 2022 13:54:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the mm tree
Message-ID: <20220823135428.021ab1de@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y4y7IeGHv+QWHHmcgg_gmHr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y4y7IeGHv+QWHHmcgg_gmHr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
these warnings:

include/linux/maple_tree.h:230: warning: Function parameter or member '__fl=
ags' not described in 'MTREE_INIT'
include/linux/maple_tree.h:230: warning: Excess function parameter 'flags' =
description in 'MTREE_INIT'
include/linux/maple_tree.h:243: warning: Function parameter or member '__fl=
ags' not described in 'MTREE_INIT_EXT'
include/linux/maple_tree.h:243: warning: Function parameter or member '__lo=
ck' not described in 'MTREE_INIT_EXT'
include/linux/maple_tree.h:243: warning: Excess function parameter 'flags' =
description in 'MTREE_INIT_EXT'
include/linux/maple_tree.h:243: warning: Excess function parameter 'lock' d=
escription in 'MTREE_INIT_EXT'
include/linux/maple_tree.h:523: warning: Function parameter or member '__ma=
s' not described in 'mas_for_each'
include/linux/maple_tree.h:523: warning: Function parameter or member '__en=
try' not described in 'mas_for_each'
include/linux/maple_tree.h:523: warning: Function parameter or member '__ma=
x' not described in 'mas_for_each'
include/linux/maple_tree.h:523: warning: Excess function parameter 'mas' de=
scription in 'mas_for_each'
include/linux/maple_tree.h:523: warning: Excess function parameter 'entry' =
description in 'mas_for_each'
include/linux/maple_tree.h:523: warning: Excess function parameter 'max' de=
scription in 'mas_for_each'
include/linux/maple_tree.h:658: warning: Function parameter or member '__tr=
ee' not described in 'mt_for_each'
include/linux/maple_tree.h:658: warning: Function parameter or member '__en=
try' not described in 'mt_for_each'
include/linux/maple_tree.h:658: warning: Function parameter or member '__in=
dex' not described in 'mt_for_each'
include/linux/maple_tree.h:658: warning: Function parameter or member '__ma=
x' not described in 'mt_for_each'
include/linux/maple_tree.h:658: warning: Excess function parameter 'tree' d=
escription in 'mt_for_each'
include/linux/maple_tree.h:658: warning: Excess function parameter 'entry' =
description in 'mt_for_each'
include/linux/maple_tree.h:658: warning: Excess function parameter 'index' =
description in 'mt_for_each'
include/linux/maple_tree.h:658: warning: Excess function parameter 'max' de=
scription in 'mt_for_each'

Introduced by commit

  96ba2a9525fb ("Maple Tree: add new data structure")

--=20
Cheers,
Stephen Rothwell

--Sig_/Y4y7IeGHv+QWHHmcgg_gmHr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMET3QACgkQAVBC80lX
0GyoTgf/VyNuidNJc+Bka1CkBiMqOK4p5Hv5xaI2jph6XUb5Nbyqf4phkqyPdcBa
WDPriGtlW8JR6shzBJCED81k/YPrrWM3OBah2iGeUmcI1QGdrdbW59DjpeKhVuEJ
mTh52+pAMLnGsYBOZey5upaYeT4FYW3/YKJEJ7dcg36gSKSQi62h3iZ3f/vubfc+
T72TD6Y4pzx7kxsNQ2sulwyDIK4qh6YtfIIB+YdbSIaiFPCmjzAhY74H29JxAWZe
OeEeHrahGgOpPRAfoYZ490WDea65IaeRe94eLNUBiu/XGpYvL7DerB+X2e8uz1c2
BfqBrjvkMKm9J8WuCkpdHUP1ZEv7Wg==
=uOi3
-----END PGP SIGNATURE-----

--Sig_/Y4y7IeGHv+QWHHmcgg_gmHr--

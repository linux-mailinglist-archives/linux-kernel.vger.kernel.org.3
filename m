Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF8856B498
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiGHIkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiGHIkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:40:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53B9814B9;
        Fri,  8 Jul 2022 01:39:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LfRY86xT5z4xD2;
        Fri,  8 Jul 2022 18:39:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657269597;
        bh=W7oRczXqKJ3bTDS/OVxF3kAupvYBCW29Q9o/B8lDUrI=;
        h=Date:From:To:Cc:Subject:From;
        b=iB7/lFPdPPjmwfdeJ0yf1WpilNVobJHZEIKqlIOMxSJeQlshnFzYZX3KbUdQRwVCp
         6A7DR48qJPfUOaraI6QNv6Q2m/Rbhnrh2fjVoBc/41xe/AHl5XFc1KbW7m0qa0Nv4U
         kUVO4oEx2gT8OTaBkFPolXKnodzeBlJJ+q7lhy2BHoZaXC3xezrOvF6HoDQkWHoMFg
         jB+lkXaeoKg/KG8fz0sAlFNer8tcQZBj1DEuIR0X3wyhtvpcloJEw5nWDnXG4gXaTV
         mlBwXD8ew7Iq28fFo9tb5BBT9ezqAy7c8Sz7dwokYI3WaBa7I2MkN5ZwdNdi2T/PGX
         mkCfjxbb6LMrQ==
Date:   Fri, 8 Jul 2022 18:39:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: linux-next: manual merge of the mm-stable tree with the jc_docs
 tree
Message-ID: <20220708183955.34212f5e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tb_uU/FVC3Xmh2SQZmg_1FX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tb_uU/FVC3Xmh2SQZmg_1FX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got conflicts in:

  Documentation/translations/zh_CN/mm/free_page_reporting.rst
  Documentation/translations/zh_CN/mm/frontswap.rst
  Documentation/translations/zh_CN/mm/page_frags.rst
  Documentation/translations/zh_CN/mm/zsmalloc.rst

between commits:

  5fe84fe446d8 ("docs: zh_CN: page_frags.rst: fix a broken reference")
  36395fb365df ("docs: zh_CN/vm: fix a typo for page reporting ReST file")
  97e937dec70d ("docs: zh_CN/vm/zsmalloc.rst: fix a typo")

from the jc_docs tree and commit:

  ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")

from the mm-stable tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/translations/zh_CN/mm/free_page_reporting.rst
index 14336a3aa5f4,83b14cce9adf..000000000000
--- a/Documentation/translations/zh_CN/mm/free_page_reporting.rst
+++ b/Documentation/translations/zh_CN/mm/free_page_reporting.rst
@@@ -1,6 -1,6 +1,6 @@@
  .. include:: ../disclaimer-zh_CN.rst
 =20
- :Original: Documentation/vm/free_page_reporting.rst
 -:Original: Documentation/mm/_free_page_reporting.rst
++:Original: Documentation/mm/free_page_reporting.rst
 =20
  :=E7=BF=BB=E8=AF=91:
 =20
diff --cc Documentation/translations/zh_CN/mm/frontswap.rst
index 98aa6f581ea7,5c18ea2be04f..000000000000
--- a/Documentation/translations/zh_CN/mm/frontswap.rst
+++ b/Documentation/translations/zh_CN/mm/frontswap.rst
@@@ -1,4 -1,4 +1,4 @@@
- :Original: Documentation/vm/free_page_reporting.rst
 -:Original: Documentation/mm/_free_page_reporting.rst
++:Original: Documentation/mm/free_page_reporting.rst
 =20
  :=E7=BF=BB=E8=AF=91:
 =20
diff --cc Documentation/translations/zh_CN/mm/page_frags.rst
index 38ecddb9e1c0,320952ca93af..000000000000
--- a/Documentation/translations/zh_CN/mm/page_frags.rst
+++ b/Documentation/translations/zh_CN/mm/page_frags.rst
@@@ -1,4 -1,4 +1,4 @@@
- :Original: Documentation/vm/page_frags.rst
 -:Original: Documentation/mm/page_frag.rst
++:Original: Documentation/mm/page_frags.rst
 =20
  :=E7=BF=BB=E8=AF=91:
 =20
diff --cc Documentation/translations/zh_CN/mm/zsmalloc.rst
index 45a9b7ab2a51,b5596ea08ae4..000000000000
--- a/Documentation/translations/zh_CN/mm/zsmalloc.rst
+++ b/Documentation/translations/zh_CN/mm/zsmalloc.rst
@@@ -1,4 -1,4 +1,4 @@@
- :Original: Documentation/vm/zsmalloc.rst
 -:Original: Documentation/mm/zs_malloc.rst
++:Original: Documentation/mm/zsmalloc.rst
 =20
  :=E7=BF=BB=E8=AF=91:
 =20

--Sig_/tb_uU/FVC3Xmh2SQZmg_1FX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLH7VsACgkQAVBC80lX
0GxYYwf/UKOwgevNdRGPyiHiQSZBW0W0O+bSqJgyVtfys5SwH2HKjcgnklHdg1S4
1p4GHSmx8PVkL+OjPFvZgK6TENItZkVf2y5EyeCPikuxLl9DOh9SncFMnQSlgbEE
GSMN0igxGKaqZJK1GC69S+odtxyvdjUzZbnWWhPxxoibX4ugTPWXk4DEAsyyoWE/
9VUIVuFKiBpks8FlqZ98giTHPZ9CIgw960s1qIDGG4fkqqfsYl0EqjV70NEBIcId
5AweHEat/o/z2zHgXVOtIudtXKbSUJVGLMveRAXk8rJ8oDJ9mVkNdiAqVau670x9
5yrNAMs2wR7tNh3f8kcmiCSyAZ0MkA==
=NOUX
-----END PGP SIGNATURE-----

--Sig_/tb_uU/FVC3Xmh2SQZmg_1FX--

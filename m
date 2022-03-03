Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980114CB6EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiCCGZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiCCGZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:25:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA24415C9E1;
        Wed,  2 Mar 2022 22:24:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K8LYT3Yp0z4xcq;
        Thu,  3 Mar 2022 17:24:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646288670;
        bh=WjEJD8qPSy1vfpk5bNiCZBfbzfMQ7OUIDYOq4UMLvZs=;
        h=Date:From:To:Cc:Subject:From;
        b=nexB9RKb4nJAsZftjMRV1ZStvrxNHVJYHHaQ/vteI7ntKk7YdsUNCvNd7cvPY9Qwk
         KbaFCVj33/QuiAkbdoXVPlb+kG74JTZZoXEU3468bSjGpEnewemviUM3czcuza2VAJ
         +wAW5cC+2n/2QmubNYinfIw4X1PmIgxDSyLPmLsalA6Xt1YjSY10AUDd57xQiIFBZA
         PlOnZ4YlDBFErqAlJApAGSTHCT3h8vALFoMT/AdcZ6nvC3IGBSOf6X1Za3PKL2qG5t
         TyJwRzhPEQg/9lGoJVs1JRj8KmtLrJ9M1jUuLEiW2ZjTdDBiEbzLEv8SI9mICsTuZP
         TI15qI7GT5G1Q==
Date:   Thu, 3 Mar 2022 17:24:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Alan Kao <alankao@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: linux-next: manual merge of the folio tree with the asm-generic
 tree
Message-ID: <20220303172427.24e17e51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l5ls55R_b9kvOK/4VMNXe0C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l5ls55R_b9kvOK/4VMNXe0C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  arch/nds32/include/asm/pgtable.h

between commit:

  9f15ac318b83 ("nds32: Remove the architecture")

from the asm-generic tree and commit:

  e558a885a525 ("arch: Add pmd_pfn() where it is missing")

from the folio tree.

I fixed it up (I just deleted the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/l5ls55R_b9kvOK/4VMNXe0C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIgXxsACgkQAVBC80lX
0GxG8Qf/Ur78DnlS7j0Rho0+zBqnou0eRhYNwZng2lBwOyfJakbdfQ+7jJKrYIVb
AtN3oJHYkA2FiXEEobCp77j9gKs+IjnSRBEuWlr0NnoXiyriE6wWWMpZgxAyxt7V
47WaTak3KjY99P+McVEz6JltEXN799U4FN2gFX4M9N2KSYlo8c0ouBiIUv4nV9mV
Dn8LXSbj/qQwjaxuaBZU+4PI4gLWWnHo+I0hK/rPV60Qnqtp77wvTyBrNYJUbJ2E
hj1M99IY59shtmusCzLfhLkNEpUEoO6zH4bENhnb5+tbUkDVFW2rEA1ADPn2N1vC
AK2Z2wtnnsqL8GOMi3U2vwE7iTqO+w==
=W3gd
-----END PGP SIGNATURE-----

--Sig_/l5ls55R_b9kvOK/4VMNXe0C--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4F5697BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiGGCC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiGGCCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:02:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF852F031;
        Wed,  6 Jul 2022 19:02:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ldfmq5fYTz4xL4;
        Thu,  7 Jul 2022 12:02:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657159341;
        bh=UwtjIoglRDJEKGedzdm0Ahvx+a41vhCrbpYe2EuiEYw=;
        h=Date:From:To:Cc:Subject:From;
        b=o0Bd03RSQlOUl1QxEGvhTrgpmUnJdnAH7j2M5I8TcnWM/NmHQMDiEMxOsuBtx75hW
         m82hhMRIOD0OHV1iCwrmIzKaAg5YFRbr64TiejWxjnDPQWVG+BzHUb27tdhTgbunga
         rKxZJIGszYZTOi2hjOvZK2rcNj8tK6DdwCYLo/2HUJEQzFeS0q42nbjS3T1F7QZA6K
         5GkiSDAJrY0MaKr8sYj55WqZ4lDGuV7pDSEbJ2tb/JW/5OSGnqbzaX7Cbo4tpgVWNP
         sHmgGuyEQ8Nt5FdX8HnvOP0EGExrgMV5NpM93tBp+cGQmTrQpSiUMp+8xyUKbCCzcn
         WJVyf8xAE2C2Q==
Date:   Thu, 7 Jul 2022 11:31:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Guangbin Huang <huangguangbin2@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: linux-next: manual merge of the crypto tree with the arm-perf,
 arm64 trees
Message-ID: <20220707113110.5d11a098@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0TKCtQGOIzjzWHhqvSaSiPK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0TKCtQGOIzjzWHhqvSaSiPK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the crypto tree got a conflict in:

  MAINTAINERS

between commit:

  66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")

from the arm-perf, arm64 trees and commit:

  ce6330f74b08 ("MAINTAINERS: update HiSilicon ZIP and QM maintainers")

from the crypto tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 027d9a232107,b04fb3324837..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -9069,13 -8936,8 +9069,14 @@@ F:	Documentation/admin-guide/perf/hisi-
  F:	Documentation/admin-guide/perf/hisi-pmu.rst
  F:	drivers/perf/hisilicon
 =20
 +HISILICON HNS3 PMU DRIVER
 +M:	Guangbin Huang <huangguangbin2@huawei.com>
 +S:	Supported
 +F:	Documentation/admin-guide/perf/hns3-pmu.rst
 +F:	drivers/perf/hisilicon/hns3_pmu.c
 +
- HISILICON QM AND ZIP Controller DRIVER
+ HISILICON QM DRIVER
+ M:	Weili Qian <qianweili@huawei.com>
  M:	Zhou Wang <wangzhou1@hisilicon.com>
  L:	linux-crypto@vger.kernel.org
  S:	Maintained

--Sig_/0TKCtQGOIzjzWHhqvSaSiPK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGN14ACgkQAVBC80lX
0GzkhQf9F2NtkvOfFRAwd5K1uneuCbqM/QJl03sWNw2rHzTAF1LHMiDlgjqzAM/y
oqO+iLUDkp5U2NE6cxUovQjLQdzyUdSwjxBXNCgc+FFfYZhBwJ+dCf6EwD0D1RXM
dq+fWKL/gSeI6W+ghhIk102hV0SZQ3J80PvEONLa+rUN/DENG/Qk5V3UJ/l+q4X6
LRyx0Zm2vtS60mDXPvrTyE4HBgSKxF0kzESvkBC0b7yk3Np0JAFpJYXJ98+m9Coi
Qq2RZRhHlzBuL4FmrfYzIK0HqwGK5sEFrvT+2X64MfhmZ4Okdp6+UWRyRQD8cyJH
T/luLClhW+opiYfvmEKpIkdX7h1QlA==
=y/Pe
-----END PGP SIGNATURE-----

--Sig_/0TKCtQGOIzjzWHhqvSaSiPK--

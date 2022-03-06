Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182B64CEDB4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 21:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiCFUdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 15:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiCFUdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 15:33:22 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C06386;
        Sun,  6 Mar 2022 12:32:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBYDT4r6rz4xsk;
        Mon,  7 Mar 2022 07:32:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646598745;
        bh=Y1LnWnzTuiK+qUe2dOaAZFJLdDa/r/dVbAhlbUr1IOU=;
        h=Date:From:To:Cc:Subject:From;
        b=ZHmy8FCQ0kbC6QlhU4xALxzOcohaMRb6ubkkY9g1yqwFbotXxa1mDqjCX8jWEpwT0
         l/PCuGkrbnETvYMUA3TVR3A+FfnDQUJfdi/nis/2ABm9W4XKnMIQCWuI4E2x0dZVuX
         LSb9bEC2rl4a1hDcTG93Exy+2s50bZfeS11JwnvFCwRBOpW2YCMaY7OwfImJ15qoHp
         NcTBeZreIcl8lgAH9tWAAOVa+t4XrHxfNx9WX6nfvbCPv5Oy7nDAXxTsG6anMKhJbd
         jA+rQYMZLJNpyeJsL4BBMuludSGf8iorLsYMZUs9By/egUVyI9spxDFArGzGbk2pDi
         6ZlhTqH2tO/Jg==
Date:   Mon, 7 Mar 2022 07:32:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the iommu tree
Message-ID: <20220307073224.704133ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wPnO2v21jsZ7ne.aNnm1Apr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wPnO2v21jsZ7ne.aNnm1Apr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  71cc6e9b3f17 ("iommu/amd: Remove unused struct fault.devid")
  ff1580d8e352 ("iommu/amd: Clean up function declarations")
  34dbeaf4e950 ("iommu/amd: Call memunmap in error path")

are missing a Signed-off-by from their author.

Vasant Hegde via iommu <iommu@lists.linux-foundation.org> v
Vasant Hegde <vasant.hegde@amd.com>.

--=20
Cheers,
Stephen Rothwell

--Sig_/wPnO2v21jsZ7ne.aNnm1Apr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIlGlgACgkQAVBC80lX
0Gx1xgf/W6+u86gnSaRgzKuACwapP7Ch/I1Er1TWld0CZmZ4ITWShe5nLEAVCWYw
9tQmTYgrh8t3pA2/sGv7boWxaGD8/esT2NfYgzWLdK77qDqREXLBCaUUAl9N8Jy4
QsNyEEeftCY4kwx4zqy5u/XkZldgCPX3Ja0F2dGhkZ5ofxf6Zl7FqEMlNaCSIvPa
sSCyTgTs24bnWgMHBqnCfIftUe472Pyboz140COdVJcYIYWBiHI6imPnJzTL3+t6
6zfwhfC52qXlnxiTVKoo+WSi6dwfAPZsYvFQZca44w/IE0QOQ3mD2rIqVTFWF3iI
AaT7+YMWJ/TA6sxlTjo5EersIfOW1A==
=q+Cf
-----END PGP SIGNATURE-----

--Sig_/wPnO2v21jsZ7ne.aNnm1Apr--

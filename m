Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809384AE747
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbiBICrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiBIAzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:55:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5E5C061576;
        Tue,  8 Feb 2022 16:55:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JthJG6Fn7z4xNq;
        Wed,  9 Feb 2022 11:55:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644368145;
        bh=83yD2kLC+w3eptGbL7E6G+Sn1mmHkgmN/qSn0gBm/oI=;
        h=Date:From:To:Cc:Subject:From;
        b=DT09vSnITqs0AWDzsqGJi1CsytuJ9vXF/qqrStkKuqMxgsQNcskbdw/clELXubWVn
         XArHWJuJDBoHmBU1wFgSIxfH9YmoKmjAAzKr1pnj3noFCzLNW7Lo1MiIJaEKbSBlfP
         oOAwZcNve9+FSOkslo7XhIt8yyxXVqvLpoVxQ8S6UPAizCjMBpHgf5oajhyuDXYYUi
         +c04xps2xP9AOGWdkoJhLW9ZoQxVVGv76oSMMocOeyYPXWytQ1d5ok1ybx5hgaixAE
         DW02zVOYiRn2/G8CApo4qlj1zpbCgdKqxIO2nh387W0oUj/NKbcnHy21jMsBUZ6PXi
         B63Ck6itKOd6A==
Date:   Wed, 9 Feb 2022 11:55:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@linux.ie>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm-intel tree with the drm tree
Message-ID: <20220209115541.59188f6c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bf+rm/HNHrPxt.eFmh_lE3A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bf+rm/HNHrPxt.eFmh_lE3A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  include/linux/dma-buf-map.h

between commit:

  e8c1f36157ce ("dma-buf-map: Fix dot vs comma in example")

from the drm tree and commit:

  7938f4218168 ("dma-buf-map: Rename to iosys-map")

from the drm-intel tree.

I fixed it up (I just removed the file - the changes from the former
commit are only on comments) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/bf+rm/HNHrPxt.eFmh_lE3A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIDEQ0ACgkQAVBC80lX
0Gwjywf7BbS081ztWnj1nzLHN/Tb5Kh1mMDCpgqcxtzJeyRjN9lv+ADnUTDaXZxS
ZqJYDO+hGBzEKex70kUq42aTcqIRzkE1KD+13yaIv/O9WIkhyS1pmuRVEyfd/Nu/
/Elp1jGML3wJR752pGdfF1bEV56vb6Z4vaVJpwjjfZ3CPKu0ns9h5x/Qhr3hs+g7
csn7Gd941ij6ZPDqYj+4/mtYnHf+ST3IzhEIm7r7/+8c9PD1JsBB+hcQTqdNWEcv
I126J8DQ1tNRngSrPStTf6GQ+ujKLweNr01jnHuh6CoX0/EyTHOkKwkwccJRzZH5
JpmzC2vwaj5NcPT/fkD4rISDtuvvhQ==
=7k3s
-----END PGP SIGNATURE-----

--Sig_/bf+rm/HNHrPxt.eFmh_lE3A--

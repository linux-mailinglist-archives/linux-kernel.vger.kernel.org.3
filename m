Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EBB57C8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiGUKLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiGUKLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:11:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E04B4A1;
        Thu, 21 Jul 2022 03:11:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LpSyC06DBz4xD9;
        Thu, 21 Jul 2022 20:10:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658398259;
        bh=sEgdxDtyfRSnTjr22k3su89zLrONxxZN72LRDIbVWz4=;
        h=Date:From:To:Cc:Subject:From;
        b=u3FIEyZhiF8wVDKfx+bhM301sQ59ownFwMK64EQInwf4DNodJgPHj0LnQKjGAF3tH
         soYmTiguiKhqhQSOv/r8ClVtMRnPHHMAuTXMPI37r94aAabQQbhHGGJv8rJddsd8JS
         OH9LywgtmFArHE5TRYheWTRie1A0HVNsk+nkcgc6b/1Ks6Ci2fKiCDfDaX3ukmsc1a
         wRIHshA0ogIaCHoK8qxX7bQuGomsBlJFP+SorNkYdpcWT8MN2f9tR/5fVGPQPoRtCt
         b0XXaw+LNa/q0vX5b394MViPL1O+tdIl38c/fL3DqUGCmXvxIF2cwfoINZ3GUDpVEM
         Fhfxs/gopbvUg==
Date:   Thu, 21 Jul 2022 20:10:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the s390 tree
Message-ID: <20220721201058.2a276286@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FlDX2OqGTG0pA9kWq21S_Za";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FlDX2OqGTG0pA9kWq21S_Za
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the s390 tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/s390/vfio-ap-locking.rst:10: WARNING: Inline emphasis start-s=
tring without end-string.
Documentation/s390/vfio-ap-locking.rst:10: WARNING: Inline emphasis start-s=
tring without end-string.
Documentation/s390/vfio-ap-locking.rst:10: WARNING: Inline emphasis start-s=
tring without end-string.
Documentation/s390/vfio-ap-locking.rst:15: WARNING: Title underline too sho=
rt.

The Matrix Devices Lock (drivers/s390/crypto/vfio_ap_private.h)
--------------------------------------------------------------
Documentation/s390/vfio-ap-locking.rst:22: WARNING: Definition list ends wi=
thout a blank line; unexpected unindent.
Documentation/s390/vfio-ap-locking.rst:38: WARNING: Definition list ends wi=
thout a blank line; unexpected unindent.
Documentation/s390/vfio-ap-locking.rst:56: WARNING: Definition list ends wi=
thout a blank line; unexpected unindent.
Documentation/s390/vfio-ap-locking.rst:92: WARNING: Inline emphasis start-s=
tring without end-string.
Documentation/s390/vfio-ap-locking.rst:92: WARNING: Inline emphasis start-s=
tring without end-string.
Documentation/s390/vfio-ap-locking.rst:95: WARNING: Inline emphasis start-s=
tring without end-string.
Documentation/s390/vfio-ap-locking.rst:99: WARNING: Definition list ends wi=
thout a blank line; unexpected unindent.
Documentation/s390/vfio-ap-locking.rst:101: WARNING: Inline emphasis start-=
string without end-string.
Documentation/s390/vfio-ap-locking.rst: WARNING: document isn't included in=
 any toctree

Introduced by commit

  e32d3827f3d5 ("s390/Docs: new doc describing lock usage by the vfio_ap de=
vice driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/FlDX2OqGTG0pA9kWq21S_Za
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLZJjIACgkQAVBC80lX
0GzUBwgAiyoJNGinR6fM2hN2wFpxcrweFQocgh1GPerMzlyqnGmXNAWk55k1oC3K
VKhu2ctyhOi7NMD3JqKKvHUh7UucayXkgyT1B63lAeHDqV9KWAK2RePcRGRJ+vWS
C3N1648QqEXd0sjrD/J6qh+/HRfkQM4Psm36TRj2XfbgEhthhaRf/mmTjl6UO4dM
gl52zyIv5Ww9P1n86pweBz6i68v4K8gwn/4gHcVd8ZSK6PmnuijOWF3jCNpglNBk
9+0kmI/rOpeaNezShKAlIKznFRbXJvqeZxSHPFzavji3l+bwxnmc0naz3MINwane
mJTj+Pfp5th4dI0Iyj0mxOpuvxUV4A==
=AeYn
-----END PGP SIGNATURE-----

--Sig_/FlDX2OqGTG0pA9kWq21S_Za--

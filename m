Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44257C974
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiGUK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGUK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:59:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CC982F9B;
        Thu, 21 Jul 2022 03:59:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LpV2M0cJwz4xD9;
        Thu, 21 Jul 2022 20:59:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658401179;
        bh=LTZQOvJr8ear+cIoJhpifBjbEikmG63F8Fv6vdFzcEc=;
        h=Date:From:To:Cc:Subject:From;
        b=sxH/PbVaVvc5dlbHNx3kuCg5tZ36O/jig/d/OHVniKeDpVjLfgHLXydL1fShCv0J0
         Wa1GSEZpz3J//1L9y7VgIogOuwsDxw7o4q4Pm01SkNJ26RyliFh0QPoIAokEQ/08/H
         eNy2oykIQ9iGZTui7FRWaeSZVqr7+fWgzGQhMtGhlnDjjw7hS3tOp0ST6bZypPZpD5
         d7Xjet3Ba+Q3Z/LHeWFENEXSokVH+g43q1Oe6yAtnsIYk6cZ3gmUuWPtq2c0lml3el
         oPOFKs6nAoXhdHIkFgzQqJGWeI396DNb0Bf0Ge8oA/dSbkc1J4+wmITVtvfbVlxE/J
         Z3zanhD4bU1UQ==
Date:   Thu, 21 Jul 2022 20:59:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the s390 tree
Message-ID: <20220721205937.10043b5f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QdrUYM_Zcu1KIpvNg68mM1n";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QdrUYM_Zcu1KIpvNg68mM1n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the s390 tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/s390/vfio-ap.rst:684: WARNING: Inline strong start-string wit=
hout end-string.
Documentation/s390/vfio-ap.rst:684: WARNING: Inline emphasis start-string w=
ithout end-string.
Documentation/s390/vfio-ap.rst:943: WARNING: Title underline too short.

Hot plug/unplug support:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Documentation/s390/vfio-ap.rst:943: WARNING: Title underline too short.

Hot plug/unplug support:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Documentation/s390/vfio-ap.rst:965: WARNING: Title underline too short.

Over-provisioning of AP queues for a KVM guest:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Documentation/s390/vfio-ap.rst:965: WARNING: Title underline too short.

Over-provisioning of AP queues for a KVM guest:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Documentation/s390/vfio-ap.rst:998: WARNING: Definition list ends without a=
 blank line; unexpected unindent.
Documentation/s390/vfio-ap.rst:999: WARNING: Definition list ends without a=
 blank line; unexpected unindent.
Documentation/s390/vfio-ap.rst:1038: WARNING: Definition list ends without =
a blank line; unexpected unindent.
Documentation/s390/vfio-ap.rst:1039: WARNING: Definition list ends without =
a blank line; unexpected unindent.

Introduced by commit

  cb269e0aba7c ("s390/vfio-ap: update docs to include dynamic config suppor=
t")

--=20
Cheers,
Stephen Rothwell

--Sig_/QdrUYM_Zcu1KIpvNg68mM1n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLZMZkACgkQAVBC80lX
0GwpwAf+MC6ISS5iUzgGEVRMVkquS9qUui69AP7aW4hL7rPNueIDPcTGva/0+L6/
WPY3WmCtzB6MoAOqTPQ3MeMqShZjSlPR77wv8scz/bNOdhCymBQaODemQ6NEJZi1
jkQ30cMznxj9uUCeqx2tNW9FqB4NWTE4sGmCtq85BU4oPa8grhVC64FDV6sZ5gYG
UZ6XLJtqZ+dGfTZjhp8SjPYOvJChEnnoqadnMcslPs6yg0k8M0bq1GexTuS2O91L
b1FfsA4saIQTUAZr2KrqGslULVGbTQLTYKhMaEeRi+Vg6Z4Yovq3KUeYSPIpOUMZ
/gFwlPPelVlkWk903vOa1YwPsPchAw==
=pxGK
-----END PGP SIGNATURE-----

--Sig_/QdrUYM_Zcu1KIpvNg68mM1n--

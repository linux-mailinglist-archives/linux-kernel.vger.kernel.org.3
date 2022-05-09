Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18BA51F267
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiEIBb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiEIBEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 21:04:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477CD5F72;
        Sun,  8 May 2022 18:00:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxNBr1vj5z4ySV;
        Mon,  9 May 2022 11:00:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652058037;
        bh=bAQNVmL1nelFRnuEjXuv+vl2PGSNpPyNR00TWGEVLk0=;
        h=Date:From:To:Cc:Subject:From;
        b=sR5zqKr+L/S1hGh5q7JU8y7RmUcDtP9NVD3MUFGPQ1MALQVAr9kORycj+Ggk1ny/6
         vXGjnmp2O/DtzypGgnnpzGP/xiJukSL4yp2341pruuaXvvPrEvg67+MIMpev0516ct
         gaGpdpZs/3pG5n3B7/twHt2eCR/2nKDPwp4VK76CoGkJW+/YS+moz2dBAPUrNTa4En
         uC9rx6qN1qnXbJUxcRdt0qZMHClUrJYaOY1tOo9xd1TQFHdutnNW3xYdggtqqvV4JZ
         Bd+ZwyyRZ7Fhk3FbNtKfIQuiCPBKStlBznvV2r3spIc4kVsSxLFwJwNLb6AodhMTlo
         VkTDd1qufvSwA==
Date:   Mon, 9 May 2022 11:00:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>, Greg KH <greg@kroah.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Darren Hart <darren@os.amperecomputing.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the jc_docs tree with the
 driver-core.current tree
Message-ID: <20220509110034.4fab2013@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X6MIx4CIhbdU.b+XL7ghsuN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X6MIx4CIhbdU.b+XL7ghsuN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/process/embargoed-hardware-issues.rst

between commit:

  8bf6e0e3c7de ("Documentation/process: Make groups alphabetical and use ta=
bs consistently")

from the driver-core.current tree and commit:

  ca3d0b5dfc6b ("Documentation/process: Update ARM contact for embargoed ha=
rdware issues")

from the jc_docs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/process/embargoed-hardware-issues.rst
index 98d7bc868f2a,41a2afaaea75..000000000000
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@@ -244,11 -244,10 +244,11 @@@ disclosure of a particular issue, unles
  an involved disclosed party. The current ambassadors list:
 =20
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 -  ARM		Catalin Marinas <catalin.marinas@arm.com>
    AMD		Tom Lendacky <tom.lendacky@amd.com>
 -  IBM Z         Christian Borntraeger <borntraeger@de.ibm.com>
 -  IBM Power     Anton Blanchard <anton@linux.ibm.com>
 +  Ampere	Darren Hart <darren@os.amperecomputing.com>
-   ARM		Grant Likely <grant.likely@arm.com>
++  ARM		Catalin Marinas <catalin.marinas@arm.com>
 +  IBM Power	Anton Blanchard <anton@linux.ibm.com>
 +  IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
    Intel		Tony Luck <tony.luck@intel.com>
    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
 =20

--Sig_/X6MIx4CIhbdU.b+XL7ghsuN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ4Z7IACgkQAVBC80lX
0Gw/owf+PypV8kca5Q4xe/TKAg5fYIM6TKBdruKREMON7ynZuUViYRaTxozBdYzj
2rtyc+P346QZhfznR7hUqHh+LdaafPtf+M9DI0XSsP8RHRSzsktCHkH31CIhhx95
JtIUuTA9FiMMYAHQP++U9GmsURv4dUcmills+KnF2j7VaDRB3Ltep4AmzjsafU32
d0W0l1CmTSkjUQf2YVALcmw8+y++cDaO9Iic08Z+MSGxWVwgQLS6fOBNdu1oBAoj
Q8l+y+qZM8rLFAQ+x5GYtMssYRbqEirUMeMkUku5H0iddJCxbhPYrDsnMXlaNeWh
vJotKcy5O/sKXu6dBhCr1ITSJwMDgw==
=MJi0
-----END PGP SIGNATURE-----

--Sig_/X6MIx4CIhbdU.b+XL7ghsuN--

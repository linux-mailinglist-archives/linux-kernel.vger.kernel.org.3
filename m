Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBCC4CEF3C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 02:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiCGBvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 20:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCGBvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 20:51:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1EB13D2C;
        Sun,  6 Mar 2022 17:50:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBhHd34r8z4xcq;
        Mon,  7 Mar 2022 12:50:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646617839;
        bh=GzweUE785J65O30TfxM1FL3puKNfm/CcW0S4lUR1EeE=;
        h=Date:From:To:Cc:Subject:From;
        b=J5y9wqtQ273aJkssULNGO6ps8hA4CsUszNHlvJ8uhPyYwhvhR0q3/BrJ9+YagS4Vx
         ya1fThlxXCI4MET9YFfWxZOm2yD80sKFs9UmjoDrp0sM57WDRFcqWGdwlFDioiCePk
         oj9DE2kHjr5P2OKYbwhZhfyqucxSHwmnE2d1xyN/nex01HiRism8iX/0J5syfgM80F
         db4O0DVn/l539jTQuw8GERA/S9+oTNCn4qCqLG2yblWT1moHvfZUMWLxXyvQ6bTtOj
         ZtnFdW8No5ofMh8shxChdXV3wK6TReZppE2LUzlyqL9uZEYSUC86q1pF4aGoyonoBH
         66XIYw5L2bpbQ==
Date:   Mon, 7 Mar 2022 12:50:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Borislav Petkov <bp@suse.de>, Fenghua Yu <fenghua.yu@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: linux-next: manual merge of the tip tree with the iommu tree
Message-ID: <20220307125036.5aeaabc8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vs2G3HgUb9iRiWJWBj+YwHx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vs2G3HgUb9iRiWJWBj+YwHx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/iommu/intel/iommu.c

between commit:

  241469685d8d ("iommu/vt-d: Remove aux-domain related callbacks")

from the iommu tree and commit:

  701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and fr=
ee it on mm exit")

from the tip tree.

I fixed it up (I used the former since it removed the functions modified
by the latter) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Vs2G3HgUb9iRiWJWBj+YwHx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIlZOwACgkQAVBC80lX
0Gx8CAf9EIEemBIo73Jx5WzmmhTMkYRuxWciWvMapYVwJb4IfDm4FskXgRYDvXBl
QFtrJwxc1pd2xUYNJMIxfcHBge8fW6zQXnJAltYkz4zkmMT1WW+Andg2AOJDV+wY
in/crBCUCedTz0GWWMDBhws+jB7fhKyvHm4t30Gg+Fkn/EBzxUB4xg7I1SVTIhTT
GcuUVjF/LQ5yV9EbYHkLD/OEPVY837v3ZockPoN4+gjm7lU4/mODq9iEvGzQhyck
MIiuPAK8eIdmK7inWZnoC5U74CfFkQlQYds/kfkNHxM39CTxU1jjev1byTWmmIi9
6xybaWn7q+/TPxksA3DPJodMDUKDYQ==
=X6VP
-----END PGP SIGNATURE-----

--Sig_/Vs2G3HgUb9iRiWJWBj+YwHx--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D4C5169A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 05:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357274AbiEBDuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiEBDuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:50:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E366F4E3AD;
        Sun,  1 May 2022 20:46:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ks8CP4kgGz4ySt;
        Mon,  2 May 2022 13:46:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651463186;
        bh=DmSduLjo8at0fNn2LOdFmpFx0UqJcMIFmirLxanyDgQ=;
        h=Date:From:To:Cc:Subject:From;
        b=cqIKMBEZ4kT+BAhTB8x75sVjRR7GyUyfWzDBf7j5Auoo0QT9l80H+IWEWsHivRnY/
         ld2Af3jErz4PtZvMNsB2L1M8exco97KP97dQFdurj3jZmDB8PoiLupscsc1onGzBZc
         mEEzNcRH/47dTl+1V8vxRoTTD77zVKvc7yh5ZOcDFZHswUiYDPX4moRDXoFa43w6Jn
         8DqRN6myr1NYFosGeDl4uHeig0/36D543xiH7ZsW14FHtiuX0lf3zzNxONOobcYsCi
         IrDcZ0yHcRyYmYRxegPXd4cJMOX4InPAbM6scYTVZKjsviPKPIv3Ee2vFhZ1NZY7bS
         S1KWPoWJqhrbQ==
Date:   Mon, 2 May 2022 13:46:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: linux-next: manual merge of the iommu tree with the dma-mapping
 tree
Message-ID: <20220502134624.76a88cff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7GZ7tWIWZ_rgS1FrWCEH6AY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7GZ7tWIWZ_rgS1FrWCEH6AY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommu tree got a conflict in:

  drivers/iommu/amd/iommu.c

between commit:

  78013eaadf69 ("x86: remove the IOMMU table infrastructure")

from the dma-mapping tree and commit:

  121660bba631 ("iommu/amd: Enable swiotlb in all cases")

from the iommu tree.

I fixed it up (the latter removed the code modified by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/7GZ7tWIWZ_rgS1FrWCEH6AY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvVBAACgkQAVBC80lX
0Gx+awf/WqWsSl3QqzaIQybbjAoE0rFK29ObGI7FQEgM/lPzdNyvhROgv+pBijfK
sC3WhxSmgNhkQA7LBLaOCwA0I/ZnWRj2Cz/ZLJRFwRHyj7qALGidPFbUPfztUN3S
1mzMlLdd9mJUs+BbDQyUXBNA2JmKUWfMQLQFHlJjeqON0/iPuMjOOIqq3Mm3WgeJ
EGICfEyPCJ0g2WDb8U5uAGYTe5vdTy9EfUipESJV0k28uouRHSOL/MmVHDpt3sJQ
SOqW0GuQEEj3cjnmDGoO8UyxSRG0dZpKR6UxcKCbs2YF3DnNe/R9FReD2/zFAide
nMaJadfGabk2k+bCqmOoDgKOh0h1aQ==
=F/hy
-----END PGP SIGNATURE-----

--Sig_/7GZ7tWIWZ_rgS1FrWCEH6AY--

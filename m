Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B96655B45D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiFZWlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiFZWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:41:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB0F2ACF;
        Sun, 26 Jun 2022 15:41:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LWQnS569Dz4xDH;
        Mon, 27 Jun 2022 08:41:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656283276;
        bh=v0M0/nb6YdMx4nugtyCRHV2oZo4XfWKPM1RTmB3XRuc=;
        h=Date:From:To:Cc:Subject:From;
        b=lX+qlPMxpTptuaFDqiOAohJMfeB6EmrhhpPQH/733TsFZJPpCKRozkyHKwSDI+8N0
         bJYWHHAaY5BTVqAKmVxJAB2oK59N6ZeTVpu8XC4e0qixc1yNfBgWEruJQvWicHmrRl
         YvxIB8nvW4Hx4QsgjAtYt6eSBPnFJqliaaeFggY9AQdUBUJwxlTp/lGTE7jOoLbo10
         m9fFOgxSpiWbJmtCco3li3kagUNEdQ8PoLG+w7Y26FpwHvjXoKDjLuqgyG1nMRr6RY
         NW3pd66BhV3MR8Qnp80YARxIs4BF6E/ksJ8wURZ/Q8ieIoLlfav/2xbzpLlTQAEoXC
         s7NoJAHE5RwYQ==
Date:   Mon, 27 Jun 2022 08:41:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the iommu tree
Message-ID: <20220627084115.559a257f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XFzdjH5IlC.vLRq6PnFL5/I";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XFzdjH5IlC.vLRq6PnFL5/I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  145c15624f39 ("iommu/amd: Update amd_iommu_fault structure to include PCI=
 seg ID")
  58f1c71a0e84 ("iommu/amd: Update device_state structure to include PCI se=
g ID")
  964d21a7654c ("iommu/amd: Print PCI segment ID in error log messages")
  58e5ca96cb16 ("iommu/amd: Flush upto last_bdf only")
  5a903a691117 ("iommu/amd: Convert to use per PCI segment rlookup_table")
  a0eedb5738c3 ("iommu/amd: Convert to use per PCI segment irq_lookup_table=
")
  f1bd29bde636 ("iommu/amd: Introduce per PCI segment rlookup table size")
  d59145a5e129 ("iommu/amd: Introduce per PCI segment alias table size")
  ad967e9639e3 ("iommu/amd: Introduce per PCI segment device table size")
  89e9f3d6219d ("iommu/amd: Introduce per PCI segment last_bdf")
  e202b39618b3 ("iommu/amd: Introduce per PCI segment unity map list")
  a42d9be7f4e9 ("iommu/amd: Introduce per PCI segment dev_data_list")
  65ad39268837 ("iommu/amd: Introduce per PCI segment irq_lookup_table")
  ec6f20c037c8 ("iommu/amd: Introduce pci segment structure")
  98496c13a2b6 ("iommu/amd: Update struct iommu_dev_data definition")

are missing a Signed-off-by from their authors.

What is really happening here is that the iommu@lists.linux-foundation.org
mailing list is changing the From: header in the email submissions.
The solution is to either use th Reply-To: header for these mails, get
an off list copy of the patch, or make sure that all patch submissions
to that list have a From: line at eth start of the body.

--=20
Cheers,
Stephen Rothwell

--Sig_/XFzdjH5IlC.vLRq6PnFL5/I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK44IsACgkQAVBC80lX
0GwxJQf+Mp94gqA8MsYludSJbMcQYnqIM3tyBgx+XUP1lMfHUBBypfGka642XnUo
mWyayygkYYHwoHFvLE64xkfUHkQcljurrdB2w4tTPeK0JwDmerb3B9DR4lVmW7K3
NgS/+nP0PdfQVLvQTu8M4GugbnMN/M9ZuiLMNxACQypEdfBwRe8d7Cj81OLubbPv
nlO7rQcvW8bGADlOh4LZEERRqMLIfgX3vNt4GI+Oa6fUn4geihTlm2fWrbHEH+W2
bnZBSS4QFYn39zgS1/SUZOxkMjnXsZnEfve1ahsGUm5HC10osApQkiA+51JCruY4
kWh7c7s23YwPOmI/lKnoecYelr4BUw==
=VAMY
-----END PGP SIGNATURE-----

--Sig_/XFzdjH5IlC.vLRq6PnFL5/I--

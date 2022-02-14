Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04A4B404F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiBND3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:29:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiBND3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:29:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B415555487;
        Sun, 13 Feb 2022 19:29:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JxqTZ23tlz4xQp;
        Mon, 14 Feb 2022 14:29:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644809379;
        bh=icM+9Xu69fBIx/89EewjmfGendiahiG7T3/u5TE2rqg=;
        h=Date:From:To:Cc:Subject:From;
        b=cEz1MfXBSgoRhz3dOhD72kHtNaOLArkY7YrYmU1ORalKQrsZqpdb/p4Oarp0Z5r/h
         BUZG7EMVCoFmPuzPMBE0xsmr+P8PZMG3G25xPdys+E27AhGIPvo5/luBIqn/su/1Zw
         kAJUlJCA0wekk3MAc67Wi/PZu/OhfiVlDp+hWfW9sVLRjFZXsm6EGeRnvsfz/pkyGu
         XJEnO+NvinGUcpPrNAs5iAnzH0FSoID5mzcl17CI/Bzay0BCLJeIYuzLU0m2piWPb5
         2WuNfHhN4bAZ5flITqmxjaoCL3s5KghoHUyhtnKAkUzuJSRg75EwvSgbzAXblKXu06
         mBkAa5IkBIglA==
Date:   Mon, 14 Feb 2022 14:29:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Ajish Koshy <Ajish.Koshy@microchip.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Viswas G <Viswas.G@microchip.com>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20220214142936.41bd3e7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xQ5Ke=WuXxsG1cQ003LFOS0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xQ5Ke=WuXxsG1cQ003LFOS0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got conflicts in:

  drivers/scsi/pm8001/pm8001_hwi.c
  drivers/scsi/pm8001/pm80xx_hwi.c

between commit:

  c26b85ea1636 ("scsi: pm80xx: Fix double completion for SATA devices")

from Linus' tree and commit:

  26fc0ea74fcb ("scsi: libsas: Drop SAS_TASK_AT_INITIATOR")

from the scsi-mkp tree.

I fixed it up (the former removed the code modified by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/xQ5Ke=WuXxsG1cQ003LFOS0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIJzKAACgkQAVBC80lX
0GzJMwf9GthKj+KbjLjtI1SABGJ36+LZysPXU1k702dMXPWS7jQISXnfO/G2iDTH
x8BOcK5HeV1Goz+FzBWBu1cj+jC7ikATkNnGnletmvf3WsZUP82SxemaKh5HyFM8
Z4p9TlnrSV9W7F6Jtvum4Z8bvxpbQgMzgF55f8Rbd/EzklaEAzVlh8Ebh2KVJW2+
SwQ4nUWgJihYarn7lhXdraUv8NJvD5I0Xvawsf/VT8749ZOReaCufg2dVZUdMVST
hzvIMsaOm+7C72mkUb6mtzzuAvSJUp6c+716zlhoKLoFZh1PL2IZgODRIr7s9mB+
dGcZNuJeRb1ZA87wiH8F6cbfQbqByQ==
=bx/o
-----END PGP SIGNATURE-----

--Sig_/xQ5Ke=WuXxsG1cQ003LFOS0--

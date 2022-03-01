Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C934C815D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiCADAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiCADA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:00:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A826AF9;
        Mon, 28 Feb 2022 18:59:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K72636QfBz4xNq;
        Tue,  1 Mar 2022 13:59:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646103580;
        bh=7Q2XxiuZh4OAN5ROShBZBuzoqEVD2Wz8f+6nQEryq9o=;
        h=Date:From:To:Cc:Subject:From;
        b=EkdwkwRV1IMzOAMxVyfbQiZTPJP8X8DUM+A4GLC4QllAn4d+UU2jJ+tODJ2CR1Ea7
         Dvhi5WFJc+CG6Tj4XhGLAJTh8twCgviEZgrorb+ndwwcA/G1FfiXt9JFTRWiA7qwDx
         gfamZKfxL6NYzyJOkhaiuaoeE+XGWno5rdKO/te1Xl9/xZBMbwtiaB/5jWyj9C3MKB
         WLL4nxpJ7aLHtfApG5PaB/qR9y6Xdu58uevo/xuy2f79rSg2S+QBxQ6g1310eh701n
         jkxb5359kYiYLteUrdZBmsvcncyWawzZ1qQNoMAcxvILie+1In2v6dVR2PGAkaQpc1
         zFkLCMRJ15gNA==
Date:   Tue, 1 Mar 2022 13:59:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the pci tree
Message-ID: <20220301135938.4c664beb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yCqVUdJx51gXcqyEHmXRtB6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yCqVUdJx51gXcqyEHmXRtB6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pci tree, today's linux-next build (htmldocs) produced
these warnings:

Error: Cannot open file drivers/gpu/vga/vgaarb.c
Error: Cannot open file drivers/gpu/vga/vgaarb.c

Introduced by commit

  d6e1898bfa5b ("PCI/VGA: Move vgaarb to drivers/pci")

The reference in Documentation/gpu/vgaarbiter.rst needs to be updated.

--=20
Cheers,
Stephen Rothwell

--Sig_/yCqVUdJx51gXcqyEHmXRtB6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIdjBoACgkQAVBC80lX
0Gz3Uwf+ONzu1pGFSZr88/B5tdYtLKe1Wy5B72hNW7jJkdAfklms6rDgC0DG4P/r
HIRCgradmq+786W5UJkG2dbH+AbesmxNo8E/AuUDvgz9xDWLRqAYdsbhF1bRF+nm
J200tSv4AIgb9OS/cIaQ5X0eW49JQPDEfuWUNz1ZekjbFJXosZpGstuiYRHIakcP
7wz4zk5OICts/5XYCUZilB36MRVLmwzkLidc3L/R4PjfedS9QyDxSMlZbsdzpSul
IvY4AhfqbgVLyzKIQ8N+2AjI+L5c2Q7xddh/Lr4xK/olhrmRXS3/4ZW+ONuePzee
FVO6Z4kBS3AN5lp9aumbvAu0JbC/Iw==
=X93b
-----END PGP SIGNATURE-----

--Sig_/yCqVUdJx51gXcqyEHmXRtB6--

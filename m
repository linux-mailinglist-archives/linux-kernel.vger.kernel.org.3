Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8A552F62
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiFUKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiFUKCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:02:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469027FDA;
        Tue, 21 Jun 2022 03:02:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LS2BN2MZwz4xLT;
        Tue, 21 Jun 2022 20:02:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655805756;
        bh=yI1nhbgiGULXHG6ktjTd6dVCnSmD0glHSc/BjsjUH2Y=;
        h=Date:From:To:Cc:Subject:From;
        b=h5E3WbYFRBS/I/ZAivuQvEe2mrUHeXV1GN8mwkxIOr1Kte5q0273z1qgZqOfkgNyU
         FIiJ8FoKPq9GVpuYBOcLIWi0BRhdHHzLZTHjkG77v01t6/mJ3YXozmLoS9qdbbnSV3
         ts6WGrJ0Y3KBfxlFIE1J+wU/IP7EAcE+acJBtHDc2NrLs8SlKwT3mDfpuzLXHxhU4U
         j3y0b866EYbhJV1uziCmqS2q6FIhQ4sVh8TMzL1Ih9a7Uh0tTzVLz7uC/7zzDTQcAF
         KgmT4XGpn5a8Z14Ta3HM6Egz/HYbaUSeQWGUwsAuGX9f5sjIPZcqNnvO3VVMol+ag0
         ZUsz1dwp/etvg==
Date:   Tue, 21 Jun 2022 20:02:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jon Mason <jdmason@kudzu.us>,
        NTB Mailing List <linux-ntb@googlegroups.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the ntb tree
Message-ID: <20220621200235.211b2e32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.5078yDMVPMkgCCqMwrC=L8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.5078yDMVPMkgCCqMwrC=L8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ntb tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/PCI/endpoint/pci-vntb-function.rst:82: WARNING: Unexpected in=
dentation.
Documentation/PCI/endpoint/pci-vntb-howto.rst:131: WARNING: Title underline=
 too short.

lspci Output at Host side
------------------------

Introduced by commit

  0c4b285d9636 ("Documentation: PCI: Add specification for the PCI vNTB fun=
ction device")

--=20
Cheers,
Stephen Rothwell

--Sig_/.5078yDMVPMkgCCqMwrC=L8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKxlzsACgkQAVBC80lX
0Gy1ZwgAm/G2qqSAbJxvxWnUavKdaFiwzQnOiIg4b6CZZRnOY+xSHP4Fl2k/hef6
PCIOgsNSmTNzSu05FNgHlE4cCfOPHw0QIW1nMyS7FYYB60G19br3Y+IKwcKZZ937
A4C0FgOCsyfqdyTzpJfyyh/KQVpNi3C8fasMs0GCtVqNoxCVsqziPYyhYwKZ3ccP
3/ibSmOtzzD9UQr2lqwepnDfIA3dPm4Hdr9T7ysibsB7WPqHIm2Bn1w/G62NamGz
uKSYocMbOwd+RwGUGFXFUVMVyav+Dm+DBdke6R8d9WGodXE97Q00GkKw0Pxsh8ac
LZYm4qjKSUmUHdDjf4ZuwxnYkGysag==
=2Ikt
-----END PGP SIGNATURE-----

--Sig_/.5078yDMVPMkgCCqMwrC=L8--

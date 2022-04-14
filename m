Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31788500A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbiDNJoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbiDNJol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:44:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF54570924;
        Thu, 14 Apr 2022 02:42:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KfDyG6NDFz4xLV;
        Thu, 14 Apr 2022 19:42:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649929334;
        bh=lRx34qBuvMl/QwxAOzwStVTgOQMc7IKx8eRjUzLWPYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cOyEAoRAUfyNQEhhyEINpvRLuVAB6X+WqhKjN5XVKVL/aJjhAQsZWET7262BeYHD2
         T/4kRkWT9lAClHdKKtenULVVkYwSFvEIFD8qkFipL6d5GTzOIGiEllZ1ELoyTyOk6C
         A5x/3HGnVtta4UxDi1gv4F1VcEc0pi3GCjdhEZ1O9dHcM8keMfytjYYCdOFFMolkKa
         DvaH1JXRZoqAG4c7Y3b/5qPGHKdmWIYD1lzD9Ny8eiXgM6ZvPfjBElXM+budUsp9vv
         JSZCsXXZKHAPPyOLCKf03OEsryRvx1Tdgve1oMr/g2sPF67cIG5sIkQ87Mp6a99O+s
         u1Taw2p940fYQ==
Date:   Thu, 14 Apr 2022 19:42:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Apr 14
Message-ID: <20220414194214.2a8583ef@canb.auug.org.au>
In-Reply-To: <20220414152510.0f61f29d@canb.auug.org.au>
References: <20220414152510.0f61f29d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QW.hMuZsmhr.HJ.sv4.k_3t";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QW.hMuZsmhr.HJ.sv4.k_3t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I forgot to mention that there will be no linux-next release tomorrow
or on Monday.

--=20
Cheers,
Stephen Rothwell

--Sig_/QW.hMuZsmhr.HJ.sv4.k_3t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJX7HYACgkQAVBC80lX
0GxoHAf9GZ+pWO2ZWkP8yibcElOHEhhLvsl3C7K1fJh6GceqN69DRBFcshcdxm5f
gh2H0xVs2DGcPgQ2iiI9yxM5Xgpo1WZV26CTYlmXcsgiWa1PewO7a9cxCrDzveVR
r/WXffcnyyzXLVPLpTq41ebt6MXH6elFOHcCBwvA9iLOb/mQNRJVYPLQrn2qI1SH
ns8GT6xPbGkhiwcTQ8W9IQiXMJqA4xRN+51rugbJo68pzTOJJdWHSXb79ErDgd7T
qtgFiVwSSrt+BWoww0C75xcZ7L9ejp0Cme/S6FH98PXa/1ky1SztcZWkqvsMjGLo
OW/Wv8FXTEzX/qzSU+n2gmz9IOz90Q==
=W+Jz
-----END PGP SIGNATURE-----

--Sig_/QW.hMuZsmhr.HJ.sv4.k_3t--

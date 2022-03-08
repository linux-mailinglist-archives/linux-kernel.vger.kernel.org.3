Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F994D234E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350339AbiCHV2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiCHV2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:28:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8091650E24;
        Tue,  8 Mar 2022 13:27:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCpLx6tB4z4xvf;
        Wed,  9 Mar 2022 08:27:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646774842;
        bh=ia+02u8yOr5U8LQBep995wZ05xzApNtG0GaoeZIXo58=;
        h=Date:From:To:Cc:Subject:From;
        b=MZcDn6v0WbX/oe7qFUNPcoHgyxStErU913bGaCK/DWAI1KMjWmjZNXl/0DL12zUP3
         hUNhSfRYaA135o3y47DHXs6L4ZPWxvGIfxlnglUzuD83WSYJW0YcD+3/J703kM12hM
         8sziDXF2+hscn1W3tDEc4UJy3IAnF8v/JIjx9eg4qwodENxG2DESlcz4JzojBlQNpE
         0hyI7a+ffdTSce9dz0tWaXCcJfIJnp1eww3t+MIGE4hGcX4AlfQKlj4NLEdXHqkmrY
         mqywD+vjGMRxmDVJvxB3QYSKckPFd2QEnEwI55yW7fPXw6HgTsMVoqFIFRLrRVP5aU
         agmSDVY6ZrQzg==
Date:   Wed, 9 Mar 2022 08:27:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Jamie Iles <quic_jiles@quicinc.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the i3c tree
Message-ID: <20220309082720.0f32c2f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0X/m=y4_gDCH5tBniudRhG8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0X/m=y4_gDCH5tBniudRhG8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6f5bad3d6960 ("i3c: fix uninitialized variable use in i2c setup")

Fixes tag

  Fixes: 97a82882d852 ("i3c: remove i2c board info from i2c_dev_desc")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 31b9887c7258 ("i3c: remove i2c board info from i2c_dev_desc")

--=20
Cheers,
Stephen Rothwell

--Sig_/0X/m=y4_gDCH5tBniudRhG8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmInyjgACgkQAVBC80lX
0GzTeQf4+8h7GXc1W9dZpInPj5h/plx93nB75S13uoM2rYVSVNfPGJxy/jvxRrM0
syI6+QNWpROELLVxhpg47bxrwJhR8tlZZX736NRDhYBOO9bQGIwo4EcgwZ4OQDYl
67YLtpXLXYUG2wxM4fsPSUXxlwS6fHE5DnP2kfToMGfUm1UGvgEkVPktiBKiFTe7
N2EQYUrZtvNlKCItOC1gLwEtbbApN/SPLo+20rUJ8Xqrf0alFu6QEjwc9XqEi6nj
RShNKxBXwsUxsW+QJRV5D4H8r/u2nzPRUS9UsdgraxoUjpS3DyyrRzg6fwS1rZHR
aVZX0Em8ETelgl9f4FcHAV9FcEEX
=E5aP
-----END PGP SIGNATURE-----

--Sig_/0X/m=y4_gDCH5tBniudRhG8--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB44EE2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbiCaUzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiCaUzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:55:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A8143455;
        Thu, 31 Mar 2022 13:53:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KTwWQ0mWGz4xXx;
        Fri,  1 Apr 2022 07:53:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648760018;
        bh=4Nsex74KCP11NRR2YSLFOgDVkQpplJAetQ7co/ZS+bQ=;
        h=Date:From:To:Cc:Subject:From;
        b=cmBWn4czkyXksLx9dX3ah2bMZ6ZdBvroOBU0LVXYnByS6oJPebVjZamZTjRkUm0Ah
         Sn68Nbye8IEM/xw0WSrLSUb02foGO/F/dXhFZhV0IgMLHuSonPRkZGAMt2Sm0hM6cr
         GNRq1KnxpaxMQ60v8DyXrV+5WUKF/Q13yoXO8Aya+F1DRJGmP+xUxXj/7Jk9tWmMv1
         n17t8MUt4njH1vV7Yu/w4vgu9ouX82gSMD5dRo89Vgy+iWj0rdipBE8sNyt8757H9M
         0yDIY2Oaws1RQfg05IKoVcwODVkWvULQ6Sh8ucOmyYEm0yGN4IIDhYF9uM0Go/5Ke9
         3mcJ02t2j70Ig==
Date:   Fri, 1 Apr 2022 07:53:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the dma-mapping tree
Message-ID: <20220401075336.2789d430@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wZ6xbqvbvwsQl6nTiUTZIK0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wZ6xbqvbvwsQl6nTiUTZIK0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bc29832b74e0 ("dma-mapping: move pgprot_decrypted out of dma_pgprot")

Fixes tag

  Fixes: 5ff79fddf0ef ("dma-mapping: remove CONFIG_DMA_REMAP")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")

--=20
Cheers,
Stephen Rothwell

--Sig_/wZ6xbqvbvwsQl6nTiUTZIK0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJGFNAACgkQAVBC80lX
0Gwizgf+P6Iq79IfSyvmSzeSs2QJh6mYjKA/jV7BxX38tc/7hb58Gnf45hy2fq7Y
YmEjUyaaCSjveVaW5bddzHnKYY3HW3PM9Ga1DAi+B/swJAELd4IqFYJiSvGdDoay
aKixZ4GexZYI5dYMSqAMkGem44x8WvBdRz4ngIYmEwgQVOzdK9UVAaJ1L+0pWJ8I
1AY7huXVvYvvkV5b6vXOqM0zoP8J68O0XKxARe2YKGHkjQND1hgcdtF9Hyldp2MD
JJC9o9qcx1RjBff0KdgB7KWfyzgDfgPzZAk4ZBLgUYHPeSooWRcspk4jdrCW7py0
7v0+tCiigB9bk3laKZbhjioVSWfSHw==
=1d5T
-----END PGP SIGNATURE-----

--Sig_/wZ6xbqvbvwsQl6nTiUTZIK0--

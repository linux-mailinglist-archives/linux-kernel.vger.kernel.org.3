Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3B500141
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiDMVia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiDMVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:38:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA53756766;
        Wed, 13 Apr 2022 14:36:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KdwrM0xVSz4xLQ;
        Thu, 14 Apr 2022 07:36:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649885763;
        bh=ZouU6rewlC+yIobTQWAYs+7V/rbKE1/eYRPFG+Vw82c=;
        h=Date:From:To:Cc:Subject:From;
        b=uEm8vtGcpfWGE4qoKCXxje8UkLrJcT17tUtW+mGuDXWGmb+1omYvWEUMtm9TEc9nj
         MbfPA4hoPaI8POqKvmW+yGzrO9KqM5aLohGphyZ7doMPSxkrmZPeuJr1IJqkjzeSd/
         g8FMo5bmmXnh4e4t0fEfTLjXLumw8XoefMLgfocvJJxpPuBXhhGYLWG6KYUBEgPeAz
         VTTSuwssZzmCowNSe5Np6j56NtGP3J2l7Km5joSC8KumWWl4fflD1PipvAwwdlqtSt
         eCwNpTpRS6T5uUdoy7pe7gU/QR20G7A9C1bTuycU9T7A4O9m3v5CagZLonHXHtGGOV
         7gj0nENsn68lQ==
Date:   Thu, 14 Apr 2022 07:36:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the dma-mapping
 tree
Message-ID: <20220414073601.397a5f46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AyKgThELA3l3Qoth./bsbI8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AyKgThELA3l3Qoth./bsbI8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  726f1e25c93b ("dma-direct: avoid redundant memory sync for swiotlb")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/AyKgThELA3l3Qoth./bsbI8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJXQkEACgkQAVBC80lX
0Gz2Dgf9E3Oa7Vq2/CnT+HSXmXmgPWv96DpZxZoD0mtHJKZV+FcAzu5RSCMk+pNe
vM2Sljjoz2/ajJXLub8UwUZ7g9GP/+uOYFpaDaulBza+6wSufDrrK7MBLmYtBbtn
FWnnDt3AIbuopamf/QpWvA4GtOG/cjpruraHp8Yhdv+q1h5fF6s1qH1sEn2vbzqz
zQfA6/brL9swNJ6CeUDwkVokbsmNUA7q9SaRt8zeyCHyb+U5RXHHkcgWI13hpxdz
lzc0zhTKaOZLrniFKYVu0MOstFfTjOH3tV97J0vqanpNpCLlJh3d5VC6XcijnxHk
msS370Zb9ItdoW6VtThh5qDfs2GfkQ==
=itzc
-----END PGP SIGNATURE-----

--Sig_/AyKgThELA3l3Qoth./bsbI8--

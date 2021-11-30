Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4773D463F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbhK3Uem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:34:42 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:48325 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbhK3Ueh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:34:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J3YlR3bHBz4xPv;
        Wed,  1 Dec 2021 07:31:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638304275;
        bh=/dRFnSftz0CBGpqp7O9R6Z3WAD9ADipMQ6POnb6rdnw=;
        h=Date:From:To:Cc:Subject:From;
        b=WJ1oLAldnHU91DGlIOf9VIZREFa2ijz50m1Rc3/mYb2DCG0FHFNVdF2CG6fGM+OqY
         wVPfTQzo3H9BXa3xcDauuoDojUAExEO2XJYUsiRhenq70FDhPlIZG6j3eYDU9yPPzl
         3DOa9vLcgxq4DKyDaE6otajnO5wTGvhNBB3cZueUEgFqh2IvGwYZXqPSOzFMxBLZ/f
         /nyBJiuSHhDE4pSPWjcHU5iPJxwRpjn4AqL1HU4FkT9XBW8iRt7SN0pyKBKE+lkSmt
         9tA6iuDL4qEz7Toj9cc17zVDbksTsu4wPleMrhDwSkmKwcdUSEHzcrEs/zNWn3Eu9w
         7dBr1D2Vn1pMQ==
Date:   Wed, 1 Dec 2021 07:31:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the xarray tree
Message-ID: <20211201073114.065a82b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L5Rm3MEgBGfD5CvbWxPhFTP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L5Rm3MEgBGfD5CvbWxPhFTP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  74cb8d1851c5 ("stash")

is missing a Signed-off-by from its author and committer.

Please don't do this :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/L5Rm3MEgBGfD5CvbWxPhFTP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGmihIACgkQAVBC80lX
0GykEAgAhQdZz3fAes2j1oknjaQnmxvCy7U0vYUTNT22L5n736ZjF6rUqpeAP3Gy
M/DkTNVV1eZDPgVys3RAl7SwUEgB32ptVx8kbu/NCBAwj21zYPc/8mu/JyOEgOPl
p4rMbjTvgkmu06fCXfHakmmJtPDw+hnpcduBOExAaTRrYwsmVPGEiUQeCaW0leC+
+GI8/DnEQu0RkFaTctpMsc+txQwJ8pLcNi1rUV4xgljt4LHX89MqkFFvCt3vSn7k
qw9oAErVDoMj5p1454jIc09hfVgfuimR++NNgYlfNTvHQFcIXhFnT5MMw7Pov8LU
uzm1KjiY5ND3ihcn0+L6yGXaS0quVQ==
=DvdQ
-----END PGP SIGNATURE-----

--Sig_/L5Rm3MEgBGfD5CvbWxPhFTP--

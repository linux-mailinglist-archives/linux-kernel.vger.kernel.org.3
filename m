Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC31F486BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244311AbiAFViI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:38:08 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:44025 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244184AbiAFViH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:38:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVKTT2TzMz4xgr;
        Fri,  7 Jan 2022 08:38:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641505085;
        bh=LBRvWTccl8jI75VNSII6S0Rplpj5gw0rHL4akA6JVT4=;
        h=Date:From:To:Cc:Subject:From;
        b=oWCqrY/3iyyY44/JffkDRuCkwN1S1FML2ZZf5oFWqPVsb6wMjxOGDFfqghHgZj5QW
         zWl8ybAc5rzsS5hYiF/xwo83JxA0leAkFkzIvrzjGT4Gz8arbgxwjPy+47+T1NKfjo
         WDG7pdRg0Jfu5aBN2vdJ3U6Wm9cvHH1k08m75WTokrhMALQLR+EmQRLsEF4BdxLC3c
         SV7z0e+hf7uME/bx/GJu4SgzUDe1NJIIitLxp+0emGxWZHaX9xsuZLWTFcKSwbDGF1
         ll8wfM0OdxZkbj6wrhKi/8DOUNo6JC8KTRH1c/0iujvEMpeAtRvhhsd3rYqJ5urThh
         klkYlC36mONSQ==
Date:   Fri, 7 Jan 2022 08:38:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tpmdd tree
Message-ID: <20220107083804.1a053153@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D.e3_K/jTCzNcQIBSmMr97l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D.e3_K/jTCzNcQIBSmMr97l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  1268950cc152 ("tools/certs: Add print-cert-tbs-hash.sh")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/D.e3_K/jTCzNcQIBSmMr97l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHXYTwACgkQAVBC80lX
0GytnQf+IQjWXj7QiKzaWu67CQfcRu1cW9T4Nnvh2MufMgQLgdo9vzWJOha9EA6t
tEVWlsBU1i5Fm9MOZxzRGyjk8D/hu20iCAYOBhj6aD8ggDuptU5gHrswQoM6sIUI
JCYLGYjD4weLl7OiuiJgqSUbLZZ7XnU817NU9i3z7B0exuThY/fHRH/zb7fFD98B
26Sgu3WMoJDwmVMI5EDS5B21aNR0lKV44T6PskPt/uPx0GchJCzU8BeuDU+RS10x
7d+7gd/T7cyRBQRtjSw5Hk78KHiLS3+52OZiiuy6Rxftb+K1EoBweu6FLxWTxi1y
t7Rxi7ejODZFJs18W3fvoTgyqc2G7g==
=X16j
-----END PGP SIGNATURE-----

--Sig_/D.e3_K/jTCzNcQIBSmMr97l--

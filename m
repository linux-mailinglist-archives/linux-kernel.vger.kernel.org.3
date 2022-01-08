Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA5A488227
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 08:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiAHHZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 02:25:42 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:59781 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiAHHZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 02:25:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JWBSz39k6z4xd4;
        Sat,  8 Jan 2022 18:25:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641626740;
        bh=T/jZhA/L/dBQfp25qCLfio2/MXXlXg5j0WqIA2XSV8U=;
        h=Date:From:To:Cc:Subject:From;
        b=rx3o9dExyKX7LRxz2Yil+gTijoel8hV5faFiZV8GFqt4M2b8M7aW9BL/ru6C0Ydki
         HfqWJZm1S02eNX4Dx8psrGdl1xZEapwgZf+nfy2H9cxKVa82FClmwHubFo8nPa7DRQ
         XJQCL7m6GMRuyyJxKCuKc0uDYYY0NR6Bz5kFr/qcDufvsw94WlfQn7UyxOEeKuk+f0
         7+jVnbWVGGSz/+L5KZyBfZr6opY/lf5Gcwld3odg+IH/O/cbysInLGvuBJkqwqiMdR
         /xNXjWdx/pYp5u4UJ63eg2Z6DRNvgSIsQV8FxDDxO4kHAVaubMe9+6Zq2FKmSGNArd
         JNk1IyfkYo/hQ==
Date:   Sat, 8 Jan 2022 18:25:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the devicetree tree
Message-ID: <20220108182538.362c8e29@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XmTTLoeyiaSTdJ=sNqjs6TJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XmTTLoeyiaSTdJ=sNqjs6TJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  86ce070ce00a ("of: base: Fix phandle argument length mismatch error messa=
ge")

Fixes tag

  Fixes: af3be70a321 ("of: Improve of_phandle_iterator_next() error message=
")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/XmTTLoeyiaSTdJ=sNqjs6TJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHZPHIACgkQAVBC80lX
0Gx/aQf/eghOLjKTIVvNHNnRYh2WP+Q0W35fUwCi9/dQQqaebGkDApItJcfmys9d
qG0NsxqzEUnyoCzZzdyB4JdqIXo6fkYnT5AcMrlhmr25Mppb9ZqW0JFKzDCgN88/
iUrEnHKDvPc2j/ZUV27qkvB2mDn7AG3D0q0BQ/yypcXRyL6jJSTZjz0HP886ezFg
nHroxBA85Vwu4gnZdGu1aLrNthPx6bEDH9dMphX1kk8XNY6vaiNU0LxhFKI3UyWY
3tyPCmEpSXC+R8R/mgIXwGOpS4jJn9Gbr1Vp3IfdZN04TdTxk/TpXoFVCB/vKbO9
ha1PmxccFgj7MQDy0jaVxbQCFb4/eA==
=JDhE
-----END PGP SIGNATURE-----

--Sig_/XmTTLoeyiaSTdJ=sNqjs6TJ--

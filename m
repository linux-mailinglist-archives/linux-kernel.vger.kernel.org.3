Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5648F4BE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 05:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiAOE2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 23:28:17 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:55843 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiAOE2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 23:28:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JbQC211yCz4xQq;
        Sat, 15 Jan 2022 15:28:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642220894;
        bh=8jn6I8CPZWipEDPcWXz04laC7x/fRHvcfk2+bwEX0tU=;
        h=Date:From:To:Cc:Subject:From;
        b=W7USzrqaDnKx64N7hx+a+f37CBMr0moBwg+f4OcRI7+9joFZHVlyOGFWSaEgM5fSn
         +3mB0AHGI85Uk279uv15c0mtRgwLn3kQoAU2gRpZ5Qn54kmsySe4lhcZ7F0Sa1D2Wk
         gkWeKpxWM41ZLKT+ur/qh41/I3TtZkKBUfoFTJiBwoWof9tVELgGBCDwlsjwwiZ9Q2
         eSkVMNEiwd4tXWF7RgDr+q+UAX2Tg7U69DsLH1Mq7uw2gkTRvYzORol0Sm7xwe1iY7
         UKPcqjDdAa51fBcWoXn68qlJKJYQTFAEFqpBPl9N/KaWJqTDSy2ff0jMGNweunhKVN
         cxw/Wb1Jyscqg==
Date:   Sat, 15 Jan 2022 15:28:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the ftrace tree
Message-ID: <20220115152812.32d3ba5a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_550BUW8eWvGwM_SywU2/bf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_550BUW8eWvGwM_SywU2/bf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ftrace tree, today's linux-next build (htmldoc)
produced these warnings:

Documentation/tools/rtla/rtla-osnoise-hist.rst: WARNING: document isn't inc=
luded in any toctree
Documentation/tools/rtla/rtla-osnoise-top.rst: WARNING: document isn't incl=
uded in any toctree
Documentation/tools/rtla/rtla-timerlat.rst: WARNING: document isn't include=
d in any toctree
Documentation/tools/rtla/rtla-timerlat-hist.rst: WARNING: document isn't in=
cluded in any toctree
Documentation/tools/rtla/rtla-timerlat-top.rst: WARNING: document isn't inc=
luded in any toctree

Introduced by commits

  b1be48307de4 ("rtla: Add rtla osnoise top documentation")
  e7041c6b3c12 ("rtla: Add rtla osnoise hist documentation")
  29380d4055e5 ("rtla: Add rtla timerlat documentation")
  df337d014b57 ("rtla: Add rtla timerlat top documentation")
  5dce5904e3b9 ("rtla: Add rtla timerlat hist documentation")

--=20
Cheers,
Stephen Rothwell

--Sig_/_550BUW8eWvGwM_SywU2/bf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHiTVwACgkQAVBC80lX
0Gzyrwf/cOcJfaR9UAS3oNdlrSdpZliqHmXA78TZ5oVOhimXvg7vglTmY4Rh3vq+
xT7GrunW5p2Xy7zDHlgwlb1lfSCis1SEKlUBWZ3GitYQNCW/YmEUP8vlKkTioKvp
TGbuv9xh8qeNQJGrKGWIcG/9TyiP8y4YQZ/NNkvpRuNm0y8eu7IR98DpcnBusqOj
28HxYD07VzVNsPBRrAgyByrBvGZqBHTmd6dfu/ZjMYmbT9wMiwWhZ7Qr0ipTaqXV
5mPC+SOQiEMDCFNIQY71Sq+C2Yx1fA2g5AeFxqJEbLdlDts33vVP0knQGdsPf5EJ
oNOLfVkNCiuHgKP1ETm4HH+FRIld1Q==
=NPUz
-----END PGP SIGNATURE-----

--Sig_/_550BUW8eWvGwM_SywU2/bf--

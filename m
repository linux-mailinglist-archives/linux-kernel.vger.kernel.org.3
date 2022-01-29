Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B14A32A2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 00:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353426AbiA2XhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 18:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiA2XhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 18:37:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0719C061714;
        Sat, 29 Jan 2022 15:37:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JmW2K4t2Qz4xcN;
        Sun, 30 Jan 2022 10:37:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643499436;
        bh=FSKXe7E9PwPDbZiibMOaFerPO5Fty9qSVnGbt7bjiOA=;
        h=Date:From:To:Cc:Subject:From;
        b=P6cEBLAT+WqETy48Mb4Fr9Tr7ECTnQT1y0U4tSAe1IgKVEdwO+zUzr8Oe/nVcVtOQ
         o/s/MiO6oTCVwOVDdMhX8C2mdOhjRUQn/fyEu1qf3B+zgFOgceCybg5JvcHsVrl51/
         8e2foIo6W2KlamTO+JEPlfLCht35wNhtb4agcdeRve1YLbQzHkybYs3wmroRimeaRb
         YD2ZFwi7I+IZGRQcqiZarSIrFaIluKL+GIE2JK2kf2xuoFpW8d+0EaOQNHmzLun8dy
         HtGoM+RxjwBJegDdIYQeeVdNJ66BYtA+cn7K9x5HEX/ABOrhVYdNfq25AqSOZGYqfs
         biqr1StbvN9qA==
Date:   Sun, 30 Jan 2022 10:37:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the edac tree
Message-ID: <20220130103712.391407a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/47CorGqD=TTlKR1s8bFM9g0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/47CorGqD=TTlKR1s8bFM9g0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  34f6e9ab86ec ("EDAC/xgene: Fix deferred probing")

Fixes tag

  Fixes: 0d4429301c4 ("EDAC: Add APM X-Gene SoC EDAC driver")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed in the future by setting core.abbrev to 12 (or more) or
    (for git v2.11 or later) just making sure it is not set (or set to
    "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/47CorGqD=TTlKR1s8bFM9g0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH1z6kACgkQAVBC80lX
0GwUoAgAj6ZfNtmHZimqK/zMianANBgmw3mhCbtjsRj6JsMvbiqW7zZPsH+CsvQa
cnLkZALIErpW/OxTw8KrjPXmXr9j/S05zjX7O4EjNCWoPJpNpGJDe4sYz+tPu0C/
tp9Pv1MeVJApP0h9qDzyqLqccZlKyRnoN12lE4I/K6t8fAt/4KGSllwvc1oQKFLY
e+/Lw/1lXehvZPDEMngqVk+SeSWpOIAbyeFula307KsQ+NuIEtkFRNW3U1/xVCj/
gJY/cjrMwWgyZJmT02QWrKDqclQEAcyLFjieNTGB62Be7UaT0MKA1+AJZKDhz93R
Xlv5P4iAg5zgs6JDLE7A3xO950ArAA==
=YirD
-----END PGP SIGNATURE-----

--Sig_/47CorGqD=TTlKR1s8bFM9g0--

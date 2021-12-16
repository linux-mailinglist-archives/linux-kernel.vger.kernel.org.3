Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218A747727F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbhLPNA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:00:59 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:53889 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhLPNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:00:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFC0T21zWz4xRB;
        Fri, 17 Dec 2021 00:00:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639659657;
        bh=oyle89FM3w5oZcH8w5oNb+WkBQPyqp9LhUgHOy9z+x0=;
        h=Date:From:To:Cc:Subject:From;
        b=vAT3Uqq27D/xSvAajPN1/JCY40zk44WJg3G9Utj5HPV+U2i5xijPMUhrhcXEswZ5X
         +NHhXldI42TQftAnpc/a4v7LVn55mZiac95HtoL/PKjrtbkWy4grJesYHfU1T2Eg24
         Bys9x27JgTO38o4RNlXCTY4XMDOcbGkHo1vJ1h6mot6iO/4YiCNj8EO/zcTpI8sdB/
         cOFnBVlJnXY66lPtn9nE6IA6jpRmry9+qguTZbcoUkYSr8n7ViQStj/pA1oMHVnY8I
         q0zIZaskKTR7LrUI8jNGCPUIQu8mn/GbIvsAPrOJzQJLKJcTHAYr4c6H6n6Ze3FY5M
         qs79RtZmJHumg==
Date:   Fri, 17 Dec 2021 00:00:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sound-asoc-fixes tree
Message-ID: <20211217000056.54aa1e81@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FPN.Oo7yRtDzSXiQNL12xPc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FPN.Oo7yRtDzSXiQNL12xPc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  db635ba4fadf ("ASoC: tegra: Restore headphones jack name on Nyan Big")

Fixes tag

  Fixes: cc8f70f ("ASoC: tegra: Unify ASoC machine drivers")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  d341b427c3c3 ("ASoC: tegra: Add DAPM switches for headphones and mic jack=
")

Fixes tag

  Fixes: cc8f70f ("ASoC: tegra: Unify ASoC machine drivers")

has these problem(s):

  - SHA1 should be at least 12 digits long

This can be fixed in future by setting core.abbrev to 12 (or more) or (for
git v2.11 or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/FPN.Oo7yRtDzSXiQNL12xPc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG7OIgACgkQAVBC80lX
0GxkRAf/TDZp4hOVy2Wl4dEWLj6IGMXwRfP7JKfW0DlaKY0Gss+Hv45wjrBMxvZH
lWWgf6sy0wI1xcQYwt5ehLWQR6juOpwxi5uTUfNAEsARWL3dCi79zWB2pL31yjrM
zunEzDWsDwzWrBXCgWnj9aZzq6y/wqwsu4YvLX6qphmHxjLOpK5LFuqSWyUclmEv
BUfRSUefGWF3HQxYLYehjElL7kEDm4Rcy/VxKBNTPXK3a2m5nQT+Bwww7Gj2ckmq
Im9gGmYZbHIlJt8VmaA55FTAr+rCVEAj7BMLTfVdrlcEDwKlzcSqIv2jrK/2x4Rt
vzEfP3dR4DAQRd2mx6EKOhLnA/3NxQ==
=1sJx
-----END PGP SIGNATURE-----

--Sig_/FPN.Oo7yRtDzSXiQNL12xPc--

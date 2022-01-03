Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA39E48383E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiACVPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiACVPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:15:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195DAC061761;
        Mon,  3 Jan 2022 13:15:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JST6w4yd1z4xgr;
        Tue,  4 Jan 2022 08:15:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641244537;
        bh=teojRSACimY0JQGit354iqPjqfxxvMa15nrLCMgclKM=;
        h=Date:From:To:Cc:Subject:From;
        b=Zi7ZePcjkcLXgn+fdj0y490AN0eK7lqTATobf2ozEfftyDWstqJjDSlon4lBmV9N9
         jPO8INwEl5pG2H8BuWaowxtmZD+dQjX22J9ujWGaLZcCrJHJPMChLvdaqX6LJvGQXG
         IL0DjCKUxHnLRTGTxczimppfigB2DNJmogbK7W9biuMFAmskMJqswZyoZtaUbFDqJ2
         y2NnZCW+xbpfZXrVqCc8pOevS7OLvRo2O9trQWPIunT3VBRLLH0ys8cOfG4xafqTm9
         9aD3HZfjAsvjAnSuhqewtOqw4X7hqrE7oB0VbKbpT9Qy2p5kseqZ+6zODZ+Ajkj4+4
         RSHc5kNZGGV/A==
Date:   Tue, 4 Jan 2022 08:15:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Bob Moore <robert.moore@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the pm tree
Message-ID: <20220104081534.5bd47f87@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_LRrlSCbdzNIs0Th8yZZpz3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_LRrlSCbdzNIs0Th8yZZpz3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  a3e525feaeec ("ACPICA: Avoid subobject buffer overflow when validating RS=
DP signature")
  339651be3704 ("ACPICA: Macros: Remove ACPI_PHYSADDR_TO_PTR")
  5d6e59665d8b ("ACPICA: Use original pointer for virtual origin tables")
  ca25f92b72d2 ("ACPICA: Use original data_table_region pointer for accesse=
s")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/_LRrlSCbdzNIs0Th8yZZpz3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHTZ3YACgkQAVBC80lX
0Gyy2gf/eRL1DU4SOUeKm2HFbnMhsSU/Qsw9MZWkgz8kQi50jtiX2VOkj3dhg0zt
iS2OeIfrqZf3JobYJKRBbS7APP7Q/f+jNhGrdOc0GHBjavSSGHNJQu+w3I+OSGEl
F3nrluXsQuZKOtz0QabympkLEGxAc6ADhm2YAYBNX4ovBAYAMGTKFAE2hhylAh1Z
y3gxH4wCwc230Q+rNcyNP/okIjLb9Rt4LKSWeGqla8LVdNI06ywmDWHE3XwXmJjR
lEqUpD55LlWRE86qvYtOaB0d6IAvuUU4QIpvDBqCzFXT+WojpihSz4O9rQiRTfAk
91BnZt6MeOvXdq+eD9+2Red50GVC8A==
=X1UR
-----END PGP SIGNATURE-----

--Sig_/_LRrlSCbdzNIs0Th8yZZpz3--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4C5486DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245638AbiAFXgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:36:55 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:41147 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245626AbiAFXgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:36:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVN6X22yLz4xgr;
        Fri,  7 Jan 2022 10:36:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641512212;
        bh=ra/S1AZUdgEtZEUsntqIzIz4E26NHONUheQ0Umcisxk=;
        h=Date:From:To:Cc:Subject:From;
        b=LAdAelGPTvPDHzz34R8KNreBoWUqWLD94j7UCdcGbbiVETJEA3GjGiSh9hjjNyF76
         Yrk+2JxaD/3bLQcq6acmFuWqHbKG9e8u6v0x71o7RGQzzj4CCQR3ZDoTADJtxab9ZW
         L3XfWcoCsJJ6UB8RPmUYsGYr+U5Nu5vibKm89ycvyVa3BSjbyr7cFeqOuKsG0XjsMO
         2NR1fFoZatkt6ma/+cKixKaNz/8SAqG233sXQghhqOeiShQ7HHeQ8Lw6VY5TIhHQOs
         ssxoKFOIl9od+6okVQeDf6IxFzH79ogFPKVwQJ1p00alhGcDZovMq6aA/383oZOWZu
         3L9mJ2QnDv52w==
Date:   Fri, 7 Jan 2022 10:36:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     James Clark <james.clark@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the jc_docs tree
Message-ID: <20220107103649.53774b30@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P_hZfvUFFMhrxBxeT5=ylIR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P_hZfvUFFMhrxBxeT5=ylIR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e94f43ea200a ("docs: automarkup.py: Fix invalid HTML link output and brok=
en URI fragments")

Fixes tag

  Fixes: d18b01789ae5 ("docs: Add automatic cross-reference for

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags across more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/P_hZfvUFFMhrxBxeT5=ylIR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHXfREACgkQAVBC80lX
0GzS9AgAl9H1SfYCyfxPuUVHAOiHn7k8s79sIQcgJfGWpBZWb2HcFtB1svHnkOz5
g56VWqQvOeezxoRk4g38VuZrrHcfqgz/zHYIOczmYg7BBQbjkrSj8ooe3YTh9uMx
ERDWo9s3tt/eUplGtrZNdur8Kdt9rvZhrBDokI3dyAYWlK9VKPc1qLyBj8qsHfP8
LIwspjbQ4+qeubZTzhes8Q64fyPuyaUiGfiL2NLmyPbJOO0CXt/fqOBtaRdT/vWK
+ZRsJaVpCLCCLMRjZZ9CDW7f8ORYf6VSV7GBgHx0jkoMCY3HfjC89Q7/F2hqCt5y
RmnZoqdJLbsi1CO+3qhPi6DC1ZYwVg==
=HvBp
-----END PGP SIGNATURE-----

--Sig_/P_hZfvUFFMhrxBxeT5=ylIR--

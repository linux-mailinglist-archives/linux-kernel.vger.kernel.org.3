Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC90486C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244360AbiAFVoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:44:30 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:53523 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244268AbiAFVo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:44:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVKcq09kmz4xsl;
        Fri,  7 Jan 2022 08:44:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641505467;
        bh=AsWTp5tVZkxU3lvX2tMz7AI8ypLPcwzpujgaLSuIplE=;
        h=Date:From:To:Cc:Subject:From;
        b=o58zDQEHyc5MPFYOSPVjWONFHh0qFD54KafivTajEpfzciztA8/HOL25W3fR3cean
         GuvkzhUW6QmaupX0BPw1EqlWW1DHTZO98vfRzU5vWq/zE2kJyCQlOj3qL00dEhqyDq
         qJdemS+VB2Ze6MjRlertP5GvQkeOMseeagzSLakmSz3n948U/PUVViKA5NcWqqaPMF
         +z2slEkiqXGDNPv9crnlBAlGgnkYbZP8nZEVYduOeIVXBZyJowk96vBO9+HNhYFJZu
         n2pOpSIB68JTyzDILvSBPEJ8qp8urq3gll0Lb0n7KHark5Zth+LAhacXwR4zyQrcOn
         unkrE/9r9N3qA==
Date:   Fri, 7 Jan 2022 08:44:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Laura Abbott <laura@labbott.name>
Subject: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20220107084426.60b43e2f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1f.d9/9fQk0tw/=l8.cHIND";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1f.d9/9fQk0tw/=l8.cHIND
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  4f48d30af284 ("vdpa: clean up get_config_size ret value handling")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/1f.d9/9fQk0tw/=l8.cHIND
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHXYroACgkQAVBC80lX
0GyaeAgAkc09bqylyMdMlTcLEIq0WeQ281zesMPcuJBKtK7dvdamb6o7XPSCwKUC
5iqDTc7ulxxm72EqLPAVVcvbVG5o59/krJzF7l5f22ONb7I9MOjr9vj7lVJTEwmf
vSQ9MkaaQ2VTqVtuSRHunMwdqrhiTN8SQ5AmTZxy2e1FTQROW3Xih+yTmqC+pHdi
7q2qJ/SQYNoGyny4doWBRzxuSxGSIiFo247Ib6O7q27UoH57/7VOgPuxeYdJBjP/
Y3FRPKbsyOeqjaOeD/LQxFtS5+RH+eildMEpQO/wHtOV5CTIJfRhH527ItKyA2iO
RVeZ6b0wa/VuoDmWhvX4f5/JSlHwYw==
=Rg4S
-----END PGP SIGNATURE-----

--Sig_/1f.d9/9fQk0tw/=l8.cHIND--

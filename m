Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9465477C05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhLPSyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhLPSyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:54:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5DAC061574;
        Thu, 16 Dec 2021 10:54:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFLrB1KPbz4xbd;
        Fri, 17 Dec 2021 05:54:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639680858;
        bh=rLK4SY40uEkvmL/uH6UGQ2pLfiEP4TAdDBOu9EJHYgo=;
        h=Date:From:To:Cc:Subject:From;
        b=GAMpsRxlze5WkPWtOutexbQya4q0PKWw/V5z2f1H8j8ehzXTqUjN+XbdPZjzsG1rS
         f2GQNDd9OP5TQP5eju0ZDK+ruKOxuFxgzhC3pVrNKhlvNQslU+ph6UdJyvuyN7zCOF
         uxJLF69y7XhNqa4Rah4ljSiamTyilpduuxgvHX6z6wkbjYuUjlo9L4NE1nJVKmLCnp
         jVTQVpjsrfhAlIQXK/SS7iRFubUvcvnyAZgSsCXZJQp0cKlD+v+f7aR5yPlKaItAtJ
         QrkUBpbqOeYF01FL0tPN2PtKQ27VQ23W/b3GHyk0YUfapgh/Yp2Qd4vVp1D9yss5Ff
         Ah7E506QXbAxg==
Date:   Fri, 17 Dec 2021 05:54:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kvms390 tree
Message-ID: <20211217055417.49872d28@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TgdSFJHLklbt7vqQE=jzBTe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TgdSFJHLklbt7vqQE=jzBTe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  697a708e3106 ("KVM: s390: gaccess: Cleanup access to guest pages")
  7619a23b4788 ("KVM: s390: gaccess: Refactor access address range check")
  782f8be3c167 ("KVM: s390: gaccess: Refactor gpa and length calculation")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/TgdSFJHLklbt7vqQE=jzBTe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG7i1kACgkQAVBC80lX
0Gzu7Qf+KhAGIJocPFlEw9o88pefN6cFUUqgE8kek5sYXJFzsCG0ng+1XLWVg7HL
2tvk8vZx44vo7QYjr/E1RM1OLkj/Taor3nkxznwPNSHOMSGgwxZdqS5Fl3rMyGk7
8WRB0aWJpnF3V8BSjrN2gOixpGBpkX8s+0CvjBf9YZ0oT6yKVjZNTsLGHuS7gWLY
iZiHooGmAczNZXF3V8hP8OrJD+TY3X0i0ogEfcP7yiIZemD9JiFk1TWL99NxOcMF
BbUdV7TKQQXyCiOBa4+s7Lan2ZRAKOZgJVaCOF8rOWX918+F+RraXcsO8tDGZqQ3
6K+qBFp0x98Fm2pJT1Uyhy+urRZqug==
=GPCn
-----END PGP SIGNATURE-----

--Sig_/TgdSFJHLklbt7vqQE=jzBTe--

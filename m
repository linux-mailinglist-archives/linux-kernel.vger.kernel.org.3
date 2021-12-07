Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EFF46AF22
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378437AbhLGA3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:29:47 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:35551 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhLGA3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:29:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7Lgp6bRSz4xgY;
        Tue,  7 Dec 2021 11:26:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638836775;
        bh=xVll9Sj2WgtVmaGS+U4gl/0q+mTuWb5o1MqSu+779JI=;
        h=Date:From:To:Cc:Subject:From;
        b=IvGGIDB0H2oEF96AUtx6AApTqo0Uo7dyVk6w4Ls7a/aB9vBi/ZFU2WQ0eldzHsdHc
         BYVqQXP3h3n4FTIYq8bC1Z5qs8tIfvhDcAJMnzMjtawR5kwL4myGCR63hkl9sJfFKj
         a3yn6n8usg8teO/NqbovNm0R4KRXyMSLDJEsRKOgTkw4abEhU0GYHbH9udHDBrX0BA
         e9URx/Ayyhy3pUSLwuCk2VYVh0uKxmKqnVW7CRELMN2dGJW0KDzYZE1MZaGzmm0goJ
         lU1bU4RsOsJpn8qWr1nYK4pnjY+JteeR2s4BJ4qucGEPsk7EZZjCQbePuGoSGg/1rn
         2dctk5QzpTnDA==
Date:   Tue, 7 Dec 2021 11:26:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20211207112609.0a6e7d8a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B15Z.isHt0WoHRZhb6SWgOe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B15Z.isHt0WoHRZhb6SWgOe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bluetooth tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

ERROR: modpost: "skb_pull_data" [net/bluetooth/bluetooth.ko] undefined!

Caused by commit

  54dda1e8cf3c ("skbuff: introduce skb_pull_data")

and following commits.

I have used the version of the bluetooth tree from next-20211203.

--=20
Cheers,
Stephen Rothwell

--Sig_/B15Z.isHt0WoHRZhb6SWgOe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGuqiEACgkQAVBC80lX
0GzRcgf+IAQyB+9bx7fC9iggdQPJ07w1q45OGIUx7961Lzrek50zYTtXooA1W9Ro
lGXFyEdlUPWaFXvonI4D6RbKl/rZtxZ91l0oNxAraywQHxUBqLz35gCAhgYmRI5L
RxnHRdLj2FM9ZJA4LVlBYawZTaVc2gQcWOgtcvK1iauGfGk2VgWGEcmc/IW8jdVa
WZmB+IyfiDKTzBCPo3/Gua9icFEjZ/UpBhlLNnCJgmg5IuPViJglRpw+Dz6uaSER
stl85wwT+5JHWlV/3DS/2NLAHc5eBwRqqezuLDkSSOoT4Y2wuZsGe+sf0WkJiRqD
4UZEZJnzuNwmT5I3llNJmUikPrr+Cw==
=RGbm
-----END PGP SIGNATURE-----

--Sig_/B15Z.isHt0WoHRZhb6SWgOe--

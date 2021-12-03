Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985A946725A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378748AbhLCHEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:04:52 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:56981 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345605AbhLCHEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:04:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J53df06TJz4xRC;
        Fri,  3 Dec 2021 18:01:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638514886;
        bh=SUVbQnKpFA54I6+lh3rt6Aj++o7uT7IfrdkwC1qkkao=;
        h=Date:From:To:Cc:Subject:From;
        b=CTFIL+ElB0+MhBAbUx2HFgXBQVZZGCvd1jUoOdkaOw9nDpxTKQbZnpkZyCdY0+atl
         GLnE1bU8FVpxaXyhA8aJwoy7S0ry1XYyCXKjMjhaYC01Dkdek0/9MoxMhzXOfagI2o
         aB7+UGpPiDcF5WHMP+hovwWUeSRrifcl+ljKwqe8+ZoB6JaYDlNTqAcLu+uT5H3YOX
         F3ZAwJcDAlNEi4zzVAdi9o0cAXb+mLL/kxgezpL+L+k4gvoe3bt0mvLrxQKa2adDr2
         Jyza/uEg0SZHGXyvxqFfeuVbMd+DTQ1lb9hiXZQYZzUZR/k/zi4RojzE8rtDEqjHqk
         guw7PX0CrDXWg==
Date:   Fri, 3 Dec 2021 18:01:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hid tree
Message-ID: <20211203180124.1721cbe4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GVJp0TQPTsRXCGqVXCSwXdK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GVJp0TQPTsRXCGqVXCSwXdK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hid tree, today's linux-next build (sparc defconfig)
failed like this:

hid-chicony.c:(.text+0x4): undefined reference to `usb_hid_driver'
hid-chicony.c:(.text+0xc): undefined reference to `usb_hid_driver'

Caused by commit

  93020953d0fa ("HID: check for valid USB device for many HID drivers")

I have marked CONFIG_HID_CHICONY as BROKEN for now.

--=20
Cheers,
Stephen Rothwell

--Sig_/GVJp0TQPTsRXCGqVXCSwXdK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGpwMQACgkQAVBC80lX
0GyBtQf/THK2cZDDhBQjLpDGzqf8zMK+k4fPDx/S0thryzBAlnutvyX2cg5YbuWw
jSf8TpJV10YMcvuNg5nlB7CAwvC+7rOXIAVWvYEAwOLSWbjH98JzW1mEkOh+42wM
X8H78mh2fX7KseiVY624gPJCbsEd74Ve+2v63cajLUbDUk1k6LJJuWbPxOelUYnt
Nq3sPOvpDpduOJOQUPJjtz/qGG6C8G6ko9xFmym8VsKQ5FyMOk73PU2r2QavSf1d
kK32zDHzm1qFd9UxsFu93NuX3WOsvEz2YSvoURwpXQ2WafMIf4nqJoAU32yAKaVQ
MPTJ/lL0cRmwuUZgvBfDlUTiQSgw2A==
=XIwj
-----END PGP SIGNATURE-----

--Sig_/GVJp0TQPTsRXCGqVXCSwXdK--

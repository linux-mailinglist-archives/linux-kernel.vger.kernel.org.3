Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1213549002B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 03:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiAQCYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 21:24:37 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:47183 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiAQCYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 21:24:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JcbMR12cqz4y4k;
        Mon, 17 Jan 2022 13:24:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642386275;
        bh=jM/PpxZeuRF01Ym1oPmV24yB9bH5pWdzOHQTGF6DL2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XSIqK02oAC6SJIVzqKXDB9KtxK3I7bXgaYP8KPWwy41AKWeEwYnupejKb5NBqcB0h
         GRrsliRA26AhdsL1ic9O/+Uq4mqrrG3x2AIJp8BX+5jLUKkRwDD+u5IOedg+Ni8ljb
         rTNSVoyDcp+4MDJZYKFdfmJrQ225lI3XfJp0iXl/M9YpMFTz5xucS7z7MLOh0xu6ih
         V+9dmF95+GD1eq+fu/0Ev7NDUJOeKL4mYASjW/aStRCfUKTO/i1Cztlv5Owct7/Enm
         vIb48DCkx03lJ1Z5U4t006f87bgdEKUxtyBev6iLlasd/hp6VJvsosplRZR/rt+L8r
         pP5Y2+RzYmLaw==
Date:   Mon, 17 Jan 2022 13:24:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the origin tree
Message-ID: <20220117132434.242b0f66@canb.auug.org.au>
In-Reply-To: <CAJuCfpErqDrgEkw7OXyGTkfXiAEDHx=9DF9cW0qdc27Nm1_wrw@mail.gmail.com>
References: <20220117114514.5b6daa04@canb.auug.org.au>
        <CAJuCfpErqDrgEkw7OXyGTkfXiAEDHx=9DF9cW0qdc27Nm1_wrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iDGspGi3PYOFMsjd=dOA0YV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iDGspGi3PYOFMsjd=dOA0YV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Suren,

On Sun, 16 Jan 2022 17:27:34 -0800 Suren Baghdasaryan <surenb@google.com> w=
rote:
>
> Sorry, I saw the warning before when backporting this patch but I
> didn't realize that the followup patches refactoring this code would
> not be merged.

Hopefully they will be merged shortly.  Andrew?

--=20
Cheers,
Stephen Rothwell

--Sig_/iDGspGi3PYOFMsjd=dOA0YV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHk02IACgkQAVBC80lX
0Gw9SAgAoOD02e7zx7YVifcz9q67BmDWsKwB96A6dK+n+rg1LD8VXvFd3x5rABPp
kK4VZ+RCqIpnaRAv087fKi2iEeblzIZeYsgi3EN9V04JFa1cCGLWG8mFKzKFbffj
JjSQtXwIXDNpgV07EDU8rF11AhKYWSdJZtnCVTUA842pD6d0Q16/tKm1J4FPzJ+K
I3r4SZM3BSIa/SQoqMq/nynmyPG/xLsuG0raOc/oYIWlZiCqJ5kP8sZmkaBAXESK
Od/k83Sx3/FEItE9L9WvKI818gh9AgDjPK/5UDj3iUOP0eJsYEzVCaU2abXIPKLC
vVviR+8+YCi7m8r8vFJDeiqbSrKtuw==
=pn6d
-----END PGP SIGNATURE-----

--Sig_/iDGspGi3PYOFMsjd=dOA0YV--

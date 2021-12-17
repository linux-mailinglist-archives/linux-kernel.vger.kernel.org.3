Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8EF478164
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhLQAfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLQAfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:35:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE9C061574;
        Thu, 16 Dec 2021 16:35:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFVPv01KWz4xgr;
        Fri, 17 Dec 2021 11:35:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639701331;
        bh=0yV4OjD2/txk+TqQ+snBZ4pY8OoYKPgmVqfvt4PRsCU=;
        h=Date:From:To:Cc:Subject:From;
        b=sl3m0o6/giPv1SF5VKfZhidknItSkuy66u3pbKyrtZJuEVl5HikeQu2fnt6JAyp64
         we+tBfMeVMIv87DaZJTMGVVg7Ad4qH38j8p2ntpeVCtTSYluWhgyNi4fKhIVgFh+pV
         kTDp7CnqgiyRx9IGPvANDI0Fctl6nkK5Aa4OnWmUhbnGvoGYudN2/4M0bjO3t9/iKB
         RuPfwadszv4OTMlJ3oQAjyLDDOlcWsNAyLv7ritHOBLSg8x2tB9LgnWTjdfYLVkfeN
         yaQZaDcVySCoD1Uaw3ZKO+Q/KyE3gaza7tKYjBvtYuCVfHqSzQaNGpVWju5HHqgsE8
         11ljeoWox7nvg==
Date:   Fri, 17 Dec 2021 11:35:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the fscache tree with the asm-generic
 tree
Message-ID: <20211217113530.30f9e48a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yKsQczCucaJ2uF2GZ12Xrpr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yKsQczCucaJ2uF2GZ12Xrpr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fscache tree got a conflict in:

  fs/fscache/object.c

between commit:

  5c61c384095a ("Documentation, arch, fs: Remove leftovers from fscache obj=
ect list")

from the asm-generic tree and commit:

  b03429170e20 ("fscache: Remove the contents of the fscache driver, pendin=
g rewrite")

from the fscache tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/yKsQczCucaJ2uF2GZ12Xrpr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG721IACgkQAVBC80lX
0Gwhpgf+N4t9doOVE5rHmf6OvLp27vydq2u11sqV6/+LNL0JI+5f4mAYua60H+/S
9/7kVObvWVlI69rs+A6YNV+Z4u24cx+ueB9H9FlxX9ns9Z+JW4v4lvv0ejvz/0bn
M67ZM2j0D+9QKyMT5KNkIjUFtihB3WzVf0YsjHAWF9mCU3DhTW+bh/pJcCaUdv92
saGjg+5da20feB7RcfRbAdtKect+Jf24mg8uMavksbw++UJbZZko0SfLXcHsInit
v4PraqvUKfU4FGCMUZNzdZjQlE8j6Q7KxZtD343C7FPFRFOjlvlvYSgEQME6V0uN
IaM9F9okkkLerzMZEoQbuG7GGGVTBg==
=KWML
-----END PGP SIGNATURE-----

--Sig_/yKsQczCucaJ2uF2GZ12Xrpr--

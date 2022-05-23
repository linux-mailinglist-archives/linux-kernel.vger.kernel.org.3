Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE06531082
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiEWK5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiEWK5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:57:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BBD24BD6;
        Mon, 23 May 2022 03:57:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6Dmt0fkmz4xYY;
        Mon, 23 May 2022 20:57:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653303438;
        bh=ipnmT+KYlz54CrCz7ax5U6ihv1QHFR3hGtNaRZQAscM=;
        h=Date:From:To:Cc:Subject:From;
        b=qLjCUhTx1VqiGmIQCxQcmy0QDFsmIhShDJUNNkChx+cw4icvfMtjZxikJKre7LIdp
         kg6UTWVceXsNpMyh/Kuy/BharAe7qHefPsif5GRlMjuAlRPXOanR0g2mj7WHrYOOR0
         G5ocCT4Md/tYCpvZP8JOoU8xgvRKcm06OoHaK9KYM+QRWjV59/ETEBj+kQIfaO9bU6
         gg4VZirDXbrUN2j11NeYc4MTGwTtcqeYR6wVT/Qe0dxKyAX/+ooIUYsYZcKCzEsRX2
         HaprDCtUSBOViAeWqYUf6EsPh5brZ641o2lxXYIyinigrjx5k0W9szHJzjJ8/QG2U5
         t7UXH0CT6EaBw==
Date:   Mon, 23 May 2022 20:57:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kspp tree with the fscache tree
Message-ID: <20220523205716.4a641c41@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mHPv+uWcSHFbhN1peCdQU8l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mHPv+uWcSHFbhN1peCdQU8l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  include/linux/netfs.h

between commit:

  713423282ae1 ("netfs: Fix gcc-12 warning by embedding vfs inode in netfs_=
i_context")

from the fscache tree and commit:

  3b5eed3c71a2 ("netfs: Eliminate Clang randstruct warning")

from the kspp tree.

I fixed it up (I just used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/mHPv+uWcSHFbhN1peCdQU8l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKLaIwACgkQAVBC80lX
0GxJPAgAl0ATBZCiW5HFQtqyWIOy4ArICRqcAVaLJGEhnz0wnexaSqN0PtqA+zWi
xrt+jPAqydSee2FNGmWjqUtLiO3X+aI2hN/87kx8rZrjCYmCxnEiNVi3Aq88aAcA
OTAo6tv5diaqG6r96LgkBCUKu3xPfb7eDJB38/UP6WnT/KdcU8d8doOZL8mw6h8P
5EXlA/rVqJtsl/y8ifxchImACf63afogT2If6Pr7Rb3m04FVZUKLPFosbuk5cI2r
EMp5/8WkgMLAySWEx83ylfhyISfseMMVk/NrU7xH6kpyFnLq1P8Y0ppv8lF9q8sx
GTDE4ePXnWLjGlAj859tb0uuT48Z/Q==
=UZBv
-----END PGP SIGNATURE-----

--Sig_/mHPv+uWcSHFbhN1peCdQU8l--

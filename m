Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF3955F429
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiF2Def (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiF2Dee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:34:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B518342;
        Tue, 28 Jun 2022 20:34:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LXnBq5mqgz4xNm;
        Wed, 29 Jun 2022 13:34:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656473668;
        bh=ZkgYchXvx63+PobnrKf/DDwkwBtGCDcHG86cj9IM2YU=;
        h=Date:From:To:Cc:Subject:From;
        b=ErEEd+NfqYZueaBowFEhJFX0MHJ7LUz444Y8RbNLj9P6u4Kt5QeW6i8wesCPkjNNP
         3eGv3wR5v4sVi770KbOENnBShtp4rWge5Htt62HF4aITNvA1ofJ58bRc6UrLDcwf4U
         AAdc+HzE9YLg7AUOcCJN2/QZTLyUIP2FloD578UToRATwD4k743v7ibnuIYjU+wKGI
         KNfJxLi7IFGaef6GGJYs7Gx06ZQ1eXkDeRtO/z/18q41GzosCXxNknPo8jYRydB8KV
         X5Vq8EK3U11mH3lpVbiPcP9CJX+MoXw+XwLBtfThPMJQ88vMG5ci3n06diCxj1zYnF
         sSuGBmKbW7XVg==
Date:   Wed, 29 Jun 2022 13:34:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <markpearson@lenovo.com>
Subject: linux-next: manual merge of the drivers-x86 tree with the
 drivers-x86-fixes tree
Message-ID: <20220629133423.7aef5b57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R5/rL3IiIdFRN.qv+zE/Z1H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R5/rL3IiIdFRN.qv+zE/Z1H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/platform/x86/thinkpad_acpi.c

between commits:

  42504af77536 ("platform/x86: thinkpad-acpi: profile capabilities as integ=
er")
  bce6243f767f ("platform/x86: thinkpad_acpi: do not use PSC mode on Intel =
platforms")

from the drivers-x86-fixes tree and commit:

  6fe391dd5d87 ("platform/x86: thinkpad-acpi: profile capabilities as integ=
er")

from the drivers-x86 tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/R5/rL3IiIdFRN.qv+zE/Z1H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK7yEAACgkQAVBC80lX
0GxEfggAg37DRH0MGeqWKpjP88/Nhd6W2Q448/0pekOwAHejDBapylN8sohIqnxV
/co5xceHFmTbX2dP2PchIrIwjJpJfrmE9+ydouUmX8v21ItW8Vhe7RIGUlwA9Qca
bMAgl3KRwY38KUgONxY04ADDUtKAxSBzFZRT1EozwjPke9AKO7herCbboiGZ54rG
Q9tHTbplBCInXZhWXwVLhEU7vdChqUZ+W1kzB3TQjfHEiM3UelQ6ghHsNp5x/sch
PwdPl+07ut1EYZoQQGhWOWxhm7kZ5YTwboeqBiqooMxbyNyOPwKj2luYU30Ur83E
3krZqyPw7efHN4IALuhU2sJ41PgZmw==
=zB6j
-----END PGP SIGNATURE-----

--Sig_/R5/rL3IiIdFRN.qv+zE/Z1H--

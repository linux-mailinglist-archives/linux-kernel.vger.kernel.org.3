Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D304B3FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiBNCtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:49:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbiBNCtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:49:06 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB334BFF9;
        Sun, 13 Feb 2022 18:48:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JxpZZ3mSxz4xcd;
        Mon, 14 Feb 2022 13:48:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644806935;
        bh=O6Yxw7olL9eIY94uU8ZnAackp5T4kTVjArRR1rjkFcs=;
        h=Date:From:To:Cc:Subject:From;
        b=ktHzUMYC5xOpMa3OKhDPvjGlMaMYqMbE5q7k/5vPnNzUZLY5k7/YwrdS9UcRbKZyY
         EMvbImf7TazTr08ulhn5Gb3ouQTGxqQraPjsc+X3+W/KunO6IVogP6g1hR7j25yJ7H
         2kHI2wgFHdl5xIa2AGDR2Scd0M1NX4ycN9EL16x87G0mMiwzj4hW68Y8kLalZUjcQl
         6A7NUN+L8MF3vYBerEUucIghK09ez8ovnI4p9YgK6DpBHRESLRmhodG4O+l0WY5/BH
         YRF8yl87Q0gs0wyWt/OLSwN8A3bTZ7mT+Dqz45EDxxlKy8A/fJn/Xr8Jx4A2QwV9+a
         AKU7KHP0qDPFg==
Date:   Mon, 14 Feb 2022 13:48:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Sebastian Reichel <sre@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the driver-core tree with the battery
 tree
Message-ID: <20220214134853.520ba31a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5jRh6C4.HUUoAWAuglfEPUS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5jRh6C4.HUUoAWAuglfEPUS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  drivers/power/supply/ab8500_chargalg.c

between commits:

  05906f58c822 ("power: supply: ab8500_chargalg: Drop charging step")
  75ee3f6f0c1a ("power: supply: ab8500_chargalg: Drop enable/disable sysfs")

from the battery tree and commit:

  a8e223094c7a ("power_supply: ab8500: use default_groups in kobj_type")

from the driver-core tree.

I fixed it up (the former removed the code modified by the latter, so
I just did that) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/5jRh6C4.HUUoAWAuglfEPUS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIJwxUACgkQAVBC80lX
0GyiMwf9EryOivKHJi2Odb+HBJYhRzDYlkahHUCIvzICQ1cEPshbsmbc/x/ydRWw
XwUusrbR8L9Db8DhPQQoIA9xdTXgHbsa/r5lrzXj1Vn7OCq8nK7tSqYNLNvyDBq2
ccZV2E3TrCyQBpB6OhiOvc5apGKQituXhsJjlV/uGVrytyLA/A+nOiRCAxU91t46
GFRqwM/tdgeDV80+Vv5ZK9BeydFkyEqOL4X9ywARJiDlYlp1PaDfP+764wf8gdO8
mma0TyxNFCf4cuwBlk9mGOKd2JChw36VUt8Ij206gc8vyB7p7vI1v3+Jp7d2XJvm
K9hQoUuu/9p50oWP/QmiLPo4AhOLHg==
=Ozpu
-----END PGP SIGNATURE-----

--Sig_/5jRh6C4.HUUoAWAuglfEPUS--

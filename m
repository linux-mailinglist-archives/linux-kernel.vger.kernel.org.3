Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C192A54BD99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242087AbiFNWX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiFNWX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:23:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02F24D604;
        Tue, 14 Jun 2022 15:23:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LN2ys6y6Gz4xXF;
        Wed, 15 Jun 2022 08:23:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655245430;
        bh=cijYic4Yqf393NE68L/sY4Cjec66pbDgVeVxDejtf7Q=;
        h=Date:From:To:Cc:Subject:From;
        b=GlZoe9kh2EForDHqWY5MVHEejvw3LAQktNn62muv51sD0r9H+3XF+9Udh0v80kSjK
         k/FsubCOcnG7282G9ar4K8c8r74tnEWSGjp3eN9cwrqd6fRtnYohSicnUkq4eGLRn+
         7D6FkdBOcIAkr7mP6ZFkhsqKYeJvpe0T7S+mF8pPa3SIIIwwPWUmK4U08Y4Jp03cq5
         KYyXhA5uYKOF95uO3O8gYd0r6UzwMZqc48ZXMsYZr8lp7QsgXsR9lHkMoEbUeNCq4v
         2vtOH+vez2RyFnSjWi4gM31hZoKtltWGGE7nkWbrWRnjddTFYW+lLju6qVcDB6in7v
         EUOz6WnwIOTSw==
Date:   Wed, 15 Jun 2022 08:23:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ceph tree
Message-ID: <20220615082348.3e55ec40@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NW+AP.cIWz1E2BU5hGDoeCZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NW+AP.cIWz1E2BU5hGDoeCZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  39be3f3c2896 ("fscrypt: add fscrypt_context_for_new_inode")
  93d0d0af009d ("fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_en=
crypted_size")

are missing a Signed-off-by from their committer.

One of the downsides of rebasing.

--=20
Cheers,
Stephen Rothwell

--Sig_/NW+AP.cIWz1E2BU5hGDoeCZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKpCnQACgkQAVBC80lX
0GzwbQf9FUabwiX5dUlrHTWzDY0TVzmHO/sMIipl9cTXyto8uGXSws3iHyTLPNQ6
uJsaWCL2c7QHIfUlxa1qS9twdJde8z2Xt7M5h2OEY+60OPi7IPswtHr8yUVZ1QTv
Tu8q4dW/zF8Y5LtMTkdmW/dMr3SWA91pFUiPe9QfX/iXq7hHurG6mNKGSMRTFpNN
0orrmPqSSfygBKQcxyTodqDI5nqVt7cyZcE/m6L42nGxu/xybRBOUkTXT4QHrJT1
yrEBNzjjtyW6Y0/Nlfm/pJHlmSeRBa2qUW5z2/QPf+vPoFH5RuZTIV8HqOYiJyVZ
Mr9dvNF0P46v8eugwm7+ke9MJ+OY2Q==
=ZUKc
-----END PGP SIGNATURE-----

--Sig_/NW+AP.cIWz1E2BU5hGDoeCZ--

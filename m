Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4AA4F1FAB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbiDDXAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241112AbiDDW7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:59:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A320868338;
        Mon,  4 Apr 2022 15:15:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KXQ816Y3Zz4xXl;
        Tue,  5 Apr 2022 08:15:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649110530;
        bh=hSld1OtloNUlGP1u1Kfudxjz3bzQNeJmyMD73S0cr9Y=;
        h=Date:From:To:Cc:Subject:From;
        b=OByxMCWOpsI93eJl8pTrnm5j5D4GmQY0YdL+bahp3Z2t9EQLSpfVu2pA6I4j0aDS7
         4F55xdUsbREAODAq82apo8tdB/FmvqWIPJS7jFgF8OXxm5AdAIt6nfyAIDGBITMYqo
         sphJPDseod9G/RsWVPGNgrUsinilYc+qJAz9PKql3meYTVvREs/7x2+CU25U9W245w
         aJd80Hqt4dcOgyuo2fSyPNA4JBu7Z8m4ooEiNKap59VLkN9ERxjOcHkOkvbcPloeE8
         HvCf5J3urmVhE6mvQRs8ryybilzqpiXQsTq2TK1IgeqoRAUo03qOAvY8vKQQtMI0Cs
         VDNGKQfP6P2wA==
Date:   Tue, 5 Apr 2022 08:15:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the modules tree
Message-ID: <20220405081529.28925a1f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ozG8sG927w5RS7u2QYNrcLY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ozG8sG927w5RS7u2QYNrcLY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  450f0134ccf0 ("module: Make internal.h and decompress.c more compliant")

Fixes tag

  Fixes: f314dfea16a ("modsign: log module name in the event of an error")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/ozG8sG927w5RS7u2QYNrcLY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJLbgEACgkQAVBC80lX
0Gzvawf9FUl9NsJQqmtaYCeYWbkpVDp8bDdCdAsiIG+LCUB9Tl7w8tkPf6Pn+vCs
frFYcGdjHWvSz74ttbIUrPMYSLEmLZOt2SF6EqII5019jTSvtb+EyxBC1slRV5Uq
K7e6G9OCSq1BfjnQ5U3z+XQU1GeyuSHmXIt6K8DEZhHe78OzIL8Qf+NGY5TXutt4
OoPKom0hAqyS0wjoSUYxRW82fUr7E6iVS+9Ys65mN3bLA36Ot1NZKutneYrKxl3T
N/AyNt2n928AlUKHlryLYTqz72aV9/o8TvyJhstA0aCzO28GOlttiviUr8rf0ATH
JWTpSsBj4RobGLKGzqwZhx0LdQATFQ==
=k1r2
-----END PGP SIGNATURE-----

--Sig_/ozG8sG927w5RS7u2QYNrcLY--

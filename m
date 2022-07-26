Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BFE581C61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiGZXXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiGZXXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:23:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A053A494;
        Tue, 26 Jul 2022 16:23:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LstJL1hN5z4x1b;
        Wed, 27 Jul 2022 09:23:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658877810;
        bh=EvHXjrk6xF6rN7U3dwOB3M7AgSYPOv26DlDFlEQ35ks=;
        h=Date:From:To:Cc:Subject:From;
        b=pzSB+9xswK8dC5tLrnhV2o4r7nLtZxLCfUQgSkxZYRNB03KT+r8K6PEq7KO57cXCg
         50q4f/O5edazLFfLOTQA7iUTBou39oyvCCGY43XHGRG5mNn9+higw1yMT6VpKdyxRx
         h5TY3IF7yzOpbbgVE6Vbj9od8CLZ9OT+kdHrLuB8PozcsHvk2Cwnhtz2YfOf/reOaX
         LxYVr60G9Asw/EGvTvYh1dEr0+FMUGfqcgT08JQR9cu5HVi0NevyYr85fEP7VhWnKZ
         mMkyTdLKCThq2CKt9+5Kh1LHe0heaIHicY/3Y79YfGIWuecqxap5oRJdr8hCWfm0JV
         zySQGX7h1Cq5w==
Date:   Wed, 27 Jul 2022 09:23:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Adam Sindelar <adam@wowsignal.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20220727092329.2a4aade0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oSGI8OS/MXqIFmRBQWohqp9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oSGI8OS/MXqIFmRBQWohqp9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1da6684b4930 ("selftests/vm: fix va_128TBswitch.sh permissions")

Fixes tag

  Fixes: 1afd01d43efc3 ("selftests/vm: Only run 128TBswitch with 5-level

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.  Also keep all
the commit message tags together at the end of the commit message.

This commit is also missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/oSGI8OS/MXqIFmRBQWohqp9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLgd3EACgkQAVBC80lX
0GyF2gf/fX/3deboWxvaAE5ET6Rz9zK++8uowf0yydnDUlzOo7o2Nj/fM7m4tCHk
ev+gkwdG+SZOL+BlDTfaD00xJeiE6xYKIQSYXVbikT53/2K+7FO2UmI7Iu8vy3oW
BMmROZgcjoAzDqbxdCaK7mTOjruf9b9NO40g5GxyaTzjNXt26nCw3Vn2llm/ZMdy
xM8fwrzx5OuetEUbwsXZZwa1DBpfojs0EiBVlgWIg9GPQ8UPMClfm5CUA6QRWflE
jzE3oC5lwm/9E87gtA6cfVnylJimrUvvzFmE9hCY6CnvcFqOrMDXMgpd615wwpWn
vG1pc66U8oiDYeXera9cvYgir2hw3g==
=65xA
-----END PGP SIGNATURE-----

--Sig_/oSGI8OS/MXqIFmRBQWohqp9--

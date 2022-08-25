Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5E5A1D67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiHYX5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiHYX5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:57:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C8C59FD;
        Thu, 25 Aug 2022 16:57:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MDKdH50c5z4xDB;
        Fri, 26 Aug 2022 09:57:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661471828;
        bh=w0fopPhFE2EysWvKVMY9Iy0kz1dPEYl57Vsh6jP6ALA=;
        h=Date:From:To:Cc:Subject:From;
        b=FcP8lQl3gOT+Lh0x8e7wcPoXKh1HU/OsMeoCq+BeFRvlaaiE38DKb+QftpoLWgoWZ
         ftQbkheIz/B1x238GMntq3SBoHD5Ku6U5fDfuTclBiGesxXeA3eItA2HAUZxaZpBY5
         CEXNvgnjqiKlxxJYssK5EZGu/vJoz1XbvozcpwZ1Q2kiotBDDDTjtiIgJ/ZY6keG7Y
         3CQXUmyiARRBC70ABRyF2Qe4biU1KA9KHxDSN2PGsYciTkYB2QT/cp2Q6lkbET0bWH
         +MCfIroovktWeoKvT+M9AJHL4wV5L+3hpNlTZo6Yz6EDS9uQH1Iy2+I+LiIRtqfzR6
         lM3oVHkaZltvw==
Date:   Fri, 26 Aug 2022 09:56:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the hid tree
Message-ID: <20220826095647.2484954f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DjWenuwu_gApy6l_3/aheeF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DjWenuwu_gApy6l_3/aheeF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  609174edeb75 ("HID: uclogic: Fix warning in uclogic_rdesc_template_apply")

Fixes tag

  Fixes: 08177f4 ("HID: uclogic: merge hid-huion driver in hid-uclogic")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/DjWenuwu_gApy6l_3/aheeF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMIDD8ACgkQAVBC80lX
0Gxj4wf9EFw5tAOU039trEwKAitCj46lQhazso07axNtSeDs+tuaqOOt60bR7wEk
p9geGLYeurinVNpKUzB4Pr6yhE71YII+qrYvMMUIbqrRWe4HdrHjrDtbUzWfgezg
F09c9/s4P/8nn7lssXziPgVz297xnhF98C5xr8dy0spXGqIa5I6iMg0cIW72lPN+
IkaUVLlkzxnfF40j35aLXr6PnSD4TWIi4HffuhRRIusqEbE5m6zMSEH1wGVc9Wh0
PIR0v3qRhhvcW2/6ZMsFkdMihT5n68pq+dEZr/zN6Ogv+saTM8oW/dobpAo3vuvU
V1fpvXML4WHxMSZrj/oNLR6CJR87Hg==
=s5Lp
-----END PGP SIGNATURE-----

--Sig_/DjWenuwu_gApy6l_3/aheeF--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE11E54A9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351039AbiFNGpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352363AbiFNGpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:45:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D92738D95;
        Mon, 13 Jun 2022 23:45:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMf7l6Mp1z4xDK;
        Tue, 14 Jun 2022 16:45:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655189108;
        bh=v4eMGv6F0pGDG8P6YwXKgBBRDsJE2uZVBZOU1AvylC0=;
        h=Date:From:To:Cc:Subject:From;
        b=VZLZ5WG/u0dkr3hXEo8GhR13w96FkGkqRlEIhHBghjEq3v2lN6/DfKxg/Y4AbxIwL
         CxUUGjTY5j1Ol8ZDeP3iBfjrpWD2UxSDbKVCwleeHJqdsYYViCgs0NcaZcuHj17MVB
         Krojan2ggb2WRnSx+qD2FR6Jg1xKEJ/QgDcPsDeXFtY+JWOUFBZ0l5si1HaVZKTKNm
         h/VmGNTtx0hyyQjXB7MRl2UBWvK7Lg3T/9hVNYsmgyB/gxY9CwwELa2YwaJdsweenr
         I1bP84gcDo5p8HrArqdGG13wDWBOy8EcE1nFN4SNcwLtcZsl2xRKrj/wa+zjNW16c/
         D7y635mWNIdZQ==
Date:   Tue, 14 Jun 2022 16:45:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the spdx tree
Message-ID: <20220614164506.6afd65a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7FqolVtGCx38vzdik+GL5n8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7FqolVtGCx38vzdik+GL5n8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the spdx tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/arm/samsung-s3c24xx/cpufreq.rst:2: WARNING: Explicit markup e=
nds without a blank line; unexpected unindent.

Introduced by commit

  b7bc1c9e5b04 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
gpl-2.0_147.RULE")

--=20
Cheers,
Stephen Rothwell

--Sig_/7FqolVtGCx38vzdik+GL5n8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKoLnIACgkQAVBC80lX
0GwGXwf+NAjxl7ZMHZnM7nMdwrWecmCHnHEhflX51wOi9aqTElKKfvHKnJ061qnZ
L3Ef676RyC+D0LF8gBYVPPma1jpnY41VTWz5oUb+hrWemugdi2caHoVXPgE/tWTL
X422TjP0u6ke+EHkvtU/a6KvD0HpjzazvDld8M104I9s0EeB8D0TTJATZ8qM2/w8
9kQf/OAoKV8s1VKRd2vkDWyER8Nl9DDHAEEHOCct4i7NVgyF8MKj88rRHSsenRiH
hsIB5hv4oNUIRQqqLdvTCW58NEUpvR/RlWpTZ6r4QBCiQ3WnCy365TsRCN0plbpU
vcLRT0lu6yHnMgqaNTXNggEWurWfbw==
=tGLc
-----END PGP SIGNATURE-----

--Sig_/7FqolVtGCx38vzdik+GL5n8--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DAF57789D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiGQW3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGQW3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:29:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3408BE2F;
        Sun, 17 Jul 2022 15:29:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmKXX3rjWz4xXF;
        Mon, 18 Jul 2022 08:29:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658096989;
        bh=BtuyYyEPMliNMGBCpxY9tHwKACJPgr79QtAHEnmrcSE=;
        h=Date:From:To:Cc:Subject:From;
        b=GKT8apuwzVwkau6D49r/ENwdJED0Iqj56dwY6mA9/4Y1sppNXk/q8Xsph50qle7dG
         5Wo5H2DTo8GCjNulg0se3omMtU67PwoeKDOaZJX6PmDwKWWSCj9R8QfA/xRC6siPfo
         GnBOLWUxUL9YoLbtXYXO4PcC0UhR8wj15Rcvc451gKKUrTOq6mKo9SnRUVPvb2xcnn
         pBuUMqRdNSTCeAEBUFWU0HRRf16FnzEL7NwuGAjbfC6reepgKtN5y51X+wcta8IODo
         m1sXl0MEBWF0MY2Zji4HkxaNqtZbm1YFq/ABLmPwYf58ivDHmL9ydgN9nB24ctcEg2
         4drtM2Hz4dgSA==
Date:   Mon, 18 Jul 2022 08:29:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb tree
Message-ID: <20220718082947.1ba585a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/irkJP.cZKb44CiBBj7h4BbF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/irkJP.cZKb44CiBBj7h4BbF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  fda0f59a3aa4 ("media: ov7251: Fix multiple problems in s_stream callback")

Fixes tag

  Fixes: ("media: i2c: Add pm_runtime support to ov7251")

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: 207f4162f1c9 ("media: i2c: Add pm_runtime support to ov7251")

--=20
Cheers,
Stephen Rothwell

--Sig_/irkJP.cZKb44CiBBj7h4BbF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLUjVsACgkQAVBC80lX
0GycZwgAkqHvtYt/HvyGgtQKtPfQf0l9aqLQFAiV4PBz2mLmVpuWQmUNlSrpp2YQ
kH76K56jO1tvinOQawIr+U05tP8XivizG9VTJ7MYpIlGBwyWt/xwn6rHBtJPwp/C
JYcwdnzV4SNshaXBGce6SzD+8lxcZWhGUXjZwqWM6h2HYIlntbeAynQ0m3iWarrs
I3RUvVy7jOjT8SvIvgUOY3AGCLNw3lGOJhejiynZ4EphAjeWI7yJQdkHmASJEgbo
1GbMB8HZ3bNxJOa69v7bu8AOQ+hmWvfy1ZivQ0dDXJ2Rl7RfQ9H/s3JEDnDofsiS
buoHVZ++Dou26GKPXVVRmQ7VnJ5S1g==
=Mj3l
-----END PGP SIGNATURE-----

--Sig_/irkJP.cZKb44CiBBj7h4BbF--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE174B1D44
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbiBKEJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:09:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiBKEJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:09:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8BD95;
        Thu, 10 Feb 2022 20:09:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jw0Vl3NPqz4xcZ;
        Fri, 11 Feb 2022 15:09:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644552561;
        bh=VUVojCKKHWJKmWHANxS0TOL5/b0Vvl062S8oKMsUMXU=;
        h=Date:From:To:Cc:Subject:From;
        b=X4BafQYNtpR9G23Lo5DB0dMiuWtJPpvuPKrmkUzS0D2FfFFfDfvYxnTSW/7/eGBmJ
         ze8E6zWE3H0G7DcrdFEANtSkTmt9kjvUJuV73YAUQn9oB6o/YQMMYewo87feuevoc0
         ILRO90NIJ1XJtohzPAQpl1/9M84p4JcSe1fNw7SipZB6jwAI7qB/0X8fcNCUFJiv2l
         k9+O4AaAGyRSmgRwvcZxAfjA6NtlbAhAKwrAWreFTBz2p49FTe+tffKLrzUL2IL/4O
         HoLf6wVxWU/ttQNT0Hf55FEcHOvFldAtHDj4B6qkUQWhHaZKdJeO2bYCqbBuQUiChf
         E5nNkse/p6bUQ==
Date:   Fri, 11 Feb 2022 15:09:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: linux-next: manual merge of the iio tree with Linus' tree
Message-ID: <20220211150915.712009a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RsAQV=bWgI+mxumJR4XMy9w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RsAQV=bWgI+mxumJR4XMy9w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iio tree got a conflict in:

  .mailmap

between commit:

  984d1efff230 ("mailmap: update email address of Brian Silverman")

from Linus' tree and commit:

  f3366f8e6464 ("mailmap: Update email address for Cai Huoqing")

from the iio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc .mailmap
index 8cd44b0c6579,76dd303c7eac..000000000000
--- a/.mailmap
+++ b/.mailmap
@@@ -70,7 -70,7 +70,8 @@@ Boris Brezillon <bbrezillon@kernel.org
  Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.c=
om>
  Brian Avery <b.avery@hp.com>
  Brian King <brking@us.ibm.com>
 +Brian Silverman <bsilver16384@gmail.com> <brian.silverman@bluerivertech.c=
om>
+ Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
  Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
  Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
  Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>

--Sig_/RsAQV=bWgI+mxumJR4XMy9w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIF4WsACgkQAVBC80lX
0GxDqQgApGlLLS5f/rq5gu1zLJ0oxN/F5zigNo1TdqjIKEFdZ8ti1IIH3pD9DgVB
Cev5hj4OWD+UTv+RG4gvFSYfDjfg3/bHWwBhS0BzdPevYhgM0pEIxeAEpsfa+zgF
0oU303tpGThx0Tti9MNDoRPMXBy1vmrb+n3zg4LMyMvdi/zQLUXigMC5fymywDaz
tBxJRIJWYtSLsrIiJ4eNN/tIU/D9LYquFXaGG8uB2/oJfPHjuxIpKd84V+izd/7+
L2xFam4MiSs5YSuAoDyJVvQRV1OtXFY20k6cnxCMLKkEiWfqKysRogVdEwHBL0zN
gwH8jl1GdLXIcIlV+eSsTJbWxF7erA==
=EWHb
-----END PGP SIGNATURE-----

--Sig_/RsAQV=bWgI+mxumJR4XMy9w--

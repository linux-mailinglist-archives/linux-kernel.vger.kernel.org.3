Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA0D4DCFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiCQVMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiCQVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:12:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87472274DC;
        Thu, 17 Mar 2022 14:10:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KKKYj6gkBz4xc2;
        Fri, 18 Mar 2022 08:10:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647551452;
        bh=5Gbcgm1/eQ2SEUxZw4dVP+MOI4Cn/0ChyocP6oFoSlE=;
        h=Date:From:To:Cc:Subject:From;
        b=oUz2lYwdHlGU0iI6i/ZePJ3wO83e/Q13JkUavaEvz3wQUA+lc2wxznN7jBIEA6BzC
         fkzIHd/LtoT52mMZ+ZOUxDk13CaNsyKEjSgkUdIydRqU/VCyxIFljLmgzJvqCYvGLI
         ZyOeFnYklT8xwH7me/yJJ1UNSp6r9aFet+98WTuQXQ0ekaYFM7aGwrl+6oZdXdtHVk
         HRsZXYYw8x0pfuI5/W0g61eSgC0tH3SZY0VRxC843qO1wU2HpGRtBNgFcVObQFcISC
         ricy3nBH5nW+U8eeTndxPqeo1SHkuJ04u/2lFUA0w9n01jqLArkfkmlgnEl2kxg62N
         ndrNOEuru0+CA==
Date:   Fri, 18 Mar 2022 08:10:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Fengnan Chang <changfengnan@vivo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the f2fs tree
Message-ID: <20220318081029.55bb053b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8ip6J./a2n9MBq0oguPPdYR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8ip6J./a2n9MBq0oguPPdYR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  3459538a3654 ("f2fs: fix compressed file start atomic write may cause dat=
a corruption")

Fixes tag

  Fixes: 7eab7a696827 ("f2fs: compress: remove unneeded read when rewrite w=
hole

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/8ip6J./a2n9MBq0oguPPdYR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIzo8UACgkQAVBC80lX
0Gy3oAf/aAaoLaajxrSCEtZ7WTEw3qZ8uMDf03hv2lIXD7SvBGL8NI4ggVv3K9QS
2Xc5BcUpXcEmCFdfGX4KZuxOMsgHnFg4lQZqRoUC5Uw+C1GEjGZzZXSQpkVg+bRK
pRtQAYFT+57Uz7xieQRAyXuxB1GY4+C46KCnd6RpsvQXAs9rr46c+Zmuof6/AI1v
GCbGKt965ceKGb265cborRddg+Wq10WjX/tUSAgoKngRgFgZ9KIAxgIYGcryXHGy
N+Sh8r5HGhTh3SeM0B13b+TDduVrDvxq2EmzDjiQgXbNFatfq0AGKwawfY2XyTWf
ottJVQsjSofSvcSQSAgNu5f3yNtawg==
=uddZ
-----END PGP SIGNATURE-----

--Sig_/8ip6J./a2n9MBq0oguPPdYR--

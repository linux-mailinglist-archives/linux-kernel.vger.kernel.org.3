Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68335B19B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiIHKL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIHKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:11:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07152786CA;
        Thu,  8 Sep 2022 03:11:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MNZf35Btwz4x1d;
        Thu,  8 Sep 2022 20:11:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662631884;
        bh=nhrDaWIOx3Riue88SzzVI1By9F+QCIAlO78rQFHqCh8=;
        h=Date:From:To:Cc:Subject:From;
        b=D8xgvbgpSG2rVP9bbU+6V2w7eX9hQRxU8MVrMt2SiWBawM/o/nBl1/fvn+EQ3U+s4
         92GAuE5q1+4QyucU15LKABXXbov9UnmG076iLcoDmmdDFBStaHZ6RVaSHtWbFuWqnO
         iWrolKEUawSnpinLmuoV/nQS2NBXyKFd2hj1Y9L7Zam51jr2NfO0LqDV0Jcm0laWiJ
         NFFIpfmb0z57PmlUuFzegB8peyxIWQkP3Mk9qgeUj+KjszLXbLijYgWhnbqHoZ7K7r
         T5oX3iRvpcXdEbCCRlE6kBnKU5Bvzdwo/bqOAQjYTiQsePWyjgqb5IFyfMzfLnNHTw
         R/lUEgXyE2QIA==
Date:   Thu, 8 Sep 2022 20:11:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Sindhu-Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the rdma-fixes tree
Message-ID: <20220908201122.69e705fb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b+hm+6p_DnfK=KCPTZjS/i5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b+hm+6p_DnfK=KCPTZjS/i5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2c8844431d06 ("RDMA/irdma: Use s/g array in post send only when its valid=
")

Fixes tag

  Fixes: 551c46e ("RDMA/irdma: Add user/kernel shared libraries")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/b+hm+6p_DnfK=KCPTZjS/i5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMZv8oACgkQAVBC80lX
0GycFwf/V+EOm0RAfFUbReeDYXvP0t1g593I/2cirk2JKRRMoZINZjx8s1N4IfKr
Zlt8mYmyMUcujnu/BxKTlEcTlvlCyksZhuNxd31g48TKP0FlmwC2BgdhBzRpE5/d
jD7qstpVY3HJbt+MBcrQljWYF1m5zlCjSwxXgKveRvn2asNZ0YchGOG7cnf1D59A
J1deMJXou6AYqXy/JFFJeNJiJHrHfWJgBCOqgxU0SQ3fQ0poBVm3JhL9R+BQk7zh
8wiD5jdvbUh+yfG09vwGX/kBqPt54DsLH32Hse/X3jFBq/j1Hs+z1tg/3+UVWEG+
dL0RiOtXIOC1F2/m6o5oA7NVqxuUsw==
=12/m
-----END PGP SIGNATURE-----

--Sig_/b+hm+6p_DnfK=KCPTZjS/i5--

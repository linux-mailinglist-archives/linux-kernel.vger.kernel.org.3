Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524254B9A36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiBQH4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:56:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiBQH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:56:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B66423E5D7;
        Wed, 16 Feb 2022 23:56:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JznFb3C5lz4xZq;
        Thu, 17 Feb 2022 18:56:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645084563;
        bh=5DkXCu6Qn38xUQrfa5eFKYn/4OPnVVD/X7PTWonvSsI=;
        h=Date:From:To:Cc:Subject:From;
        b=r7zUn+evoJqk8L8+Gr2XlcKUoGzT3Ec2cFd3XVMXWe0evb8s0YhkbTm+OazvTt0z5
         kvUT+15dBCsEGcYaNbCAb7C2LKUVAuRtksmiuAdeJxeLiXDp1L+fHfM7/wvLApNCe3
         lvNtzWEHlvYgX49JyMVJy90d68jQWCy0WheubWymn7OwZMxdkvpuWTeLR9m/CgdyLs
         sz8z5vyTWj1TsbZfSswXZejot9yNLEx67gxwiECulkULiPNOpq93kvnPbdeEoOaXZF
         xMGqmhsp0gx0tdr3c5x5f9qmJKnufDahW3lXbECkNkHblhQT3KgeKzhlTT5ErcAm9W
         6B9iNXp36V8MA==
Date:   Thu, 17 Feb 2022 18:56:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the maple tree
Message-ID: <20220217185602.78adebeb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SU0cL.PEctrX14xgXbTbAdn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SU0cL.PEctrX14xgXbTbAdn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the maple tree, today's linux-next build (i386 defconfig)
produced this warning:

lib/maple_tree.c: In function 'mas_wr_spanning_store.isra':
lib/maple_tree.c:3941:1: warning: the frame size of 1040 bytes is larger th=
an 1024 bytes [-Wframe-larger-than=3D]
 3941 | }
      | ^

Introduced by commit

  4af8015a7707 ("Maple Tree: Add new data structure")

--=20
Cheers,
Stephen Rothwell

--Sig_/SU0cL.PEctrX14xgXbTbAdn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN/5IACgkQAVBC80lX
0GzhCQf/Z/5crA1uxBbOgvXbKsg+rVZPc/c5cVen8oYthQNcKYshZwOCpu55IVe7
DuMlITd3kzsBfklyfCSASVjkbLdkdXdkzTih9U4pZxDfvNz/ZZI6ZoIsiMAZecCp
pz1NaM9T6ngK3vXrNMiqe9rpQ5GG015lQv/UjF5FpL6N1sC0XoUnR+50quSLzHYw
do42q2nUgrca70uJgjID56CehGvwPCOVxzO9I2Zevht7Hw065W3Htl3Sdq7AqFAN
ODm8aUGoLqu/hsqaiDGbeIys7+PUtcBaTaUvd1HZ6rs27gl34sPRwb/kq8+RdDFn
oFsVv4Z19ZH9fMs6e4JW8P9BNu2g9w==
=myvA
-----END PGP SIGNATURE-----

--Sig_/SU0cL.PEctrX14xgXbTbAdn--

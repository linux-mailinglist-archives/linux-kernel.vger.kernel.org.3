Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D266F534669
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbiEYWYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiEYWY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:24:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC63BA99C;
        Wed, 25 May 2022 15:24:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L7lwj5Z1Bz4xYN;
        Thu, 26 May 2022 08:24:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653517461;
        bh=GcX1zrOslcSNVPuexCtnllZ4TxAh4B75ZOdxWYYivCE=;
        h=Date:From:To:Cc:Subject:From;
        b=DkXT4v6cH1j9iN4srmywiCpQ4lNNzHZwLjF3PQS8w80r8svq2RkBJVQ6dN7x9JcEp
         rtkoTR6cANTCTDi25RrDarYGuRrL9XsvjngPuyDkzpEAbMv25CpesObP9qNcHFbrZ9
         eofnzzIPWc99OFL7w8FilscGwT+x+NbExQ/CW3s5o2W6S5+mf4rT9JvzN6W68XGW89
         0neoReuYioTitAlerlyhjTDcxj5mnA4rbkZys4qE/ZZkME4rtnCH5Dq/Ut/EidguST
         NxMPI7ZP6e91T8FYJV6BTpCB+H/wc5pV1aZctpQTYEqbOIJPyRYDL440GcaWgUpuLu
         Ce3tflQa7zOqw==
Date:   Thu, 26 May 2022 08:24:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20220526082420.0717c1f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//JY2oR0yxyzAzNk9jrfEofX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//JY2oR0yxyzAzNk9jrfEofX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  a92c6daedb08 ("cifs: Remove unused code")
  d0c4bb4b3c12 ("cifs: Change the I/O paths to use an iterator rather than =
a page list")
  da59e9982665 ("cifs: Add a function to read into an iter from a socket")
  13ae847ba07e ("cifs: Add some helper functions")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_//JY2oR0yxyzAzNk9jrfEofX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKOrJQACgkQAVBC80lX
0GwFUgf/RP+nXfORLMUFrIUoJRxJbFD2qX2590trrgmZmSXDircgQM+UOx1s8iWq
ndO+kJLpnLdzqGLqGcH32QRbceM/aJr6nzmGw4c7VV0BTFFo7logN6R9i9Q595Jf
lpaDZbpHsLj2t4GcCni7ix4qoboDmzvU5tg7x6577pIM8kgzVUjrZT5rX0IBqfK+
86h+eDNEA96/f2z+htbU6maOEV2Ps+s1dq/b97G334aFU8awKn3XS3F/38CumcQC
PyZtyxWRCkieqVZc/+MQLAq1W+0XbCOKDjHMlXlAkzODgvunfzOpVhn6dk/8YXlu
daV3ZmZ+stVNPm0pFtv66mCmzYyGhw==
=cfgT
-----END PGP SIGNATURE-----

--Sig_//JY2oR0yxyzAzNk9jrfEofX--

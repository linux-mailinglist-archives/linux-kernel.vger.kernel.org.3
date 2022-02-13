Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23674B3AF1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiBMKpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:45:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBMKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:45:11 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A87C5D67A;
        Sun, 13 Feb 2022 02:45:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JxPBQ4zqVz4xPv;
        Sun, 13 Feb 2022 21:45:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644749102;
        bh=rc04cqWIKdAAbQXu6l3QwXyrgGSEPlAdKLhxMCoARX8=;
        h=Date:From:To:Cc:Subject:From;
        b=eXn45UNKV4dgnz2E3nNRrKQBLA1l/x48H5fGS/3XNi+iV3ElBqY97DO+PQpgtz3ox
         N7jeeVaaEPI2wbZlvI5lQOtqJ7vMCrGLoKGNj+4ZTQSFPH5QjtdntNdUYoPHJjHFMV
         0goWfsk8Z5Vp4iI5TZZHb8uqh1V9W94eIezeAYP+TXADGOABaBKf1ww+JyLpmrRzs/
         PxmZPW07zFw0IdPDraRXIEeiE9TXRNvD+iMHj+5/srVPZWJcdWwuXw03UBfE67WCTG
         8JZGVVwPKVQBZcZWqzPSPbaUYw9Yh+AIfoHBxT09w/j4qO8EpKv+v2Ju5LeP14ay59
         WYfAhmDlNtvew==
Date:   Sun, 13 Feb 2022 21:45:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pidfd tree
Message-ID: <20220213214501.4e2961a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mSzW0hLnaiYIU0lG/wX32VE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mSzW0hLnaiYIU0lG/wX32VE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  fdadcbad209c ("fs: add kernel doc for mnt_{hold,unhold}_writers()")

Fixes tag

  Fixes: commit fbdc2f6c40f6 ("fs: split out functions to hold writers")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/mSzW0hLnaiYIU0lG/wX32VE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmII4S0ACgkQAVBC80lX
0Gx0Ggf/TXumUWseGRBhi2TxzNUBcjsYw76X+2Q+Siaqk4OkTjIUJSu/sAsxe8LS
RRd4gtAaBhIGzxYE2TQfIi2JI4DAHoyrpqSvONl+rOl5zQNfyksJr+mMjVdqu7DI
+AfKcxArxTgTsxDkmIT/R0487SCNPlew2SJOkl9AY1PrjnL9ccpe0eBGVq3ig7GK
NCUUjUz81itSu61TaFjp0I772cb1UPTEsES9Uqq4Y5LIXjaW3pUyRzZa8krRed8Q
wCMWQbyN6zfB8MDiJCtr1hXXe2vczxIkAI29h9/B5qe197dIRYWYOeV3XiGzYcI4
MnKS7q4hsPUfxNElPK6weTQTJzOgDQ==
=440v
-----END PGP SIGNATURE-----

--Sig_/mSzW0hLnaiYIU0lG/wX32VE--

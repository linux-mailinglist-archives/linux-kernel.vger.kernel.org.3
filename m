Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15C94AD153
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbiBHGBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344115AbiBHGBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:01:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D048C0401F4;
        Mon,  7 Feb 2022 22:01:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JtC6x6pc7z4xQp;
        Tue,  8 Feb 2022 17:00:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644300058;
        bh=ZZCpdlEQ/Ema3kcAjqS0xWynAUEivmo6JFYv4IqdiTI=;
        h=Date:From:To:Cc:Subject:From;
        b=rdTyD0XI5BW1CflcbNoU4LcI2oj1XK6VhnP7GpHKMy2+b6kgfR4e3ShqiSGOlisKj
         qvvhms4gUvuCf5VKV5nnXcBJ2KDUKxJOOy5JDxuOsaiMgTY/+TnOuPE38jHMcv9v1p
         3hP38sCC4RwiyrQupoM+LTzZdArPvsyDKETI2ag3SYiQxBlAMfiqbYfGh0SMthwDNn
         7yeFOrGW5MReG2aB19bK+KH3EWq0SLHlLXHIsXqk7QnlaPDSdCydCc9C7zCWnEK2wU
         +Sp4RZJL8Q2wEolc9orp3Cb+7c4Ov+tBf1DUM69lGCnv7+6eXankVqdap5Xbp4FFIH
         w9vqUrW3AfC5Q==
Date:   Tue, 8 Feb 2022 17:00:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the nand tree
Message-ID: <20220208170056.0054db04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sz5HOOyHujCgeI33/b5+Sy7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sz5HOOyHujCgeI33/b5+Sy7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nand tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/mtd/rawnand.h:1307: warning: Function parameter or member 're=
sume_wq' not described in 'nand_chip'

Introduced by commit

  0ff4eb01ffb9 ("mtd: rawnand: protect access to rawnand devices while in s=
uspend")

--=20
Cheers,
Stephen Rothwell

--Sig_/sz5HOOyHujCgeI33/b5+Sy7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmICBxgACgkQAVBC80lX
0Gx/dwf/Z/uiBzdS580OY3aHIaRG5pxHUeLvvmkUdnn8/Fo3rDsP/hBHrYJ/fE7d
LdEQkpb09EUs7wCWCZ5ucGRwTVN7eLjj3Ns6Wg7m6DaeeQ9rMYJqgG2m3iWGfiQg
qz2/jwEyjQ1zCnxqqxEm4KeKsaZ23yanQ3tnIHthEtvp4lkePNqA8h0lfUDAb8Fk
GoeRMuIAhhZzwpIS2r40MYpVlaabqZ6Xj+DqEiH4KVOxvMCa0vnj6/anH6RHnQNd
ynQ6Ic6RIxdYd5Remi3rmz5/WQEuoR2a8nPe2GbXIjVdrz9ocLOOVyLmEGbQRJIS
wvWM+6P17SoOzINgRiMC0omoKLLpwA==
=fywy
-----END PGP SIGNATURE-----

--Sig_/sz5HOOyHujCgeI33/b5+Sy7--

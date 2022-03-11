Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B004D6778
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346517AbiCKRWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350721AbiCKRWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:22:47 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3798D1D304B;
        Fri, 11 Mar 2022 09:21:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFXm64SLjz4xLT;
        Sat, 12 Mar 2022 04:21:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647019302;
        bh=2dmlzBZW8U9nY/8OTcnnbBXh7K1ktmT67UC/6cR88RM=;
        h=Date:From:To:Cc:Subject:From;
        b=sNo5DvvQYMmQpHpGEE0s/WUPBeRB/JbwibtaC608glNN/jUSoUXs8gkCMqK/9vc4d
         0uTmDZ7z3Ziz6G+yHu4D0OR2Vr3aLsGf04y56jX2OuduIWuvrDH3Ctzb+lphoh9iHX
         tWe19Z7A3+BsqTno/Br94hKzio3jz5Qx9nn6+QT7t0+sCqiFVdWcBWJrCAWZkOUzUl
         ly54OBXVqne9Qf3MqHqL3kv4RDL0n9glcKPo0qPxWomKBXCf85ZlCgk6Imz6n2RYpa
         zb8juMIHPHjPduQjXqrYrOsi4cJHldSKABZZwD47lxhcZYOex5N5yGbcmje2cFuoFB
         juzbZ+UBDFrrw==
Date:   Sat, 12 Mar 2022 04:21:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the ksmbd tree
Message-ID: <20220312042141.3a663549@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mmtlHnwT_sybQTsy3RzkLwr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mmtlHnwT_sybQTsy3RzkLwr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  88e06e5fde8a ("ksmbd: increment reference count of parent fp")
  78d3a45c44d6 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
  6d21d63f1300 ("ksmbd: remove filename in ksmbd_file")
  07d033e29795 ("ksmbd: remove internal.h include")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/mmtlHnwT_sybQTsy3RzkLwr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIrhSUACgkQAVBC80lX
0GzAnQf/V8zJEBcnpmdMpJ4QPJPRsIp+YOh6xCg50I8+VN1F0uVZvjtyAmFgbIRx
xSMUZLO5P+4lSb2f0EqgVWjJH2iLiXp0EIgPc/kVuqN6cjm6he/dAUAvjRtjuR73
9YX9FMenVnusdNURYL5/qVOkhCm1I844HhR9grbueq0in33BRo1b91f6ahzQVqoq
WQ0eJjdC1mlJxF+18rs0iMUj+cYgzsS3aVfdLk6A27W3lROvyI2Zhf4JNdFXKpS2
q8no9Wt929b/Wg7kxjVMVpbcFKQYCpX5GobNUIZRrSFuho+8J1zTf1lzcB7V4I7R
0mvD2gvsJpoAb8UByrG9vrhaH12B1A==
=elvG
-----END PGP SIGNATURE-----

--Sig_/mmtlHnwT_sybQTsy3RzkLwr--

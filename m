Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6950014C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiDMVoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiDMVoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:44:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B4535DD0;
        Wed, 13 Apr 2022 14:41:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kdwz90WJrz4x7Y;
        Thu, 14 Apr 2022 07:41:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649886117;
        bh=S1t7soU57js9JWGNDRDegAoz7qs1jRSYfxB5PN4d/Bw=;
        h=Date:From:To:Cc:Subject:From;
        b=E+qThmDpcR7fgu0r4mA+k62a0PMmyE0etlSWtoit1X9cteQFZkCQFc4SUdMRlB9pF
         VLpU7HkQY7JMkxBp7/SdYoqtmV3x6LSWIXiyzPwzV9c+J2QXMKtRacs6rhnjWEZC4r
         JG1Ef2nUdug9O+1PVkMEEC+nH8D1tAgEaiwbrSR7qbk/n3hoskrvgJpSgboX9YpDd2
         2anLalsuFrewOlUU9DFe7gDsGfd9HirjdpcuQZqWjEDcYWsZTGxWITat5IGkfvaoTc
         B5onoDcbYuP2D/37jUQjHJOLKbHNbSd/TMWuAkmWMI/LKImtiWryCrSMlbCNHnnO5p
         geEAXf+lKwdIA==
Date:   Thu, 14 Apr 2022 07:41:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the f2fs tree
Message-ID: <20220414074156.2c454505@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ctXd1eiqxaQokqVSKRg59An";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ctXd1eiqxaQokqVSKRg59An
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4b6857882c90 ("f2fs: remove obsolete whint_mode")

Fixes tag

  Fixes: commit 41d36a9f3e53 ("fs: remove kiocb.ki_hint")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/ctXd1eiqxaQokqVSKRg59An
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJXQ6QACgkQAVBC80lX
0Gy6ewf+PiWrcG/QyYJgbvK/MFjNsYYAOrMGBKZNAYkaz3mKWB0jlu+3Moi+B+0s
ZW+w/qv43rwNTn+CMgTe7SeJ9a3trsb6bDYPeu++DBmgSG5vraqlTogdMpFubPSj
PGb5pUhPuuTKBpm4/aIG2gr1yZgfqiGAUXFy66N80CVr+4YAY9k1D8YE78fcOUjf
w1hDD23FA/ye12PYJTwKKUKlqEi2RDraIL2QCp0h4r5jWzQszGreBjVSHEPx8MsY
MHp9Qz0e0HhV7ow1LpVtE0l9BRUh7zXQbLyP3JQacLCbmKP9O4SUFJ0Xs9o75zih
kuLCLbm9nNhx0JQbPv5lYKXgU6byyQ==
=IB2N
-----END PGP SIGNATURE-----

--Sig_/ctXd1eiqxaQokqVSKRg59An--

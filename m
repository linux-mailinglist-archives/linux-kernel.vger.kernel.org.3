Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D509C54A1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiFMWQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiFMWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:15:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038642C67F;
        Mon, 13 Jun 2022 15:15:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMQrC1q5qz4xYS;
        Tue, 14 Jun 2022 08:15:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655158555;
        bh=CPqoRx6jFf/Uk//ngMt58JurfE00cR2plqehG6AYzk0=;
        h=Date:From:To:Cc:Subject:From;
        b=SJFlxhw46CIu8v+9QZmIlSkwz9Kb1aw18UMKo6V9IBL8L+d9KHB08/QADvbYcGW2l
         TJQV6qqmYIGe12IThQr3H6HTr7oyt0cmtlUXWMKI2z8Eb7iUFOtCub+qdg/0DrEG0y
         2roC4giGGWI3et005vAY6wqq9CduhFUc8DU/Lb88uHmfpnfjlabVYspyKHkz0/9C/Z
         jcc2YxLJYGv2fiOLbb8Kb3UormSa4WWo7PmLp/SHmsMoj6uYmvhoExLoV3S+zRdjST
         Y1AEuulvfw2Ps6SrK9MJeKLyMnESegSwVXns5kLswb7/qZC3pTNe3ZNUdEZlUYUYE0
         39Je0amaZWvZA==
Date:   Tue, 14 Jun 2022 08:15:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Jack Qiu <jack.qiu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the f2fs tree
Message-ID: <20220614081554.2be34f1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w1k2f2relOWYd8oA5cH+AJo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w1k2f2relOWYd8oA5cH+AJo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  dd43bcc205ab ("f2fs: optimize error handling in redirty_blocks")

is missing a Signed-off-by from its author.

Maybe all patch postings to the linux-f2fs-devel@lists.sourceforge.net
should have an explicit From: line at the top of the body.

--=20
Cheers,
Stephen Rothwell

--Sig_/w1k2f2relOWYd8oA5cH+AJo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKntxoACgkQAVBC80lX
0GzeuggAmqpIJ+Fq+YnAvxIQ9dMGGizzicjgQ3StNgOLYZFAB6FEBXx+JJxWrKWB
03KW44uPpeFxhefd5U42dYXDIW3X9s6dlPvHDM4tBof0R2rwxinnHzjIYWLTixr3
iSuZSmXj8S1z8ZkwxaPVvtpulY7+xmNE87HDaeMovRcdJTUGEaDjJItyVH+DaaOO
EquWtDw9R6tnGYHf/pom5CCkfn9zpStRpnFQVZ+s5ahABIEQtjZGW8SXC5EhH44K
eCHrjM2GYYu/nkyj5mETumz3/PUkLqpH5y98YelA7BNI3tN0HZJtbZsyN6Z29gG+
0yjhwJlSC4ORp0NEOg6547pbL2cxzQ==
=1MTK
-----END PGP SIGNATURE-----

--Sig_/w1k2f2relOWYd8oA5cH+AJo--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811C14CA375
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiCBLVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiCBLUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:20:49 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A565FF3D;
        Wed,  2 Mar 2022 03:19:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7s8p2WDPz4xvK;
        Wed,  2 Mar 2022 22:19:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646219994;
        bh=EF91EKCuPV6PsFC9pwzGkvrvy6Suv96Fn1u4qmkDwGk=;
        h=Date:From:To:Cc:Subject:From;
        b=QOSYjsRttDuyhJ+oCjzY+nUAmOIfKBkgV6FKZRt5mneLuBxWv1Wy3+BiC8rH5+xJ9
         lhoYXKBDlUKBgeFxYvkj0w7Bk2KVxRwPhX5mK9yzylwh51Ryu6zHc8gd/EyNxW89R7
         1gSynv6+vKcPJlhHdlq2juhpQOwXH/ydMZW1X9HjemkLzH4GqlvhUDOvBUK/bfmFEc
         s2/gOnswjNA9gQtQOcAyA9ZUVYD0eNCT0WmFErWzujiFo4Z0SUpSrvFnuX7Yq5QPob
         AJU2UANXsEZNZ2vB+iG2PBcXV2Edh7xu3Jm7rjkBCSn6zprUublTkGNAtNnCu7FugE
         diSjYXQEOz9wg==
Date:   Wed, 2 Mar 2022 22:19:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20220302221953.1d925ca8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z8dj8JCBNgMJ7q5CFIsT/s1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z8dj8JCBNgMJ7q5CFIsT/s1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  1c9566edd537 ("Revert "soc: mediatek: mmsys: add mmsys reset control for =
MT8186"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/Z8dj8JCBNgMJ7q5CFIsT/s1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIfUtkACgkQAVBC80lX
0GyH1gf+Or1EBPoQC/6h2CqSofn0mxDh2p0MKSupYPzxYwTigwsMAT1ZyE7BFhHb
IyHBvr2rm8JddtqLAoFtQOupBV7sooNYcAEDSTeiz4abR6O/mEC5knELRbmqV3n4
tqZz4CvrOVrfx3oNyHgV1+yl7IeO1UWKkMo3utz/a/r2VsI/4cH9coRDf2x65mO5
0rN1fDeAwAEvH4OKcyynnjEzM7YioMXXD29O+O9SqPeFOLf1trwKBGeNStOgaPhD
nkqdtqoagPNHHTcVpDrQOGB1Ca6RXPm/qBU+hIfdJtJCMoBWy/yJBP/ENfCuLOUt
IWXdrPk6T+WD8SWE533SwTPlFeno5A==
=aBL7
-----END PGP SIGNATURE-----

--Sig_/Z8dj8JCBNgMJ7q5CFIsT/s1--

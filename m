Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93A51690F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 02:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379508AbiEBAsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiEBAsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:48:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEB52AE0C;
        Sun,  1 May 2022 17:45:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ks4B50Kvsz4yST;
        Mon,  2 May 2022 10:45:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651452301;
        bh=Tsmh1GPH5ggE/QiTp+T90VkpZ8nezLMIPO8p25HS+QU=;
        h=Date:From:To:Cc:Subject:From;
        b=BcVio2Wk8rxgwHNDOP+fIty+1jRTGa3baxAfvhJzhEKYahRHlBz5ucGKOZ8xoXJys
         gzowZnvLJx0L8Mah8QJAZJAk3jJosdd+orX1ZbXjSdQG5nX7aM8aAqhvP+C+QXFHkZ
         SbTylC9HdjzSWqN1rpC+FX2bejfb8XIOhu2VP4fyYIMfoJklsVDxIPqFf7jgTedfPc
         FnQ/1LhoV/Ohu/WnGOEZNkboH/FiWtE9Z2gplyZ4ONYUTQlMTIp9w9RkH/ZmoN2BD+
         z6gdm3ZPiwyK+DNBgzQ1eQoOdRIM4KYwj48YGhm/ztoMmev65zr7EAbR+KnepjXAww
         ykWc7aeOL40zw==
Date:   Mon, 2 May 2022 10:44:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-bys missing for commits in the bitmap tree
Message-ID: <20220502104457.5fcd1141@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/utG3gWfgcb=i.JkScNCvuVb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/utG3gWfgcb=i.JkScNCvuVb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  34c148a5c18a ("lib/bitmap: don't implement bitmap_(from,to)_arr32 on LE s=
ystems")
  73bdbf9cc15e ("Revert "bitmap_from_arr64"")

are missing a Signed-off-by from their author and commiter.

--=20
Cheers,
Stephen Rothwell

--Sig_/utG3gWfgcb=i.JkScNCvuVb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvKYkACgkQAVBC80lX
0GzqXgf/UkQ8MxawoGftarx4Zfx+rAJwdeHTtv6/8O16sLQm6tOndyf+sQ0eSuWr
H7/8pDsm66xayPmrSKjVCUlBCklqnBusahWhyeD5iAhYFTKjnFe2Feu6cAqL8alj
CpRqzzeOftzXK7kuSC6W5YJ+VkqC7dR3yjNsKuMLpqnsCMxMc1HnHW+EflgWg3a8
5EnX7VKu+UlW2Pd/4KNx7Ret9Pr7m4Y+QkQ5i8k9730fugTyGBHwqldlN4EwVuho
BJ/ADYhbf4j0vA0EJQhUsWoAFIIoFdlSEQlxtPFJVBWQvk866SJXG/VkqdhFNtdf
B+H0G3slfpGlxY0sjuKMlkuMcvbqJg==
=RbTh
-----END PGP SIGNATURE-----

--Sig_/utG3gWfgcb=i.JkScNCvuVb--

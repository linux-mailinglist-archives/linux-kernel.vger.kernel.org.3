Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69EB5526BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238954AbiFTVv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiFTVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:51:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CC51A064;
        Mon, 20 Jun 2022 14:51:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LRjzF1GrXz4xDB;
        Tue, 21 Jun 2022 07:51:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655761913;
        bh=P20hJGueQ+TlbFzqWZ44ZVVemwRlB6d8HHlOrayd5OQ=;
        h=Date:From:To:Cc:Subject:From;
        b=VbWpbq90XlaXIyJKR7xT+kk45W4rtPKlyaXARnyuyXLkKKJEHLycJ1WNKN3kumpLz
         jZ3cnHGZ7xlmhLOV08arXxzHtikEBCh+BupAV9/oj7rfV4NiU9LoQRUuTBN6pxnH5e
         l8ktk3YznBEKrocz31bTjzASxGjp2/c9G/WfwuoJnCOCKoiaNLhpUgTP4uCEB+DLFv
         HrW9PWoCrON+R7YP0+7LlUCZhrXfMeyh86tksj6Qi+cECSo6Bw3hpJ6l29qPGTfXV3
         kx2jRZLhHaSYXxeggYJSQsNRt52HwppQKoFuhEwde4utFSrM5bJSSMF3WK1bevvf6L
         0QyPBsGiMe8ug==
Date:   Tue, 21 Jun 2022 07:51:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the stm32 tree
Message-ID: <20220621075151.1c612be6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2VSfGPI0Bcd7h3bVoeRN.+f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2VSfGPI0Bcd7h3bVoeRN.+f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b3c4c7346bc9 ("firmware: arm_scmi: Relax base protocol sanity checks on t=
he protocol list")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/2VSfGPI0Bcd7h3bVoeRN.+f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKw6/cACgkQAVBC80lX
0GzgVQf/foeGc1UCGDG3UkSt9QCJGthgQejurAUanV1/a8nYN9jL7ba/0zktwwTu
VCC6h6jn0LakP040wbbssIASBLKv+T1egmO9IRpB7Tm3Rn/Y2uUyyxXETG/w/EYb
uozrwYsoE/51QiijDSLuIM2PmhXdKkwpeP2ZJRcBXfS+wHrS1jW3L6TQ+VkB5Pze
hKIF3Xyg4jk9+kXoqEEZACHNyOtv3Xl6fxEwj0HqcdGtlxPPvMVnEzMXKdz9a388
kGhZiygCdrHBK+hCrYXJWQgkUVLXbhYLqFoxmPZSwTt7G6+6mgCnN5cjItN0sKzu
1WW+MvuhyhMUvto7SrfSyo06PS0gSA==
=bFcy
-----END PGP SIGNATURE-----

--Sig_/2VSfGPI0Bcd7h3bVoeRN.+f--

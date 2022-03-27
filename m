Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A211C4E8A2E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 23:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiC0VSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 17:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiC0VSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 17:18:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC5BFD39;
        Sun, 27 Mar 2022 14:17:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KRTDH2kRGz4xNm;
        Mon, 28 Mar 2022 08:17:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648415823;
        bh=0kdN9zM+X1uRZiE2ZBmkfo1quRCkCUYeKbqtkLzz1B0=;
        h=Date:From:To:Cc:Subject:From;
        b=LKf3+c3kj8g0SY0ETjV7Bc+n2wLte4ChEjwMsFqQ1YYVgk6Kwe8FXCG4XmP5eKbRP
         KJO/HEbahrX48Qh90NMjjbJ9pRPmhSr4g2WryMm+w/BKVsrfOV2Atkp6BfsR+aJZkx
         4Dm9i4wn9DmqfQXaoI3dGk6iyNLsTcZoroeA8jn6zCoXCdyUuDyIFjnV68epYn/G8S
         fnBdFE2DB904ctSr5H5Zvcm7Fm3hxt5UCpavOcUI61O3rChfBOBwWlC0tha1eUG/je
         A6gyRYQFQt7k58DznoRKxVXRvLs4FlcqydLaODt7Ga/pcs8Yh0hCSqbiynw6NEN+D0
         Zx29Su+LSSoIQ==
Date:   Mon, 28 Mar 2022 08:17:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20220328081702.31b8c45a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xgSwUTHL+iyg8B7fWXz/FXx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xgSwUTHL+iyg8B7fWXz/FXx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9e349f23802b ("gfs2: Make sure FITRIM minlen is rounded up to fs block si=
ze")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/xgSwUTHL+iyg8B7fWXz/FXx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJA1E4ACgkQAVBC80lX
0GyTOwgAlGx1vFxpStkNSmIg8ECVICUB+K6iCf+QDxX4nQVQc8y0OIrGIusJt7fA
5Mw6FY3DO/xTO8oo67k0U7kgksfY1z3sJTzErxDIDpdQFNWVDOgoZi7yDkBEaGuc
bM0eENFwHaC/7RfTnxTO7zErq4GSOgC3xhgnkzgQmdj+2bubObLMKYVAxyD5A4b0
0H17cUSmBiDH4meFWiLHsuO8TROyba73AV+O6GjYbtij/8j0AiIVyfeHI6rHgmFb
HPLHd2f9ffoOas5mSqIK96svh0LVvdRiVqXXjkAACQCUafgQRc8+0uyGRj7kVsJi
y0QcExc6AazupyMr7Zf/eUCPAsjxtQ==
=9Zva
-----END PGP SIGNATURE-----

--Sig_/xgSwUTHL+iyg8B7fWXz/FXx--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD914CB08F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbiCBVCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbiCBVCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:02:13 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2377DBD25;
        Wed,  2 Mar 2022 13:01:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K863n53qyz4xcP;
        Thu,  3 Mar 2022 08:01:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646254886;
        bh=SQUuc3pybNpsZ8c1blUw1EbYy3GfHMBlhW9RHVMoqao=;
        h=Date:From:To:Cc:Subject:From;
        b=Du9og/MyYKgDTOobVi4U0CYVKywdskIZFGVoA/aKoS58xYNkyVIlvEJ62HX8is6tv
         ih9XKHNFUEYNYchn/JuuDQkH6xKoL4seNHWly4dZkmnXXntWMY7239K0Fqdb9/D4ct
         bLJMjVuoSr9Su5KlnhPDUaxhfMumjwI/9BVyu0hv00bnm3s4I9PAluv2S0ESONoFyl
         6Td3sGScqPaQLvBZ6Hqz9is3JcWqBh2Ngan8eUGPfWj1ae9iAPcNJVnGSoCXeibqHW
         Xa+Cy40swvjv6hw7GCTC6ZlEl9i6xvhPI3Cz5AB1AMa5o7ax5Qu6oM0BPimfaltLkU
         JXYgY+GbbzugA==
Date:   Thu, 3 Mar 2022 08:01:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20220303080124.32dd0d15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ICDADcts05.GOWJxqhjO1BI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ICDADcts05.GOWJxqhjO1BI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  de2c6f98817f ("ASoC: soc-compress: prevent the potentially use of null po=
inter")

Fixes tag

  Fixes: 467fece ("ASoC: soc-dai: move snd_soc_dai_stream_valid() to soc-da=
i.c")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/ICDADcts05.GOWJxqhjO1BI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIf2yUACgkQAVBC80lX
0GwJ4gf9Hgq9pA8em56U1sZ8Cx8BDiV+Yu4kfkOT3Psr9mdodRUwwNjrx95DmZLE
+qIK7H13elHstBFq5DFoF3EYakiwed++XMjqmAHkX2Z/1hM7kV/tw/6IvhOrqmXB
miDwXdNQvkbqVeVQAnpSGsq/QdndCsda6Jco5YvJjy8BY7Rs0fHE/6CeiPl7FBPe
med5DkfxLAsrM0vUjuffQjSuBcZi5sHfNYUkTVxr1z1N4tkIHAVV2rFj5g+wTapT
JwcbU/KsAwHU2I7uNFM0DWQOHQlgPtHta+mt/RhtSMZm5NxTXmWHRE9rsA1iqnMq
oClqCxGf1Kqsv6/vh3PW1LF0SxPIkg==
=Q5TE
-----END PGP SIGNATURE-----

--Sig_/ICDADcts05.GOWJxqhjO1BI--

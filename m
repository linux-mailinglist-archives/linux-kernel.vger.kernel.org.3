Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF9C54276E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiFHHCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348949AbiFHF6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:58:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869523E9EF0;
        Tue,  7 Jun 2022 21:30:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LHvRM2SSnz4xD2;
        Wed,  8 Jun 2022 14:30:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654662640;
        bh=Sv3uWBzA8q3/6PngmwAEfumRDgBiDediNbKLISMb2Dk=;
        h=Date:From:To:Cc:Subject:From;
        b=UabP+SC+e8cqaGY/HZXhY7km8cWTzakkl6TbYNDuvfc6PiaBJIdIL+TVHsnu4/dFS
         UhdgTdP2DM5hCEEU/VKhlq2uvgbQmEdPBAnoOtlENf7ka7PruX9gF3DXNOKs44o30E
         m/KoAFnO/VWzKQhWIsD5H8Xz8GVSzi0b6qQHpnYhMToEOUbxJP4gaCSGzYIUEhxdn1
         KDZ9Qa6S42B1pt32gBx59Wfmjyqq4037SvnvcRzTKH2WOtqEiiqixnB1BzhXNRFltZ
         7ZLjyoqdASiMfS28ThbyQqLM0L4n/mH5B1A4c0E0wWgcuS+81DCs1KwtkhcNsXOkfx
         Qga8MMb3pE2ww==
Date:   Wed, 8 Jun 2022 14:30:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the spi tree
Message-ID: <20220608143038.0ef8365b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/98XL6OcGmW9VXLu_sH/MqaU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/98XL6OcGmW9VXLu_sH/MqaU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the spi tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/spi/spi.h:82: warning: Function parameter or member 'syncp' n=
ot described in 'spi_statistics'
include/linux/spi/spi.h:213: warning: Function parameter or member 'pcpu_st=
atistics' not described in 'spi_device'
include/linux/spi/spi.h:676: warning: Function parameter or member 'pcpu_st=
atistics' not described in 'spi_controller'

Introduced by commit

  6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")

--=20
Cheers,
Stephen Rothwell

--Sig_/98XL6OcGmW9VXLu_sH/MqaU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKgJe4ACgkQAVBC80lX
0GzB2Qf+PBFQdwcnjmaPrYBTu+5H5LaLknM7RETxcm4qyP9zyiX0J3HTgiIPeS0N
FyjJkxFoddnfDqjzcEF7NqX83r7lBx+qOXqfW7Vi4CrYLFwqgxpVFMPIo2s37mLC
5Rpzgjf/MJ1/Er0Qp3xpWbiglrzVJNnB+w/Qe1qNF5fXwF2CpEV4PsJJNWShwmwQ
hLla8eCophLuSSEYu02XrwhYIizq2RK+B6GXP2QRwrGkN/B8q1mL3M9TflrO3tcq
CqQSpPatWxLq/YbJy0zmcrBMy4FJ2wWszONYvicvyBaQQrnIxUTMtmbCmxOFLIAB
ewKjJVLazfGDWAnQxWPxyMunCitTIQ==
=xVVA
-----END PGP SIGNATURE-----

--Sig_/98XL6OcGmW9VXLu_sH/MqaU--

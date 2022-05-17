Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B704752ADC8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiEQWBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiEQWBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:01:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C3434AF;
        Tue, 17 May 2022 15:01:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L2qp140T0z4xZ2;
        Wed, 18 May 2022 08:01:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652824890;
        bh=/oHSpEipuP59VYldR2XT7dL3zHLu+rTtE9WVdis6W4I=;
        h=Date:From:To:Cc:Subject:From;
        b=JvCMpVdL8YdKW2NquIy3/17Y0hm9sUI/BT3LJauV9T4uU3RNeSeW4CUxAhNDEa245
         xIZZhr9SeYp8yiQhcrDNfba6YAGuQyQlcXGfucsDkQ4rY7RN1RTYGFVQv2eUfPLerE
         tIo/+QxwsZq0wvzj11BaCikX5R0ZQceIcKwTc4QyV1lcHa/zlxalbv9CmKi5de3b/L
         LRSlnz92GB2ZXjQ5QN2y48amQOj+107wclwPjs/4OvQniT6765t4bc10FwW+qBwdt/
         FU42Y9BvC1E5cEwFVEd8r3vcNpw3ljtK0p1x4aGKRzGT1MmKQsUp89gh61b2gwsblJ
         75Kuer88PUPSA==
Date:   Wed, 18 May 2022 08:01:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20220518080128.77351ada@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DcXU62eVVpFEjrW0W_.RZ6P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DcXU62eVVpFEjrW0W_.RZ6P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c5003f08fe67 ("ASoC: SOF: ipc-msg-injector: Cap the rmaining to count in =
IPC4 mode")

Fixes tag

  Fixes: 066c67624d8c: "ASoC: SOF: ipc-msg-injector: Add support for IPC4 m=
essages"

has these problem(s):

  - Not in the correct format
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/DcXU62eVVpFEjrW0W_.RZ6P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKEGzgACgkQAVBC80lX
0GzFWAgApKF+BbsHKqzkrWBTR5wWSNEmpAEkilkbwaimFLnGHBySCU+OHUdVWDrK
CTUUUigyk6PFn+NwAHDUZbS95tunVWS8D5t5NO/odvfxM9rplSxZslsIhijvmgtB
MoaQhKVaKYbmimyyh/mZGgcfMxyzXkdxVoUYDEwE7SWuZ3PXa1llD64NiNvuWKfT
KqZaWhkjfJQzQQuKTLwy65/e1CqZHd5TMpsb8CMihW5svYuXde350Fn/k/K5BdkY
N4tR9KXd+JqEKm7VROMi+S15tb4enkWAZPUPqHWXNLe1vBytQ7eWbr0NL3eLYGFk
duxJkkQtSg0U64MZVP6TSDFL82mXWw==
=WDM8
-----END PGP SIGNATURE-----

--Sig_/DcXU62eVVpFEjrW0W_.RZ6P--

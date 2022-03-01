Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC44C81A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiCADcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCADcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:32:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB870051;
        Mon, 28 Feb 2022 19:31:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K72pw73t7z4xcS;
        Tue,  1 Mar 2022 14:31:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646105500;
        bh=g5GScV7wuN/bN5XX/KQIPEvExlYocIn6KNBO0qLhBYU=;
        h=Date:From:To:Cc:Subject:From;
        b=gU57ymSEyZyXrYCL6VOnILd7zsOtKRr+jpgzN+0uSNC8a3wCcBCfSzJ5j2VPRYCoM
         LliBfN13RMgSqYUgghQpKxQak+bhJK9LjmD2WGCDeIp4SdlTJh9BASZpj2q7GzWNQZ
         DOdVIfDGV7IWqCDfDGsrRykVirpC5fsnfW+m5t9dhZKy31KzPERpXvhj+C4DMdI0uz
         BH6qgVFe8wV3XhH0BL299Q+yNHnhKGMIxSVXx+G3FHAuSMFKD1PNJdxV+tOD+Sno0A
         z0VXFdI3r7/sf63FHJLFsWX29dZUKmMR5E0GORF1Gfygt99Qxy8Vm3rzgrKMP8Ivyw
         Fr8uD8w+V++iQ==
Date:   Tue, 1 Mar 2022 14:31:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the spi tree with the arm-soc tree
Message-ID: <20220301143136.7489cab5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B40HRGLO8balFLSwijb+OFx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B40HRGLO8balFLSwijb+OFx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the spi tree got a conflict in:

  arch/arm/mach-pxa/stargate2.c

between commit:

  28f74201e37c ("ARM: pxa: remove Intel Imote2 and Stargate 2 boards")

from the arm-soc tree and commit:

  31455bbda208 ("spi: pxa2xx_spi: Convert to use GPIO descriptors")

from the spi tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/B40HRGLO8balFLSwijb+OFx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIdk5gACgkQAVBC80lX
0GxTtQgAgs7E6tIy9maHWVVL1S5quOgmCPpeGJCplWgl2f+EVYXiUJ+3stvLUR+5
EU7Guxe8YuVlWfqk6VWKdiSobb9ghVR5CpiBQ5rXxz7B32GPdWvJiXrzU06S9C4k
3LZPaxwQgREADIHb5UxFei4Cb/pFTm3/dNvyXDXR9QPjcTYk/rcp7175lAQvlRam
wh7zObs/b6jAqfVO2YvqtJEp74pRiNB9Y8v/x5mRBF/EqH0Z65I8kkCR+cusifSq
lGyJxVMbFVEN3SOQvAreijNfqU4JfknlCtF9pvPUEC9so+c60t9HUkz6Koc3y9yF
FVU7duYit2urSIsX62qEC5moDJmqXg==
=DXzX
-----END PGP SIGNATURE-----

--Sig_/B40HRGLO8balFLSwijb+OFx--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A0A5209A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiEIXsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiEIXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:47:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A9D1A6AED;
        Mon,  9 May 2022 16:41:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxyNc5X1vz4xLb;
        Tue, 10 May 2022 09:41:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652139667;
        bh=gcj5N2stAh0o9Vt95Mn81SY0ptgejBMeaPn8kPhX/CE=;
        h=Date:From:To:Cc:Subject:From;
        b=IskjAnQ34Po4cVUZAE/I74cAYu6YSgdVApwykQFzboanpz494inWkUJsFskG+qRLk
         0UXJayai6PWQ9w6WsZ3nNMgqdr3PWaaB0TXJJrkewk9Jy5e7rCSBrNbVGQdcUiyxS/
         vk9t4DTfoGkVEjOISJxuz4JgQBm4g+5p1ar40LmhBRmxoSh9CYqWF0uo0dc7Jf9GES
         E5PedpNys3SUc21Cz8h1UZqFOm9ig6Q0xrCuWts0UyZcatQzh1rVuCCPOpk4xrEUT/
         33T3YOXXjxm481z1jAAO0lT73YYAc/GWDD6UsFJERIWco2eBRpIMCS7RpXfMcDn41E
         PIDfrk+GspNfw==
Date:   Tue, 10 May 2022 09:41:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
Message-ID: <20220510094102.099d5e54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UMyAxjC44_7frVPl/lvX3xC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UMyAxjC44_7frVPl/lvX3xC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in:

  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts

between commit:

  2f00bb4a69c7 ("arm64: dts: marvell: align SPI NOR node name with dtschema=
")

from the arm-soc tree and commit:

  5e9b59bd3737 ("arm64: dts: uDPU: update partition table")

from the mvebu tree.

I fixed it up (I just used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/UMyAxjC44_7frVPl/lvX3xC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ5po8ACgkQAVBC80lX
0GwCEAf/Wu+gNxrthCwldhZbPMBGR736gEndrPdbe+LHjRQorx0/rvRp+Tw4qMfY
MaIC24A1lsgdGsGrb/Pd1Gi9Aw2CHNn12mEgOtO3m4NyYrhJkfkTdlZnWxYUZmEk
eoclCixyHxHDbnnznvQOuAfDPg4T6vGWPOlqCbTTWLWYiClfQ0uHTZ7kgCG6Sbhw
IAggLODmAkWch07XwHzUuXgGUc84ksK/XUjgCoYodi1PAUSNXqQTc1mByPuu2oof
iFzqmhdtwruOxn0m3Hs1tQTvv/vRZCxBAK5lbcxqQ4eypb4ZW02d+LSMdAr5OKWi
PDO7bJZ7W6cPRzAkq9g/U01HY8R5Fw==
=+Nzo
-----END PGP SIGNATURE-----

--Sig_/UMyAxjC44_7frVPl/lvX3xC--

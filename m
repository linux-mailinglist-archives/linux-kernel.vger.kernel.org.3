Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82150ED2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbiDZAKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiDZAKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:10:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA41132F1;
        Mon, 25 Apr 2022 17:07:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnMd030nMz4ySS;
        Tue, 26 Apr 2022 10:07:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650931620;
        bh=yMUVb+JIWqYs7pY/etlzM8thCIFLBgLptEPrejiYLhE=;
        h=Date:From:To:Cc:Subject:From;
        b=mmnMp4kujX16Y6lIQXjF+1x4YxUxil0hRi9tMi3hyvPPgn2qHgkgzjri7uFN4Ij+n
         ZUDmKNJxu3wLES0q7pbCKus3NABVpCMVY6pfmc+V7ATGfLf7WPNSGowPzaCFkhJ8GJ
         fIF2tovtDIN2+8ffWG9EjkQdezS1qrHTY7VrrmK7RcAQvB+TwPNrUl31t6K/iiWyf0
         ilYW7hZoZr8UtScInejKDWZ5Y7C9RAEpQ8aDnvfi98fQzkVFNPz+kUNl2pfbjZ9qgN
         R4zVFJPlsOPHsyNmEJOsbFfgU/RIOsUGsBwDa4T+pA2aS7km8J4g3yD7N9PcBjD7RW
         L9am36uaDKrNg==
Date:   Tue, 26 Apr 2022 10:06:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Alison Wang <alison.wang@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the imx-mxs tree
Message-ID: <20220426100659.0e3f3ca8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5l8mpMpzvr.wF7tq/sspOv4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5l8mpMpzvr.wF7tq/sspOv4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the imx-mxs tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

arch/arm/boot/dts/ls1021a-iot.dts:150.3-26: Warning (clocks_property): /soc=
/i2c@2180000/audio-codec@2a:clocks: cell 1 is not a phandle reference
arch/arm/boot/dts/ls1021a-iot.dts:144.27-151.4: Warning (clocks_property): =
/soc/i2c@2180000/audio-codec@2a: Missing property '#clock-cells' in node /s=
oc/interrupt-controller@1400000 or bad phandle (referred from clocks[1])

Introduced by commit

  23f550d5f7f6 ("ARM: dts: Add initial LS1021A IoT board dts support")

--=20
Cheers,
Stephen Rothwell

--Sig_/5l8mpMpzvr.wF7tq/sspOv4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnN6MACgkQAVBC80lX
0GzZzwf8C+GVGAuXAQ5Moeva9yW21gBqgB637qTTQsruV31m0UENour55p5L+F9g
7MpFJCXkuxQouRwRz1WEY+b0VBpGnLI8A86uHALloXnRCWegKVKAytUt9J54LIvx
OLM+5ufrnm0UFv8FXu5h33QJUNtK6y5EMuc3xiWCvlUMPJpzk32crxtekBzSKJpg
1In7xczaEdyox58mV1fX3QAA5Nw9TZPoMi5tb/rPr3otnNZNdd7KqkZ4oShsqfF2
lD0kPPcrv1tz2DqbZjWE1JoocYEJpfTEx1xvj4fHKFc5doo7Cu8nOymqVF/nJ8FX
gAkhZUHuVYxGfIDRGSWA8bM30Mi6IA==
=dxU7
-----END PGP SIGNATURE-----

--Sig_/5l8mpMpzvr.wF7tq/sspOv4--

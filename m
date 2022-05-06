Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0145251D0AA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389153AbiEFFcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389116AbiEFFb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:31:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E1B853;
        Thu,  5 May 2022 22:28:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvfGz1cGmz4ySZ;
        Fri,  6 May 2022 15:28:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651814892;
        bh=fKUMqt9F3o+EnUvm0e9MmalqPDqw2qHRQSLf9kpzP8o=;
        h=Date:From:To:Cc:Subject:From;
        b=qc3vQoMLTWvZTbgibcqFlhzLIhYD3c2Crrr4o7y9Xo3HvWBGA4NNFGOHc8IRFCxD6
         a9gM/ZB9dqaU7+K6dI+wkPeXXyKT7j9WWVGNDTk4ucp2qca49u8xi79JGGwPSJ+jSW
         wvRAmHOXrK3nk5KdNtbvSH+lh7Fsd1RVfK4aDj7XcLkpCcyHGUdLw3woIO0pMwkK9+
         W3NxdewXrkCAzh/zT12ND6S2Q5dzI7igspGlUYiR+N/yhACuVAXdCHn3hHgmfKN7NT
         TW9Op284yFvZtXms5n2esIe/PCBln/IgQQSQBbeEtamhJcmwnPyKvZt/jPe7CshRno
         QOp6Kfs3PLQmA==
Date:   Fri, 6 May 2022 15:28:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sven Peter <sven@svenpeter.dev>
Subject: linux-next: manual merge of the nvmem tree with the arm-soc tree
Message-ID: <20220506152809.530ddde8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/573cbl5NHlMeyYe_w9Xv67f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/573cbl5NHlMeyYe_w9Xv67f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nvmem tree got a conflict in:

  MAINTAINERS

between commits:

  82b96552f15a ("dt-bindings: nvme: Add Apple ANS NVMe")
  5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")

from the arm-soc tree and commit:

  e99e7f098c06 ("MAINTAINERS: Add apple efuses nvmem files to ARM/APPLE MAC=
HINE")

from the nvmem tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 644b27c889ee,1bf57fd937b5..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -1837,10 -1836,8 +1837,11 @@@ F:	Documentation/devicetree/bindings/ar
  F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
  F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
  F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 +F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
 +F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
  F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 +F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+ F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
  F:	Documentation/devicetree/bindings/power/apple*
@@@ -1849,10 -1846,9 +1850,11 @@@ F:	arch/arm64/boot/dts/apple
  F:	drivers/clk/clk-apple-nco.c
  F:	drivers/i2c/busses/i2c-pasemi-core.c
  F:	drivers/i2c/busses/i2c-pasemi-platform.c
 +F:	drivers/iommu/apple-dart.c
  F:	drivers/irqchip/irq-apple-aic.c
  F:	drivers/mailbox/apple-mailbox.c
 +F:	drivers/nvme/host/apple.c
+ F:	drivers/nvmem/apple-efuses.c
  F:	drivers/pinctrl/pinctrl-apple-gpio.c
  F:	drivers/soc/apple/*
  F:	drivers/watchdog/apple_wdt.c

--Sig_/573cbl5NHlMeyYe_w9Xv67f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ0sekACgkQAVBC80lX
0GxLegf/ZvoFYj7UJ888DcU5C1VxYDp0/gymdO8oPK6zWM4FQESge0Oem+lrR+gL
o2eW4ExSs5n4GiMjHJQLL9Sfv6xp7jPIi/SrfRbAiu/ID/8WYh9zBG1vMeAFcqHu
tbbsxPTWuhWpbYy0NwSyFe/FtAiWJqEH2PU6UpI30g44TfyfNAKoB6WPxFkFaT9k
2w6ns/PfLhLs9Itku+hv/rYwr6rPyIWFSP8mwve60ssZVgn8Q/x7OdqXWtvwqJI0
Z3nXzXF8RQ6MC5sXzoiDctol7Vkve8sOibVynLSLSWSEnT4zRSQikzWt9T6rwEWI
dseqZ+4kCDY75w0lQtd0B8sIB9ZkRw==
=t8qa
-----END PGP SIGNATURE-----

--Sig_/573cbl5NHlMeyYe_w9Xv67f--

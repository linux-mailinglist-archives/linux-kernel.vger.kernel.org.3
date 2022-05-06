Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE80D51CF08
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388347AbiEFCnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiEFCnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:43:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7F6128F;
        Thu,  5 May 2022 19:39:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvZWz6dgCz4xXS;
        Fri,  6 May 2022 12:39:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651804754;
        bh=1Ilo05scNIwalNfyaTyXng6aFmzopQdKNcSB0fD7WfY=;
        h=Date:From:To:Cc:Subject:From;
        b=AF/xXeiEX5JHJOrCdc73ODupfntyVbcSVyuf9Wnk4DMR8Mw1E3zcdpJvy8Mq9ui6I
         /JmH5wW+3v2oyCuezFdlxKR1KztHEOSUazRExHrSOx9NJZdzGTiobp9O9jJF+2PkR/
         e0edBpbNk2UWZQqtGur4USBCNaR1LeigrlwOH3pDQVUAnN0gSU6M/KV4OaI8BMNHgj
         frzePQ+9VghUr+NIUYDuYfTuBKBZJpDXNFDacFCpTlMWtOu4xOCx8ujMpH8j5h6OtW
         GpMPxCwdpAPWLz74KUVytt0BRmBR8+MjBlckAHCvVc27aDM04RZT+6I5MfVbZqgUC4
         +NdD5E4mY0bdw==
Date:   Fri, 6 May 2022 12:39:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sven Peter <sven@svenpeter.dev>
Subject: linux-next: manual merge of the iommu tree with the arm-soc tree
Message-ID: <20220506123910.3faae09f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qCeDa=YQICowG_VAz3MQQrL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qCeDa=YQICowG_VAz3MQQrL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommu tree got a conflict in:

  MAINTAINERS

between commit:

  a12d521f4a3d ("dt-bindings: iommu: Add Apple SART DMA address filter")

from the arm-soc tree and commit:

  ee5354345242 ("MAINTAINERS: Merge DART into ARM/APPLE MACHINE")

from the iommu tree.

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
index 83a61d719d95,7d728a19e857..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -1837,9 -1829,8 +1829,10 @@@ F:	Documentation/devicetree/bindings/ar
  F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
  F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
  F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 +F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
+ F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
  F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 +F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
  F:	Documentation/devicetree/bindings/power/apple*
@@@ -1848,9 -1839,9 +1841,10 @@@ F:	arch/arm64/boot/dts/apple
  F:	drivers/clk/clk-apple-nco.c
  F:	drivers/i2c/busses/i2c-pasemi-core.c
  F:	drivers/i2c/busses/i2c-pasemi-platform.c
+ F:	drivers/iommu/apple-dart.c
  F:	drivers/irqchip/irq-apple-aic.c
  F:	drivers/mailbox/apple-mailbox.c
 +F:	drivers/nvme/host/apple.c
  F:	drivers/pinctrl/pinctrl-apple-gpio.c
  F:	drivers/soc/apple/*
  F:	drivers/watchdog/apple_wdt.c

--Sig_/qCeDa=YQICowG_VAz3MQQrL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ0ik4ACgkQAVBC80lX
0GwGPQf/WcMGnd7q/a2Ue32+G1oyF9ZES98SYdlDG++n5u9EPWMzjpLF1FQIG7Yi
h7gYlwULEMPV6CzCBuWlrvrZJrKzKLkrRRueKBLXkBrmCpDWn8rBHsHAbkFRV4uc
dJcYQZNmfM24MNY0sBrMoeBoYaWeUe78FwSwTxznwL4jrmEmq+bDQyU8DLO86cQj
QE2DBPlltSfYdyqvW0ijYpOYhWpBBFuWEmE2d8Kw5uSHgqFwpgsWKhMRVMZqIwBH
1SrAV1j/p440Tj1dNr2tZKIGnHKUl8nBeeegWYcKU+bnbhKOaaFi0DRi2URG8fG4
QWvG0P5orJsgQKmYvQzkljtPNhd7zQ==
=Hg7P
-----END PGP SIGNATURE-----

--Sig_/qCeDa=YQICowG_VAz3MQQrL--

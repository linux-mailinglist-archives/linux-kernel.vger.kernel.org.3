Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE85359C6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiHVSjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiHVSi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:38:28 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 538AC491D5;
        Mon, 22 Aug 2022 11:37:59 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id F33E1DAC;
        Mon, 22 Aug 2022 21:41:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com F33E1DAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661193664;
        bh=mzQNUfkrKWcvRM4PSNQ9YCrFiNRfBiAjy3rPri/eAZU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=CYAPAbkYtcK/82szAPYVl3sAB3c1OkeSr189y2/JyeHEBrC4y5GUuiHv/3amd/cvf
         tNGgZhnAJx5L/+VZWf64Yr3kyreun1zgIqsBXYAzT4iYv2a4m6DsaG4gXHBps6/W6N
         jw+pMvA7TJrj7Dty0NINIm7PPrrrdhPkniVDc6kg=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:37:50 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v7 23/23] MAINTAINERS: Add maintainers for DWC AHCI SATA driver
Date:   Mon, 22 Aug 2022 21:37:28 +0300
Message-ID: <20220822183728.24434-24-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822183728.24434-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822183728.24434-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a maintainer of the new DWC AHCI SATA driver and
its DT-bindings schema.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Use dlemoal/libata.git git tree for the LIBATA SATA AHCI SYNOPSYS
  DWC driver (@Damien).
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe..7a1cb5ff19cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11552,6 +11552,15 @@ F:	drivers/ata/ahci_platform.c
 F:	drivers/ata/libahci_platform.c
 F:	include/linux/ahci_platform.h
 
+LIBATA SATA AHCI SYNOPSYS DWC CONTROLLER DRIVER
+M:	Serge Semin <fancer.lancer@gmail.com>
+L:	linux-ide@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
+F:	Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
+F:	Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
+F:	drivers/ata/ahci_dwc.c
+
 LIBATA SATA PROMISE TX2/TX4 CONTROLLER DRIVER
 M:	Mikael Pettersson <mikpelinux@gmail.com>
 L:	linux-ide@vger.kernel.org
-- 
2.35.1


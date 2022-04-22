Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F33F50B165
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444804AbiDVH3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444777AbiDVH3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:29:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E75132A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650612367; x=1682148367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xA3N4B1Oq7NN/T+qdPN5HDE/pIMyStNJQREGSATatw4=;
  b=Eb9rFkWWZ816G1HdizNtjcdZ65+uzOM3uHK0CgkRSO4mtjoFgr7Yj/Na
   3AFQSP1P1nv9EAtlwZp8cfCp/zcwVPcXLHaMDUyd78Yu/sthSzrGLYZ0e
   bQ+Za4rykPaiHpu+1Yt9LEy5WbHEPk19o5Sre+JeqgdCzK7DRHuR7mmMp
   u2Q9PmzdlKl0lBUXlMboZHtIC2OhMpz0TvNojCL8mc2JFU7SWf5Es5E3w
   /kM5pjDaXxq5GgTiVE/vlQTaEKAaVM8AsHLxj27lbFALVRJnl3Y7Io8nW
   79g57Rn9/UCp3fYleiw+A/tvnEgUejFEjMSV6IoyOK7Dyk1+eRD4FrbNc
   w==;
X-IronPort-AV: E=Sophos;i="5.90,281,1643698800"; 
   d="scan'208";a="170537731"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Apr 2022 00:26:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 22 Apr 2022 00:26:07 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 22 Apr 2022 00:26:05 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <cyril.jean@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 4/4] MAINTAINERS: add polarfire rng, pci and clock drivers
Date:   Fri, 22 Apr 2022 08:25:33 +0100
Message-ID: <20220422072533.2582084-5-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220422072533.2582084-1-conor.dooley@microchip.com>
References: <20220422072533.2582084-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware random, PCI and clock drivers for the PolarFire SoC have been
upstreamed but are not covered by the MAINTAINERS entry, so add them.
Daire is the author of the clock & PCI drivers, so add him as a
maintainer in place of Lewis.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..d7602658b0a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16939,12 +16939,15 @@ N:	riscv
 K:	riscv
 
 RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
-M:	Lewis Hanly <lewis.hanly@microchip.com>
 M:	Conor Dooley <conor.dooley@microchip.com>
+M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/boot/dts/microchip/
+F:	drivers/char/hw_random/mpfs-rng.c
+F:	drivers/clk/microchip/clk-mpfs.c
 F:	drivers/mailbox/mailbox-mpfs.c
+F:	drivers/pci/controller/pcie-microchip-host.c
 F:	drivers/soc/microchip/
 F:	include/soc/microchip/mpfs.h
 
-- 
2.35.2


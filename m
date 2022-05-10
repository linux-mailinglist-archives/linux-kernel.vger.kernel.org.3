Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D65217DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbiEJN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbiEJNWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:22:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22171A90DB;
        Tue, 10 May 2022 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652188620; x=1683724620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8pp90tvf8kTP0zWhyfPDbb/zxfLJMKZ53ILcrsvHuto=;
  b=HeP2VqwUlh1WZpJDAKL4lIzcejYDPwSN/ELGD1RwvP/ZAmWTFtUnSmcJ
   JUjQQSCQ2DlbMCYchglOHqZouX+Vl3GQAilgkYbk8puCVr1XIVdgom4ZJ
   E8f6jq00I3A8ws8YLKkEUCU4OWEwgE+qzBmbwCRFm6i7fU2ziNc1E8GlO
   nur7byJkEjt28jcy+8GCiW0H2VpcOURo3xSFCTyhlPc14VfQINrH6W4bL
   BVw1DlPQaYrenYA0LxyGTLObUO/I3dXK8/yer0Ow3ncL4NgcC42rM9zSk
   8Xx7RMgr8MxqQz3838czQxyNoNO/3VINDWIpJjn8x5wzbYrHgBeKEJ0eV
   w==;
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="172695912"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2022 06:16:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 10 May 2022 06:16:45 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 10 May 2022 06:16:43 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <conor.dooley@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v2 2/2] MAINTAINERS: add PolarFire SoC's RTC
Date:   Tue, 10 May 2022 14:21:17 +0100
Message-ID: <20220510132116.506572-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510132116.506572-1-conor.dooley@microchip.com>
References: <20220510132116.506572-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for PolarFire SoC's RTC drver to the existing support
for PolarFire SoC.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e8c52d0192a6..625d735f6a24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16952,6 +16952,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/boot/dts/microchip/
 F:	drivers/mailbox/mailbox-mpfs.c
+F:	drivers/rtc/rtc-mpfs.c
 F:	drivers/soc/microchip/
 F:	include/soc/microchip/mpfs.h
 
-- 
2.36.1


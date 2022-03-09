Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B12A4D35EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiCIQwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiCIQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:45:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476E369CE3;
        Wed,  9 Mar 2022 08:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646844002; x=1678380002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hQ88M2thWVMv951o9xrRQLwqeDq6XC6dMQcAlluRG0w=;
  b=PMzdC+lB4YdSeFS+JL3Bq/d21mtDQPpdStu6cYSkt+m70GiigIeJfNXx
   xszbxA04nSpvqccx3D7jnMBp8j8j9sg1xujy6Gxmv+uQ6pwTzrlVGPY8h
   +u1U7B69CiVv+AlWWk/1Dtu7PFw/puvJPx8Ue6oRDos5ruqW+IGTi2cme
   K7qdjqQ022+0GDr/bqzux51XnA95PF4Ln7uAyZlzaVqQR2h8IdQyi5noC
   D3QHhS+ewI9Cl0CAwMUmrnL6D57PZdU3kxJ/oTStXmnBfGQyRoYJO0LIj
   eidvwNlBKL2fhk84QY4mSzthv3RjD1wjAhaxENjcxGgAifkaXsStKSEh2
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="148643034"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 09:39:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 09:39:55 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 09:39:47 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v8 09/13] media: atmel: atmel-sama7g5-isc: remove stray line
Date:   Wed, 9 Mar 2022 18:37:54 +0200
Message-ID: <20220309163758.2672727-10-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309163758.2672727-1-eugen.hristev@microchip.com>
References: <20220309163758.2672727-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove stray line from formats struct.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/atmel/atmel-sama7g5-isc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index a0d60cfdba7b..638af8da2694 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -225,7 +225,6 @@ static struct isc_format sama7g5_formats_list[] = {
 		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
 		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
 	},
-
 };
 
 static void isc_sama7g5_config_csc(struct isc_device *isc)
-- 
2.25.1


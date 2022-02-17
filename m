Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05EA4BA24A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbiBQOBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:01:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241660AbiBQOA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:00:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AF42B0B08;
        Thu, 17 Feb 2022 06:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645106422; x=1676642422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WMo3A0FXzl8kVU3sLYwWm3RXrK0Q37aqF1ExPiMbpJs=;
  b=WeszXtQ3TCA1atMu3P50wwQm1K4oVTr1a6d1Gp/jXy8+DSKfE3Qv5qMi
   p8EUngEpJzlYjsyggzOeAGyxFJWWj7fyGb9/E+Px73Xhmdf28YfNQPbuh
   A0DQh4BFdAqTRDLB6wsic20cevqeZpmnnoVE5uHuLph9JhRb7CNvkYleN
   A7Z24WQG0a+fhrIVK3NTO4zeI/gmyynYyLnuVcex8oLiLRsCUx9NlDkuL
   +6heV4x5I13X5bxF37kmZNVwTCJVu09faC/S17gtRww2tcNsu7nWlvkae
   1zpLZjDj367SFeUuDpab3ifGgb4rZ8UN2TqWdPXd0e7/g/vY729Gsc1x6
   A==;
IronPort-SDR: ZHvn6cQkHfF5xdWBh+AVqWkLPLUHQIfwcmXtyvYD3ahlqRKceEzmIFQaUD1fEHztg7Vw5AULu8
 P367lOF1pVOY7hsjE1yBMyDMrmAIm+AGP+YNokojZv7vdsr8jbBY3Ll15CCdj7cWSm4ZZ/Duk7
 Dqz0kgmwFmlRjhJUHHDQg4DGdvf5qeqZJWqKDA6dlTuLAbtPWX1whj/85VF9FA/FseuYrAbgSb
 rGa5RZ/BK7WdBTjpbphQTGW5ScBnmDAmMG5sWoVb2mkIBmHoJsMfiaNPRJXx+qObZ3BcFpYBC2
 gtDCOLuVfiseKlspHDo+YPzY
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="146333777"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 07:00:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 07:00:21 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 06:59:58 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v5 09/13] media: atmel: atmel-sama7g5-isc: remove stray line
Date:   Thu, 17 Feb 2022 15:56:41 +0200
Message-ID: <20220217135645.1427466-10-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217135645.1427466-1-eugen.hristev@microchip.com>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove stray line from formats struct.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
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


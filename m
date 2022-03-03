Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25EB4CC183
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiCCPhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiCCPhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:37:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326219416B;
        Thu,  3 Mar 2022 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646321821; x=1677857821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljHFpNtf90raf0Mi1Px1Md0sP/C0tdoXJxxBXqKMu50=;
  b=wrHoDuT4VM6IphxaywbOs8+kcq7vLEfUQwpOq3v8GbYZ76s27F0izD3W
   2M4QLo+JgS54ORXC5+6twEz7VawhIC+ss/QfoplfCp04cG3hoTd2h1+wA
   xqiiSNWX8jRJY16VaOwGeJSgNgkUR6AmzLUy/F7Vc37Rw2MDdOOXVwoIy
   DLbBPToF2UwRhmzTL7yicyFTPMIxZkBMYg754WY2KZldBZay5WkzNlk2+
   bt+hvy0mTowIf14sxte0fXR2pFE/l+G85V/6H9a2/IcGYoqYuTpWSyKaB
   E5WpHSiNxL2POU5CB8B1Yq8CzvjWAJRUaahBW9RJkB3HGJ3VzmQJKb1PT
   w==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643698800"; 
   d="scan'208";a="155595993"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 08:37:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 08:37:00 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 3 Mar 2022 08:36:52 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v6 03/13] media: atmel: atmel-isc: remove redundant comments
Date:   Thu, 3 Mar 2022 17:36:08 +0200
Message-ID: <20220303153618.2084156-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303153618.2084156-1-eugen.hristev@microchip.com>
References: <20220303153618.2084156-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate comments which are already in place before the struct
definition.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/atmel/atmel-isc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
index 07fa6dbf8460..f9ad7ec6bd13 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/media/platform/atmel/atmel-isc.h
@@ -272,7 +272,7 @@ struct isc_device {
 	struct video_device	video_dev;
 
 	struct vb2_queue	vb2_vidq;
-	spinlock_t		dma_queue_lock; /* serialize access to dma queue */
+	spinlock_t		dma_queue_lock;
 	struct list_head	dma_queue;
 	struct isc_buffer	*cur_frm;
 	unsigned int		sequence;
@@ -289,8 +289,8 @@ struct isc_device {
 	struct isc_ctrls	ctrls;
 	struct work_struct	awb_work;
 
-	struct mutex		lock; /* serialize access to file operations */
-	spinlock_t		awb_lock; /* serialize access to DMA buffers from awb work queue */
+	struct mutex		lock;
+	spinlock_t		awb_lock;
 
 	struct regmap_field	*pipeline[ISC_PIPE_LINE_NODE_NUM];
 
-- 
2.25.1


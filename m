Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34844D43D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbiCJJxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbiCJJxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:53:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686DF1C4;
        Thu, 10 Mar 2022 01:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646905950; x=1678441950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljHFpNtf90raf0Mi1Px1Md0sP/C0tdoXJxxBXqKMu50=;
  b=Iw+/DMqZb95tWRO6Rh3DfxSehVukCaCN4oK6BI9RiTF+ovmrlsmLimAP
   TPiPtGZeSt1TRdKMh0vG/mm24yUtMSqpN1kzoZYIYGI5mTSAQ8LW5B6Po
   gKaELWba3JgI6955Q4kKGAtjLoz43U72aTw6Zgfg+DVZKad2P2zWJlXR1
   Su4Em2lZGSoNfyj8xr7gNUvKBkPOZ+7rhmQ7hIPK8Vs0RE/Jr5lwsOY2Y
   5G3C/G+X311y73dt13wGCRjyBv4L1Qu6zOteKnc220tXvyuOCxQUS+hw1
   uj+O7O1bB9KwIlSUtg1s+T2ijvHqD/I1C+Zs8L5+oXnvavdjBRobU/cNL
   A==;
X-IronPort-AV: E=Sophos;i="5.90,170,1643698800"; 
   d="scan'208";a="88487766"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2022 02:52:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Mar 2022 02:52:29 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 10 Mar 2022 02:52:26 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v9 03/13] media: atmel: atmel-isc: remove redundant comments
Date:   Thu, 10 Mar 2022 11:51:52 +0200
Message-ID: <20220310095202.2701399-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095202.2701399-1-eugen.hristev@microchip.com>
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
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


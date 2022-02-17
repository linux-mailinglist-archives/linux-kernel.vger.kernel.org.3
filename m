Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB804BA224
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbiBQN67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:58:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240238AbiBQN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:58:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C568B2B04B1;
        Thu, 17 Feb 2022 05:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645106319; x=1676642319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMHVBW5xJnQ6+rjm9f9+3MplRfX0nD0A6a0io82wM4o=;
  b=vPUuOdxf0bou/vKMzw7nwvDM6GVzGnvSDrEZLrEBiXnB2TNfnWel2U0+
   ZV+7dwWj0kVtUkmlorqfW1J2jVhcD52SQYKrougK7Kda9dtH1QBJ0xqk6
   zpRhMvD78cAX5tOjq6ntCrPAxij2v2Ye/M79HdosO5Tn5nY/N85ldjlP7
   G1RgbAr0fCcja7eBZfT3T8W/bHk26S+R5vQ/riwU9kh6+OrCxM7dPpr2r
   4gJjh74BNmteTQAtmxpd0yQ5tRtq+nT53aJdJGszEKnD/CvxB4i9NphUX
   KQ4Ur33RU7VcZh02AO4jNIKrK8J6PW6t6b9Aj9OqcsRwghc51CHYvr+9E
   g==;
IronPort-SDR: EPfv1I96D/dE2hg+4n9/eezvCI71KYdhRyT1KVRUSmgZQtDjyaT32uOIpxBvcJVbOtum6olWVz
 002UIosxZIrwhpM1pmFS7aEXoBv65S0CFoXmdXVWdlpjv+8uPKMAreLPVlvnPr0gN8UUzi5OrG
 GzRzRkg8Oswg+/iEgxq9oqHh8beb0a96gMx8ZQ5AeaMwOxOQV+ZrR5ue7J5R/kLL3295R8VnU9
 20gRnLk9Baz6XR3FE2hz/D0UoD/fDUwU2uDjq6i+qJ64Tgd5RqBf54hbW5O8pYY18HPzLytzQX
 vkiMSICta3MV5ZCa+b4O+gin
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="86082200"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 06:58:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 06:58:22 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 06:58:01 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v5 03/13] media: atmel: atmel-isc: remove redundant comments
Date:   Thu, 17 Feb 2022 15:56:35 +0200
Message-ID: <20220217135645.1427466-4-eugen.hristev@microchip.com>
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

Remove duplicate comments which are already in place before the struct
definition.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
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


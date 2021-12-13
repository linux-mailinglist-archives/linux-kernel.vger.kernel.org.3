Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C5A472DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhLMNva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:51:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:24201 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbhLMNv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403488; x=1670939488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szwLENg9eGEahRxwM5kjaS6EGD+dZeAptjmdZDyt9iY=;
  b=0yJCwE68emFNycGYeNd54h08wZkNkoWQyadDCVvIyRwI5VnugAdhpJ0Z
   s4dlX9y42EICaw20QC2oz8KNaoFMm5tbRoZyZ66lumbkPdL+GPe8/q+3T
   iQnJWbR5I2iSQ5Q9sqZd2uje4wz4hvRnai+8dKngHNSoj5BGZxyNhwZMo
   6yCQn2rmtt0X/P0YLI+BIK7O/CsLcfDNpm/Qx9Hb8FIOr5qHphCYjTQUW
   cat/1L5NkwAPOwAKIKh+q1XTqL30v5SvJzd+05E87TUVA1V27HGU0B30I
   LQe8q2BJ34q6NytdJVz0repm7i2WPfBX+Ds56amTz/1LvKf5fP9pSRHR3
   g==;
IronPort-SDR: GopgcEjMzEa1jtvLssKvZPVdi/vFXx3ksSLVaEOOcxI5kMIjDWPA02qZLfdIZF9bz5NruKjj9j
 wvscf2P5ujIuIqgaigXwgiPtGx7ibKqUHP1cBXQKCRaIrcccUuwGKzJZeLeF/TJ5HX8RfIXknN
 qPGLi4B/hwed8TpWt3skkUnpn/xm2oamru3OshM6PZ8faTaeQO8oi9+ljbLT+NDGuoiGrdF6hU
 kGj1/je2PvOdIks7hJYauT7/sDKrQnBqGEsXNcQRrSFUJTvbFkmnhVIxfXH2wQfsAIOy/qpSud
 ucJAvf76Iq4u2gLy5texaagm
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="139571448"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:51:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:51:22 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:51:11 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 05/23] media: atmel: atmel-isc: replace video device name with module name
Date:   Mon, 13 Dec 2021 15:49:22 +0200
Message-ID: <20211213134940.324266-6-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To have consistency with future media controller development,
replace the video device name with KBUILD_MODNAME.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 58f468d32613..26a6090f056c 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1886,7 +1886,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	}
 
 	/* Register video device */
-	strscpy(vdev->name, "microchip-isc", sizeof(vdev->name));
+	strscpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
 	vdev->release		= video_device_release_empty;
 	vdev->fops		= &isc_fops;
 	vdev->ioctl_ops		= &isc_ioctl_ops;
-- 
2.25.1


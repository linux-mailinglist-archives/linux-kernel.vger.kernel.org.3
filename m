Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA8A472DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbhLMNuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:50:24 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11388 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhLMNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403423; x=1670939423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FqvwlZxB/OJUGSNd0nD5EpkHzuOHgqAauXHPtlBZFiw=;
  b=YHZfHLY0ZHHpuuMmPSal30ZlVl6GH4Jj6ax1RzJIuR3YTWjgcJl0deNe
   MdKSKmmcyyyYHPxWny4tFk1RpKg1MBbSW7XKEjiMIzo2nBPhu6UaEIEqD
   g/lqQJHt63HuBAZJ2Nua/TLeCCui+Q4T9OxsCnClJbXnGmBUENTVvpUKH
   073XepZhAYdvccAJetAR0PKQjaO2l6JLXKGgBltYEiocdxLRojXIXWU+a
   xIaadxSgZxSY2pAuRZ6pU0PyyMvBQqd/UL3gAqb5t6hl+oeDDJWDfiDY7
   NG92ef9CAGryV3FbVhBxvYqzy38+13zNvOll9KSVUiqPVCEOhQoJfJ8Ag
   g==;
IronPort-SDR: BPxNGInRynISDrcx2C8xHGf4OqtNdF24Bqs2bt/Urfx8GwkT5dLs2SURFce6J7ki/i3TBO1Bpm
 KrOPzsBkd9sEZoODrLeJweua42+n2sQ5Zzy6flZbQ3Js28n0bGmGH8gOmipjpFuz0ukErBy7n6
 eRSmvpEqJgKXazxoofWVJpZn/TjEQP5VjedELfAt0n4hVvPKJPunE+tx0SVav8RaQbLLodCcCX
 REFR6UnaCAx1FOILu2LWEC4MrGI7gqYnV7lquM6xxGGp/rNLIaXr1wH8DgWbQpbN/Df9TyGbV8
 JNCIGU5mIXg4yr+NawSz0we1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="142189264"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:50:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:50:22 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:50:08 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 01/23] MAINTAINERS: add microchip csi2dc
Date:   Mon, 13 Dec 2021 15:49:18 +0200
Message-ID: <20211213134940.324266-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Microchip CSI2DC driver in the list.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2239eaff8d3..afb74460e5c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12468,6 +12468,13 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/atmel
 
+MICROCHIP CSI2DC DRIVER
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-media@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
+F:	drivers/media/platform/atmel/microchip-csi2dc.c
+
 MICROCHIP ECC DRIVER
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.25.1


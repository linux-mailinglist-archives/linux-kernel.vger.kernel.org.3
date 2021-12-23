Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F4447DFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346884AbhLWHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:40:47 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:58192 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346874AbhLWHkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:40:46 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 0IiQnZlqWwEZf0IiRn1Rhj; Thu, 23 Dec 2021 08:40:44 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 23 Dec 2021 08:40:44 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] usb: dwc2: Simplify a bitmap declaration
Date:   Thu, 23 Dec 2021 08:40:41 +0100
Message-Id: <a2bf604d26dbe9816fdaae0faf4b4837ecacc6d3.1640245180.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DECLARE_BITMAP() instead of hand writing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/dwc2/core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index e2fe64239328..8a63da3ab39d 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1154,8 +1154,7 @@ struct dwc2_hsotg {
 	struct list_head periodic_sched_queued;
 	struct list_head split_order;
 	u16 periodic_usecs;
-	unsigned long hs_periodic_bitmap[
-		DIV_ROUND_UP(DWC2_HS_SCHEDULE_US, BITS_PER_LONG)];
+	DECLARE_BITMAP(hs_periodic_bitmap, DWC2_HS_SCHEDULE_US);
 	u16 periodic_qh_count;
 	bool new_connection;
 
-- 
2.32.0


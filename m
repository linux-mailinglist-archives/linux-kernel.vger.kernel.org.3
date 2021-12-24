Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0280C47EA3E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350721AbhLXB3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:29:13 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:17454 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245333AbhLXB3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:29:12 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BO1M74V007689;
        Fri, 24 Dec 2021 09:22:07 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 24 Dec
 2021 09:27:37 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <hverkuil-cisco@xs4all.nl>, <sakari.ailus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <eajames@linux.ibm.com>,
        <mchehab@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-media@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/4] media: v4l2-ctrls: Reserve controls for ASPEED
Date:   Fri, 24 Dec 2021 09:27:36 +0800
Message-ID: <20211224012738.1551-3-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224012738.1551-1-jammy_huang@aspeedtech.com>
References: <20211224012738.1551-1-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BO1M74V007689
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve controls for ASPEED video family. Aspeed video engine contains a
few features which improve video quality, reduce amount of compressed
data, and etc. Hence, 16 controls are reserved for these aspeed
proprietary features.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
v8:
  - no update
v7:
  - no update
v6:
  - no update
v5:
  - no update
v4:
  - new
---
 include/uapi/linux/v4l2-controls.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index a2669b79b294..e7c425a6fa9f 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -192,6 +192,11 @@ enum v4l2_colorfx {
  * We reserve 16 controls for this driver. */
 #define V4L2_CID_USER_IMX_BASE			(V4L2_CID_USER_BASE + 0x10b0)
 
+/* The base for the aspeed driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_ASPEED_BASE		(V4L2_CID_USER_BASE + 0x10c0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.25.1


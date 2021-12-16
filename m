Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF481476BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhLPI2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:28:05 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:30253 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231771AbhLPI2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:28:05 -0500
X-QQ-mid: bizesmtp49t1639643265txy3paag
Received: from wangx.lan (unknown [218.88.124.63])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 16 Dec 2021 16:27:36 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: ALI+OuUAduxoHWx0Y3MhqQgu4GNgLtEIvAMXOXTQB1paT/WHHMt1wDgu6Syo7
        JNhKv0uGLVeIZp03yGkV1COUzNzDdXLGCV3Z1WwuZodbuZdtV0XNxNyuKyg1yF3eC55g8A6
        tVys9QxwOJmst8Ys72ouXUtS/WFaAqXcjWrxUfBQib0disY7Xzso8oIJ1a2iXFP4Aiu36xE
        Iyjr4Ex/t2TqmGQZ+8D9t1ZI32vTT96JyTPeWygMT4+uROJqYRxHwW3lktqqdSYOLRGJckV
        UtbRrrGf0CLslptX+NIPWCmCV+iqqXm6db7jCnTpzhlnGxf5C3isiJ9T48GbeZFcdT+gtaG
        4T9/zu6dSauz4h4PVb2xdwhKd0saA==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] Input: byd - fix typo in a comment
Date:   Thu, 16 Dec 2021 16:27:35 +0800
Message-Id: <20211216082735.11948-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in a comment is repeated, thus it should be removed.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/input/mouse/byd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index 6e0c5f5a2713..221a553f45cd 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -191,7 +191,7 @@
 
 /*
  * The touchpad generates a mixture of absolute and relative packets, indicated
- * by the the last byte of each packet being set to one of the following:
+ * by the last byte of each packet being set to one of the following:
  */
 #define BYD_PACKET_ABSOLUTE			0xf8
 #define BYD_PACKET_RELATIVE			0x00
-- 
2.20.1


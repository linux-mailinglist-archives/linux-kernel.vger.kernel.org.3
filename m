Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88700479BE8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhLRSBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:01:05 -0500
Received: from smtpbguseast3.qq.com ([54.243.244.52]:57797 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbhLRSBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:01:04 -0500
X-QQ-mid: bizesmtp42t1639850446t128xz0o
Received: from y2m.intra.knownsec.com (unknown [118.192.48.24])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 19 Dec 2021 02:00:42 +0800 (CST)
X-QQ-SSF: 01400000000000Z0Z000000A0000000
X-QQ-FEAT: MYl5Gn9dGPXhjg1K5TSJll+eTcAd2/TqXeqTpxby+3mn4/66Z0lGQg3WsNeAc
        XPveTkUqXWtgsAQMnHdDe8n9i06xl3/D9Jbn3zd3D7VMYVh3tqGwxq4nCCdhg48jO0PQqGz
        7fGDIBx0DVtXjps7XS0cZl5hKHvrpG1y/DNV7fkATLAGxF7noAn5fb6O8xnIEt5760ZOblT
        SesORUDnXvUXW8ZGyG1RNro9Myqe3e2HvDJ37RHfvusE/5vvTKb48hm15DiMDY+kLbBvErJ
        HncRySKyHRPU0UCSD1t4ts0eFBpSU9ee2U/1qiQiR57bJWhTv+yw24U9IqjeOhCzHbMtnay
        DYEF/OjgHDS4TwMIr2F7OvbxSRHzQ==
X-QQ-GoodBg: 2
From:   "Z. Liu" <liuzx@knownsec.com>
To:     liuzx@knownsec.com
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] matroxfb: set maxvram of vbG200eW to the same as vbG200 to avoid black screen
Date:   Sun, 19 Dec 2021 02:00:35 +0800
Message-Id: <20211218180035.200552-1-liuzx@knownsec.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:knownsec.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start from commit 11be60bd66d54 "matroxfb: add Matrox MGA-G200eW board
support", when maxvram is 0x800000, monitor become black w/ error message
said: "The current input timing is not supported by the monitor display.
Please change your input timing to 1920x1080@60Hz ...".

Fixes: 1be60bd66d54 ("matroxfb: add Matrox MGA-G200eW board support")
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Z. Liu <liuzx@knownsec.com>
---
 drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 5c82611e93d9..236521b19daf 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -1377,7 +1377,7 @@ static struct video_board vbG200 = {
 	.lowlevel = &matrox_G100
 };
 static struct video_board vbG200eW = {
-	.maxvram = 0x800000,
+	.maxvram = 0x100000,
 	.maxdisplayable = 0x800000,
 	.accelID = FB_ACCEL_MATROX_MGAG200,
 	.lowlevel = &matrox_G100
-- 
2.32.0




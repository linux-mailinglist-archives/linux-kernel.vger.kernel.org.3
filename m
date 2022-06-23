Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D305574AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiFWH7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiFWH7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:59:17 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FF43A5DA;
        Thu, 23 Jun 2022 00:59:12 -0700 (PDT)
X-QQ-mid: bizesmtp86t1655970183tb51krff
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 15:42:58 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: Y/4E1fKPEOomo7nHBf9a08WqvhwxDc/uzHCns7utu7bdKjxFBLSv3xcG4N7Q4
        ZFPzy3/GvSFkMAtoblpdcigbfYRrPpEwf5+L+bEMspnzRWxEH8O1eGHVaG4o01qzjgXa5/m
        H4MSIbmyvEp5FdevLGHDsTXzYTXatCv1WTIWW7Xjxoz+9ILaJuTVU8Y5jYt9RNvfQ1Z+0Ov
        dPgXKYe27+IvJbsb7nE4bCrr7HZgmKwnN+WiM3yRwLq+2xJCy8co++rLQI7kSAG/w3/M5U5
        1rh1CGwOILN/8S6lFb6SZTfXd4EfAcOD0gCZb416N/0K9P2i098hkKHoiFdQoOWj53dSf2C
        9IyWsOVjV20AOCy0s9oRbbzVjv3HGWkljMWPvVD
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     isely@pobox.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] media: pvrusb2: drop unexpected word 'a' in comments
Date:   Thu, 23 Jun 2022 15:42:57 +0800
Message-Id: <20220623074257.18951-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'a' in the comments that need to be dropped

file - drivers/media/usb/pvrusb2/pvrusb2-hdw.c
line - 5044

But now it's a a chicken and egg problem...) */

changed to:

But now it's a chicken and egg problem...) */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 92d6db1ad00f..62ff1fa1c753 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -5041,7 +5041,7 @@ void pvr2_hdw_status_poll(struct pvr2_hdw *hdw)
 	/* Note: There apparently is no replacement for VIDIOC_CROPCAP
 	   using v4l2-subdev - therefore we can't support that AT ALL right
 	   now.  (Of course, no sub-drivers seem to implement it either.
-	   But now it's a a chicken and egg problem...) */
+	   But now it's a chicken and egg problem...) */
 	v4l2_device_call_all(&hdw->v4l2_dev, 0, tuner, g_tuner, vtp);
 	pvr2_trace(PVR2_TRACE_CHIPS, "subdev status poll type=%u strength=%u audio=0x%x cap=0x%x low=%u hi=%u",
 		   vtp->type,
-- 
2.17.1


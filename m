Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245D857DA62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiGVGg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVGg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:36:56 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9B4D15A3B;
        Thu, 21 Jul 2022 23:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=E3oBu
        jAk5+CJh8HxzfokInqGTX7i0cI8oJxfC2MTK34=; b=DpMVIC2pV+IcBFVi636jf
        MxS4BMglcsYrcibL0VsrlHw81lNy4AXd7Wn4w5GJ6R8UzyGm549SCfAvigFbhgDm
        o0hdWrP4X/er7m40zn5Skwb1/9TGHHEkh01/yS92kdSyASEsDhAJhtGAa4yQ/tnw
        9L8xbd6vgfu9/Kwulh0gf4=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp4 (Coremail) with SMTP id HNxpCgBXkXF+RdpiLGBmQA--.5172S2;
        Fri, 22 Jul 2022 14:36:48 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     frank@zago.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] media: gspca: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 14:36:43 +0800
Message-Id: <20220722063643.70229-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgBXkXF+RdpiLGBmQA--.5172S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1xAFW7Jr4DXF45trb_yoW3Arg_Ww
        4kXw1xu348Jw1FkF1ak3W8Za4Ik39rur1fZFy5Kry3ZFW2kw4UuFWqvrZ8JF13WFy7JFZx
        Ga4kAFykt3ZxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZHU6JUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRwhGZFc7Yw9E-AABsU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/media/usb/gspca/finepix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/gspca/finepix.c b/drivers/media/usb/gspca/finepix.c
index 66c8e5122a0a..bc6133b525e3 100644
--- a/drivers/media/usb/gspca/finepix.c
+++ b/drivers/media/usb/gspca/finepix.c
@@ -129,7 +129,7 @@ static void dostream(struct work_struct *work)
 				 * for, then it's the end of the
 				 * frame. Sometimes the jpeg is not complete,
 				 * but there's nothing we can do. We also end
-				 * here if the the jpeg ends right at the end
+				 * here if the jpeg ends right at the end
 				 * of the frame. */
 				gspca_frame_add(gspca_dev, LAST_PACKET,
 						data, len);
-- 
2.25.1


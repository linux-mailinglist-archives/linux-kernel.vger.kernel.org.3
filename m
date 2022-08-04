Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F51589B40
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbiHDLyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDLyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:54:49 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6D33A495;
        Thu,  4 Aug 2022 04:54:47 -0700 (PDT)
X-QQ-mid: bizesmtp67t1659614074tdz7owsv
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 19:54:32 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: 1EOhyQsbXJAdwz25hL4rUr//pNWsQIdxH28b2BqDBMiUsQuuw1F+T/OZdfB9X
        RvFWwEL8dfVl+NWJvyWublyFEBuaql4N6ysw74F6bu/O1jGsX/yhAUo9IouzQVRwc+VHYEs
        17Rv/om6BJOIn7ueOt5N3uQTTyFSMcQj7EZugFk4Sy9Rusg35PFV94W9WfKEk6hF2agDf7o
        lu/CWCLLrC8bnJxd64r4jBYjUgGK3cF/8FZOg9GLlmv7aoIxKkkXzy8mImA+AWwAinCdfEx
        6MpcBCOnFlF90gTpaarXqaRikhcifefOpfPeh+SVG0P22/KyMlQI5Lhe9JXF1vbBZQ9L0N0
        B71y0kxTW8e0C6y4DXnXLta39gY4HKnKUAoxFpLgipm4NXACmMiDifNckdNVYqFEsjuG0Gl
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     frank@zago.net, hverkuil@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] [media] gspca: Fix comment typo
Date:   Thu,  4 Aug 2022 19:54:31 +0800
Message-Id: <20220804115431.51327-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1


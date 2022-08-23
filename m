Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9877459E772
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243927AbiHWQgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244966AbiHWQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:34:15 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905689F8CD;
        Tue, 23 Aug 2022 07:51:18 -0700 (PDT)
X-QQ-mid: bizesmtp68t1661266256t4wach5u
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:50:55 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: r2rDb3hmPa+9/9TtBsGCh0SiIngsEZYB8qwqfEG7njgYZqBBxsIjh2ywnwmHB
        dEp22+GUeqlyqght0gxBi3qouZvcXigBkBLW2Gq12P6ksXuisJAvSw3EVHPsYpO0QI496hj
        CMhWpK0ZOVfFojcQe8M1G8fPL8W8ONdiaMU7Uxs5vw/SesHDxO48FeMYQVwsJE7r1lT9SQR
        WiyeyH51Ovg3px3I8H3R1+7VTWrr/MDpy++ByL8gRS2Z2v5YeTowR+g/Lj/ikTS7uj44XUq
        NwlY0/bIwglJ50MyB9qF6ZL3/sQk0M6NuHHEqfe0CvSl4DEI6sYxe18HpGibBR/bsIvw+Mh
        746u2S0rsTkXNaP5WtefgpXXMkmw8aP+/RsD0LY59qv9/bG2BghTlpaxiPQRw==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     frank@zago.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] usb/gspca: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:50:48 +0800
Message-Id: <20220823145048.42330-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
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
2.36.1


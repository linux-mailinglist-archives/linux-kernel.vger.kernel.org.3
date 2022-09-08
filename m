Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398F15B1CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiIHM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiIHM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:28:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048FEE5822;
        Thu,  8 Sep 2022 05:28:48 -0700 (PDT)
X-QQ-mid: bizesmtp86t1662640123t827xnr3
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:28:42 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: xqT8U4SkSphd4WmtCLI8WEMU7bQn+l+hHT6vbJsiU9UG/6Z0A6fyjHjZ27SvS
        hdhlPJXhWTjypwx/J2mhHrWEYWFMiHoJUwUAF/B01hnPo4E1ZTtkFQQR32q5V+vI2/hdftw
        xgUFyawz4WNweiIgCwp5F9z6WV+JxiZxTQtgVKeeifvLUZjuvrblM+TyUrpRaNHJ/LYDRwU
        ZZBkevLj6NU4lBwISFpVK+CdjwOd1VGWNu8M8r72LgoYW+6jMzKH3Uxd1S2H7JDFcz6Hxz8
        jQvf6ko2tNZAUvqJB2Sy0rBBWE1I8CXAsY+LWAAL+UFoLPr3DavLbG99Jwyymvh4HKgWhKL
        DSFFy6JZ1C+s1d98oAW+MISIyO9dZ/j1i5EhLl3WxeMVQYKcp3vY53tUSnl5A==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] input/serio: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:28:35 +0800
Message-Id: <20220908122835.13888-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/input/serio/q40kbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index a1c61f5de047..fd25679af251 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -81,7 +81,7 @@ static void q40kbd_stop(void)
 
 /*
  * q40kbd_open() is called when a port is open by the higher layer.
- * It allocates the interrupt and enables in in the chip.
+ * It allocates the interrupt and enables in the chip.
  */
 
 static int q40kbd_open(struct serio *port)
-- 
2.36.1


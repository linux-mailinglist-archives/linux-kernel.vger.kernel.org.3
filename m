Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539185A8A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiIABSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiIABSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:18:33 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8034213287E;
        Wed, 31 Aug 2022 18:18:28 -0700 (PDT)
X-QQ-mid: bizesmtp76t1661995101tl183vom
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Sep 2022 09:18:20 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: yFTBESVR13bmP1vhbBOWsDdLIdg88W7VljOWgedLS0fRkTBf9+TRqITWriyq/
        XYier5i2fFUG1A+HmzBjkNLze9OoG/3OjSMqwXx3LPOAyCVqmRgWzdVtZfp2uPsAtuUZ63n
        V+66SSmE/dkF09/h8XTnydJjA1BYg6eW3jC3fLmdmDOq25lHCHxI7TqavPS0h636v15E6B2
        +5wEwbbt4u5BTbz7Zy3oNe/c5V8aPkFzD5KwieG5Vp2cbG4I9/b2IMpIygb8k36qW/87l/V
        Pxa+a1eRfrRGHKS1XrAVz1OdJ/+9WM4X8yMKhtr44sVwcL01A0gaMYt51HBHXAm6C/s+ZC2
        MLEY4BMvok1xqaFLp0fD0SyVsnqpRKfUadtoW7LQpId9RFnl0iSyJOoNj5EBw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media: cx2341x: Use 'unsigned int' instead of just 'unsigned'.
Date:   Thu,  1 Sep 2022 09:18:14 +0800
Message-Id: <20220901011814.24875-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 T_SPF_HELO_TEMPERROR SPF: test of HELO record failed
        *      (temperror)
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' should be clearer than 'unsigned'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/common/cx2341x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/cx2341x.c b/drivers/media/common/cx2341x.c
index 1392bd6b0026..45bbe013a70d 100644
--- a/drivers/media/common/cx2341x.c
+++ b/drivers/media/common/cx2341x.c
@@ -1572,7 +1572,7 @@ static struct v4l2_ctrl *cx2341x_ctrl_new_menu(struct v4l2_ctrl_handler *hdl,
 }
 
 int cx2341x_handler_init(struct cx2341x_handler *cxhdl,
-			 unsigned nr_of_controls_hint)
+			 unsigned int nr_of_controls_hint)
 {
 	struct v4l2_ctrl_handler *hdl = &cxhdl->hdl;
 	u32 caps = cxhdl->capabilities;
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28A554133
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356415AbiFVEJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiFVEJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:09:43 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8A060EC;
        Tue, 21 Jun 2022 21:09:37 -0700 (PDT)
X-QQ-mid: bizesmtp81t1655870968tn8rmo5g
Received: from ubuntu.localdomain ( [106.117.99.132])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 12:09:25 +0800 (CST)
X-QQ-SSF: 01000000000000B0B000000A0000000
X-QQ-FEAT: ArfJXynxbT1cyRpiEcN1yh7uYGTa/piEohXeXghTcreGUhbs9of9CPaALCTjr
        g8DC5AMsXz3nNXDu8SSlSszDsxFQCwtjzWVYRJNjci5crhF27jWs/eytqw0CCtWTajH8192
        NoFU9oxv0/pzUUqPfmgoTE4z2/3yC5fVm9OYSKVS6LuR7MPXzP9AIqBGcbjIsdnuDYi/Uk0
        9XjJ6umntqA334yhTEvbor1GN5xSrdnnpR2nLnhl/4VPLgL8Nox2sQ6UWtsIoW83tXyHxyK
        UMYKed04QUA8wprB9EaWNZmbtHV7gJnrMA71auAViw1q0eyVYZiBO7NvkbhgiWI+jeIYFn5
        4ms4qYqS73jK/kloYIvgiK2uFDb1Q==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     hverkuil@xs4all.nl, jiangjian@cdjrlc.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: xirlink_cit: aligned '*' each line.
Date:   Wed, 22 Jun 2022 12:09:23 +0800
Message-Id: <20220622040923.7604-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider '*' alignment in the comments of function cit_model3_Packet1 declaration.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/media/usb/gspca/xirlink_cit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/gspca/xirlink_cit.c b/drivers/media/usb/gspca/xirlink_cit.c
index cc87c24dd24c..acfb9a195106 100644
--- a/drivers/media/usb/gspca/xirlink_cit.c
+++ b/drivers/media/usb/gspca/xirlink_cit.c
@@ -817,7 +817,7 @@ static void cit_model2_Packet1(struct gspca_dev *gspca_dev, u16 v1, u16 v2)
  * 00_d141_0124
  * 00_0096_0127
  * 00_fea8_0124
-*/
+ */
 static void cit_model3_Packet1(struct gspca_dev *gspca_dev, u16 v1, u16 v2)
 {
 	cit_write_reg(gspca_dev, 0x0078, 0x012d);
-- 
2.17.1


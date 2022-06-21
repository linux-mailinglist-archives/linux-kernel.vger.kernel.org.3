Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B627552B56
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbiFUGz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFUGz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:55:26 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D82B1CB1F;
        Mon, 20 Jun 2022 23:55:20 -0700 (PDT)
X-QQ-mid: bizesmtp85t1655794510tecgufrv
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 14:55:04 +0800 (CST)
X-QQ-SSF: 01000000007000109000B00A0000000
X-QQ-FEAT: FXvDfBZI5O727lhUz+nlWjbS+YGHrAm99amHTkYl40oJBl0fVK/GjdC2++pfD
        9CiaYIDNCqHPmElksqT7ui6a4qYwkpS3I6mSO1tU8mQzIyR+Nj+saVPqVnATPW0Ki70zmXc
        SKojQ62b/e9I+MBOz0bMTbjcIFzRPnmxEoJ258ID8lABLFfysHTQeX7Eao+TKMMsZp2Ma3x
        rvKN6a4FJkDO6gy7M6lJR5awH74KubTDUFGTgg9v9e1F8RYUjsROVXz9IJRiWXwdT7jPgBn
        ciYtwyWl+we80/1p4irQC6rFXETolsBm3wkfsSZ3vGekdX/cljh7VAr4N2fgNKR6NEcmNgs
        G47rLAc2CtNVV2FREQ=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     hverkuil@xs4all.nl, jiangjian@cdjrlc.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: usb: gspca: aligned '*' each line
Date:   Tue, 21 Jun 2022 14:55:02 +0800
Message-Id: <20220621065502.28868-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider "*" alignment in comments

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


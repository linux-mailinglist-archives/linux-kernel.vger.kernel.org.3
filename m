Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7639A55512B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376564AbiFVQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbiFVQSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:18:39 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E533EA3;
        Wed, 22 Jun 2022 09:18:31 -0700 (PDT)
X-QQ-mid: bizesmtp88t1655914684tp2g1n6p
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 00:17:57 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: ztjZAoZewZwGOUT2w9Vrhb0i6cIDG/Jju4p+EzUZEb8NianaBMLtjDV8MlroT
        nWo3dG9b8Y/0tWvFF9aCsFcTuC3KjtbfGmCCdxMYGCKR+eDPYYKcq/n9fXLQXQwTZj6g84U
        URj7xNRGtPORUxEo67qIYckHCfE0lHxoQWs0gWdYCTLtQTcC+2kATz9XMiO15svS46F+0lD
        EQ9YGlpGuB/JYgbeCyP0dnganwifGfoG021CN2tCr96n/IYLrY4Tdy/RyQ9UHcrB9Mloxh0
        4sz+UrV95wXlsnuLK+/h1BYbeCPFtlFASMr7Uh68Vby77DvgJFcS1BumcSxE2bG62klw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: sg: fix typos in comments.
Date:   Thu, 23 Jun 2022 00:17:55 +0800
Message-Id: <20220622161755.12916-1-jiangjian@cdjrlc.com>
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

Replace 'is' with 'it' as following:

file - drivers/scsi/sg.c
line - 697

* but is is possible that the app intended SG_DXFER_TO_DEV, because there

changed to:

* but it is possible that the app intended SG_DXFER_TO_DEV, because there

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 118c7b4a8af2..02ced7be877b 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -694,7 +694,7 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	}
 	/*
 	 * SG_DXFER_TO_FROM_DEV is functionally equivalent to SG_DXFER_FROM_DEV,
-	 * but is is possible that the app intended SG_DXFER_TO_DEV, because there
+	 * but it is possible that the app intended SG_DXFER_TO_DEV, because there
 	 * is a non-zero input_size, so emit a warning.
 	 */
 	if (hp->dxfer_direction == SG_DXFER_TO_FROM_DEV) {
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07B55537CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352603AbiFUQ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350323AbiFUQ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:26:57 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A192D1C0;
        Tue, 21 Jun 2022 09:26:52 -0700 (PDT)
X-QQ-mid: bizesmtp62t1655828799t1g18qmh
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 00:26:34 +0800 (CST)
X-QQ-SSF: 0100000000700090B000B00A0000000
X-QQ-FEAT: KohptFNNdqCwupxfi+VXJS3+/HQdqDzx69QHmumwNzSso0DtdFwGPiu+uvOZ/
        iKhOdW3u05OnYtgFae1e7SByFhae1lQk1SIhau4xALOVViwkjEHTXlBK6kNLH75H4c7lo/C
        88pSxPHnZYAAO1SmXpanAzE5hIUzTI5ifILjKKrxWNYgq5Abl2nCikMT1GXIiGiYKCkRs8y
        uH2CrhuVZbyffHIxV7klYAi3bDzbNRcwD9hI7up5P8pqSMTHJUs9AMqq834SbWUkJXGuQ5X
        C66JlAtukzX4gu7+C4eYJvLEXGs1EjnvhD3cR9IoTTrAJEGgMS6qZ8HFWCI9KphhnfOM93g
        nJHg/hP3Po62yytVpc=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     willy@infradead.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: sym53c8xx_2: Remove duplicate 'with' in two places.
Date:   Wed, 22 Jun 2022 00:26:31 +0800
Message-Id: <20220621162631.25353-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file: drivers/scsi/sym53c8xx_2/sym_hipd.c
line: 3601
  *  Gerard's alchemy:) that deals with with the data
changed to
  *  Gerard's alchemy:) that deals with the data

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/sym53c8xx_2/sym_hipd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
index 255a2d48d421..d5a3808d8917 100644
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -3598,7 +3598,7 @@ static void sym_sir_task_recovery(struct sym_hcb *np, int num)
 }
 
 /*
- *  Gerard's alchemy:) that deals with with the data 
+ *  Gerard's alchemy:) that deals with the data 
  *  pointer for both MDP and the residual calculation.
  *
  *  I didn't want to bloat the code by more than 200 
-- 
2.17.1


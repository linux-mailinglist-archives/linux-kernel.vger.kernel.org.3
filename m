Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB53A553474
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351529AbiFUOZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349421AbiFUOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:25:08 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C56515FCC;
        Tue, 21 Jun 2022 07:25:03 -0700 (PDT)
X-QQ-mid: bizesmtp80t1655821432tiv9c18h
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 22:23:48 +0800 (CST)
X-QQ-SSF: 0100000000700060B000D00A0000000
X-QQ-FEAT: rCzLTtzQ0gcnji6xLlhDR/w4nX/P79abYLkOaTRlAZW+wnQmI3CnF4k3BiJRn
        /FybuJcViTGqzAXrxQh6GT/w8faNPbGatL4ajOsZR0bFL2y824RF+sfVSbDPa94jEZxoOfo
        W/g5/kSspCQDaYsuy/Icf4UNTpHN4/SQylFw8RjnTxGEmLZFqfbGQN+i0B37Wq8w/N8/z5/
        McUbIzwztGBFmE6gaFiBExFsjR+9jOPfijNQ/RDPjACnRi1Hv51ciXyYlf0gdUfvE+Rh8Wf
        tAsr2VLekeGarmlD6sYi35h0z9cr3EbOtqjzWCHliMYtuFPIOb7q5c25I9cwcqKOAqU+oHo
        6Os9Pok+VvaiJ0y8TgnXX9TSG/dIg==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     aacraid@microsemi.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: aacraid: Remove duplicate 'the' in two places.
Date:   Tue, 21 Jun 2022 22:23:46 +0800
Message-Id: <20220621142346.6429-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file: drivers/scsi/aacraid/aachba.c
line: 1053
* The LSB is the the end.
chaned to
* The LSB is the end.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/aacraid/aachba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 81462f4ddb90..4d4cb47b3846 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1050,7 +1050,7 @@ static void get_container_serial_callback(void *context, struct fib * fibptr)
 				vpdpage83data.type1.productid));
 
 			/* Convert to ascii based serial number.
-			 * The LSB is the the end.
+			 * The LSB is the end.
 			 */
 			for (i = 0; i < 8; i++) {
 				u8 temp =
-- 
2.17.1


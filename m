Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1834C8EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiCAPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiCAPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:16:06 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D165A089
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:15:22 -0800 (PST)
X-QQ-mid: bizesmtp88t1646147703temkr52f
Received: from leo.localdomain (unknown [103.144.149.54])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Mar 2022 23:14:40 +0800 (CST)
X-QQ-SSF: 0140000000800040B000000A0000000
X-QQ-FEAT: eTtJes0duVstZc8gVtcc01w8JsC2Oa/wyMO1xRzCWSJTvfuFj/wdRfI4Fxr9/
        4PqsjgGkwfG5zqrKDECD3OdDxjj8GtzqJUCXw9bAqz/1NUuqF4phzsZSt3veKnWnTJZr7kP
        jiFXuOBIB3sMI/HvPEpwg6z8bQwugTjh5n51rNlxlwpE/UvhJFLwRLPd/M9+2t3ZI1yFTHI
        4IdsihFpjjJT9sS3VCDCpAcSzzuihjb9F8+BvCoABL3TNg4kXksMlZL0SN6TOU0EU4DVf1U
        AZi9y01z1L+DvVaFLBhdt2C62CVLf0MQpUOc/LmdouslGVeSApK7JoXTBfw+JX7neu304dk
        Xn0C5xFI2gIR6jcdBLMHOts4V43Iz9UW8MApWjK
X-QQ-GoodBg: 2
From:   Jiajian Ye <yejiajian2018@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     sfr@canb.auug.org.au, caoyixuan2019@email.szu.edu.cn,
        hanshenghong2019@email.szu.edu.cn,
        zhaochongxi2019@email.szu.edu.cn, weizhenliang@huawei.com,
        zhangyinan2019@email.szu.edu.cn, linux-kernel@vger.kernel.org,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>
Subject: [PATCH 1/3] tools/vm/page_owner_sort.c: fix comments
Date:   Tue,  1 Mar 2022 23:14:36 +0800
Message-Id: <20220301151438.166118-1-yejiajian2018@email.szu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two adjustments are made:

1. Correct a grammatical error: replace the "what" in
"Do the job what you want to debug" with "that".

2. Replace "has not been" with "has been" in the description
of the -f option: According to Commit b1c9ba071e7d
("tools/vm/page_owner_sort.c: fix the instructions for use"),
the description of the "-f" option is "Filter out the information
of blocks whose memory has been released."

Signed-off-by: Jiajian Ye <yejiajian2018@email.szu.edu.cn>
---
 Documentation/vm/page_owner.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 6591e518819f..2ddb632d847b 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -78,7 +78,7 @@ Usage
 
 2) Enable page owner: add "page_owner=on" to boot cmdline.
 
-3) Do the job what you want to debug
+3) Do the job that you want to debug.
 
 4) Analyze information from page owner::
 
@@ -126,4 +126,4 @@ Usage
 		-c		Cull by comparing stacktrace instead of total block.
 
 	Filter:
-		-f		Filter out the information of blocks whose memory has not been released.
+		-f		Filter out the information of blocks whose memory has been released.
-- 
2.25.1




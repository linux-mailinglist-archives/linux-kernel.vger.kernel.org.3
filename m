Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFDD4C40F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiBYJJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiBYJJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:09:43 -0500
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CC91D6F71
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:09:09 -0800 (PST)
X-QQ-mid: bizesmtp64t1645780142t3cpv4lp
Received: from localhost.localdomain (unknown [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 25 Feb 2022 17:08:25 +0800 (CST)
X-QQ-SSF: 01400000002000D0N000B00A0000000
X-QQ-FEAT: Z953UCsBqO7uEMhmwV7wgH8Q6K9Fe+f6MgA4BWrGifd1I2EHKSTOJ5cV2o0XI
        JzBVCQOY3TiqYfgS+iGzle3XUhlq1GuWhCQrB8S0VsnF7SQioeFuQwWKUmu49118CR3MUc7
        TpGwVRqFhrPM4Z4ZdPJ2F4UKZ+d64KsqBx7KLswwKqKJ8NGOVJGG8SKG3GVwhWkQOrbGNvt
        CSIORqhLZE7DbRYIBj8Ei0sD2z+esPtpiVj2KvIVC2ugLcCt8G/J5ayjxEmKZbH/jo7ryFf
        9Efw9SJ9hqaS7X0cJrc+lPjKp3V3ShFTvlvIA0Xwyz6QSLySovf1g7E1WXmEMCAWroBPPns
        5enmtE15f6n/gy9TCwaE99Yo9k6Hg==
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     corbet@lwn.net
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        weizhenliang@huawei.com, georgi.djakov@linaro.org,
        skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, hanshenghong2019@email.szu.edu.cn,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] Documentation/vm/page_owner.rst: fix the description of "-f"
Date:   Fri, 25 Feb 2022 17:08:24 +0800
Message-Id: <20220225090824.2343-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few days ago,
I noticed that in tools/vm/page_owner_sort.c,
there is a comment that need to be fixed.

In function usage():
"-f Filter out the information of blocks whose memory has
not been released."

This comment does not match the actual function, the "not"
should be removed. As a result, I submitted a patch to fix it.

Similarly, this document should also do the same
modification, that's why I submit this patch.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 Documentation/vm/page_owner.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index aec1906976f4..32ca54757d3f 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -78,7 +78,7 @@ Usage
 
 2) Enable page owner: add "page_owner=on" to boot cmdline.
 
-3) Do the job what you want to debug
+3) Do the job what you want to debug.
 
 4) Analyze information from page owner::
 
@@ -126,4 +126,4 @@ Usage
 		-c		Cull by comparing stacktrace instead of total block.
 
 	Filter:
-		-f		Filter out the information of blocks whose memory has not been released.
+		-f		Filter out the information of blocks whose memory has been released.
-- 
2.31.1




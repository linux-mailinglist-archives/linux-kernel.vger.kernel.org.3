Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D7554D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358649AbiFVOfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358437AbiFVOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:35:02 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72457387B0;
        Wed, 22 Jun 2022 07:34:57 -0700 (PDT)
X-QQ-mid: bizesmtp83t1655908488t2wplegy
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 22:34:45 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000E00A0000000
X-QQ-FEAT: HMSvG+9aVfOvI0ncvrQ8fWQeSncCCBYRAdRTgt6HQakK/JFo+V4kshxZkvURu
        5Jr07Eii/6jb+1TtT3Lb93QyyAa14rh2sG5ZWLiRyN7tNBwTHvHDfn8qmdBXuip19YL5HaW
        KtzUVrHNaMBADg562QdMQlAGTWGzvxEraGzFVmNQHr+jJmvqO5PQZqLhZnftBj2kV0qtgGt
        xsWWRV3PIdB9/sXs8PaPNE0KpyRdMXCOwF25UPCmXZmBozyicffLyenYVGRbAS65mXJKeX2
        uCVIsTUsFqLsH8T/JXmvMThvc0Mx4swUNzznVMVY35eKJIVQ6RUCFyL9RN/LQmIxWWLLq+1
        hLalhlqnkHeJDvKK6eMZ76o6LFloEf38E+533tz
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, jiangjian@cdjrlc.com
Subject: [PATCH] media: atomisp: Fix typo in comments
Date:   Wed, 22 Jun 2022 22:34:42 +0800
Message-Id: <20220622143442.16942-1-jiangjian@cdjrlc.com>
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

Remove the repeated word 'and' from comments

file: drivers/staging/media/atomisp/pci/hive_isp_css_include/host/debug_public.h
line: 28

* The buffer has a remote and and a local store

changed to:

* The buffer has a remote and a local store

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 .../media/atomisp/pci/hive_isp_css_include/host/debug_public.h  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/debug_public.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/debug_public.h
index ee861ddb8e92..5660bd4221be 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/debug_public.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/debug_public.h
@@ -25,7 +25,7 @@
  * Simple queuing trace buffer for debug data
  * instantiatable in SP DMEM
  *
- * The buffer has a remote and and a local store
+ * The buffer has a remote and a local store
  * which contain duplicate data (when in sync).
  * The buffers are automatically synched when the
  * user dequeues, or manualy using the synch function
-- 
2.17.1


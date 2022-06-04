Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39C553D529
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350429AbiFDENq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiFDENn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:13:43 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763512E6AE;
        Fri,  3 Jun 2022 21:13:37 -0700 (PDT)
X-QQ-mid: bizesmtp65t1654315983tz7bgyfv
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Jun 2022 12:13:00 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: 0Mv5E39fBgZryfVyjPYIPioplg4fxOWAmPDHFrnSJ7KUfXYKXGXRdU9GByOnt
        dMqwrq2PrPh95iyul6GAZykQM/yPr41Nn2bYU0zrC9TGsGq+JZlJY9LlMXM7B+N8NeWj1GH
        IErWrJq5v0R5HVtDFwjPhMt/sJ0lM8fa04WReSqPU130dyhXZSbg4vbIdHIE8ZLvfcBvE29
        LH2J4A7kqG7O3SBqJV1AhlKTMtGeDjy0qJYp8l69swNlf3dCWCbj5IRS/wQQ+9dWEhn5Mza
        VAbnLa+SATeM+dRxPn+RWTeWjhxzy2OjNPX6OSsXKcwa6BmF/vqi2KcxC9arkijGJ5pCl/f
        Mp6QW0c
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     lenb@kernel.org
Cc:     james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] ACPI, APEI, Fix syntax errors in comments
Date:   Sat,  4 Jun 2022 12:12:53 +0800
Message-Id: <20220604041253.9298-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/acpi/apei/apei-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 33b7fbbeda82..9f49272cad39 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -3,7 +3,7 @@
  * apei-base.c - ACPI Platform Error Interface (APEI) supporting
  * infrastructure
  *
- * APEI allows to report errors (for example from the chipset) to the
+ * APEI allows to report errors (for example from the chipset) to
  * the operating system. This improves NMI handling especially. In
  * addition it supports error serialization and error injection.
  *
-- 
2.36.1


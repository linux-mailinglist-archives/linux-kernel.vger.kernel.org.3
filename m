Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A7D56CD21
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 06:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiGJEw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 00:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGJEw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 00:52:57 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488C2E0EA;
        Sat,  9 Jul 2022 21:52:51 -0700 (PDT)
X-QQ-mid: bizesmtp84t1657428757ts9pb3l3
Received: from localhost.localdomain ( [182.148.15.109])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 10 Jul 2022 12:52:35 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000C00A0000000
X-QQ-FEAT: 3ppQUczvdPs31HfZuafa++J6npiEHF//M4pNr+p1rzVl8VAtco08n9yoqzw4k
        OvbVq086tu7BACghh1B90C9NVDTbxRG5DWZnBz9IIdTdVLn2njktEGAdSfpxbEA0SUnLDq7
        MLOJH7ghDybFXRr16wWM5BMpKkgXTQ+zmhC80tn3nLnqzJrBYO1UcDcLtX71H/RYPoUrn2Y
        C6vRW3FOKgMZsuDlTAeVDmsFK/0NIcIbHK8pAA0raQJO9diM5beyKRK+XUpm8b3IW9b7nL1
        oNig5msyLdtParOZ7jGj87kcOGIPM8E82Qg1O/Jdw2efxROJVvzEdN/snfhu/7zVBalm+bw
        tcg8U43RSRdLNV7a7Cu3JSGf5k0z7rgT9AVcDGxuvbrXvT/JpGGGobinEFpeg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] acpi/acpica: fix repeated words in comments
Date:   Sun, 10 Jul 2022 12:52:18 +0800
Message-Id: <20220710045218.55021-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'is'.
 Delete the redundant word 'a'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/acpi/acpica/exconvrt.c | 2 +-
 drivers/acpi/acpica/nsprepkg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 8de5d47ad485..7a66a70fa974 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -446,7 +446,7 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 			 * Explicit conversion from the to_decimal_string ASL operator.
 			 *
 			 * From ACPI: "If the input is a buffer, it is converted to a
-			 * a string of decimal values separated by commas."
+			 * string of decimal values separated by commas."
 			 */
 			base = 10;
 
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 82932c9a774b..2afc5baa325c 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -540,7 +540,7 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 
 			/*
 			 * Make sure package is large enough for the Count and is
-			 * is as large as the minimum size
+			 * as large as the minimum size
 			 */
 			expected_count = (u32)(*sub_elements)->integer.value;
 			if (sub_package->package.count < expected_count) {
-- 
2.36.1


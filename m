Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA30D5901C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiHKPxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiHKPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:52:51 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5046697D6D;
        Thu, 11 Aug 2022 08:44:20 -0700 (PDT)
X-QQ-mid: bizesmtp85t1660232644t32ggu42
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 23:43:58 +0800 (CST)
X-QQ-SSF: 0100000000200060B000B00A0000000
X-QQ-FEAT: +ynUkgUhZJnrSkfX6RUwLa8u1PVPLcBhzKhvmXohh2NQnAafqJHCfP7Mxp7ik
        FgXQAul39KCZcROczGqRjIbAqbzkpwaaEdHkTJIZ4n9o58eq8rbHoE+f7upYJjBLSHegfE2
        RI4YzLI0FZm8TzEVqCMXxzJCLa2afUrCrxlaIYCnc8vQ7o3mMc5J0ho7Cm3uk3BpJlbwT8E
        2+HTVJ10p0bygADOcIMl6QTKaXB0S9WFqOStnxqP3LoL46Z0lLL3qe7Tf3yofgE/7jXIv7M
        Lux1v8y5ZBEMM58NoqXBy0Q4M0PKDUrlQjFXLzPvnlgGrMzjTW+rD8DDga9DGNvlPXZAxns
        7u8WzkHa0hmwXigMl70ohkdpH3VQDzylM0Z2lmj0uyfP2PTVwYBANeAvru7d40QJrRQRFNz
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] ACPICA: Fix typo in comments
Date:   Thu, 11 Aug 2022 11:43:57 -0400
Message-Id: <20220811154357.18674-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "method" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/acpi/acpica/psparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index ba93f359760a..b0faab1e6d3f 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -508,7 +508,7 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 			}
 
 			/*
-			 * If the transfer to the new method method call worked,
+			 * If the transfer to the new method call worked,
 			 * a new walk state was created -- get it
 			 */
 			walk_state = acpi_ds_get_current_walk_state(thread);
-- 
2.35.1


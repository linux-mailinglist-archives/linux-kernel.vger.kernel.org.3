Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849E2496DCC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiAVT6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33386 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiAVT6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C1F60EC1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E746C340E5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881488;
        bh=UCMsiG6f/DfKkaY0U1WLA1o44ruUik+sVj345f77EJw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eoGKWOB7gbb/Ux+C2ngU5bEFpmyeTi/as9IHZ5Cx7dULOvnz8xi60Y4aCgFtERzVL
         fTPsAHXj1Wh6FwTO5oDu9fOMa+AfmA5lIF+OU0NUiPXM9FczgGiGlCmUaADzegeHd6
         SLLmKOdLYJO9tSD9SeqxAjh6kCkrFbLxYn4gFqXfuXUptaVV0uaiDwPolSlokCHNpM
         lNqVoArhrY7CQo/GwpPd6LLEkmrduuU5h0lpDCc9NwAAn5uBp7AthrMMVgs90ruIFq
         pLBOi1jJAMxj48dZxEy5qSi+rxk68W1G9kYpeBcXEhODaP5Qo5/QP5HZx4pSaIdDcx
         JOhmEnVys8SDQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 24/30] habanalabs: update to latest f/w specs
Date:   Sat, 22 Jan 2022 21:57:25 +0200
Message-Id: <20220122195731.934494-24-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the latest versions of the f/w specs files.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 135e21d6edc9..15f91ae9de6e 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -33,6 +33,7 @@ enum cpu_boot_err {
 	CPU_BOOT_ERR_BOOT_FW_CRIT_ERR = 18,
 	CPU_BOOT_ERR_BINNING_FAIL = 19,
 	CPU_BOOT_ERR_TPM_FAIL = 20,
+	CPU_BOOT_ERR_TMP_THRESH_INIT_FAIL = 21,
 	CPU_BOOT_ERR_ENABLED = 31,
 	CPU_BOOT_ERR_SCND_EN = 63,
 	CPU_BOOT_ERR_LAST = 64 /* we have 2 registers of 32 bits */
@@ -111,6 +112,9 @@ enum cpu_boot_err {
  *
  * CPU_BOOT_ERR0_TPM_FAIL		TPM verification flow failed.
  *
+ * CPU_BOOT_ERR0_TMP_THRESH_INIT_FAIL	Failed to set threshold for tmperature
+ *					sensor.
+ *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
  *					running FW populates the error
@@ -134,6 +138,7 @@ enum cpu_boot_err {
 #define CPU_BOOT_ERR0_BOOT_FW_CRIT_ERR		(1 << CPU_BOOT_ERR_BOOT_FW_CRIT_ERR)
 #define CPU_BOOT_ERR0_BINNING_FAIL		(1 << CPU_BOOT_ERR_BINNING_FAIL)
 #define CPU_BOOT_ERR0_TPM_FAIL			(1 << CPU_BOOT_ERR_TPM_FAIL)
+#define CPU_BOOT_ERR0_TMP_THRESH_INIT_FAIL	(1 << CPU_BOOT_ERR_TMP_THRESH_INIT_FAIL)
 #define CPU_BOOT_ERR0_ENABLED			(1 << CPU_BOOT_ERR_ENABLED)
 #define CPU_BOOT_ERR1_ENABLED			(1 << CPU_BOOT_ERR_ENABLED)
 
-- 
2.25.1


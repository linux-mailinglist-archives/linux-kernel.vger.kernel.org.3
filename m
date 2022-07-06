Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26920567B92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiGFBea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 21:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiGFBe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:34:29 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BCD0101D8;
        Tue,  5 Jul 2022 18:34:28 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 36C5F1E80D40;
        Wed,  6 Jul 2022 09:32:17 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1880IgI1VR-9; Wed,  6 Jul 2022 09:32:14 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 8789F1E80CDE;
        Wed,  6 Jul 2022 09:32:14 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Li zeming <zeming@nfschina.com>
Subject: [PATCH] acpi/sbshc: Add header file macro definition
Date:   Wed,  6 Jul 2022 09:32:22 +0800
Message-Id: <20220706013222.5323-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header file macro definition.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/acpi/sbshc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/sbshc.h b/drivers/acpi/sbshc.h
index 695c390e2884..22b11a1655d2 100644
--- a/drivers/acpi/sbshc.h
+++ b/drivers/acpi/sbshc.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SBSHC_H
+#define _SBSHC_H
+
 struct acpi_smb_hc;
 enum acpi_smb_protocol {
 	SMBUS_WRITE_QUICK = 2,
@@ -30,3 +33,4 @@ extern int acpi_smbus_write(struct acpi_smb_hc *hc, u8 protocol, u8 slave_addres
 extern int acpi_smbus_register_callback(struct acpi_smb_hc *hc,
 		smbus_alarm_callback callback, void *context);
 extern int acpi_smbus_unregister_callback(struct acpi_smb_hc *hc);
+#endif
-- 
2.18.2


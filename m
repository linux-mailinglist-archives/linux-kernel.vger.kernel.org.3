Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF255F634
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiF2GIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiF2GHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:07:48 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E16862F034
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:07:34 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 222F61E80D11;
        Wed, 29 Jun 2022 14:06:24 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R_X_whhPI2Pt; Wed, 29 Jun 2022 14:06:21 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id CEE431E80CDC;
        Wed, 29 Jun 2022 14:06:20 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     lpieralisi@kernel.org, pali@kernel.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] bus: mvebu-mbus: Fix spelling mistake
Date:   Wed, 29 Jun 2022 14:07:16 +0800
Message-Id: <20220629060716.22310-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'informations' to 'information'.
Change 'accross' to 'across'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/bus/mvebu-mbus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index a6ec0566db12..5dc2669432ba 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -22,8 +22,8 @@
  *
  * - Reads out the SDRAM address decoding windows at initialization
  *   time, and fills the mvebu_mbus_dram_info structure with these
- *   informations. The exported function mv_mbus_dram_info() allow
- *   device drivers to get those informations related to the SDRAM
+ *   information. The exported function mv_mbus_dram_info() allow
+ *   device drivers to get those information related to the SDRAM
  *   address decoding windows. This is because devices also have their
  *   own windows (configured through registers that are part of each
  *   device register space), and therefore the drivers for Marvell
@@ -120,7 +120,7 @@ struct mvebu_mbus_soc_data {
 };
 
 /*
- * Used to store the state of one MBus window accross suspend/resume.
+ * Used to store the state of one MBus window across suspend/resume.
  */
 struct mvebu_mbus_win_data {
 	u32 ctrl;
-- 
2.34.1


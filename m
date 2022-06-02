Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB46053B55A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiFBIsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiFBIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:47:58 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F325BA0;
        Thu,  2 Jun 2022 01:47:50 -0700 (PDT)
X-QQ-mid: bizesmtp88t1654159656t7jkw0u3
Received: from localhost.localdomain ( [117.176.187.31])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 02 Jun 2022 16:47:27 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: XNMJAYeyDb1BQja60L+e0Tyze+zeCnNkRVEr1wydgq72XgMHSlMxTEc+H4rNl
        +xryqX8Vi52mNztyT7QyvEnWKFNh5WcORdkbrVtvzOFh7gET22Be6M/X+e8EO3pcbuELgFU
        xTgANtbV4Sz/wotfUXh66kMhgEati9WvqKQPozUhK2fVLmlja0I/uAADURAbJSiBH6iRGtC
        IXvGbeEF4VgUrkOWIG217DTEQiyQNceyPj1z2oZpDHsy/6ScEegIGT6KIqXafbM4j3Nv8ZR
        I2p5zXDo4xAFiebEXCALam5LLrpsZEzbp2dMJ2EhteDmcw8kLCWzJSSeqO55RBUzeh+Q==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] PCI: Fix syntax errors in comments
Date:   Thu,  2 Jun 2022 16:47:26 +0800
Message-Id: <20220602084726.11902-1-wangxiang@cdjrlc.com>
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
 arch/sparc/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 31b0c1983286..385c61d199cd 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -310,7 +310,7 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	/* We can't actually use the firmware value, we have
 	 * to read what is in the register right now.  One
 	 * reason is that in the case of IDE interfaces the
-	 * firmware can sample the value before the the IDE
+	 * firmware can sample the value before the IDE
 	 * interface is programmed into native mode.
 	 */
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3D157F369
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 07:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiGXF5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 01:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXF5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 01:57:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8724E13F69;
        Sat, 23 Jul 2022 22:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ALHQnf37rjocjkAbQbprdZiPEdNUODhIkV+7tdLrWNM=; b=el2Bq0Q1zo58rjpxtNtTTxfY8U
        00v14n2gqfX5lBcUSdpQ1PGR+LTTqhLdl/XmkW32A47BQGxqQLmA4DyerzVr1+4UNfdvCY4Q6oPul
        L4F2hS39BfpueodAKJBo51b7DBUGhMPLD41z3Zaij2YTvTrufEqUOmmlHlTFMWu2/NFbnXIFjnTsq
        na8k/o0VTnvX3BQHUTwdFfy6cAMki75cnkND5Ztt9RQx+fWJFCUA2xna8Ky280KemMz25KUiG9RvG
        SLBECr+1BrSuwM1airmfLtAydOf/QN4OMEHSWMpFGJQMSgwyGuh1MQr2Q/Rg7ACjR4C2bLJwHCiRp
        T6cMti0w==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oFUcL-0007zU-69; Sun, 24 Jul 2022 05:57:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH] MIPS: msi-octeon: eliminate kernel-doc warnings
Date:   Sat, 23 Jul 2022 22:57:23 -0700
Message-Id: <20220724055723.12986-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange kernel-doc notation for 2 functions to eliminate
kernel-doc warnings. Use Return: notation for the function
return value description. Add function short descriptions
for both functions.
Correct 2 typos.

Fixes these kernel-doc warnings:

msi-octeon.c:49: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Called when a driver request MSI interrupts instead of the
msi-octeon.c:49: warning: missing initial short description on line:
 * Called when a driver request MSI interrupts instead of the
msi-octeon.c:62: warning: No description found for return value of 'arch_setup_msi_irq'
msi-octeon.c:189: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Called when a device no longer needs its MSI interrupts. All
msi-octeon.c:189: warning: missing initial short description on line:
 * Called when a device no longer needs its MSI interrupts. All

Fixes: e8635b484f64 ("MIPS: Add Cavium OCTEON PCI support.")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Aditya Srivastava <yashsri421@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/pci/msi-octeon.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -46,16 +46,17 @@ static DEFINE_SPINLOCK(msi_free_irq_bitm
 static int msi_irq_size;
 
 /**
- * Called when a driver request MSI interrupts instead of the
+ * arch_setup_msi_irq() - setup MSI IRQs for a device
+ * @dev:    Device requesting MSI interrupts
+ * @desc:   MSI descriptor
+ *
+ * Called when a driver requests MSI interrupts instead of the
  * legacy INT A-D. This routine will allocate multiple interrupts
  * for MSI devices that support them. A device can override this by
  * programming the MSI control bits [6:4] before calling
  * pci_enable_msi().
  *
- * @dev:    Device requesting MSI interrupts
- * @desc:   MSI descriptor
- *
- * Returns 0 on success.
+ * Return: %0 on success, non-%0 on error.
  */
 int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
@@ -186,10 +187,11 @@ msi_irq_allocated:
 }
 
 /**
+ * arch_teardown_msi_irq() - release MSI IRQs for a device
+ * @irq:    The devices first irq number. There may be multiple in sequence.
+ *
  * Called when a device no longer needs its MSI interrupts. All
  * MSI interrupts for the device are freed.
- *
- * @irq:    The devices first irq number. There may be multple in sequence.
  */
 void arch_teardown_msi_irq(unsigned int irq)
 {

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E5E4966BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiAUVDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiAUVDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:03:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4047AC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4350B81E35
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 21:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43155C340E1;
        Fri, 21 Jan 2022 21:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642798981;
        bh=UygxUJeKtrvWKjcOvHZavPMo687PCkqQ5Gov65k70nw=;
        h=From:To:Cc:Subject:Date:From;
        b=IEL5akOerrkcwljF+2e4ueemrEh9R7HItv7GnQQh2+VYFUaXD4cTTXjGhUSDiOS1u
         b9kyJFacnKO96BEuRSotLiuSsGG/F78NrUAW5o2gC+EEIaHNW8hrBxueWiyJGYsIRa
         nrW/yWqBeZkA9m5wCpyUj7crG5JhuyMGBHNcQAbnthhB0NDGhPBKSthgtg8nrGaWI8
         LlAzCnuQ7CcnOsFAnK5y5/svINsvAU5Bxk53p2c8kZkqAOZcQhxRWW3apRcbxFPXFF
         LVo1pRMxl6bQ+7HRkrM+cmsYQDzOTuyJ8QanaKlmqCghgFPoAZxggRhCW+TEbpKW/Z
         LGK202lcfoa8A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, linux-pci@linux-xtensa.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1] xtensa: Remove unused early_read_config_byte() et al declarations
Date:   Fri, 21 Jan 2022 15:02:58 -0600
Message-Id: <20220121210258.1152803-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

early_read_config_byte() and similar are declared but never defined.
Remove the unused declarations.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/xtensa/include/asm/pci-bridge.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/xtensa/include/asm/pci-bridge.h b/arch/xtensa/include/asm/pci-bridge.h
index 405526912d9a..e320aa5bbedb 100644
--- a/arch/xtensa/include/asm/pci-bridge.h
+++ b/arch/xtensa/include/asm/pci-bridge.h
@@ -73,13 +73,4 @@ static inline void pcibios_init_resource(struct resource *res,
 	res->child = NULL;
 }
 
-
-/* These are used for config access before all the PCI probing has been done. */
-int early_read_config_byte(struct pci_controller*, int, int, int, u8*);
-int early_read_config_word(struct pci_controller*, int, int, int, u16*);
-int early_read_config_dword(struct pci_controller*, int, int, int, u32*);
-int early_write_config_byte(struct pci_controller*, int, int, int, u8);
-int early_write_config_word(struct pci_controller*, int, int, int, u16);
-int early_write_config_dword(struct pci_controller*, int, int, int, u32);
-
 #endif	/* _XTENSA_PCI_BRIDGE_H */
-- 
2.25.1


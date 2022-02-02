Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636F24A6D0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbiBBIkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:40:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43240 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiBBIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:40:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE52604F5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 08:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2C4C004E1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643791253;
        bh=BsJqPHr1a1QERpDYDjRxAe2utZwlVtAoE7GZWIK1xF4=;
        h=From:To:Subject:Date:From;
        b=Gyyj5IeC5IVLOcs17EBVsZpaJZ+hBpFtu+e7zc+sRGWC9UEb40pTF7lJAweNkTz//
         qZi6Dfa6iNewYEPutgWN+QEXWPtTK/Ctt4Pgn6a2OegJEbY8gH8X+2/lf+BNIG5Uad
         dHamDgPGNVJaR64TO8O7C2tqJsJUMT4RXpi7slRC5mg351Eww8VYWdtgLOWJf+pI0d
         L+q0gWmklPW9+l9luLmIWgLCM5hTdQ9s64RdRHpSesQEXXCwJaJ5MvQtdtNlerDDWY
         FddCPweqUmmirx0ngHNqgHuj3+j8LtzyDW1yNCGPWtYkd9bsUWt2ermRUiKZoWJvRZ
         73B85bdG0CMqg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: add missing include of vmalloc.h
Date:   Wed,  2 Feb 2022 10:40:49 +0200
Message-Id: <20220202084049.3184758-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of vfree(), vmalloc_user(), vmalloc() and remap_vmalloc_range()
requires this include in some architectures.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 348daac621ee..7bd4cae87a54 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -11,6 +11,7 @@
 
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/pci-p2pdma.h>
 
 MODULE_IMPORT_NS(DMA_BUF);
-- 
2.25.1


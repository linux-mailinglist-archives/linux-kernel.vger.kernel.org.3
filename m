Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0312B52C064
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiERRDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbiERRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:03:05 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748B51A29DE
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:03:02 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nrN4d-0001Pv-1b; Wed, 18 May 2022 19:02:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        hch@lst.de, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/4] riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol
Date:   Wed, 18 May 2022 19:02:52 +0200
Message-Id: <20220518170254.3178923-3-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518170254.3178923-1-heiko@sntech.de>
References: <20220518170254.3178923-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This improves the symbol's description to make it easier for
people to understand what it is about.

Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/Kconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 65285b980134..a4b299ad4473 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -356,8 +356,13 @@ config RISCV_ISA_SVPBMT
 	select RISCV_ALTERNATIVE
 	default y
 	help
-	   Adds support to dynamically detect the presence of the SVPBMT extension
-	   (Supervisor-mode: page-based memory types) and enable its usage.
+	   Adds support to dynamically detect the presence of the SVPBMT
+	   ISA-extension (Supervisor-mode: page-based memory types) and
+	   enable its usage.
+
+	   The memory type for a page contains a combination of attributes
+	   that indicate the cacheability, idempotency, and ordering
+	   properties for access to that page.
 
 	   The SVPBMT extension is only available on 64Bit cpus.
 
-- 
2.35.1


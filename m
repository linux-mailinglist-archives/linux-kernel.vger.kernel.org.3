Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406784AF209
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiBIMm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiBIMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:42:23 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE868C0613CA;
        Wed,  9 Feb 2022 04:42:25 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nHmEv-0001Mv-BV; Wed, 09 Feb 2022 13:38:29 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, huffman@cadence.com,
        mick@ics.forth.gr, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v6 13/14] riscv: remove FIXMAP_PAGE_IO and fall back to its default value
Date:   Wed,  9 Feb 2022 13:37:59 +0100
Message-Id: <20220209123800.269774-14-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209123800.269774-1-heiko@sntech.de>
References: <20220209123800.269774-1-heiko@sntech.de>
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

If not defined in the arch, FIXMAP_PAGE_IO defaults to PAGE_KERNEL_IO,
which we defined when adding the svpbmt implementation.

So drop the FIXMAP_PAGE_IO riscv define.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/include/asm/fixmap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 58a718573ad6..692e25e56d8e 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -44,8 +44,6 @@ enum fixed_addresses {
 	__end_of_fixed_addresses
 };
 
-#define FIXMAP_PAGE_IO		PAGE_KERNEL
-
 #define __early_set_fixmap	__set_fixmap
 
 #define __late_set_fixmap	__set_fixmap
-- 
2.30.2


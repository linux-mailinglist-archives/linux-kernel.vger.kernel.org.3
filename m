Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69957815C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiGRLzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:55:49 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87D823177
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:55:44 -0700 (PDT)
X-QQ-mid: bizesmtp73t1658145336tq5j77rk
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 19:55:35 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: tyV+f0f3wWdqykYe5zQ7mwRy9UwHLWPO8Uv42zkLwW+tZ33nKlElnTElPdVFb
        Bmo9UjblvyzgZnUaXDwd2g04trnMZCA5zixxjiic1DKLIAVlwOTC8AGNEbyJO026xT78aIk
        uZSCn8n13vREfV3sKStCbhhMPUvCZHf1bPz1bZRs4CEwneJMJHZLZg7Ha0tbnw2tFzL9dXS
        QBZXg8SMfq/HmcRFpW826v04ZbmF8THezYSKGLCiWfahJzmpKhql/Y1nJONygyJhpEwygUG
        OC4ls9XqCPc2HuyXm2AoBr92hcZJssPtWh9kHpNr/auk7e9W6pUJLlBPLr3UxmsNluH+hWf
        1xK9wlvjanGTS6cNcvCdlj9xwt9SEIk77ApupeWOLU5MyAFGQOOrtAj9c326oBnJwNDCDCZ
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     paulus@samba.org
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, nick.child@ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] powerpc/sysdev: Fix comment typo
Date:   Fri, 15 Jul 2022 11:52:50 +0800
Message-Id: <20220715035250.5978-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `is' is duplicated in line 110, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/sysdev/cpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index 3f130312b6e9..915f4d3991c3 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -107,7 +107,7 @@ EXPORT_SYMBOL(cpm_command);
  * memory mapped space.
  * The baud rate clock is the system clock divided by something.
  * It was set up long ago during the initial boot phase and is
- * is given to us.
+ * given to us.
  * Baud rate clocks are zero-based in the driver code (as that maps
  * to port numbers).  Documentation uses 1-based numbering.
  */
-- 
2.35.1


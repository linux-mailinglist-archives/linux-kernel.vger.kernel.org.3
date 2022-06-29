Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971FA55F426
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiF2D3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiF2D3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:29:20 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C501A050;
        Tue, 28 Jun 2022 20:29:18 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 27FCC1E80D11;
        Wed, 29 Jun 2022 11:28:09 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s7BffYbgTWxE; Wed, 29 Jun 2022 11:28:06 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 661CA1E80CDC;
        Wed, 29 Jun 2022 11:28:06 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] arch: Fix spelling mistake
Date:   Wed, 29 Jun 2022 11:29:08 +0800
Message-Id: <20220629032908.12417-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'modifed' to 'modified'.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/mips/include/asm/octeon/cvmx-helper-board.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-helper-board.h b/arch/mips/include/asm/octeon/cvmx-helper-board.h
index ce52aafe7a8d..81c40272f2b1 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-board.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-board.h
@@ -63,7 +63,7 @@ typedef enum {
  * connected to this port. On chips supporting multiple MII
  * busses the bus number is encoded in bits <15:8>.
  *
- * This function must be modifed for every new Octeon board.
+ * This function must be modified for every new Octeon board.
  * Internally it uses switch statements based on the cvmx_sysinfo
  * data to determine board types and revisions. It relys on the
  * fact that every Octeon board receives a unique board type
@@ -81,7 +81,7 @@ extern int cvmx_helper_board_get_mii_address(int ipd_port);
  * and are handled by the fall through case. This function must be
  * updated for boards that don't have the normal Marvell PHYs.
  *
- * This function must be modifed for every new Octeon board.
+ * This function must be modified for every new Octeon board.
  * Internally it uses switch statements based on the cvmx_sysinfo
  * data to determine board types and revisions. It relys on the
  * fact that every Octeon board receives a unique board type
@@ -103,7 +103,7 @@ extern union cvmx_helper_link_info __cvmx_helper_board_link_get(int ipd_port);
  * support and should return the number of actual ports on the
  * board.
  *
- * This function must be modifed for every new Octeon board.
+ * This function must be modified for every new Octeon board.
  * Internally it uses switch statements based on the cvmx_sysinfo
  * data to determine board types and revisions. It relys on the
  * fact that every Octeon board receives a unique board type
-- 
2.18.2


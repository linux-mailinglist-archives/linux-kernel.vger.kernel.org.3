Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D8C55466A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiFVK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346857AbiFVK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:27:31 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D53643B556;
        Wed, 22 Jun 2022 03:27:28 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 92D3B1E80CD1;
        Wed, 22 Jun 2022 18:27:17 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YcCGMe_fzIrh; Wed, 22 Jun 2022 18:27:14 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.97])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 77E371E80C7D;
        Wed, 22 Jun 2022 18:27:14 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     tsbogend@alpha.franken.de
Cc:     rdunlap@infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH v2] MIPS: Fix some typos
Date:   Wed, 22 Jun 2022 18:27:20 +0800
Message-Id: <20220622102720.30450-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622090713.24370-1-jiaming@nfschina.com>
References: <20220622090713.24370-1-jiaming@nfschina.com>
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

Change 'modifed' to 'modified'.
Change 'relys' to 'relies'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 .../mips/cavium-octeon/executive/cvmx-helper-board.c |  4 ++--
 arch/mips/include/asm/octeon/cvmx-helper-board.h     | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 1daa0c6b6f4e..d09d0769f549 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -282,9 +282,9 @@ union cvmx_helper_link_info __cvmx_helper_board_link_get(int ipd_port)
  * support and should return the number of actual ports on the
  * board.
  *
- * This function must be modifed for every new Octeon board.
+ * This function must be modified for every new Octeon board.
  * Internally it uses switch statements based on the cvmx_sysinfo
- * data to determine board types and revisions. It relys on the
+ * data to determine board types and revisions. It relies on the
  * fact that every Octeon board receives a unique board type
  * enumeration from the bootloader.
  *
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-board.h b/arch/mips/include/asm/octeon/cvmx-helper-board.h
index ce52aafe7a8d..cfe9c256a918 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-board.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-board.h
@@ -63,9 +63,9 @@ typedef enum {
  * connected to this port. On chips supporting multiple MII
  * busses the bus number is encoded in bits <15:8>.
  *
- * This function must be modifed for every new Octeon board.
+ * This function must be modified for every new Octeon board.
  * Internally it uses switch statements based on the cvmx_sysinfo
- * data to determine board types and revisions. It relys on the
+ * data to determine board types and revisions. It relies on the
  * fact that every Octeon board receives a unique board type
  * enumeration from the bootloader.
  *
@@ -81,9 +81,9 @@ extern int cvmx_helper_board_get_mii_address(int ipd_port);
  * and are handled by the fall through case. This function must be
  * updated for boards that don't have the normal Marvell PHYs.
  *
- * This function must be modifed for every new Octeon board.
+ * This function must be modified for every new Octeon board.
  * Internally it uses switch statements based on the cvmx_sysinfo
- * data to determine board types and revisions. It relys on the
+ * data to determine board types and revisions. It relies on the
  * fact that every Octeon board receives a unique board type
  * enumeration from the bootloader.
  *
@@ -103,9 +103,9 @@ extern union cvmx_helper_link_info __cvmx_helper_board_link_get(int ipd_port);
  * support and should return the number of actual ports on the
  * board.
  *
- * This function must be modifed for every new Octeon board.
+ * This function must be modified for every new Octeon board.
  * Internally it uses switch statements based on the cvmx_sysinfo
- * data to determine board types and revisions. It relys on the
+ * data to determine board types and revisions. It relies on the
  * fact that every Octeon board receives a unique board type
  * enumeration from the bootloader.
  *
-- 
2.25.1


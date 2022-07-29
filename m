Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06251584E88
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiG2KHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiG2KHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A5181B03;
        Fri, 29 Jul 2022 03:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E53E61DCC;
        Fri, 29 Jul 2022 10:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CD9C433D6;
        Fri, 29 Jul 2022 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659089269;
        bh=jLXNpvbkVuc/riRik6wZTWlkdiGTxaidgr+pFRiWClQ=;
        h=From:To:Cc:Subject:Date:From;
        b=QBTbupyOTG/Ea7N6OY7UOKTXGz5fBm8BpNtscabjRy9M8w+LKzQWRoWtKfuTUbUgP
         PVABGXZ5c2D/n2n/SSvd7qqaK9R+wq8W3nNtWXYEB9dvD2BQpPfUjYLz0KXAR9oyS3
         wh1Hulj3cl6AiyiyzZBVO3x1wX6/tvOGa10XG+3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH] docs: embargoed-hardware-issues: remove bouncing AMD contact info
Date:   Fri, 29 Jul 2022 12:07:45 +0200
Message-Id: <20220729100745.2225558-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2862; i=gregkh@linuxfoundation.org; h=from:subject; bh=jLXNpvbkVuc/riRik6wZTWlkdiGTxaidgr+pFRiWClQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmPN+ZetA37xTJHV9fLTOaiQt2/O/dyn3GtmM5yimGl3M25 IkmnO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAikgYM8yx8WHsZH60S4sth6VWYfW vl5O3n/zMsWLhEalJb5bM6/8Pv/d/Per4tdlVvIAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current AMD contact info in the embargoed-hardware-issues.rst file
is bouncing as an invalid address, so remove it from the documentation.

At this point in time, the kernel community has no way to contact AMD
for any hardware-specific problems.  Hopefully they can resolve this
issue soon, or maybe they just don't have any hardware bugs and do not
need to worry about this.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Hu Haowen <src.res@email.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/embargoed-hardware-issues.rst             | 2 +-
 .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
 .../translations/zh_TW/process/embargoed-hardware-issues.rst    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 95999302d279..a8c38e1c40dc 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
 an involved disclosed party. The current ambassadors list:
 
   ============= ========================================================
-  AMD		Tom Lendacky <tom.lendacky@amd.com>
+  AMD
   Ampere	Darren Hart <darren@os.amperecomputing.com>
   ARM		Catalin Marinas <catalin.marinas@arm.com>
   IBM Power	Anton Blanchard <anton@linux.ibm.com>
diff --git a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
index 88273ebe7823..a59d6e311cc2 100644
--- a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
@@ -174,7 +174,7 @@ CVE分配
 
   ============= ========================================================
   ARM
-  AMD		Tom Lendacky <tom.lendacky@amd.com>
+  AMD
   IBM
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
diff --git a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
index 6c76fc96131a..b4a594320c69 100644
--- a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
@@ -177,7 +177,7 @@ CVE分配
 
   ============= ========================================================
   ARM
-  AMD		Tom Lendacky <tom.lendacky@amd.com>
+  AMD
   IBM
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
-- 
2.37.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA4A5AF9BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIGCNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIGCNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:13:15 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E188A6CA;
        Tue,  6 Sep 2022 19:13:14 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id BBU00010;
        Wed, 07 Sep 2022 10:13:10 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 10:13:11 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <david@lechnology.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <nsekhar@ti.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] clk: davinci: Fix spelling typo in comment.
Date:   Tue, 6 Sep 2022 09:27:30 -0400
Message-ID: <20220906132730.3977-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid:   2022907101310cd91f230c681606fd029c6306301c4e5
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the maxiumum to maximum.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/clk/davinci/pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 082206676e73..f862f5e2b3fc 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -98,7 +98,7 @@
  * @hw: clk_hw for the pll
  * @base: Base memory address
  * @pllm_min: The minimum allowable PLLM[PLLM] value
- * @pllm_max: The maxiumum allowable PLLM[PLLM] value
+ * @pllm_max: The maximum allowable PLLM[PLLM] value
  * @pllm_mask: Bitmask for PLLM[PLLM] value
  */
 struct davinci_pll_clk {

base-commit: 840126e36e8ff272cb63158646433fa1324533d9
-- 
2.27.0


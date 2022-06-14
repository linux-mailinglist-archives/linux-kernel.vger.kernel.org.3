Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5655554ADB6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245075AbiFNJuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbiFNJtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:49:47 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13337443DC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=dhx9YTpVwW/F5JDxftQIj4yB0Qv
        VqWjJfB8eo/F5H8k=; b=kt88BNgDcqZqwQlSj8zR4s+FsMBZbv8/18nGSfjOkno
        UR0GlYTxKMJVYLf20JQK//pqIWukoYQY3gPWesgzndBwU/mGdrqOO6tyyqBW4Qx6
        qas2pnvcMqtiKboRbQcS9e1VuFNG7+e8wMLwYDlgBBSxks5dZ+DwwhXe2KRPTCaQ
        =
Received: (qmail 1658824 invoked from network); 14 Jun 2022 11:49:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jun 2022 11:49:41 +0200
X-UD-Smtp-Session: l3s3148p1@QonQUmXh33VZD+ws
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: renesas: r8a779f0: Add HSCIF clocks
Date:   Tue, 14 Jun 2022 11:49:37 +0200
Message-Id: <20220614094937.8104-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1: include all HSCIF

 drivers/clk/renesas/r8a779f0-cpg-mssr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
index 0aec5e8ffd96..4528f50c8174 100644
--- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
@@ -118,6 +118,10 @@ static const struct cpg_core_clk r8a779f0_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a779f0_mod_clks[] __initconst = {
+	DEF_MOD("hscif0",	514,	R8A779F0_CLK_S0D3),
+	DEF_MOD("hscif1",	515,	R8A779F0_CLK_S0D3),
+	DEF_MOD("hscif2",	516,	R8A779F0_CLK_S0D3),
+	DEF_MOD("hscif3",	517,	R8A779F0_CLK_S0D3),
 	DEF_MOD("i2c0",		518,	R8A779F0_CLK_S0D6_PER),
 	DEF_MOD("i2c1",		519,	R8A779F0_CLK_S0D6_PER),
 	DEF_MOD("i2c2",		520,	R8A779F0_CLK_S0D6_PER),
-- 
2.35.1


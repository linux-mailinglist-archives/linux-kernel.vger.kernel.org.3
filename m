Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FFD5733C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiGMKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiGMKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:06:19 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E659F90F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=BPp5By23roYfK7
        iwbIO2bAgRQF/uABOekz9nkUl6+rI=; b=nAoGxwEGgYtdJejksDUAXkLrpnA8C/
        r9GTz2DxIwW1HbjHSrCM/3d+tMgDbjdO3Wa6FvvY/bMHOKW1le7InKGlEoBf++fh
        Bnxy6G36167FsZwySRElSS6OtagShc3GQ4VM7sGQglDl91lpho473NOGwcPo2hur
        VCHWXsE+Hp2vQ=
Received: (qmail 123513 invoked from network); 13 Jul 2022 12:06:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 12:06:16 +0200
X-UD-Smtp-Session: l3s3148p1@DG+F76zjrtYgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] clocksource/drivers/sh_cmt: Add R-Car Gen4 support
Date:   Wed, 13 Jul 2022 12:06:03 +0200
Message-Id: <20220713100603.3391-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713100603.3391-1-wsa+renesas@sang-engineering.com>
References: <20220713100603.3391-1-wsa+renesas@sang-engineering.com>
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

Add support for the R-Car Gen4 CMT types 0/1 which are the same as in
the previous two generations.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/clocksource/sh_cmt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index dd0956ad969c..64dcb082d4cf 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -981,6 +981,14 @@ static const struct of_device_id sh_cmt_of_table[] __maybe_unused = {
 		.compatible = "renesas,rcar-gen3-cmt1",
 		.data = &sh_cmt_info[SH_CMT1_RCAR_GEN2]
 	},
+	{
+		.compatible = "renesas,rcar-gen4-cmt0",
+		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
+	},
+	{
+		.compatible = "renesas,rcar-gen4-cmt1",
+		.data = &sh_cmt_info[SH_CMT1_RCAR_GEN2]
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
-- 
2.35.1


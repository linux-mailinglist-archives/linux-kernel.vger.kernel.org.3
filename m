Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C5C4E1DD9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbiCTVKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343682AbiCTVKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:10:36 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084973FBE3;
        Sun, 20 Mar 2022 14:09:11 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CB401240005;
        Sun, 20 Mar 2022 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647810549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eoUvjXcWxsCS2k8VppywzQry5S7nHcH0mW8C42GzOcs=;
        b=Kv7mnn6+qhPoe4nYAA3HU8KH96O+5yNpew8NlJqW72ofsz2ognKKCzpo6Ro6Qmuh0o6/Aj
        H4MDHrQTsDpJkXRpoVCIk2lp8hdLr9hgtulZKUNXmaZSGN69vlAfQNW1YX3dp4XAcHNNDa
        RxiykDC3B/+fAfxAf2cA3R3rB8nJDSKPFHKjlVaX80wJOW9I6LPmhdiWYncCdRD9bLhw67
        nnnWmK0oE9guT/rcqjPVCAA8uH0k9ULd+eYSJkTPPKOUFcY0eSQnRwAFDNPtwvm0wJrl4n
        axkoZzjlqM+jistlPqfPumFuC+R63Dc1qnYE6ztCeP6BqNFYwqqFl53dFD2xYA==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: sun6i-rtc: include clk/sunxi-ng.h
Date:   Sun, 20 Mar 2022 22:09:04 +0100
Message-Id: <20220320210905.6606-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This solves:
>> drivers/clk/sunxi-ng/ccu-sun6i-rtc.c:334:5: warning: no previous prototype for 'sun6i_rtc_ccu_probe' [-Wmissing-prototypes]
     334 | int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)
         |     ^~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index 712fda22efd5..8a10bade7e0d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -9,6 +9,8 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 
+#include <linux/clk/sunxi-ng.h>
+
 #include "ccu_common.h"
 
 #include "ccu_div.h"
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337C3573A93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiGMPuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiGMPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:50:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A126924BFB;
        Wed, 13 Jul 2022 08:50:34 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.155]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mw99Y-1nJYVH2GyC-00s74U; Wed, 13 Jul 2022 17:50:15 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 3/3] clk: bcm: rpi: Show clock id limit in error case
Date:   Wed, 13 Jul 2022 17:49:53 +0200
Message-Id: <20220713154953.3336-4-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713154953.3336-1-stefan.wahren@i2se.com>
References: <20220713154953.3336-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8mnJLUyPm2j8Dg6SBPoCNRDkohg99QfXZh8VkkEFevhN5A6P6sP
 nBIu5b5oVOrVqz3RSRFIq/uvpy8hRPJ76z3/Gq8xekVgq9nMbwd+DKEpOsafopJTe3ZoNbG
 rg5Nf2ARTxJpVuqZ/sVPOG3PCFWDRbwpP96G9qAh7D6ZqiRcSYeg7WVA+H1/fmHiZucdO4v
 EoZpfSGSrYOSQd0Rzhbow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xh7qk7C8uOs=:qEDdAYmcQ/dTXZQ1jLyBfq
 zkdBlORYvpKG8v663Z5MWcbMXp/+tH3PPt/IuLuSRAo/l2mhH/pkwu5bkqXPxDB7X14qPGJxG
 GW8/PIKtVkXTnCH/uyTEGbptdwjzV6s8FIV3Y7oj8WUFX1ukITic9N0+BgjzpRnn+pK7MoI7T
 PqmR3ow9dHX6X/9nrjaCEmsEGpI+R2eMCW6tOv8kCoQXxM+Q5FgYM58wW72vbD/S9Xxv+NIsT
 0pMEYL3EkHbfIqs9Dor2KA7NmJIzzDBvGoyUBRon1Bu00cAkcWZZ8rLkcz/W0aRTRgBpkWKVn
 HE9A9Zxri71tFjALCWelIGJJX9Pcm//cjuspEclemlYfLbIUacpEIRpigPnI4qR+KAFL83tCV
 XjcPrOzPXzY0pce1xjTcywqqU1quRtF/j+3SG87gsrQjOhlwBl5CfPXNIzAtF9pJ7SKQBZT6t
 borKQtg4eBXem6TBwqadm91XxwzY/bEfwKB6BYbzLLh7nUtd5KpQGzFLCLOxmPXN/ozrFBPzu
 cw4KZZZ1Bvtq8qFiNopEwXO0zg1FL1WPO8sNBHw0zcdr7xODpEGs3E1YdMsS8ZPk0QEHQQgXN
 Yf9/zYSZqItmIfGVIhqp+LPue1j+z1rK4CHzqgU4tXmFK4noCFz6BNT8zbHemLbk3BRpN5Kh8
 P+xzDl9qszO4rH00teRQ76adlSrzG4zdCWypPaOIzCAWJwtz6DvHeGLd0LHCb8eUMUHRUIyXg
 K74mW/gBeft29x6gkJzdlykFaDmH0mwYaWczEcxVGvfUnw6eLsXhfySBfbU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock id limit will be extended in the future, so it would be
helpful to see the actual clock id limit in case the firmware
response has been rejected.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index b3b629516182..676e5379ebce 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -365,7 +365,8 @@ static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
 		struct raspberrypi_clk_variant *variant;
 
 		if (clks->id > RPI_FIRMWARE_NUM_CLK_ID) {
-			dev_err(rpi->dev, "Unknown clock id: %u\n", clks->id);
+			dev_err(rpi->dev, "Unknown clock id: %u (max: %u)\n",
+					   clks->id, RPI_FIRMWARE_NUM_CLK_ID);
 			return -EINVAL;
 		}
 
-- 
2.25.1


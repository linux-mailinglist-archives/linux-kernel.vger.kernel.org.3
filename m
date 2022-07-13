Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63BC573A92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiGMPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbiGMPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:50:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC084E85B;
        Wed, 13 Jul 2022 08:50:33 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.155]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVe1U-1o1ekN0t6K-00RbxS; Wed, 13 Jul 2022 17:50:15 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/3] clk: bcm: rpi: Add missing newline
Date:   Wed, 13 Jul 2022 17:49:52 +0200
Message-Id: <20220713154953.3336-3-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713154953.3336-1-stefan.wahren@i2se.com>
References: <20220713154953.3336-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sGcyrdiutb7GIoCLipnUr6iIVEMZ+gsBWeTC2KmS5tqLdxpzkyB
 Wk50z1h/Ma6Xmm+0SdXcZ/Iqy79E/fhfv67qOruy3qvyOC8hmQstbNOC5rQEzFLSYVDI2wR
 ne//FkZ85AwORjyJLCnHEx2Qg/gyFip5RVqYrQJYQsjh/FXJCEeJFBnA49JsB2egqqgdiV+
 OXgHcxBB7DTrzt4sAiTlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BdWXRuZEhGY=:HySxyUUrMsch78s564Xixj
 spPtAVQkZQRDJOHen31aR66pqhayupEtzY55Reih+bAv4aHtWLGcVTg136zAqGN2oZQQQVgiM
 KgsaICaOtbQpX665ShyVbY9uaXizcIncqpm8CeAZIqVrOWeqKoQinEaMceQzl7ePh19+UkuS8
 b1rzCUxaWRuX0rbMblFSdJ0UXj4DuaqJHc4K8xnVFsDPbCmhjuizX9rMCYwMWGY7ITq8ATB3E
 RTJnuBY9ceRP8fUN6e8M1Bi4FtjMvCtnuLTt1o3oseidva8UqnnsDelFeiI/Er0X7Hp1hrNkE
 ZwzE76mnbT3JB5csjjKqcfvT/H+8RGEI/twYtnEM/rQsB3TwBlSrWFA8/D/7BWTwd53fAPQNI
 qycFpUPFmNIUDo+rQcid6XgB/Uv98vIQUdEpYeOOObl0xJSzCdJnloxnC3M8HzOcha5wnlK6o
 an+16M8CcBMjfJSVyEx+UWOFd1jT+eRQQy0oakEYOEvWEhNBzgmSWB/yBQ1dRD7OY2zFzC7f1
 on5JEHISRBg+OjL+XVHor9PYZA4AZtxfSozzzGbLFiDrDHrrMFGMmlABBy7NGIh22xvC+dAHC
 x45quEtcbEyNE6/FaZUiTCZ5s3CYAI166FiyB1Rj4JAUkL166aqYy1G7cOSYkWCtk9XgggomE
 P/YY5v2u2ZUEdsGUaLoNum4QsLKV/wr4T1z+Sov5XXVBnuo/9uImqkm5ce+wQHTYxvZ7ifLJ9
 XrjeL2CBdJuvn3IVghjEzo66KFunMZiQnCnBuHiwrUTAYnrQX4aHz9OmqYQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some log messages lacks the final newline. So add them.

Fixes: 93d2725affd6 ("clk: bcm: rpi: Discover the firmware clocks")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 79cbf0c0b401..b3b629516182 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -220,7 +220,7 @@ static int raspberrypi_fw_set_rate(struct clk_hw *hw, unsigned long rate,
 	ret = raspberrypi_clock_property(rpi->firmware, data,
 					 RPI_FIRMWARE_SET_CLOCK_RATE, &_rate);
 	if (ret)
-		dev_err_ratelimited(rpi->dev, "Failed to change %s frequency: %d",
+		dev_err_ratelimited(rpi->dev, "Failed to change %s frequency: %d\n",
 				    clk_hw_get_name(hw), ret);
 
 	return ret;
@@ -288,7 +288,7 @@ static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
 					 RPI_FIRMWARE_GET_MIN_CLOCK_RATE,
 					 &min_rate);
 	if (ret) {
-		dev_err(rpi->dev, "Failed to get clock %d min freq: %d",
+		dev_err(rpi->dev, "Failed to get clock %d min freq: %d\n",
 			id, ret);
 		return ERR_PTR(ret);
 	}
@@ -365,7 +365,7 @@ static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
 		struct raspberrypi_clk_variant *variant;
 
 		if (clks->id > RPI_FIRMWARE_NUM_CLK_ID) {
-			dev_err(rpi->dev, "Unknown clock id: %u", clks->id);
+			dev_err(rpi->dev, "Unknown clock id: %u\n", clks->id);
 			return -EINVAL;
 		}
 
-- 
2.25.1


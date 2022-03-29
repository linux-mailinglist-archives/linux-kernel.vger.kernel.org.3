Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1594F4EA7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiC2GKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiC2GKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:10:11 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364715599
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 23:08:26 -0700 (PDT)
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Tue, 29 Mar 2022
 14:08:24 +0800
From:   Qianggui Song <qianggui.song@amlogic.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Qianggui Song <qianggui.song@amlogic.com>,
        kernel test robot <lkp@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: meson: fix unused variable warning
Date:   Tue, 29 Mar 2022 14:08:21 +0800
Message-ID: <20220329060821.15251-1-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot reported a warning as below:
>> drivers/pinctrl/meson/pinctrl-meson-s4.c:178:27: warning: unused variable 'tdm_sclk1_c_pins' [-Wunused-const-variable]
   static const unsigned int tdm_sclk1_c_pins[]            = { GPIOC_3 };

Fix it by adding missing description about this pins

Fixes: 775214d389c2 ("pinctrl: meson: add pinctrl driver support for Meson-S4 Soc")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
---
 drivers/pinctrl/meson/pinctrl-meson-s4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-s4.c b/drivers/pinctrl/meson/pinctrl-meson-s4.c
index 3c7358f53302..067c6749c849 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-s4.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-s4.c
@@ -575,6 +575,7 @@ static struct meson_pmx_group meson_s4_periphs_groups[] = {
 	GROUP(tdm_d2_c,			4),
 	GROUP(tdm_d3_c,			4),
 	GROUP(tdm_fs1_c,		4),
+	GROUP(tdm_sclk1_c,		4),
 	GROUP(mclk_1_c,			4),
 	GROUP(tdm_d4_c,			4),
 	GROUP(tdm_d5_c,			4),
@@ -937,6 +938,7 @@ static const char * const iso7816_groups[] = {
 
 static const char * const tdm_groups[] = {
 	"tdm_d2_c", "tdm_d3_c", "tdm_fs1_c", "tdm_d4_c", "tdm_d5_c",
+	"tdm_sclk1_c",
 	"tdm_fs1_d", "tdm_d4_d", "tdm_d3_d", "tdm_d2_d", "tdm_sclk1_d",
 	"tdm_sclk1_h", "tdm_fs1_h", "tdm_d2_h", "tdm_d3_h", "tdm_d4_h",
 	"tdm_d1", "tdm_d0", "tdm_fs0", "tdm_sclk0", "tdm_fs2", "tdm_sclk2",
-- 
2.34.1


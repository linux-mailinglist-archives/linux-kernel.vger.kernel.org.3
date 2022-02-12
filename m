Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38C74B38DE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 03:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiBMCE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 21:04:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiBMCE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:04:56 -0500
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de [80.67.18.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DB65FF1C;
        Sat, 12 Feb 2022 18:04:51 -0800 (PST)
Received: from [92.206.166.137] (helo=note-book.lan)
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1nIwqp-0000Mn-QE; Sat, 12 Feb 2022 19:10:27 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v3 3/3] leds: sgm3140: Add ocs,ocp8110 compatible
Date:   Sat, 12 Feb 2022 19:09:42 +0100
Message-Id: <20220212180942.8241-3-git@apitzsch.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20211117091405.7412-1-git@apitzsch.eu>
References: <20211117091405.7412-1-git@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orient-Chip's ocp8110 has the same pin configuration as the sgm3140.
The data sheet can be found at:
https://cdn.datasheetspdf.com/pdf-down/O/C/P/OCP8110-OrientChip.pdf

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/leds/flash/leds-sgm3140.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index f4f831570f11..d3a30ad94ac4 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -290,6 +290,7 @@ static int sgm3140_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sgm3140_dt_match[] = {
+	{ .compatible = "ocs,ocp8110" },
 	{ .compatible = "sgmicro,sgm3140" },
 	{ /* sentinel */ }
 };
-- 
2.35.1


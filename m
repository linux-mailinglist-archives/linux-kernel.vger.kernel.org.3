Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C045891A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiHCRoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbiHCRog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:44:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D9A558EC;
        Wed,  3 Aug 2022 10:44:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id ey23so3500080qtb.11;
        Wed, 03 Aug 2022 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=nKqR1/j9CCv0bYcQc50jHqzMbY2amMbbgZaTSlWN9A8=;
        b=GGKa5CwpF4I2r+JNIjTsKqcqGN+l9IeJnEAJ8JyxCRUpEyT1DHqvxxX38MSP1lwQHx
         O/aI2zVjC0Tbc5Ka64T5EUu7Y71PrrvAdoozF25naNV8mg4pDrMfHrasAxNzUBltkvR0
         aQ0lhOS6A1nT1vzjJagRWPjFS7y8flkP0+VwB5KqCl4mT63srjGBKkTZJO/no5pgort4
         6YeYBTJEGkRSyA4PF60sx7ADUFtNbWV24eGjTzbmL3jeEPyLuFf30eUl35XOkz5Bo5zZ
         qGxLpk6Y2iWEUa6URiGtAplBAst/uIMs+UFt4NlE76HWSOLdaksKAdpTpjZp4CGA+n9R
         Mdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nKqR1/j9CCv0bYcQc50jHqzMbY2amMbbgZaTSlWN9A8=;
        b=0C8u/hJhrq9tcS8szG8ySKtoB21c6Zcs8AF62ffe77w7KOwXQeQdq3PtvNDHGi7vTE
         1vkNtK5ElJuXq5EuHenS86rdYlP+ASCERMEVv/PMCRr28KmZsMOmS5H4v/fD+Gf0KGBm
         4/XY8z0LEDDNKTf3Gj9000VV1lc+OkOFBMu7w0GGuVBb4vmXgORmyjAgU65PBnNE5FxK
         sxlHuMnaOeZUnn2sv3qWKslQtabnSiWUUdpAFivY52Y48YkDZ9U3EGYaA6rS7VVYQ1J6
         SYzQ0/8toX8Ax3XbyS1ISrAsR40IF4s7cyzjh8kgPYPnVI0xDNTVQcPyHMMYUYmd9gQk
         o9aA==
X-Gm-Message-State: AJIora+GcHYMyTeJUMP9nn1vtNdvGZJVDVkSm/TECXz+0a1TDTXg/vji
        KPnbVJOG8lKRI1UuqptFJn8=
X-Google-Smtp-Source: AGRyM1vgBk6dLZ/gUFqfI6KsExv3IAivV/v7sW7ltWgRMRzL76j7J0UT49xM/qVxbPd7bbi9Z4+8kQ==
X-Received: by 2002:ac8:5887:0:b0:31f:389a:2dd5 with SMTP id t7-20020ac85887000000b0031f389a2dd5mr23034524qta.33.1659548673997;
        Wed, 03 Aug 2022 10:44:33 -0700 (PDT)
Received: from BETA-0968.ad.beta.team ([167.224.123.60])
        by smtp.gmail.com with ESMTPSA id t2-20020ac865c2000000b0033c9a0d5375sm2454047qto.66.2022.08.03.10.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:44:33 -0700 (PDT)
From:   Jack Champagne <jackchampagne.r@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        Jack Champagne <jackchampagne.r@gmail.com>
Subject: [PATCH] hwmon: (ads7828) Rename regmap_config variable
Date:   Wed,  3 Aug 2022 13:43:56 -0400
Message-Id: <20220803174356.474969-1-jackchampagne.r@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap_config variable for the ads7828 and the ads7830 are both
misnamed to `ads2828_regmap_config` and `ads2830_regmap_config`
respectively. These variables refer to regmap configs for the ads7828
and the ads7830 and should be named accordingly.

This patch does not introduce functional changes as the only two usages
of these regmap_config variables are within the changed file.

Signed-off-by: Jack Champagne <jackchampagne.r@gmail.com>
---
 drivers/hwmon/ads7828.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index 7246198f0901..20bdee769882 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -89,12 +89,12 @@ static struct attribute *ads7828_attrs[] = {
 
 ATTRIBUTE_GROUPS(ads7828);
 
-static const struct regmap_config ads2828_regmap_config = {
+static const struct regmap_config ads7828_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
 };
 
-static const struct regmap_config ads2830_regmap_config = {
+static const struct regmap_config ads7830_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 };
@@ -152,11 +152,11 @@ static int ads7828_probe(struct i2c_client *client)
 	if (chip == ads7828) {
 		data->lsb_resol = DIV_ROUND_CLOSEST(vref_mv * 1000, 4096);
 		data->regmap = devm_regmap_init_i2c(client,
-						    &ads2828_regmap_config);
+						    &ads7828_regmap_config);
 	} else {
 		data->lsb_resol = DIV_ROUND_CLOSEST(vref_mv * 1000, 256);
 		data->regmap = devm_regmap_init_i2c(client,
-						    &ads2830_regmap_config);
+						    &ads7830_regmap_config);
 	}
 
 	if (IS_ERR(data->regmap))
-- 
2.25.1


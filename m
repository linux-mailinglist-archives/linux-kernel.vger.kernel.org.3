Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69AE5663CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiGEHO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGEHOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:14:54 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8950721B0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:14:53 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7BD851E80D71;
        Tue,  5 Jul 2022 15:12:49 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p7-uVR2qXwZu; Tue,  5 Jul 2022 15:12:46 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 9EC481E80D19;
        Tue,  5 Jul 2022 15:12:45 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] regulator:  Fix parameter declaration and spelling mistake.
Date:   Tue,  5 Jul 2022 15:14:45 +0800
Message-Id: <20220705071445.21124-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Complete data type declaration of 'sel' in ti_abb_set_voltage_sel().
Fix spelling of 'are'nt' in comments.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/regulator/ti-abb-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index cf18452386ca..ce00db27589a 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -301,7 +301,7 @@ static int ti_abb_set_opp(struct regulator_dev *rdev, struct ti_abb *abb,
  *
  * Return: 0 on success or appropriate error value when fails
  */
-static int ti_abb_set_voltage_sel(struct regulator_dev *rdev, unsigned sel)
+static int ti_abb_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
 {
 	const struct regulator_desc *desc = rdev->desc;
 	struct ti_abb *abb = rdev_get_drvdata(rdev);
@@ -336,7 +336,7 @@ static int ti_abb_set_voltage_sel(struct regulator_dev *rdev, unsigned sel)
 
 	info = &abb->info[sel];
 	/*
-	 * When Linux kernel is starting up, we are'nt sure of the
+	 * When Linux kernel is starting up, we aren't sure of the
 	 * Bias configuration that bootloader has configured.
 	 * So, we get to know the actual setting the first time
 	 * we are asked to transition.
-- 
2.34.1


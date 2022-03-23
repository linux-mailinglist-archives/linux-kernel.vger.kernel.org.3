Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C5B4E5130
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbiCWLVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243831AbiCWLUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:20:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB8976666;
        Wed, 23 Mar 2022 04:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CB0FB81E73;
        Wed, 23 Mar 2022 11:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF7BC340F3;
        Wed, 23 Mar 2022 11:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648034348;
        bh=aXm+/EMiPGTBOXkMG0o+LiBNARi0puGc3dM/fhCENmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSG32VvnpivgYGxEvZF3+xwuHXp9ad5Nl8jbH88EIa9I8Wnu/n4hDmKe29jPh4Rqp
         t/nmmDPunOPrmWU68egA9KNNakh81Z1lwt0ljkfUSy+4yDjeeqofX14GboFC2lCzkz
         1qS6zcAM9woVc6Sz8QQyOYi6GGxH6locQksYKeInOkMHJyA2dRCkP4Y2ISxi539hdF
         6Sw7e8JsLC3O2ud8nVq3X5qQwrQnU6aY85tcYJoXlnDqvuwuw1ivAV8xsHTpjaLqbK
         5M2CNHjDVUotacsjF7bII5OtV77g4roUZclphjxopNwTyyI3qK9rJZsCdG6ZwPHkUd
         w7aOqeDn+BNNA==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 3/3] mtd: rawnand: omap_elm: Add compatible for AM64 ELM
Date:   Wed, 23 Mar 2022 13:18:51 +0200
Message-Id: <20220323111851.4699-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220323111851.4699-1-rogerq@kernel.org>
References: <20220323111851.4699-1-rogerq@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM64 SoC has the Error Locator Module. Add compatible id for it.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/omap_elm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index db105d9b560c..aa7f49c3f372 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -550,6 +550,7 @@ static SIMPLE_DEV_PM_OPS(elm_pm_ops, elm_suspend, elm_resume);
 #ifdef CONFIG_OF
 static const struct of_device_id elm_of_match[] = {
 	{ .compatible = "ti,am3352-elm" },
+	{ .compatible = "ti,am64-elm" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, elm_of_match);
-- 
2.17.1


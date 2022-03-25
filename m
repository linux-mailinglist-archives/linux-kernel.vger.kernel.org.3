Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1124E73A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbiCYMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359136AbiCYMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:38:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C69D0A89;
        Fri, 25 Mar 2022 05:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99614B8282E;
        Fri, 25 Mar 2022 12:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE87C340E9;
        Fri, 25 Mar 2022 12:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648211843;
        bh=aXm+/EMiPGTBOXkMG0o+LiBNARi0puGc3dM/fhCENmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=digXl3nsnjDGSqWj6NnS6B8sWVQiVorkAFfMwLaFKXPKcBs19SILZwcL0i0h7NyXq
         dCunTb1FW5T2O+CUmcu8k9FQV7MB3XRrBR70oZL7jh85KVGSzgoEpKpDeQdPZ10R25
         HRoMUyyVY1kHTOjllhdaQNwOuBbSxnZLzsAz7QcMN/X5zC8vXqx76Y3RZ39eWKgLUh
         Y6swYLzPaIAPRCor7Gt67B9WgOpo3X9ypIvpw3mqSZdCcDa4WIGR73OSWzBgQThFx4
         cJP8gVwYdQw6Myso0T1AJn7VFak2kTUqXM7kllG77CxMgMpRtQP5g78Hus+OdJQTY2
         pjtEwI4jbDjGA==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, robh+dt@kernel.org
Cc:     richard@nod.at, krzk@kernel.org, vigneshr@ti.com, kishon@ti.com,
        nm@ti.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 3/3] mtd: rawnand: omap_elm: Add compatible for AM64 ELM
Date:   Fri, 25 Mar 2022 14:37:07 +0200
Message-Id: <20220325123707.22020-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220325123707.22020-1-rogerq@kernel.org>
References: <20220325123707.22020-1-rogerq@kernel.org>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C791655C63F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345670AbiF1MXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbiF1MXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:23:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E44BE29;
        Tue, 28 Jun 2022 05:23:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DEDB61471;
        Tue, 28 Jun 2022 12:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02C9C341CA;
        Tue, 28 Jun 2022 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418996;
        bh=624BIf6Kfhc5tEzLjhEHS2z9HYf+RPyNRQJ7oltMkMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVyNz+LD5Bzl+G6SrVV0hsBlc31CCNV7+hQ9xo+8NhYcuUaqVIAHHZseLxwNAKzMz
         8G2+gcfGqAdvaz6BI4f60EKoSzJ1idQJRyi16zqBlR99e3/39XWBHiPdBoy1mWAHQD
         T19hdhQnQy/Fa67QiVmbSLlQ4dDhFZbUxJgjScELv1UTUAr+DA4rYLQ94IC/tod/jy
         bG+DYcrnz4kvcHw5Iy/iLh4ApjmvQE9gbOB+UTE8HtU86/rJkjiZrSttzgH8Sh4PtH
         BcbcLm94HSn3I6qKf5JQUu2qNiH2VsQegYv1hFmj9V3pD9KPKYoAMhyaRRc9WwDUDG
         ZGvF7qxteSUcw==
From:   Roger Quadros <rogerq@kernel.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     vigneshr@ti.com, t-patil@ti.com, sjakhade@cadence.com,
        s-vadapalli@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/7] dt-bindings: phy: Add PHY_TYPE_USXGMII definition
Date:   Tue, 28 Jun 2022 15:22:50 +0300
Message-Id: <20220628122255.24265-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628122255.24265-1-rogerq@kernel.org>
References: <20220628122255.24265-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add definition for USXGMII phy type.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 include/dt-bindings/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index f48c9acf251e..6b901b342348 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -22,5 +22,6 @@
 #define PHY_TYPE_QSGMII		9
 #define PHY_TYPE_DPHY		10
 #define PHY_TYPE_CPHY		11
+#define PHY_TYPE_USXGMII	12
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.17.1


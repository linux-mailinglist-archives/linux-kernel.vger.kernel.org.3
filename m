Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC114757F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242157AbhLOLif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242138AbhLOLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:38:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B07C061574;
        Wed, 15 Dec 2021 03:38:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A4116188F;
        Wed, 15 Dec 2021 11:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8165AC34608;
        Wed, 15 Dec 2021 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639568308;
        bh=HT7Szwt0szXBEuvaddUymkqpdrJZkTiYBL4rXuzl/Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btUG5Td8KIGUfhEsEryYVMXVSzwcQeFbgrWDa02hcIHxHHfqegYPd32Xh5r3WnJYB
         Xe75bsV3b6LqMU4v+GPIplQD9u255YeyoyLrsUkU0rlwOwr/d6M2NXLApj/mw2xoMs
         or621fzQKFm2OWzjOHeGPRQwOBVw3UaaJ4CnjgZ47wMufgU6eGFj7ZDZSANFoB50V7
         WTX3Jl1ZS8DCfnwasOAKEceoAjU3uL70Mw2jrWLJlqYK9zPxdk3yaaibgd0cLcyvSs
         INdVlyKFxOvILNGbPSYpPnYEIvakJD55HhnqEarrioxmsG6/ELVGwJJbmIgeZZ6H8Y
         zikqH6bNCmbhA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] clk: qcom: lpasscc-sdm845: explicitly include clk-provider.h
Date:   Wed, 15 Dec 2021 17:08:00 +0530
Message-Id: <20211215113803.620032-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215113803.620032-1-vkoul@kernel.org>
References: <20211215113803.620032-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Stephen, clk providers need to include clk-provider.h, so include in
this driver as well

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/clk/qcom/lpasscc-sdm845.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc-sdm845.c
index 56d3e9928892..7040da952728 100644
--- a/drivers/clk/qcom/lpasscc-sdm845.c
+++ b/drivers/clk/qcom/lpasscc-sdm845.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-- 
2.31.1


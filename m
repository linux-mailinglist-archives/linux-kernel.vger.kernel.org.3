Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701AB4757F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbhLOLi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:38:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38496 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbhLOLiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:38:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 643516188F;
        Wed, 15 Dec 2021 11:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4725FC3460A;
        Wed, 15 Dec 2021 11:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639568301;
        bh=OFdsE7uFROwPQhPB6fD6ZjQV0qvjWg3mCiJ6jyG+Liw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWuhzCUwUeT33EXit0QJ9SBCiSWpbdz+oRkP71c+mPwgDSkrX4K+W5PFWhQ98X1YJ
         9bDEkSKDomi7sUuYifJvwgZgZ8w7JgkWZDmkCHOXufe+Kj5BzlCbBWcSn+eZGGYP2N
         05k4V3pSiJDpDiJBRAK97lUEw2bQyBrlzus6VHDu986PVt0Lkv/53HtikMku7SxVGf
         GydNuw1L2FAnaF41sgkR5RHwI9/Wic5OehAyexFvelciPQRRuITZtMEUNY9KwM/oya
         e58lWobycT01jaIWYD0VKi4DuyeyXSbHMs5G6qErtKIpTKKJ7kFX1ccN9j5URmIfdq
         xFua9/7JQEB1Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] clk: qcom: gcc-sm6350: explicitly include clk-provider.h
Date:   Wed, 15 Dec 2021 17:07:58 +0530
Message-Id: <20211215113803.620032-4-vkoul@kernel.org>
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
 drivers/clk/qcom/gcc-sm6350.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index 3236706771b1..a4f7fba70393 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
  */
 
+#include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-- 
2.31.1


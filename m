Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B294757EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbhLOLiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:38:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35986 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhLOLiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:38:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5EC66CE1CDC;
        Wed, 15 Dec 2021 11:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D850C3460A;
        Wed, 15 Dec 2021 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639568295;
        bh=/FUTolCTMKBJeWvTUJqvqI6G0E9USr78WoyBxstMxTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOuN3y2+yw2GttkRyscxflUc/EXijvTU+mpOjZqtCriLYcbx/ih/8fkBlml+TIJd0
         xBcnDakyjdpC5B+QP23pXxC0cNNyA0WvNzYiX7V3w6KKPvmtxgYrdHICh9AV5g3/Or
         NqqAipvrD4BkmFCFpxa2muGGSMO8WNYOb0BFQpJsS3nk8joZxKg7Yxy2xeWIWcjBcw
         4FDrgYnk79qvi01wwsZ4wnOV1VsjSTfkPoG9dADD5q2vH3iZex+Mkf0qeoyS6oOq6t
         HKjlwCkgXuHit/9dmp8aHy+dPvtejBIBy6Ji7ISM3UzePWJTLSINn5Fo3zODuWzHpM
         wT7W2tt/is2mg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] clk: qcom: gcc-sm8350: explicitly include clk-provider.h
Date:   Wed, 15 Dec 2021 17:07:56 +0530
Message-Id: <20211215113803.620032-2-vkoul@kernel.org>
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
 drivers/clk/qcom/gcc-sm8350.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sm8350.c b/drivers/clk/qcom/gcc-sm8350.c
index 6d0a9e2d5104..c3731f96c8e6 100644
--- a/drivers/clk/qcom/gcc-sm8350.c
+++ b/drivers/clk/qcom/gcc-sm8350.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2020-2021, Linaro Limited
  */
 
+#include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-- 
2.31.1


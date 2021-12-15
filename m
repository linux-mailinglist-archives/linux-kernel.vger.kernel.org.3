Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5E4757F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbhLOLic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbhLOLi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:38:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BACC06173E;
        Wed, 15 Dec 2021 03:38:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B4631CE12BD;
        Wed, 15 Dec 2021 11:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BD1C34605;
        Wed, 15 Dec 2021 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639568304;
        bh=gHzjHkODcRnjZXZuLuLJ4OnSRhh8y0q11Bj/0NqSEnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F88huF+uqql6b0MKWV8jM8gdkDqmYVm+o6vszfLK9TJrKcpjX2LXHuq2ia45RHwxx
         O9mYbbRMmE4Sk8VugJIbIwxIzPgJ/ciuZmiumpk6QEzQGGcjoer1Hu9fYkoJ8tx/MX
         ePdmXKeD/DCiTVlAzgnhQWq9reXQP5vdqme8cDXGrdV0dPZ5ncRp5N343gfvG81gBv
         K51udKEQ6o8diIs5vehw4PIJ9CQK3a01iB6fhh6gIkmO7JWzrLch6Zu/4U2iZkmUeu
         wZoX21bJGkFXjm1wc8RxQNd+gIkfN8EWtjD/odLccQakhgg/+vZxlazWole7o9M+qQ
         IQk9qfxD6PoXw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] clk: qcom: lpasscc-sc7280: explicitly include clk-provider.h
Date:   Wed, 15 Dec 2021 17:07:59 +0530
Message-Id: <20211215113803.620032-5-vkoul@kernel.org>
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
 drivers/clk/qcom/lpasscc-sc7280.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index 89f1ad6631da..b39ee1c9647b 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_runtime.h>
-- 
2.31.1


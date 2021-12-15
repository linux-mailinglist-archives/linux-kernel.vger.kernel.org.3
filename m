Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB18A4757EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbhLOLiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:38:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38432 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242102AbhLOLiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:38:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49B6D618B6;
        Wed, 15 Dec 2021 11:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A974C34609;
        Wed, 15 Dec 2021 11:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639568298;
        bh=uZp+YJqV3+lVxeTssIMc1pUOSOCyOOYo29x+HCWXrbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BlsZsuqEmMkHprRsO33GKiI7eDfy0InCq6itZX0yTbLD9PQWHAvuhmmhjMwwDnlUV
         03u90q4lx48TqdF+/9H3GhG+exjW1qwHLLfEAUi0crB6It8ecMRopAn1G0HXUb3qFG
         xQ++kwahiABrE/ziJIRcneTZzYXp5jZmo3LY8du0w78PB6hFNg5IMjrvzqnkDui8h2
         TmIQ2uTN3LYO6tUa7qVXSVvRgPjSIW6O7KM/1VmlgTeWqS5pV0BZQKhyNiY9iJ7IRD
         2nV3kd+Abl/Jv+ebD+2/Eq9UM4uX+XL8PMBWjslwAzqdATpuc6cc/2S4CpSTiPASGj
         xlq2JjVNm6LQQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] clk: qcom: gcc-msm8994: explicitly include clk-provider.h
Date:   Wed, 15 Dec 2021 17:07:57 +0530
Message-Id: <20211215113803.620032-3-vkoul@kernel.org>
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
 drivers/clk/qcom/gcc-msm8994.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index 702a9bdc0559..71aa630fa4bd 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2013-2016, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/err.h>
-- 
2.31.1


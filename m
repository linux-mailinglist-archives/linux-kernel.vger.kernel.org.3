Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26C54757F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242176AbhLOLii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242118AbhLOLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:38:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F958C061574;
        Wed, 15 Dec 2021 03:38:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ECB32CE1CA6;
        Wed, 15 Dec 2021 11:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF0DC34603;
        Wed, 15 Dec 2021 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639568311;
        bh=gpcEBApURJ8WTheFGpPDW4zUorTANQNMW6waObXBcGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdUXGi8io9/QHQa+cv0gS5BDz2jfmNpY2iQjE4Qs+s5bX/g1JnjgEhc4GXGFIyX06
         XWwpyvQYgVvbLfCds53Qkx1T79J5MpPPkl2F6S+MmTR5Qh+sowBdl7ySQjunQ4ZWKO
         kj17ZTXDiDdwVAmdLeEyN3u31nOg8rP9L7je+tdJxUXcKVQBBbwV2mIUGrVfIbQgGy
         8zH3urCsE2LccZDjjDzl2HL6Th3910LF1yDIUujGgm2fK77GhMx7eagWrOmsk5Olmu
         Tv3MtmeRhOYjFZErKkUxvDcXIMzLouo09MIFummDcFyJDchiYZZ36i9v9L+sjLWZZg
         nW5yPeSXdPKkQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] clk: qcom: mmcc-apq8084: explicitly include clk-provider.h
Date:   Wed, 15 Dec 2021 17:08:01 +0530
Message-Id: <20211215113803.620032-7-vkoul@kernel.org>
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
 drivers/clk/qcom/mmcc-apq8084.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/mmcc-apq8084.c b/drivers/clk/qcom/mmcc-apq8084.c
index fbfcf0006739..e9f971359155 100644
--- a/drivers/clk/qcom/mmcc-apq8084.c
+++ b/drivers/clk/qcom/mmcc-apq8084.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
-- 
2.31.1


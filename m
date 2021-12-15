Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D504757FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbhLOLiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:38:51 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36160 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242168AbhLOLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:38:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F73DCE1CDB;
        Wed, 15 Dec 2021 11:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52E9C34603;
        Wed, 15 Dec 2021 11:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639568317;
        bh=QFzqr1T641gUeilQG0Yx+YDcgXpXPUpklimCWNpXOUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FkvWV5UemwFnt/5MAmSx1AkvF6on1SC6ciJ5T4c0MuBtKhi8oDrXjTV2SfPaRQ5+K
         /Q/NnG+5y7j4jDXZMHk3b667YLOVHJO+0ZnojdBPHpkVICJpI/HHWZx4M/6v+ogG7W
         9ptBaqCNHeh2q84C4+5nSpxDPkGgRb2If9ppj9EszMHKfioHKA72vai4ozUBkpVG5N
         Bhg46H84VTNZewlYv9TcUG7J3S7GKbFXmdLcvSj6o/HcPTDvBbA4VXonzUlTJuothu
         pyhMFQTTU/UNs51slsQeSgrmPNaRvz0UpSS/uxAK+Bkex87w6xCsGsPt1N85VuEI0/
         OmrwSndI7Qtvg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] clk: qcom: turingcc-qcs404: explicitly include clk-provider.h
Date:   Wed, 15 Dec 2021 17:08:03 +0530
Message-Id: <20211215113803.620032-9-vkoul@kernel.org>
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
 drivers/clk/qcom/turingcc-qcs404.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/turingcc-qcs404.c b/drivers/clk/qcom/turingcc-qcs404.c
index 4543bda793f4..43184459228f 100644
--- a/drivers/clk/qcom/turingcc-qcs404.c
+++ b/drivers/clk/qcom/turingcc-qcs404.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
-- 
2.31.1


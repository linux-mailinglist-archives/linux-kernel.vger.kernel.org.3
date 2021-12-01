Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17B2464856
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347512AbhLAHcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:32:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54766 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347489AbhLAHbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:31:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 189B0CE1D7A;
        Wed,  1 Dec 2021 07:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3354C53FAD;
        Wed,  1 Dec 2021 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343708;
        bh=LwGeNInHF6Y97r5bRNYu6aqtEmm6rAjEZbygOJHjtXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DY8mwrxUEULE/bu9yYHNaQfBR3MGpAK0UKvFvbs+KF6TZ5awyJkJyH1l1kWUTJSI9
         t+B59feX/Z5yxHbkbm0IQ+PPdIiaqFLj9Qhs7iYOojElbrRFNiAkbPI7m0pxx7mvkl
         vNbC+jYsDY0CXZwJRL9cPw7eoqMpKVResDTpvVOUu9x4pp7rJBcSHDGUwpPUpcftpa
         cZANCt+X1qIMQ+0J1sfVssTXK5d7iUwu0sdIPilC3mBmMhgS4BJUlMjEzbKlAgL9pL
         8eE76v8GW4uZEVKuq3BC8AXoEr3b2eFrGgaGSGIV8VrSGIwu0S7KV9vhdTGW4Lyu2+
         dOx4KdvT5etUg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 7/7] soc: qcom: socinfo: add SM8450 ID
Date:   Wed,  1 Dec 2021 12:57:45 +0530
Message-Id: <20211201072745.3969077-8-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072745.3969077-1-vkoul@kernel.org>
References: <20211201072745.3969077-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Add the ID for the Qualcomm SM8450 SoC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 9a0eb59405e8..113dc57b74c3 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -315,6 +315,7 @@ static const struct soc_id soc_id[] = {
 	{ 425, "SC7180" },
 	{ 453, "IPQ6005" },
 	{ 455, "QRB5165" },
+	{ 457, "SM8450" },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)
-- 
2.31.1


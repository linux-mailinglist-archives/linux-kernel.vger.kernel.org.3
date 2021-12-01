Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FEC464854
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347497AbhLAHb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:31:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54674 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347473AbhLAHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:31:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57D47CE1D67;
        Wed,  1 Dec 2021 07:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC16C53FD0;
        Wed,  1 Dec 2021 07:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343699;
        bh=zhxHJuzYAveagNyTB69dXGUwL7DdrowBNHe+1EIkRtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJsd9wPQDqL3Q4vn3n9gJyEVSvVC3+9gfbD5JuR7B2MTG1foOQ+I8M6D9UJKSuahm
         YheFeMA5C+aFomfRkO7EM2sFJriJjmUK3rP7NmtWFhjNnxdifUh7JVAAC3OuNXvVY+
         yHhYpts4tCTfI73GTkf+blMRV1He69H2ZZFzkTaA9ObKbco6Yn+vUnsBKWm2FTp96Z
         vooVANPujDyNo992JVZQgHu2X4xCSsRFWkTLBi6BY8KYiKk3dId0gAQDacrul5iJQ+
         PEPqJjvaHbxjGZWfbChbEIOKt8pbWJX1VFPW0dbhk/AQaGSrocoBsZvtWGjrwZcwlT
         xS/9P0tUIUJ/Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4/7] soc: qcom: smem: Update max processor count
Date:   Wed,  1 Dec 2021 12:57:42 +0530
Message-Id: <20211201072745.3969077-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072745.3969077-1-vkoul@kernel.org>
References: <20211201072745.3969077-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Update max processor count to reflect the number of co-processors on
SM8450 SoCs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c7e519bfdc8a..e2057d8f1eff 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -85,7 +85,7 @@
 #define SMEM_GLOBAL_HOST	0xfffe
 
 /* Max number of processors/hosts in a system */
-#define SMEM_HOST_COUNT		14
+#define SMEM_HOST_COUNT		15
 
 /**
   * struct smem_proc_comm - proc_comm communication struct (legacy)
-- 
2.31.1


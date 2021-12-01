Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F687464904
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347893AbhLAHnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347853AbhLAHn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:43:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D88C061574;
        Tue, 30 Nov 2021 23:40:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5767ECE1D49;
        Wed,  1 Dec 2021 07:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF780C53FD0;
        Wed,  1 Dec 2021 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638344402;
        bh=rd1g/Mg+d9q8eRsVNqe7GRL0cp3tKq24b0vxwmqSUco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F6oBf04UDEjljSy3K4IoRij8DRgqgaPN7pu8QAHzXBy9o2Jz805NI7NBGItU3Y8bs
         C7oIKxidj3F0X/dVGCcdcLA5ukRAs+r1qiANANpgBHurSzX40X9DS0bpT+AvVPt4OH
         RwjLZGYVFV9WEMcRxSh2JZ+I2rdHzVV5kMqJgMEpOxwIPwqxWZFwJbIbdfV3d7Kufb
         aCi+WbisGz5ZX+8YogLI5xx3OsECBcH4gTB8QTxoNjmmMSTm6yqCVnViKopFSO/5eg
         5iTGy6nuFBRK99d7hMcmq0tUP+1r4JLc2y1CblLNNUWsPUYOKKpAOZdNPrMo5V3XmG
         j9Rp6ZKDKiUVg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu: arm-smmu-impl: Add SM8450 qcom iommu implementation
Date:   Wed,  1 Dec 2021 13:09:43 +0530
Message-Id: <20211201073943.3969549-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201073943.3969549-1-vkoul@kernel.org>
References: <20211201073943.3969549-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM8450 qcom iommu implementation to the table of
qcom_smmu_impl_of_match table which brings in iommu support for
SM8450 SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ca736b065dd0..4aee83330629 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -415,6 +415,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8150-smmu-500" },
 	{ .compatible = "qcom,sm8250-smmu-500" },
 	{ .compatible = "qcom,sm8350-smmu-500" },
+	{ .compatible = "qcom,sm8450-smmu-500" },
 	{ }
 };
 
-- 
2.31.1


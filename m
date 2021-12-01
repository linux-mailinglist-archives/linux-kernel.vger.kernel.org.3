Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02093464900
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347856AbhLAHn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347838AbhLAHnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:43:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B8FC061746;
        Tue, 30 Nov 2021 23:40:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AFFEB81DB4;
        Wed,  1 Dec 2021 07:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDC8C53FD2;
        Wed,  1 Dec 2021 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638344398;
        bh=hR6uODSSw97kZgq/T1oJExxGLZlH/ku0xAQ6Ys0Dbf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvP6WIbUXo5u5nfVooLIjWp03lxeC1ftv1hpmNGNjYMv7CwpCEJQ4JfXP1NVTqj9H
         TqDnKGrhRT9yfOVz/AV7i2MSAryp2xKsSNjhdIMr3RHrEug47s88MyTxpFBXnB85+Z
         mrLVQofA4ucmk1ln14euWdU7OCS3mnv7G2qB2SvwsGo0ImVr8QiY8Ro8axhkFp0tai
         ygbJCODloVb19I7RTkG4LwnuQ93oSORBtTLE4GjgsmBEggWbAhK1up4kjV0AT51RA7
         FEfpZLfb37FgF26Vley4ck8aiw3h+w5riIeWSwX2Snt8HuUbrn/kZeQTvQ/a9IxTQ4
         jSuDpYKRm92IQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for SM8450 SoC
Date:   Wed,  1 Dec 2021 13:09:42 +0530
Message-Id: <20211201073943.3969549-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201073943.3969549-1-vkoul@kernel.org>
References: <20211201073943.3969549-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SoC specific compatible for SM8450 implementing
arm,mmu-500.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index f66a3effba73..8d15b281b0ac 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -42,6 +42,7 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
+              - qcom,sm8450-smmu-500
           - const: arm,mmu-500
       - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
         items:
-- 
2.31.1


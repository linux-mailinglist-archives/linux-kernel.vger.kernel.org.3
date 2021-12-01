Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5E4648FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347847AbhLAHnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347744AbhLAHnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:43:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B6AC061574;
        Tue, 30 Nov 2021 23:39:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1812B80D60;
        Wed,  1 Dec 2021 07:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8CFC53FAD;
        Wed,  1 Dec 2021 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638344394;
        bh=IH+CH+NEHGEnnHXFwnSvSAiPgO8efzQGfFtZpwJ6dD8=;
        h=From:To:Cc:Subject:Date:From;
        b=BLiR765i6O8Tk9bXLvJsNm0TjKZ1oknLs2VHJUwsTU3Wmt6xgCk+r3NfHGwirVglP
         K3KkUk2j3KweGSylloBBAty+pQokM3EhckwaRRoazRhRWnivngUOZdTJwasadUq31N
         D+PrCWMs8kpufcmJ35pIUDSmHiTkV3wp1pvuo4be67b7o/cpAUF4ddpcfCygNGiBPa
         eFHsJx/itVkM3b8WUG2TBg4FwAGYVEkfU5Z1Rbm4bW8zaOwb34NlgomCmm/pxe0rNq
         QxXkZ//R+WI5XRRGFwPUNFQxpRSddS9d0r5Kok1EVu7PM7Hay1cU4nhO2wrkgQBOkX
         AGpB+SZQzc4NQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support from SM8450 IOMMU
Date:   Wed,  1 Dec 2021 13:09:41 +0530
Message-Id: <20211201073943.3969549-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the binding and support for IOMMU found in SM8450 SoC

Vinod Koul (2):
  dt-bindings: arm-smmu: Add compatible for SM8450 SoC
  iommu: arm-smmu-impl: Add SM8450 qcom iommu implementation

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 2 insertions(+)

-- 
2.31.1


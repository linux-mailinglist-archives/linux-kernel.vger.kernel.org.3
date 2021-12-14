Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA57474646
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhLNPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:18:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45878 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbhLNPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:18:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5138B6156E;
        Tue, 14 Dec 2021 15:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E44FC34605;
        Tue, 14 Dec 2021 15:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639495120;
        bh=mEbPeXsB67W9U6l/CDNJAqk9FaFgvYpMLADkkYtKvlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=av6TKgBpidFRVzmgEir7OzPlWXZj4u6Yfzx66u2R1J43vHPxHv5dfUlQ+pw+2p7NQ
         1gb3dfZmMNGN4U/dcX92CABeMfhUuhQErd1TXmZSk2EgJvsXWWJS/RMx/MrBHXv9wC
         loT9TsoRSPhOCL8ZYDOBA5d4Jp3HobnugKl6AMcu1rLsuVV/ZwhVZSlvSqupIQMkwf
         1/R0rJ9W3x2sHrcAe1TY+n6VNaN5qE9et0Jim2s3B0loeeixng6r9S/JT8wT+Q14qA
         Z7y0Wnowj03jlX7gv60R9WFc/sC8/nMnJ74CA/phF8suXP2NCYBVAzCQfjMwPF1Gz+
         8xswokRRLyGLQ==
From:   Will Deacon <will@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support from SM8450 IOMMU
Date:   Tue, 14 Dec 2021 15:18:16 +0000
Message-Id: <163949303736.2865377.9243428032755790961.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211201073943.3969549-1-vkoul@kernel.org>
References: <20211201073943.3969549-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 13:09:41 +0530, Vinod Koul wrote:
> This adds the binding and support for IOMMU found in SM8450 SoC
> 
> Vinod Koul (2):
>   dt-bindings: arm-smmu: Add compatible for SM8450 SoC
>   iommu: arm-smmu-impl: Add SM8450 qcom iommu implementation
> 
> Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
>  2 files changed, 2 insertions(+)
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu: Add compatible for SM8450 SoC
      https://git.kernel.org/will/c/810d8cabaab5
[2/2] iommu: arm-smmu-impl: Add SM8450 qcom iommu implementation
      https://git.kernel.org/will/c/cd76990c94bb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

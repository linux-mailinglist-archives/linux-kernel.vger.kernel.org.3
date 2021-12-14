Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D55474643
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhLNPSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:18:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40998 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbhLNPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:18:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21DA9B81A27;
        Tue, 14 Dec 2021 15:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9D8C3460A;
        Tue, 14 Dec 2021 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639495117;
        bh=xA4qErAYFfQZoMVAgqmgJanxkAG/Pa06aExW8DKib+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdAF4vm+BGbwsTBNyD1SZIwyVqUjVeVO51lj2mafBgIGLDN5Gt+cqE5gxxaI+AZ0A
         JKGOfQsR73R+3MzpwP0IKcA0ztSfXU03oUS+66zUeKSU4A/BFTjaHKXxH5BvHO/xBG
         m/Rh6zc67ghxl5e+1lm+JV5HTNA11O/ed+dONdV9EnEvcKK2AC9apEUf9g9BP8/L7E
         cfBBU9Jm0quW8ILPZaaCJVh2JJt4Kaa0r9PHUpSydBMvcUmW47hN+Q2S72HKZJ/KKx
         JHQplMxt/v/U7mGqO/W6eXnC5vred/UOIfkvQHBa/CDhrsacV05TM1GdkwcaXx4fmu
         g/V5wU0WWTgEA==
From:   Will Deacon <will@kernel.org>
To:     Rob Clark <robdclark@gmail.com>, iommu@lists.linux-foundation.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        freedreno@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix TTBR0 read
Date:   Tue, 14 Dec 2021 15:18:15 +0000
Message-Id: <163949295159.2865133.14830318061014713865.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211108171724.470973-1-robdclark@gmail.com>
References: <20211108171724.470973-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2021 09:17:23 -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> It is a 64b register, lets not lose the upper bits.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Fix TTBR0 read
      https://git.kernel.org/will/c/c31112fbd407

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

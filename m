Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AEA51DD0B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381920AbiEFQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443492AbiEFQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81666A42D;
        Fri,  6 May 2022 09:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6603B612C8;
        Fri,  6 May 2022 16:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CDDC385AA;
        Fri,  6 May 2022 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651853232;
        bh=MeBbu6N7dXVwXZN6bbf3yJI1WmMW2WD3trOSa9i+xMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiaqGgX96HvQ+tSWrsEI1Cgno44W6jhf3OyuasjIe2Qdguhtlox/qf3WkLaoDH/Kv
         Bj0yCp7hteVFKQF/Tsbx8HZhxpy9dnSFt/SZ2TTqI7LXfy2TVaNCiFILSOKYOS29KD
         vdCJ+bQKTC0ZrQEgaBpXOjED5wsIyylAVKVycF79Hi37C1N8uXdLuDM2q3lFRhrCBI
         Fz3vTSDE1okJ2RLp/PlSwSdfGPgzdbJ8R1//86qyx0EwFIFJ8tVU13rSGVEeOipxLW
         nwMz+oefRJdcsI28UOhRM4UKjWVvgwU7ZyHaLQc6UA/rRqZwHNduQmugDQSP7RJvel
         YxQS4+wWmoShw==
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/arm-smmu-qcom: Add SC8280XP support
Date:   Fri,  6 May 2022 17:07:01 +0100
Message-Id: <165185088097.2781523.14572195434290854630.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220503163429.960998-1-bjorn.andersson@linaro.org>
References: <20220503163429.960998-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2022 09:34:27 -0700, Bjorn Andersson wrote:
> This adds the compatible for the Qualcomm SC8280XP platform and associate the
> Qualcomm impl in the ARM SMMU driver to it.
> 
> Bjorn Andersson (2):
>   dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP
>   iommu/arm-smmu-qcom: Add SC8280XP support
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP
      https://git.kernel.org/will/c/38db6b41b2f4
[2/2] iommu/arm-smmu-qcom: Add SC8280XP support
      https://git.kernel.org/will/c/d044023e219d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

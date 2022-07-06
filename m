Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254E0568FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiGFQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiGFQuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3C22A41D;
        Wed,  6 Jul 2022 09:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46B6961E02;
        Wed,  6 Jul 2022 16:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C588C3411C;
        Wed,  6 Jul 2022 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657126242;
        bh=0pOVIbCNmcN/nm8RoI711i6Sp2Cnnc7ILx8PHcMjOhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuBzYQOx/x119o/XKj4ad95UQ07vgkKRljfmsnYkmmrirzmMQjHuby+c86rVqRooj
         e62NitvEEgbRi/AkzT7cg7TPO5SEkCwOZhTG7qYwx9ou9gdEYHoqM7GHTxceb5Z/h0
         umIFpmDdt4evqfV+29PgG+EcUn3IfZqFDGD/sIoHZaLdcOTBCGKDbHcPwi54S2RqpB
         aXx9RrWGAtvmFF3iPDr7aaQfWbAYYGqMazIZgoSiRZEh1pgfK4M8g8OOlQ8fXf38YE
         VIXsvv+bqBqh/aL0z7bhbqJtvVoEYVcl4U3sRSY1zUXsLWJFf2MCnW9ZgAGMpF69bi
         bS877EsNGSq2Q==
From:   Will Deacon <will@kernel.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        freedreno@lists.freedesktop.org, Emma Anholt <emma@anholt.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, Joerg Roedel <joro@8bytes.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: arm-smmu-impl: Add 8250 display compatible to the client list.
Date:   Wed,  6 Jul 2022 17:50:30 +0100
Message-Id: <165710831607.931151.17780533895560931345.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220614230136.3726047-1-emma@anholt.net>
References: <20220614230136.3726047-1-emma@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 16:01:35 -0700, Emma Anholt wrote:
> Required for turning on per-process page tables for the GPU.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu: arm-smmu-impl: Add 8250 display compatible to the client list.
      https://git.kernel.org/will/c/3482c0b73073
[2/2] arm64: dts: qcom: sm8250: Enable per-process page tables.
      (no commit info)

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

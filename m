Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D662851DD0C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443553AbiEFQLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443494AbiEFQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:11:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E06D96E;
        Fri,  6 May 2022 09:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F17861A8E;
        Fri,  6 May 2022 16:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68152C385A8;
        Fri,  6 May 2022 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651853238;
        bh=hlecmGmXMdLPY0SRK5EkvKlwwip1h2w5sOHri907iUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhFiHHHND8MOJ19d6UW4iRbnGzrkDvFC2fq54yEYFWJXiOnFi4FoJIewObEJ6Nb+k
         EsWvbsctIbTeLMStgoPFGfDMHxEE07wR8BVYakDYb0uCPIGyfRpYYMhm0CFbJ0R3x7
         TT7MR+hAhChPi9MZOfVpRpae98ETxmO1wNty9BP/I2yMcUokPs2yJVGaVtDpu8pqHy
         Ro0zYW5QlFq6Q8yE97Of6cYJyIkxEdAOqtxacw9CYx3mXOW1yA8xcf4wpj48DRuKHj
         +96B4bM+L5L8s8iIx91QCC0xE2nnbcs/5ow6HUEN5UlVZ411kE7xKUS0YOsuZrIvxB
         d4nc0r9N1Kwag==
From:   Will Deacon <will@kernel.org>
To:     krzk+dt@kernel.org, robin.murphy@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        joro@8bytes.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
        robh+dt@kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        manivannan.sadhasivam@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] SDX65 devicetree updates
Date:   Fri,  6 May 2022 17:07:03 +0100
Message-Id: <165185052553.2780438.7989324600616529868.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
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

On Mon, 11 Apr 2022 15:20:08 +0530, Rohit Agarwal wrote:
> This series adds devicetree nodes for SDX65. It adds reserved memory
> nodes, SDHCI, smmu and tcsr mutex support.
> 
> Changes from v1:
>  - Addressed Mani's Comments and made necessary.
>  - Rebased on top of v5.18-rc2.
> 
> [...]

Applied SMMU binding patch to will (for-joerg/arm-smmu/updates), thanks!

[4/7] dt-bindings: arm-smmu: Add binding for SDX65 SMMU
      https://git.kernel.org/will/c/5a4eb9163471

However, I must confess that I don't understand the point in updating
the binding documentation but not the driver. Should we be matching on
the new compatible string somewhere?

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

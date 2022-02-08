Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0628D4ADE3E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383103AbiBHQWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383073AbiBHQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:22:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BC1C061578;
        Tue,  8 Feb 2022 08:22:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB40F616D9;
        Tue,  8 Feb 2022 16:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3387DC340EC;
        Tue,  8 Feb 2022 16:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337327;
        bh=sXbCfyUpCRgkdJeoXxIsdIqWpDpDr+h2fd3sTTQiBW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsZfWIC+pXBcJXMk1q3KUH8Cx12/BrNymYL16J79pzY/l8t0dHpJQL/WmXUSxeao5
         EgHCmZCmt/Yveslj2EZQb/widC6i9hc1RI50Jf2+Tj09CAJFsIZbUrwTWAOc2q9uKV
         bhug3/MFFJOS0bdREkpJTvY3aTtaP26U8NntYc4B+rK4e+qJJU/QC2RstCQx8BDqtM
         Vjj/LJ9qRWx949tzpqh0ZiDqEVPOsmkA4d3yw/xrk0MiVWah/ds56Zxgy9G2in5bri
         Os7SsQITtQ05pUQI+hIMvgDythuZ07dazEdGseH7fnYaOv7SEP5WvxwmzmeiAM8kbD
         sg6ZQPX4niNRw==
From:   Will Deacon <will@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/arm-smmu: Add missing pm_runtime_disable() in qcom_iommu_device_probe
Date:   Tue,  8 Feb 2022 16:21:53 +0000
Message-Id: <164433576813.932880.12030091721881106363.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220105101619.29108-1-linmq006@gmail.com>
References: <20220105101619.29108-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 10:16:19 +0000, Miaoqian Lin wrote:
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
> Add missing pm_runtime_disable() for error handling.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Add missing pm_runtime_disable() in qcom_iommu_device_probe
      https://git.kernel.org/will/c/93665e0275a2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

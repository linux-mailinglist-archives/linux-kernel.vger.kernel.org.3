Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B000251DAE9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442368AbiEFOr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442355AbiEFOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E5D6AA43
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3369C6216F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD70AC385B0;
        Fri,  6 May 2022 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651848221;
        bh=oKPoDCFTxVoFK+ghBAGQywJDDEj0FOeht+c7tf5Q88k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMI5JIM7bPEnW0Eqa3ZdTWs47lcCrFeFwpGdslRtrF+V8hq01x0EZjOalecFK9ngU
         uAM5BXhF6cfi/xTjiLSyiCLxqf3QJbHgG2G4R5ArCrnNn8zwqHJBeCBOOiO/WkUO30
         8QiJDkQ8Qna8PoWviD2fPlCJ0E5cc7krdtcT3UZ1d4cNnAqzhDz/uMkRFQv+H7vkc1
         NAajdK7+kITWezKq3VdNDM/x6+rvyLdTFwMZGgSjHcCqDwUwEkG6Q5l1SNOaCnQ4xB
         BZLdjrO7jBreMeQ396DIgOFLY8QBDnLia2ah8BRkYeTT7Sg4nzJxPXYEu/Uwyl0U8o
         32w9JwqBaa/7g==
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>, john.garry@huawei.com,
        mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/2] Add Support for HiSilicon CPA PMU
Date:   Fri,  6 May 2022 15:43:29 +0100
Message-Id: <165184647189.743966.16490263687674034753.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220415102352.6665-1-liuqi115@huawei.com>
References: <20220415102352.6665-1-liuqi115@huawei.com>
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

On Fri, 15 Apr 2022 18:23:50 +0800, Qi Liu wrote:
> Add Support for HiSilicon CPA PMU driver. Json file in perf tool
> is applied in
> https://lore.kernel.org/linux-arm-kernel/YhkhSZp+a715Ldzr@kernel.org/.
> 
> Change since v4:
> - Add hisi_cpa_pmu_enable_pm() for a failed probe.
> - Link: https://lore.kernel.org/linux-arm-kernel/20220407124617.54521-1-liuqi115@huawei.com/
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] drivers/perf: hisi: Associate PMUs in SICL with CPUs online
      https://git.kernel.org/will/c/807907dae970
[2/2] drivers/perf: hisi: Add Support for CPA PMU
      https://git.kernel.org/will/c/6b79738b6ed9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

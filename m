Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1586568FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiGFQuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiGFQut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:50:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B92A425
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14BE5B81E30
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252E7C341CB;
        Wed,  6 Jul 2022 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657126245;
        bh=huZALYPFKBr4Np8d7D2qyaWr0GwXSIislDPcn8eFpkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBzQlPV1dZT3PFatvoynD8ldDTQl8Zwj3jb35ihkPVgvSTGXYsDDh7SCKL0KwQPmY
         8jTUHHXrFDW6apWQjBCeMA3a5xVkpFhcr32fac4VWuVLUm8X6WkD74juqSm26iPVLZ
         MGUt9RCQD8DGJV1f7hLnHQuJNZ8LiXBbuCo1gMvA2m0U/SRJuTjwEYoeqJQ8CmPDMi
         6bv+Q+hUpqKadeTymHbyjPAUbiCaeZR7Ja6iP0YlmHCArxo9tA3jW9aRvA+0Wncgap
         wrgvORyVScpUecTMCevWM0Z6xnS45DvYqOkIFob9w/xic2n+0OKl6+/Gw/mWtYGQbh
         aoRzEkAUyhzBg==
From:   Will Deacon <will@kernel.org>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        anup@brainfault.org, Eric Lin <eric.lin@sifive.com>,
        atishp@atishpatra.org, atishp@rivosinc.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, greentime.hu@sifive.com
Subject: Re: [PATCH] drivers/perf: riscv_pmu: Add riscv pmu pm notifier
Date:   Wed,  6 Jul 2022 17:50:31 +0100
Message-Id: <165710145080.2497812.7883037173076290820.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220705091920.27432-1-eric.lin@sifive.com>
References: <20220705091920.27432-1-eric.lin@sifive.com>
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

On Tue, 5 Jul 2022 17:19:20 +0800, Eric Lin wrote:
> Currently, when the CPU is doing suspend to ram, we don't
> save pmu counter register and its content will be lost.
> 
> To ensure perf profiling is not affected by suspend to ram,
> this patch is based on arm_pmu CPU_PM notifier and implements riscv
> pmu pm notifier. In the pm notifier, we stop the counter and update
> the counter value before suspend and start the counter after resume.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: riscv_pmu: Add riscv pmu pm notifier
      https://git.kernel.org/will/c/e9a023f2b73a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

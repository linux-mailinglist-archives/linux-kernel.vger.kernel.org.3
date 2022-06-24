Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7A559F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiFXROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiFXROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:14:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459253A74
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F4F162361
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B64C3411C;
        Fri, 24 Jun 2022 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656090853;
        bh=IZw/7WOrDWiVaSQR63/OmwUqDV58+vukF+/X5PCDrEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJgBROKy6hm2ZWdc6exjZx1pHFOcCM6wWu3+NE7iAQNew9dzKidCe3Ls+GmuSUtsC
         G01EyfvM+BVKXmqM0FawNqeBrQdZcpca+GvNdtO5dGO8So7YRQzSAzBWwvqrok0iGy
         zwvf740YO5jJ9kO7MOaCnUeG6+yoSIxK8L3cotDGczoPPV8d8oj+iRMgp/GHww3miB
         WekWHLJ88nIV1SdvHYNX47J4gQfSGvgECy5D/8XQwB/jUXv9yWIQxVkcAYY1p+RF5B
         hljz8uFkN8cxgWEBxwRUo53vLKXneQB0rvdurPxVMSB5pdmY9MgSIT2OgoaLdtTTQa
         Q/8Gf/flVIJlg==
From:   Will Deacon <will@kernel.org>
To:     Tanmay Jagdale <tanmay@marvell.com>, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        lcherian@marvell.com, sgoutham@marvell.com,
        linux-arm-kernel@lists.infradead.org, bbhushan2@marvell.com
Subject: Re: [PATCH] perf/marvell_cn10k: Fix TAD PMU register offset
Date:   Fri, 24 Jun 2022 18:14:00 +0100
Message-Id: <165607329940.2894410.8350598856242937925.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220614171356.773967-1-tanmay@marvell.com>
References: <20220614171356.773967-1-tanmay@marvell.com>
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

On Tue, 14 Jun 2022 17:13:56 +0000, Tanmay Jagdale wrote:
> The existing offset of TAD_PRF and TAD_PFC registers are incorrect.
> Hence, fix with the right register offsets.
> 
> Also, drop read of TAD_PRF register in tad_pmu_event_counter_start()
> since we don't have to preserve any bit fields and always write
> an updated value.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/marvell_cn10k: Fix TAD PMU register offset
      https://git.kernel.org/will/c/f5ebeb138fa6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

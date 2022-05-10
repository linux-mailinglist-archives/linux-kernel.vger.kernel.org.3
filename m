Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD865213DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiEJLht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiEJLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:37:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BE447386
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46CDCB81CDB
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186F5C385C9;
        Tue, 10 May 2022 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652182405;
        bh=oX5MSkN7sl6vwUSAvWzzKOhMPQxhWJZgKLqUrVd7LPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qDnIPNGYDlnXHMR9ltcODL+N4zBbqPqnSGkfIibzg+UuFvB9Vjo1dBlKgsS+9JVSN
         eh1zKvsjXE7LxNOMXzXRFk3/VN3s5A4gfmntkl6pBmBtBfWb9zgs1H7g1LNkU/u8rK
         RLaf3BEjhCGPJrHUHutB3Df+nyjCCrvXZebRBqES6B5yWjzaEaSXx1/o18YWEdHJ7M
         /dDyqkfx84thIxNXa19MGgDvi9sYPKbLClAW1I2K4sMBC2YqFg48RJTVQGW0Yv7aFc
         aJJOvCCUAFgeZbUhh0EAZA+ni9ZgqW2rcMu3qC1tAV/ZbUlLm+kNC+r2HbVR77vb5v
         iBJKQSUwcaMZw==
From:   Will Deacon <will@kernel.org>
To:     Tanmay Jagdale <tanmay@marvell.com>, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        lcherian@marvell.com, sgoutham@marvell.com, bbhushan2@marvell.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf/marvell_cn10k: Fix tad_pmu_event_init() to check pmu type first
Date:   Tue, 10 May 2022 12:33:14 +0100
Message-Id: <165218126812.3521483.9650067929105831571.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220510102657.487539-1-tanmay@marvell.com>
References: <20220510102657.487539-1-tanmay@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 15:56:57 +0530, Tanmay Jagdale wrote:
> Make sure to check the pmu type first and then check event->attr.disabled.
> Doing so would avoid reading the disabled attribute of an event that is
> not handled by TAD PMU.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/marvell_cn10k: Fix tad_pmu_event_init() to check pmu type first
      https://git.kernel.org/will/c/33835e8dfb3c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

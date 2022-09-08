Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D895B25D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiIHSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiIHSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:34:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B483AE61
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AF2CB8219F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F108EC433D6;
        Thu,  8 Sep 2022 18:34:44 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>, will@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: run softirqs on the per-CPU IRQ stack
Date:   Thu,  8 Sep 2022 19:34:32 +0100
Message-Id: <166266206917.232050.13406365654648397230.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815124739.15948-1-zhengqi.arch@bytedance.com>
References: <20220815124739.15948-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 20:47:39 +0800, Qi Zheng wrote:
> Currently arm64 supports per-CPU IRQ stack, but softirqs
> are still handled in the task context.
> 
> Since any call to local_bh_enable() at any level in the task's
> call stack may trigger a softirq processing run, which could
> potentially cause a task stack overflow if the combined stack
> footprints exceed the stack's size, let's run these softirqs
> on the IRQ stack as well.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: run softirqs on the per-CPU IRQ stack
      https://git.kernel.org/arm64/c/2d2f3bb897a3

-- 
Catalin


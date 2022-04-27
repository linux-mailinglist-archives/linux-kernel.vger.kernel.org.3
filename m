Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E47F5121BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiD0Szd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiD0Sx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:53:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035303DAD08
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F71F61EC6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF93AC385A9;
        Wed, 27 Apr 2022 18:40:17 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2] arm64: add the printing of tpidr_elx in __show_regs()
Date:   Wed, 27 Apr 2022 19:40:15 +0100
Message-Id: <165108481148.3292741.14737552201298089977.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316062408.1113-1-thunder.leizhen@huawei.com>
References: <20220316062408.1113-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 14:24:08 +0800, Zhen Lei wrote:
> Commit 7158627686f0 ("arm64: percpu: implement optimised pcpu access
> using tpidr_el1") and commit 6d99b68933fb ("arm64: alternatives: use
> tpidr_el2 on VHE hosts") use tpidr_elx to cache my_cpu_offset to optimize
> pcpu access. However, when performing reverse execution based on the
> registers and the memory contents in kdump, this information is sometimes
> required if there is a pcpu access.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: add the printing of tpidr_elx in __show_regs()
      https://git.kernel.org/arm64/c/9ec393c812f2

-- 
Catalin


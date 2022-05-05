Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551AB51BA50
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243040AbiEEIaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiEEI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87022E080
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84F7361D62
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864C4C385A8;
        Thu,  5 May 2022 08:26:12 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     f.fainelli@gmail.com, vijayb@linux.microsoft.com
Subject: Re: (subset) [PATCH v3 0/3] arm64: mm: Do not defer reserve_crashkernel()
Date:   Thu,  5 May 2022 09:26:10 +0100
Message-Id: <165173915985.2796236.12294264416690580867.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
References: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
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

On Mon, 11 Apr 2022 17:24:52 +0800, Kefeng Wang wrote:
> Commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones"), this lets the kernel benifit
> due to BLOCK_MAPPINGS, we could do more if ZONE_DMA and ZONE_DMA32
> enabled.
> 
> 1) Don't defer reserve_crashkernel() if only ZONE_DMA32
> 2) Don't defer reserve_crashkernel() if ZONE_DMA with dma_force_32bit
>    kernel parameter(newly added)
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[3/3] arm64: mm: Cleanup useless parameters in zone_sizes_init()
      https://git.kernel.org/arm64/c/f41ef4c2ee99

-- 
Catalin


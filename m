Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3674D39A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiCITOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiCITOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:14:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D35F9F88
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:13:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EE59B8233E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E60AC340E8;
        Wed,  9 Mar 2022 19:13:47 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Paul Semel <semelpaul@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, andreyknvl@google.com,
        vincenzo.frascino@arm.com, linux-arm-kernel@lists.infradead.org,
        paul.semel@datadoghq.com
Subject: Re: [PATCH] arm64: kasan: fix include error in MTE functions
Date:   Wed,  9 Mar 2022 19:13:44 +0000
Message-Id: <164685321610.1881623.15201030675764693420.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <bacb5387-2992-97e4-0c48-1ed925905bee@gmail.com>
References: <bacb5387-2992-97e4-0c48-1ed925905bee@gmail.com>
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

On Tue, 8 Mar 2022 10:30:58 +0100, Paul Semel wrote:
> Fix `error: expected string literal in 'asm'`.
> This happens when compiling an ebpf object file that includes
> `net/net_namespace.h` from linux kernel headers.
> 
> Include trace:
>      include/net/net_namespace.h:10
>      include/linux/workqueue.h:9
>      include/linux/timer.h:8
>      include/linux/debugobjects.h:6
>      include/linux/spinlock.h:90
>      include/linux/workqueue.h:9
>      arch/arm64/include/asm/spinlock.h:9
>      arch/arm64/include/generated/asm/qrwlock.h:1
>      include/asm-generic/qrwlock.h:14
>      arch/arm64/include/asm/processor.h:33
>      arch/arm64/include/asm/kasan.h:9
>      arch/arm64/include/asm/mte-kasan.h:45
>      arch/arm64/include/asm/mte-def.h:14
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: kasan: fix include error in MTE functions
      https://git.kernel.org/arm64/c/b859ebedd1e7

-- 
Catalin


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4BE58CA8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiHHObz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiHHObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:31:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE2065C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 578ACB80EB9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61530C433C1;
        Mon,  8 Aug 2022 14:31:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VcD2K99q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659969095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ef7IfqRG3PSUpglontqBYdjluCQQmLxuCBr8SM/TE4A=;
        b=VcD2K99qyCFmSRRQeFFMcLJum44QPCF1zVXXjoefTdKnLxZZ+ZQdG8kl9Yyz8h+AoTgc65
        KkRPlHMt83g/ETmtlIcbSUlePKz4Hy0bg+xXu6gURwd7sHVndjaoTyHGCYVkoI51hTjqsg
        8h/U0TurjRlKeVUBMvLmrwWSoUEwQsM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83fae7db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 8 Aug 2022 14:31:34 +0000 (UTC)
Date:   Mon, 8 Aug 2022 16:31:30 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V Patches for the 5.20 Merge Window, Part 1
Message-ID: <YvEeQrzuPIKiEh8m@zx2c4.com>
References: <mhng-1cbba637-6dd2-456a-859b-9d3f8be6bab7@palmer-mbp2014>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-1cbba637-6dd2-456a-859b-9d3f8be6bab7@palmer-mbp2014>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Fri, Aug 05, 2022 at 04:36:38PM -0700, Palmer Dabbelt wrote:
> The following changes since commit 924cbb8cbe3460ea192e6243017ceb0ceb255b1b:
> 
>   riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol (2022-06-16 15:47:39 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.20-mw0

Just FYI, the WireGuard test suite over on build.wireguard.com no longer
boots for riscv32 after this merge. Investigating...

Jason

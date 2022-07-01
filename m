Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E6F56371C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiGAPmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGAPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6194090F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B37B6248A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 15:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79913C341CA;
        Fri,  1 Jul 2022 15:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656690118;
        bh=KE9L0tDbPeP+2KwHW8x6C/X6n9rpV5btZ9jddRU2woE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBKe2PDdaOeUh+PJyv9BDuO8aN6QCNZ4d3nTvbF1wOlzRkzUBhzBKj/7HKrnhdBA4
         4Sr9yO2GXT1ARgC4yJBiZGkJ92x9RHQX2/UuVlNo/Ms0OUJYcYI51pFOW0Cp/FwP1e
         URyLyESP4MaWYi5qAXU+oxUPTBmqldY2R5hIrr3ZHgr8g1nWBWdJQrgffamcSNpQ4U
         3kPev+6IY/gkJfDREd/cUK3fZepl0hDiNtG58q7+wcDEGpmaD9mZTWOXBoYyp5HOZ4
         OCC3rD6ORLlhYn/CmJsFTTbmc00JeoKRL00cggrWlGDa1VQO5/+Wj2dE4T8ecDBmaN
         C74ObxcWWxtWw==
From:   Will Deacon <will@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        patches@lists.linudx.dev, linux-arm-kernel@lists.infradead.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/2] arm64: vdso32: Small fixes for ld.lld 11 and CONFIG_DEBUG_INFO
Date:   Fri,  1 Jul 2022 16:41:31 +0100
Message-Id: <165667366428.570517.2534125343588123289.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220630153121.1317045-1-nathan@kernel.org>
References: <20220630153121.1317045-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 08:31:19 -0700, Nathan Chancellor wrote:
> This small series fixes two issues I noticed with the orphan section
> warnings in the 32-bit vDSO. See the individual commits for the boring
> details.
> 
> They are based on for-next/vdso. I compiled with LLVM 11, LLVM 15, and
> GCC 12.1.0 + binutils 2.38 with no additional warnings/errors.
> 
> [...]

Applied to arm64 (for-next/vdso), thanks!

[1/2] arm64: vdso32: Shuffle .ARM.exidx section above ELF_DETAILS
      https://git.kernel.org/arm64/c/859716b4131f
[2/2] arm64: vdso32: Add DWARF_DEBUG
      https://git.kernel.org/arm64/c/9e07352ef779

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

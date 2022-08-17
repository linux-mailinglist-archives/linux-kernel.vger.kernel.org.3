Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9B597227
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiHQO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiHQO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:58:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BB149B73;
        Wed, 17 Aug 2022 07:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB9616152A;
        Wed, 17 Aug 2022 14:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B1CC433D7;
        Wed, 17 Aug 2022 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660748319;
        bh=UukA7zr2GtXoSZlWDUfpBufnEeeEq4BCJXJ2O44v+d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bl0idNDNtDHk1jVi8tNfuPNsj1odugEpueiUTjHfcUhceIdm1DeS40z+JZFuROjqj
         yfK4jdo7eLtF1Zde+VIbNJ62dalgWjU2OhApMt3AWgO81w/iboNW8+W1PhhkFM/44q
         bIjVCW1soZ32wjwxxz/PS4h6rmsP0/o2X98cRKaOwwU4KiLZ+wFFyzfYEPtm+6HQng
         Ogn7NP6J7pTsGHbEXwzYW00zp/96iCZmt+mfdIl1D/XESXnCncV7GEmRPVEXfSp9wb
         hQSWpFkkArIEpc1VYhfszhcvSBEBi03QwmuXe9Wwvm7FN2ClVNsv3E5UnSTr9MWPB3
         CP9O8MV7riXzA==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] arm64: adjust KASLR relocation after ARCH_RANDOM removal
Date:   Wed, 17 Aug 2022 15:58:32 +0100
Message-Id: <166074437048.1238547.17932971504421721818.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220721100433.18286-1-lukas.bulwahn@gmail.com>
References: <20220721100433.18286-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 12:04:33 +0200, Lukas Bulwahn wrote:
> Commit aacd149b6238 ("arm64: head: avoid relocating the kernel twice for
> KASLR") adds the new file arch/arm64/kernel/pi/kaslr_early.c with a small
> code part guarded by '#ifdef CONFIG_ARCH_RANDOM'.
> 
> Concurrently, commit 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM")
> removes the config CONFIG_ARCH_RANDOM and turns all '#ifdef
> CONFIG_ARCH_RANDOM' code parts into unconditional code parts, which is
> generally safe to do.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: adjust KASLR relocation after ARCH_RANDOM removal
      https://git.kernel.org/arm64/c/ff5900092227

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

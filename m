Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9D44D0A78
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbiCGWE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiCGWEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:04:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1A33C489
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:03:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18D09B81730
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E685C340E9;
        Mon,  7 Mar 2022 22:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690634;
        bh=2GDqmXh6D5xWcuM28UpH1Oal1Dlcgj4gwyunv3K2D0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dx4eApCHK+TS3QNdFe9lha8/pUJxXak/zsgU4Ss3TRAUI+lnHCFQeWOwy+iHmtv3U
         gABx/GbMjedUUWqWAx7PRrcQvjtLL2CjvWcrMXPiOee1b0JYPja8M2BQjAPxb93guP
         Cdmbjb7YQM4QB+zJbhU78Vk4UpvP5QtEIdmOOpaVdgaak43eadHlnWyyoLjGJL+bIW
         4bmiRCCNB6Hl4zFOFZyoXywpqQnaMMmERvJYSys49mCDyK6sVJCxEk1sd6lewHM0di
         uZPCouAy1pBAyZzczYA8oRw05QaeaDQ814ZrW2prQaSs81jmqV6q3g61B4dBEnOyHw
         piaShXQsehZpg==
From:   Will Deacon <will@kernel.org>
To:     ebiederm@xmission.com, suzuki.poulose@arm.com,
        mark.rutland@arm.com, elver@google.com, seanjc@google.com,
        broonie@kernel.org, David Engraf <david.engraf@sysgo.com>,
        catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: signal: nofpsimd: Do not allocate fp/simd context when not available
Date:   Mon,  7 Mar 2022 22:03:29 +0000
Message-Id: <164668908127.3275060.4752923202018767533.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220225104008.820289-1-david.engraf@sysgo.com>
References: <20220225104008.820289-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 11:40:08 +0100, David Engraf wrote:
> Commit 6d502b6ba1b2 ("arm64: signal: nofpsimd: Handle fp/simd context for
> signal frames") introduced saving the fp/simd context for signal handling
> only when support is available. But setup_sigframe_layout() always
> reserves memory for fp/simd context. The additional memory is not touched
> because preserve_fpsimd_context() is not called and thus the magic is
> invalid.
> 
> [...]

Applied to arm64 (for-next/fpsimd), thanks!

[1/1] arm64: signal: nofpsimd: Do not allocate fp/simd context when not available
      https://git.kernel.org/arm64/c/0a32c88ddb9a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

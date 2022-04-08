Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91DF4F9775
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiDHOA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiDHOAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48901DFC3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3BED61C3F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24075C385A3;
        Fri,  8 Apr 2022 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649426330;
        bh=3gkMJZ+EtFdrKXRWa1JUKWp5mIZ4LEUojndKatvtfHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AbDyDN+voR2wYC4NPTVkjTGFau6U0ppNvki0bC191jIgCkg+WRnFHzMRXaplSjfYO
         cn0Xzz5670+P3YT8oX1LuTWLwsiEIbEUXS44l2JeF3dGLxaDDLpe9U8J1+Xe3MPxxq
         q24s2UOVp7GUa4ywdg70Sw5/Ja5sjuI3KTwjTVPqcvn2zoyZyYEcBrsCGElmthX1De
         ShqcpZOkcy8K7Exj+GkPejYCqd2OOjvKkSXdoDPsVtnRtc0zRVpPjtdmpxmG5mnwqM
         ucxqRHx8r8rCrzdoguXbzJhNfUIui8CI/XRlNbVVYAT4X0Wnv7a0TGXU2+oqt5aAas
         02CBysfTTm5HA==
From:   Will Deacon <will@kernel.org>
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/11] treewide: Fix a bunch of shift overflows
Date:   Fri,  8 Apr 2022 14:58:43 +0100
Message-Id: <164942387895.2176670.1737974659871193009.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220405151517.29753-1-bp@alien8.de>
References: <20220405151517.29753-1-bp@alien8.de>
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

On Tue, 5 Apr 2022 17:15:06 +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi all,
> 
> so this is the result of me trying to make allmodconfig actually build
> here.
> 
> [...]

Applied perf/imx_ddr patch only to arm64 (for-next/fixes), thanks!

[09/11] perf/imx_ddr: Fix undefined behavior due to shift overflowing the constant
        https://git.kernel.org/arm64/c/d02b4dd84e1a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

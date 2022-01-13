Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C79548DC86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiAMRD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiAMRDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:03:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10F3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:03:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88180B822CB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 17:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45935C36AE9;
        Thu, 13 Jan 2022 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642093399;
        bh=91izWOf7ssGOFobj/+vA4zeuJR3qJ9lUZOknWOSvPS8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c7isNucNXVLCFpPpvi+cFiBDWqLFiog3qyIxBztOVb4IhUkmpZeKjPyiDrE2/Hjtv
         iIw4FTC8AmktFbPFIFmzDSv/VBlNhPnh8agLwCCkkDYXRt7HFjKs+8ZzoxypRtLuWJ
         bxok/srZGAhMsltc2c5b1+whvbFYdEFcp5wmdkoaUoKxSmhS2dY9alsRNdeKVq5kkt
         twfHcKGzanIULs5nzp0yovT4wF1U+znioyXN5Qd9NN0CgUvflTmJVAjRVNwMmtohW2
         vtQd1quhARNvqBGGBbVKusMJGOM6KaWD51aC2BorjAz1jgYrZs9E8AQ0m0Xjje/YOh
         jXibRXtT3vWHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32744F6078E;
        Thu, 13 Jan 2022 17:03:19 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de>
References: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-01-13
X-PR-Tracked-Commit-Id: 67d50b5f9114ae55d45e08e1fd1d6ae152622bf3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 147cc5838c0f5c76e908b816e924ca378e0d4735
Message-Id: <164209339919.24335.7954037392130234314.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 17:03:19 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Jan 2022 11:13:19 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-01-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/147cc5838c0f5c76e908b816e924ca378e0d4735

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

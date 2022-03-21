Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25814E30AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352608AbiCUTUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352719AbiCUTUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E22B5748A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 921A360B77
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04453C36AE5;
        Mon, 21 Mar 2022 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890315;
        bh=sm0ZGgiFfstl69dUwoSH+w2HMeHctXUNtWWqtHuoRs0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cMIZxNZr4On3ohUyksXHQhMbZMcnUPhE3hHQS/3QHR/jKFD9CSHagHpMMBqerjDlK
         X3pLfhQ3jKZdPlbZJp4iC/hm8wg/OfOxZSw8J1wWGdErFTC8LA/gil/5M9ZBnSaUqi
         qRpQcUf1YSCeRXNwbtDkbBYNI7gXFqC/yzTnttq7CD7KzB+i0s5b7PR6/rzjbAveD8
         X8vQhtitAKS70t01tRxOhZ7+t2tgbJbLqpHAmZyC203g1X6Gha6QjnGivkPiNZWggj
         hb7PY3rC7yysaUsKK3Bx60vX5ei9pzNhBCpDimFV2YzTCYJSqou2HuDjYVsjWzc0bi
         yAYCBXhXCn8LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7C2AE7BB0B;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjiZxoLpBIUTEK3q@zn.tnic>
References: <YjiZxoLpBIUTEK3q@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjiZxoLpBIUTEK3q@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.18_rc1
X-PR-Tracked-Commit-Id: d4c9df20a37d128f6acb3c6286db7e694554a51b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaa54b1458ca84092e513d554dd6d234245e6bef
Message-Id: <164789031494.24158.1280017718826767704.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:34 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 16:29:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaa54b1458ca84092e513d554dd6d234245e6bef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

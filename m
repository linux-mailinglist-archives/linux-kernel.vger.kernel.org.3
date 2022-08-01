Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3780586F83
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiHAR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiHAR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3424EC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60CB960FF1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6EA2C4347C;
        Mon,  1 Aug 2022 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374826;
        bh=wbjCPPTesc8Re7V65yX94jKUHYVC6D/pbRhcqtnn038=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hufujMt6Nk3FCEbo3gZVeTLuWLgQRAaXyiE+3e/pVCxCZkchjI0qoOv1ICn/BChww
         B69C4HLlCH6RgY88mvZzOUaJi5cHg5DJMCgM+iLohjM8RTdESpv7EAUW6PuSfgRQXE
         LLvnTr/x3tTIYaH11jm792P+dhY7H+ejF62nOyjqLhIeAXGKVer6jmb4vzxwjQyJvs
         4gNHZy7wVaEitbbrJPOw6RBNvt2YPtyXng7xhK3BYpPnOLoxH1mVUQB7z/26JA04Fq
         76jOIZFUU79FmBVnA/P5xxv820g5kNqpJjO6Q46EOKW/5G7XnHStkG7PEqhBNrBZvY
         eDrfkeVu22ilg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF9D8C43140;
        Mon,  1 Aug 2022 17:27:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YueXA90ePDFY7mKf@zn.tnic>
References: <YueXA90ePDFY7mKf@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YueXA90ePDFY7mKf@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v6.0_rc1
X-PR-Tracked-Commit-Id: 9de76f41ea2188f2784f48352f9278819d249afc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94e37e84891900f56a01f49ac173bcb15e42e461
Message-Id: <165937482671.24126.2818345942496019292.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:27:06 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 11:04:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v6.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94e37e84891900f56a01f49ac173bcb15e42e461

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

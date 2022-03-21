Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2414E3187
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353102AbiCUUO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354031AbiCUUOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F09BB0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B931E6113C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20A58C340E8;
        Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647893557;
        bh=lxbU8Gt1TROdw9UOy06fMXDq4lUrqAf7zTqacOE4hFI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fViivcZRXgGlpOj00ZxeREFKtLKiJ3yy2f3/tRxLEEAkPzsTAMdQaXgWZZTLDOu9P
         FZ1ughJHQOCvucgIz3Fa8aFTq6WsPVQ/uppH+4xHTCZ5xWyIpBaCTqSgKA8w7A/qHd
         Va3tCE3bpMaTMD8vBNXMLfQu2R5BBX/YSJanDfFaVjTEcAZ33sI5+LD9B7n5StVpN1
         7L0T3ve/XVhmVnBeeHVDAYvBhYDwnVR/pnh4vzhAn1C6QkLm2X5Sdhv7ONHKqRi13Z
         lkWPnwEsCYcRHxyvON3O8jvXm+I4Nhgda4TbgoJAWPCKIUkStCM/vUGIiM6Oym376e
         Re7rwNQFaZOgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 092F8E7BB0B;
        Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
Subject: Re: [GIT pull] core/core for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164786042536.122591.4459156564791679956.tglx@xen13>
References: <164786042536.122591.4459156564791679956.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164786042536.122591.4459156564791679956.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2022-03-21
X-PR-Tracked-Commit-Id: bf9ad37dc8a30cce22ae95d6c2ca6abf8731d305
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bba90e096468a3185649e9ab75873722ae4d6f96
Message-Id: <164789355703.19380.2653039093092848506.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 20:12:37 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 12:02:22 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2022-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bba90e096468a3185649e9ab75873722ae4d6f96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

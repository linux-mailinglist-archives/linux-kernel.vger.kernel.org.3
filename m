Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D51D4EA184
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345823AbiC1Uac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbiC1Ua0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:30:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C4632EF8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14309B81204
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B21DAC340ED;
        Mon, 28 Mar 2022 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648499323;
        bh=40sj4wPY62kphG8ik06OS1DvtvUDYU5CYHXT3CdgqaU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IoBulZLWEm1DqggvSweZRsdYOBunho/5eu2WVbS0WvXgyX82vMhbBP38TN2emze8Z
         5v/CZudsFIrCITAcjaV64nOoLbwGJlqRlgwudsPOpXISt3pkoLAWpKFMeLSJaWdux7
         dDqH0HddfTrMwNJYgLLIR1dhrpERSeap5VNJ+P9TmIqgo7R25S6n1dDVBCDTqVBLJ3
         c/imPlNDS2MVrLbZ0ko0zohIDzVMU1YxB99ZWMiq6hfyJH2jGUYin+RFmso3almLzc
         78vjnDsvXpDReq+cATfatkJp2qKVod8mUKff56xPAYYFuIoDdBYFYL+RMRUy3zsWH0
         dUD51rDm4YN9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FA6BEAC081;
        Mon, 28 Mar 2022 20:28:43 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc and other driver updates for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkG6jOtPmhHehQoz@kroah.com>
References: <YkG6jOtPmhHehQoz@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkG6jOtPmhHehQoz@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc1
X-PR-Tracked-Commit-Id: 37fd83916da2e4cae03d350015c82a67b1b334c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02e2af20f4f9f2aa0c84e9a30a35c02f0fbb7daa
Message-Id: <164849932364.7875.15963446536974235356.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Mar 2022 20:28:43 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 15:39:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02e2af20f4f9f2aa0c84e9a30a35c02f0fbb7daa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

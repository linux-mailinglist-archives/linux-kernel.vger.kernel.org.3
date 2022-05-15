Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C1D52785C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 17:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbiEOPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbiEOPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:11:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1905B65EB;
        Sun, 15 May 2022 08:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC2E5B80D18;
        Sun, 15 May 2022 15:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A27BC34117;
        Sun, 15 May 2022 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652627460;
        bh=vLtALtIMRKySMYk03NaiVsQOMocsPfeYFfj22XmCJ24=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vD7vVqvgYoDOhjrlKw35s2NGuJD5cTzIjzUPEVmBctEtPYI1aUJEDktR9qvqRFalY
         E8RLQ0I67gwJ1q8RzD9ZGCofBaIHq63Eb9LysuhvmLg/6j7NgaB4cRoe2s7mE1f3Bo
         KWftYSM+FQDrzBAA/TGyWYz8oNrE6xu0iA81AbFHj5wLzBUPMrDoKXFqXQMt5Umw/R
         U0nYEqFCWgyGA+TI44DYvbGk+i7i2hfFaUltjd3kloA4Y7GLbelbw8Vf16cUsu5CLb
         5TmD5bQXD5lDwK96JpdG2OEOznQGDl+5QVdRVp6Ql+0UmCq5QOqnt421QvWWsDYgkv
         y8MnfScUoisug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8439DF03934;
        Sun, 15 May 2022 15:11:00 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YoENxyxFu4xUQD6b@kroah.com>
References: <YoENxyxFu4xUQD6b@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YoENxyxFu4xUQD6b@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc7
X-PR-Tracked-Commit-Id: 401fb66a355eb0f22096cf26864324f8e63c7d78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6811a466d27ba79e6c31c0aecc74feab0472df36
Message-Id: <165262746053.2129.3527105823905607193.pr-tracker-bot@kernel.org>
Date:   Sun, 15 May 2022 15:11:00 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 May 2022 16:27:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6811a466d27ba79e6c31c0aecc74feab0472df36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

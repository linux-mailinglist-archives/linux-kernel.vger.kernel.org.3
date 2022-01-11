Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4591A48B4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345580AbiAKSD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:03:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58190 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbiAKSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:03:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 554AA6176E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8901C36AFA;
        Tue, 11 Jan 2022 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641924217;
        bh=cLQ+NY54sTLOsSvP81nu9uFq25q3qbCJCZDY4WmEP6M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iuvzHhJyG89/yOT2vJAGQRtWutMnVEi6lrCeucxZrgN1X/R16CCuOOMAfoLzLPEHY
         1gxygIpdKCpYwUuwoJLAq+RrTxoCz+UU8dsqOWrP6EikowyliaKbQk2AuSmDlwFHva
         oZa1zwHx1gzWg8so++buTE7Ylash46vIE7OANGr4rL7tMPxoRXVhkq4pQU8nAOQPjo
         FR/QsEQ75PUoffj+wYyl8T9KuVstHXK82jqQhSiQkHPyUQYzoNFBmPAZS+hbWp15qK
         WuYzHVt6JmDYoGJzkp5oLdy8j5aiEYRz/cMkPuHLYqWmx8lf3apcd2ZGAueVOhMgRM
         BAQl69ue2Q1Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96C1CF6078E;
        Tue, 11 Jan 2022 18:03:37 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN changes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110201112.GA1013244@paulmck-ThinkPad-P17-Gen-1>
References: <20220110201112.GA1013244@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110201112.GA1013244@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2022.01.09a
X-PR-Tracked-Commit-Id: b473a3891c46393e9c4ccb4e3197d7fb259c7100
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1be5bdf8cd5a194d981e65687367b0828c839c37
Message-Id: <164192421760.4972.3061477179236406035.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 18:03:37 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kernel-team@fb.com, mingo@kernel.org,
        elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 12:11:12 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2022.01.09a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1be5bdf8cd5a194d981e65687367b0828c839c37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

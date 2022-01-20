Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D76E494D86
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiATL7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:59:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38394 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiATL7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:59:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F13D61560;
        Thu, 20 Jan 2022 11:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85374C340E0;
        Thu, 20 Jan 2022 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642679958;
        bh=pva6rMcA+bPMAVxQZKbeWQCOxA+GQGZOZB3f1WVRbqc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gZrtfPLfrqGH43JCLMh12U7ZxKZbo+EhPf4cq+bUjVF0aJpouuQj5+XfbPbgYQTEe
         DMC3seltgLcX36mzyZ2QByL5LM6/GI3J1QvWZ5b3yOYy6r+QqLBoQyTz6Wt7RIQjdg
         Bnr1MnHI/5Qe5MKWlYDrs8TnseMfpDqD7GLpTBKj1bLZyg+5Wf9n/1NFg4iX5JIsQk
         mGvRA5j7vxyp4s26NUFlRxFB7Yrh5ZgHLjYUK4sICgz3G4cgYI49IcKVYd+CWP+8cX
         7wR9yBPZQw0CpN2nevvgpy/JtSSKsBRbOJ4UPOEl9sZTANxjwE+a9M7jGx9bmeOpQj
         eNDjpm4U3tMeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 729EEF60796;
        Thu, 20 Jan 2022 11:59:18 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220119113126.1244615-1-thierry.reding@gmail.com>
References: <20220119113126.1244615-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220119113126.1244615-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.17-rc1
X-PR-Tracked-Commit-Id: 3f0565451cc0c5158513af0bc4e91aa8fb0b5e75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41652aae67c79a50d56174468de03bdb04d61d4b
Message-Id: <164267995846.31408.15917215617477529779.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jan 2022 11:59:18 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Jan 2022 12:31:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41652aae67c79a50d56174468de03bdb04d61d4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

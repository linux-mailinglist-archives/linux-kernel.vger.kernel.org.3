Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADCF47D760
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345011AbhLVTCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:02:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56764 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237672AbhLVTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:02:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A121B61C50
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 19:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12767C36AE5;
        Wed, 22 Dec 2021 19:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640199754;
        bh=c+3YcWU9gZOcVpCpOIgqSvbqYh9sSyfiIrh6ZAog+Iw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jc336peulH3vwrXVoEeIk9l+N3OyaAzm26DTX6DczA3N/tjsXkBRaLTINoGagpJom
         /mB4ZSJkFouRo2gfIcIvUDKOKuXuPVxEmLcFnZJ07RuEGj+Kcwk4JqoacenXTeU6IS
         nTEuvYEv+NEcAU9GB8KrPF3/0PzkIXJE6eZG5GVn0r38sSASMTqhjdZ1JAp1WOjaSk
         HcsB5xI+nShEIHA+ZjhVD37y8UuY1FM6PbPwr8IY1AshSCWsPyDA2u2GCshtO+5BMt
         4Z9Xy4O13NM9ZLl1Hg219a1DcNncfBAc22J5jBC1Ea741yXII6lYUUiTY95uNhbdHO
         tbGr0n/liQkPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F13681198C7E;
        Wed, 22 Dec 2021 19:02:33 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 5.16 (3)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211222141155.GV14936@minyard.net>
References: <20211222141155.GV14936@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211222141155.GV14936@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.16-3
X-PR-Tracked-Commit-Id: ffb76a86f8096a8206be03b14adda6092e18e275
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 074004058094a07f784c8162153fa44c1e05596b
Message-Id: <164019975398.26306.13698765416675113107.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Dec 2021 19:02:33 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Dec 2021 08:11:55 -0600:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.16-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/074004058094a07f784c8162153fa44c1e05596b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

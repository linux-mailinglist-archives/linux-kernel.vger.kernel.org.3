Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE804937AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353313AbiASJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353207AbiASJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:48:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274AAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:48:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC0B661544
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31023C340E9;
        Wed, 19 Jan 2022 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642585693;
        bh=VCmRgxUL/x9PZtegUfYyBMQVrjSuxSS8rI3sidGxkxk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WPz8HgO2tso+ze+3FPS1wHP3FffgLDd/mCdV8ZJPgJESUplQ4xWmDaJ3R9bs/pDaM
         5rKlDXXLyftO+z/dDjnPIPyLaDMmdLkYJghhSJyZvJJ+uwQParIgG6XaNN7KG6ZjLB
         U0nYkIxlkOxr938y8ZHcLf0EgorpKGZKJSJUHcpsyD2NY0kkxEzWSunEwS5gANnWSw
         EzFGF+XmmI8mqzyb6myU8u4Dg6pH413e8Fd3bWdSmWZ6s3VPEsq8Eenk0qcBtQ7bdW
         Xq3mUp8DY0Sz5zj0bRQqQcmRfrwfiBfVDRWV855FAF6yhgQtes9mn/Y8ZP25/85T0y
         HPobp+U7oVQYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D182F60797;
        Wed, 19 Jan 2022 09:48:13 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/scripts: Fix some initialization problems
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220118181709.5489df67@gandalf.local.home>
References: <20220118181709.5489df67@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220118181709.5489df67@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-2
X-PR-Tracked-Commit-Id: 35140d399db2b67153fc53b51a97ddb8ba3b5956
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9f5cbc0c851c1cf98e4ecc5d72b5563d3fc5605
Message-Id: <164258569311.19279.9586578163320191289.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Jan 2022 09:48:13 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinan Liu <yinan@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jan 2022 18:17:09 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9f5cbc0c851c1cf98e4ecc5d72b5563d3fc5605

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

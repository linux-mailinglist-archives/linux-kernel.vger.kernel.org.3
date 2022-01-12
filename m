Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74C48BBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347424AbiALAOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347331AbiALANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:13:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CACC061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 16:13:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93BD76160D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0772EC36AE3;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946426;
        bh=Bq2TmVs2UanNEwvE/IfwzcabC4e5a2+QB6bfW1CdxKE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f0EdVbpneiudMm7x8HSYhpXSOX2NxUzQguiqQ3URjF6mTQEcV7rB3qpH6T5bGCaeT
         vrMYURgg8QWhzne1chrk5WKoBOHCSMkJtAyzYK2INRcwzYnRxgyMeMsuJLYFfp959D
         2zumCc3W71bILirj6ilR4zTGgkWI1dkWUx6WlCrMfd7zhZWX2pYP1DXC5cvMeQ108P
         2XjIDnqRhMLT1VvRrDTonZdgOeRaRz63L0NAZCd9zom0PQ8fOdMjc43OQMFtH7qITb
         8wQSl7JSJgujf7j+H1O6wRQdCaq3qxfhEuf+MIArvAX1PBxpHdvr6A/J39cGIX0rBK
         kqnTnP5lFt0Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB68EF60793;
        Wed, 12 Jan 2022 00:13:45 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110212145.GA19682@redhat.com>
References: <20220110212145.GA19682@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110212145.GA19682@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.17
X-PR-Tracked-Commit-Id: feae43f8aa88309224b27bbe3a59fcb9aefab6f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f67eaed57dae339603441cf0c0a74ec77a9fc03
Message-Id: <164194642596.21161.1746406907153125310.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:45 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 15:21:45 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f67eaed57dae339603441cf0c0a74ec77a9fc03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91113496B7B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiAVJkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:40:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52088 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiAVJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:40:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28A39B81B8E;
        Sat, 22 Jan 2022 09:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B631AC340E8;
        Sat, 22 Jan 2022 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642844405;
        bh=dsiJR+kP2XD9Ms4tTGM2cH6Z9ukEFKq6SuWK2HULMUo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JNZcWoOiQoO83jZQ0kkppQyqPKWY0u5lKjVmvuDYqIfM6D/Fx6raTW+RbledMB7/V
         oKq6CoEga8hUCW7VYEfJq2klxNPJrnhMT70xelmzY/sBwTTU70TSRS6AMNBd2grZvy
         txe4ETSoOeDI8qxHC4HHp9aGRQPNeRAUU8gFFszSUJ8nQ3hVEKjPshntP6pcKb/Hxk
         DYTSmkWTkI201hPXpqHUxnXLfm538TrLJNjZQ/eZ/qnFAb5wBBtbHJ/DhKaQdGgv6D
         QZRZBjVj4Zgm4r/PvWVR3KRAQLlxAVJG5526I4UngNCuCtWa3BAdeOAwOQUtGUpXqM
         olSecUyn0uusg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F67FF60796;
        Sat, 22 Jan 2022 09:40:05 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hTjqYHH3WeN-jzrgsR8m7=LAvsq9Y7eQRWz3pz0=5bgQ@mail.gmail.com>
References: <CAJZ5v0hTjqYHH3WeN-jzrgsR8m7=LAvsq9Y7eQRWz3pz0=5bgQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hTjqYHH3WeN-jzrgsR8m7=LAvsq9Y7eQRWz3pz0=5bgQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.17-rc1-2
X-PR-Tracked-Commit-Id: e5b54867f47f765fcb439e09ed763b5de617af3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bdfb259d6d66161011d1d618af190f52b6d57fd
Message-Id: <164284440564.7666.4445430942052934098.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 09:40:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 20:28:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.17-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bdfb259d6d66161011d1d618af190f52b6d57fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

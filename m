Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFD4480CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 21:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhL1ULF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 15:11:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58604 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbhL1ULD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 15:11:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDA01B811E3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 20:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C6DDC36AE9;
        Tue, 28 Dec 2021 20:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640722261;
        bh=JXgeIy3mX63xYFRf4kHcWH/X+PAYWMUTfmsA37T0lOg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gdb0eK+zmhOQgjGielnXecacVyCeiHsQxuIJlcsech+w91iih5MRzUTPGmBG1/n+r
         0ddwuUfJqC3AEf1R3LatFaJTy+IRNvjZPeDKw/vnYZ3OPABGMNK3UxzV0IbUPpLC9+
         mavqUJgg2wKqaxzkw2eyhzp7LVH5AAkkY3thARZ9gXEUYReVFaLNJGGJGE/uN7a2oL
         BY0wsHvisbysFVJP2LfJ69EvbglHLm7lf6N6eoKORFD0uR8e0zdKxWJIkG1ue97vhp
         O/EHeledpC2Cwte9BlwTOZOyQJSBZnedzoubhJLMIydQ6Gi2rcybWywTsaC+ZTm7d7
         eSe5AhIFCJG9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 899C1C004F1;
        Tue, 28 Dec 2021 20:11:01 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211228154449.GA14032@kernel.org>
References: <20211228154449.GA14032@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211228154449.GA14032@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.16
X-PR-Tracked-Commit-Id: 4daa9ff89ef27be43c15995412d6aee393a78200
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecf71de775a049cbfa6298deceb8ba2083331171
Message-Id: <164072226155.9016.6047871609342693730.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Dec 2021 20:11:01 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luiz Sampaio <sampaio.ime@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Dec 2021 16:45:16 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecf71de775a049cbfa6298deceb8ba2083331171

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

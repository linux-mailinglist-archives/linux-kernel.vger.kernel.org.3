Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4425048B4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbiAKSEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:04:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58178 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345345AbiAKSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:03:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7FF760EB0;
        Tue, 11 Jan 2022 18:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59DA6C36AF8;
        Tue, 11 Jan 2022 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641924217;
        bh=27Pj7NJmA0sfSl7pbF9zuIvyV34N2muz8AqMDzVP9GM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VDGe9+VCfQeK2K4SAYC1S3mLGL/p3SpXTf7dTuyPGeOPoKHIk7YUp73KKAAhzyG2B
         Mxz0oZZwV6r0YAogz3SVlG6657H6zbrH+Z009TmC0E4FbMAaWEhDHkIBEHL+4RJGXk
         MsHiH6nm8eFqnYd9K5/r4gNREW4V2AYvV4KBgeX5V8xPKmdQQACjHaF+phzrS46hoN
         RV1ioxahwdLVeDcXK1eN4P4/PrG0FCLz2ixN7PmEtvoPUrcy8L5igaRlLPMSf5Znxl
         fQSI31CNMplA0A28qCJsFMLBBk9TJEFyVRRl8MTVYfVG8UrFnpMHI4XC+q+656oWSv
         7AYpTRJshhn0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41D93F60794;
        Tue, 11 Jan 2022 18:03:37 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v8yrjtqe.fsf@meer.lwn.net>
References: <87v8yrjtqe.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v8yrjtqe.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.17
X-PR-Tracked-Commit-Id: 87d6576ddf8ac25f36597bc93ca17f6628289c16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f38be8f2ccd9babf04b9b23539108542a59fcb8
Message-Id: <164192421726.4972.11947953348934997002.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 18:03:37 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 12:06:33 -0700:

> git://git.lwn.net/linux.git tags/docs-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f38be8f2ccd9babf04b9b23539108542a59fcb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

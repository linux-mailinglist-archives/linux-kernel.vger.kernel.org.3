Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442B348CFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiAMApx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:45:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57244 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiAMApf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:45:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ED8A61BC5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD364C36AE5;
        Thu, 13 Jan 2022 00:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642034734;
        bh=SmgSpvBkQ4XJxlNRNZcovl9yyqP1RYhSmb7FV7TGeyw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B5jBTLhzL7PiFt0Mtm0U1hWFdxTDtZf2OFMXk5Tnfb0fczOyS7pe9hj1+JNmuwXgS
         fX9eQg7d1ERLB8Hg87BohSUtIB428mTMd0hqt3ZTbVXVuXIXwkdBX1kiA9eOUYk+Hf
         yxlRE07bsV2kzEUjwVDIL4WPEHeDOISJXFvhMrydX4HXBnrPj9d6g29PYkFbEXINrE
         mU/m94WVzmQqbDvYpBiZn9yRCUMGwBT5wIctelRKkcNtQiaZGcGnpn89/fhTi8+GBD
         0cQOXzLsPQHLIN4mTBpUEUwo8M8QfDE7imHNYYSsuL/7xryPnp9awhBPT64bUOl0UG
         3lOsP4M9g5Lfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8E73F6078C;
        Thu, 13 Jan 2022 00:45:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd8o/hxM/OH3mdQR@zn.tnic>
References: <Yd8o/hxM/OH3mdQR@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd8o/hxM/OH3mdQR@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 9cdbeec4096804083944d05da96bbaf59a1eb4f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64ad9461521b1a357846ef6cedc4bccd48a046e0
Message-Id: <164203473474.19726.7057709979850867542.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 00:45:34 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 20:16:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64ad9461521b1a357846ef6cedc4bccd48a046e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

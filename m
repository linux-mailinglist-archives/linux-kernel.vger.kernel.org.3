Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D748CFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiAMAps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:45:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36362 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiAMApc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:45:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3FD6B82013
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86A52C36AE5;
        Thu, 13 Jan 2022 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642034730;
        bh=wimvmhiPAXfDQnz1xnR6somYrEezfKXJbRcatQqc8/U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ojjQg8KQY1XYqtpgZiW9sKg8DNmt0Z1BKlv6NEt4SACejl37v9Ou3nd0lqhnU+bx9
         pvi/abtbceqVKUAiLjLNgeUhfgyWSUyP5zqfLoa+bOZJUhUBu8aJ1SucC9S7IJeehm
         Y+6MJXqLYvNhqFV9TpIEV1suhf9GFD+bKfIqsaa7+oebPAN2IC1e6ORb5q3QZr/Y+9
         j1QyACeU3PZx7tprxYkM0ZF7uK5tXP4kX+rOca7BQTplOPLb2do1NrFa6DF7X1V5wv
         BJcEO75tvznU8pIdwsgB/DWdtpPZjK5yYYa8iRNDUs2LRXYa3G2TU/GuHJkRenR0dk
         MmjTxHQ/Iiskw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 766D2F6078C;
        Thu, 13 Jan 2022 00:45:30 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd8Jn2aUqblPfRvF@8bytes.org>
References: <Yd8Jn2aUqblPfRvF@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <Yd8Jn2aUqblPfRvF@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-updates-v5.17
X-PR-Tracked-Commit-Id: 66dc1b791c5839d64d261c8b40250a33e6da050b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13eaa5bda0df8f5c1c4f2a4fb4a0bc20787dcc68
Message-Id: <164203473047.19726.14219021764370905266.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 00:45:30 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 18:02:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-updates-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13eaa5bda0df8f5c1c4f2a4fb4a0bc20787dcc68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

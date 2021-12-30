Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD369481EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbhL3RzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:55:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52920 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbhL3RzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:55:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52A756173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 17:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD0B5C36AE7;
        Thu, 30 Dec 2021 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886913;
        bh=qKGb7AtHm/pT6s9jBUXilZ9d3ebOr3wsD+lxPrkvCgk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M520au07qlFkf8rhpb1NokDE7B/rdk8mu42Ozf2VI63fDUffclFj8XPneqB3NdPje
         ecdJDb4Wk86y6eDPYBkAYe9vIaTJXTJAQQ8T6ymQ6IrQM9Rab9aC6PMITuccLWJiIP
         lsyLhMT1ibGGlLer7R1xXAzRaNTiBxLHgemgZmwEOWrA3adR5URfJwDQIMj8xZDzwy
         F6LssrtNoXb2igfNh66b3IbWd6d4eyIq5+k+2RfiowBRtpK94Gy0qTLjVTrrUppIER
         Mk/qPqXg6rvEAHA7R0HrbtWxSxm+xWrsqhQIbh3mPVUUyLnCg7fomfMfg9EDxUSYL7
         HVDFKS3HgQf2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACE6BC395DE;
        Thu, 30 Dec 2021 17:55:13 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.16-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yc3j2TMxxSCeuRWw@kroah.com>
References: <Yc3j2TMxxSCeuRWw@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yc3j2TMxxSCeuRWw@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16
X-PR-Tracked-Commit-Id: 3a0152b219523227c2a62a0a122cf99608287176
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bad743e8d221c1be8fa80f0e76102234e472ac3
Message-Id: <164088691370.28006.255323849633648572.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Dec 2021 17:55:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Dec 2021 17:52:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bad743e8d221c1be8fa80f0e76102234e472ac3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

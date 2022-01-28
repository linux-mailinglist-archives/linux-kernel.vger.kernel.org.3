Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728E449FFA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbiA1RgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:36:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43934 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344064AbiA1Rfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:35:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 003B361904;
        Fri, 28 Jan 2022 17:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C818C340EA;
        Fri, 28 Jan 2022 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643391354;
        bh=2olI4zpUvSRBoJmHZLvC3bs1VAqhS5NlookV+B8UbUc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oR47bgqH4pz2WxWVgWN1ol3P7GeZQ+3wfSOOGYrEIPYw62GMfLdS5/bbsIHEKl+8z
         JGq0MVCIn15ezqndT0zKzSqn/A1RmPVYKwfDUvhwoTNJI5wcr7MdN0unzpEpu5976X
         UHQYW2d6+5LrnQSYgoHv62H1pkT8a5LC5QNBm0IumZ2ZQ3GxEycolXhnrDog/GbaSI
         mE3gW5cD8suieRZP+09oONUxL/uLOcpmNa0AUi6XKO58gf+eaAwRKHSQQbwP4oMV92
         LXW9mYABC0fu1R+XVa1quavGe8wZfopxM0WbFTZrrQEV4RWmuLyWEqi+Z8KWFRRXPV
         jl40salOZMoBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BD60F60799;
        Fri, 28 Jan 2022 17:35:54 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01643370673-ext-6058@work.hours>
References: <your-ad-here.call-01643370673-ext-6058@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01643370673-ext-6058@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-3
X-PR-Tracked-Commit-Id: 663d34c8df98740f1e90241e78e456d00b3c6cad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7eb36254898131ef2feed7629ae93bc6a2c56d18
Message-Id: <164339135437.16649.7920817978579498737.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 17:35:54 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 12:51:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7eb36254898131ef2feed7629ae93bc6a2c56d18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

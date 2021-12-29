Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423F5481607
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 19:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhL2SRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 13:17:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44254 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhL2SRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 13:17:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A52E6154A;
        Wed, 29 Dec 2021 18:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE042C36AE7;
        Wed, 29 Dec 2021 18:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640801822;
        bh=Iq/8wAw2A+9RjyxxKXOC4ZrymhDtYJDG6qNqqpHW9nU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KWJ0SdAfDCRzf6ZBh0PDL45kXomUXzp6prLyudt5IfuE9slaSOObhFGv1XdCfg8PX
         nwECYQ+t22mq0j5Ns4zQJWGnvmSxkE99fpBDZ0Z1wG8xddRyPb/G9EJGqzuaURQ+nf
         yWAGHjWxxchKfElqilZCdTaqmcXO/q/hdc0oLL9Gn4mrq8vU326Zyd2zfq/JNIZNEI
         Rbi2p2tb/NFnkYNQSlk453XN1dnb87DdkRUTluoCdH/ICQnH8WTRqXQHvnBaO8HMqO
         VDtxxLJHEYSKJainu5jCRpoc0xqYKe1EHIqxsRINTwPNlbrHeJSip+uacJecalLTpL
         hjfGr1SYI/VvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 988A2C32795;
        Wed, 29 Dec 2021 18:17:02 +0000 (UTC)
Subject: Re: [GIT PULL] s390 update for 5.16-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ycwww97WDmQW9Oqa@osiris>
References: <Ycwww97WDmQW9Oqa@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ycwww97WDmQW9Oqa@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-6
X-PR-Tracked-Commit-Id: 4eb1782eaa9fa1c224ad1fa0d13a9f09c3ab2d80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eec4df26e24e978e49ccf9bcf49ca0f2ccdaeffe
Message-Id: <164080182261.1560.3598658760089634279.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Dec 2021 18:17:02 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Dec 2021 10:56:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eec4df26e24e978e49ccf9bcf49ca0f2ccdaeffe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

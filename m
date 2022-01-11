Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC42348B900
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiAKUyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244656AbiAKUxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E5EC03400C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:53:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89B9361745
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE0F4C36AF3;
        Tue, 11 Jan 2022 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934391;
        bh=zcsscNcGs8kkyjQ797sJRDOx16HPcm/OTt/BMbA1k+g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KOluI5oItObh/OuoJK82ATgJARbssSI4XU+KNAndCBroNTAKB7OIBBD6IqkwxyLra
         x9MpmBIMgsKQUBrE4o9CTR1Jw4XNUgAvDdEZixXj03f57y1CdzzZadZM/DI0oemmD/
         kf7gjQlJCYjEIhB3gCFrtAp4aAlI82glTzsqZJRFb9Lyp/iJstKr3558ck5xnvNI1l
         wZ1DPRfeu2yVfj/GTUjOx9Ak76YDrl/3/FfDB0dCy30zDRSOIhN5oQaI5zdro391Vx
         w/br0zZ9p5KuJaeG2mFlyXoovX9velg1rrvFDFoB9DfOis5bPk/6+QbHp7jqiQXbwI
         emEhLgml23naA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9E6DF60793;
        Tue, 11 Jan 2022 20:53:10 +0000 (UTC)
Subject: Re: [GIT PULL] pcmcia updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd1/w23Z8J6O6Y7v@owl.dominikbrodowski.net>
References: <Yd1/w23Z8J6O6Y7v@owl.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd1/w23Z8J6O6Y7v@owl.dominikbrodowski.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next
X-PR-Tracked-Commit-Id: fbb3485f1f931102d8ba606f1c28123f5b48afa3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aa1b8257fba5931511a7e152bcbbb3dd673c6c1
Message-Id: <164193439088.11435.1577234259207260965.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:10 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 14:01:55 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aa1b8257fba5931511a7e152bcbbb3dd673c6c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

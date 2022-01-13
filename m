Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB4848CFFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiAMBKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiAMBKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:10:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9FC06118A;
        Wed, 12 Jan 2022 17:10:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EF2D61BFD;
        Thu, 13 Jan 2022 01:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 009BEC36AEC;
        Thu, 13 Jan 2022 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642036206;
        bh=Oi3L6T0Z7c7/LTjIOuBTTR76Edq6/I/nmHwS9okQd2g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uku839bOif2qO5qRuxvSjp5bCDhKeAgAZhd/LTZyh5mj0StgWT+Xltvz9FGuX2tHD
         tjDpBvsfBhWlgOrBmeu2NQE2bCOl1z2WWzwClH6PCoDiFWJMW7zbN0u+YIA7D3W4xF
         GqMpS1p31DuMtRHBTvYDkXJHDfd36ZHXnCvIqDysLg8e7DZO/Rm+7VR0j0WzwDZSuP
         hYISKdMyHmibsqRuVP1v8P8K3MPue8JgR2pUzA0w5hryYlNEfXhjdENI463vO52a3H
         T63lyhVSy2uMIhTjs2nkVK16VzQzLaZB0qMvseSceLXC4pWy8Buk5Q7jc9CmoPqvBh
         IbRnhMQ/8h+Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E000DF60794;
        Thu, 13 Jan 2022 01:10:05 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs changes for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220112184611.GA2187@duo.ucw.cz>
References: <20220112184611.GA2187@duo.ucw.cz>
X-PR-Tracked-List-Id: <linux-leds.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220112184611.GA2187@duo.ucw.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-5.17-rc1
X-PR-Tracked-Commit-Id: 9e87a8da747bf72365abb79e6f64fcca955b4f56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9b5941bb5933932051e315de18a43db7d3c9e13
Message-Id: <164203620587.494.17294799514865274194.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 01:10:05 +0000
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 19:46:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9b5941bb5933932051e315de18a43db7d3c9e13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

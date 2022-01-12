Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C3348CC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357513AbiALTld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:41:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33996 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357383AbiALTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:40:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6ADEB820E0;
        Wed, 12 Jan 2022 19:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DB0EC36AEF;
        Wed, 12 Jan 2022 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642016406;
        bh=wSBLToXmBu1q0nRiptB0lPv7GNJ6wue0y7kQ2DaH7JI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tNys5s5KENOCrczkCYEUb4uX2F0mMkybUpL/+SfLG2D/M+t1hbFKi4j50j7x5a9CU
         Ef8uckMlEQY1z1jzk3vX9sAL4AzOdQE5TNZl9bKksEPcmnK4ZWg3TJtJFp7t1oiCmo
         Uzc+9PWH2FZ0Ojw0jJvv+AqDFRjPIlx8OzOAbD9TOSeziHDQfIRFw7EPuPXgKh9LF6
         6ZEI1agWzQBSoRe7mD67v9PXbsaT/FByqdmaiyZFj2jdLuvZSrIrPvcUb/LdDjiNae
         h/zdnRjLei8hgz2Q3WhVe9j/iHc/TSYHdqK3AaQt2afRV2eeIDNU0B52pH/ObK1hxP
         y/1+zW1zNUNBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C202F60796;
        Wed, 12 Jan 2022 19:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] SPDX update for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd7etLWYHrtjFRdq@kroah.com>
References: <Yd7etLWYHrtjFRdq@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd7etLWYHrtjFRdq@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.17-rc1
X-PR-Tracked-Commit-Id: bc128349588d571b55bfec471a773e29cfcd2d73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81ff0be4b9e3bcfee022d71cf89d72f7e2ed41ba
Message-Id: <164201640656.24328.9407358004484514665.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:40:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 14:59:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81ff0be4b9e3bcfee022d71cf89d72f7e2ed41ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

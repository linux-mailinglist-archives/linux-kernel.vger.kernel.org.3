Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38F48CC28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357480AbiALTlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:41:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33990 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357381AbiALTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:40:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DA89B820DE;
        Wed, 12 Jan 2022 19:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B33CC36AE9;
        Wed, 12 Jan 2022 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642016406;
        bh=cZHp4t4jfOk5RLn3HA3euMv+VEJ90LZ/G+6ow4Uyzc0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ecgO1aQosprlXLNgCH2xuVfgeGom/oy4Zom4wlsowvVHYJ8w1RJEIoOV3bO5dYVXK
         5jHbhvNUQowU/X/shK2vuYbqt/K/Ru17vxr8Um+ZPjv4MvW/tvB/qDP3cS1hSZaiVB
         yEB8fJzrWLWUQDSt3K8dZl1iVzeWucT9H46DFJXp2TrieOfNch6cgNBaB5vucLurD9
         UFz7SNy3VpaZqxMjss6UR3cKK+rMC1TFRrMySIWXFSAMJef+qz97Sz8YmdiAZl5gfB
         5V7KKiPaMXoDpvmF/GrV8FnOnZ1E2QCh4WPCWykyV5MzZ50Zi1S3+LZGz/r8pWGHeo
         FN3zDzKa9Cn/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5971AF60796;
        Wed, 12 Jan 2022 19:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] USB changes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd7eHm8EDkYETMw8@kroah.com>
References: <Yd7eHm8EDkYETMw8@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd7eHm8EDkYETMw8@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc1
X-PR-Tracked-Commit-Id: cbb4f5f435995a56ef770e35bfafb4bcff8f0ada
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57ea81971b7296b42fc77424af44c5915d3d4ae2
Message-Id: <164201640636.24328.4553918353897796750.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:40:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 14:56:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57ea81971b7296b42fc77424af44c5915d3d4ae2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

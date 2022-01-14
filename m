Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B40B48EBCD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbiANOjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:39:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35980 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241884AbiANOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:39:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93DF3B8242E;
        Fri, 14 Jan 2022 14:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E2C5C36AE5;
        Fri, 14 Jan 2022 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642171159;
        bh=Ilz8hwWyxpVkIT37w2Dn9+zvbRhwuNB5NglxBqWAed0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uNgtCrAQRiq0KkuV7n9SmOvpyXNDsMdPoTsqi/kBpmWy6WvSBcQVrH22DnlymEWXW
         Sz6QCR1VRnD8esW9k2zX/pmZO4lNShfIHyUW5j08QgQjZ0AywXDPkuIZdGLB3m5KWE
         NVXrCkAu8UNVOsqyx/V124m4HDStg74eeZ62eo+wR7J6rkGLSds4nkoGxoWRImv4ij
         mpurdM91qjwNqzw4Kgm2GxshF0PqgI2W9DGaPc8nbiYvuQFDHtZS9Dm1OnDnwE4LEx
         PIwbOyAoU3MO+wGWGcD02WV+hTXrXF+df0MuB2V7aiojw3Dj6PE/oWT6VCiT4NnXg/
         oPPUbad/wlvAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5897BF60797;
        Fri, 14 Jan 2022 14:39:19 +0000 (UTC)
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.15+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <31f8716fbb4f1e2a332b2b3e3243a170e8b01145.camel@HansenPartnership.com>
References: <31f8716fbb4f1e2a332b2b3e3243a170e8b01145.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <31f8716fbb4f1e2a332b2b3e3243a170e8b01145.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: c77b1f8a8faeeba43c694d9d09d0b25a4f52cf37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1a7aa25ff45636a6c1930bf2430c8b802e93d9c
Message-Id: <164217115935.3976.6135264390120710165.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jan 2022 14:39:19 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Jan 2022 15:22:42 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1a7aa25ff45636a6c1930bf2430c8b802e93d9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

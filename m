Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC46248283D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 19:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiAASlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 13:41:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52376 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiAASlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 13:41:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54CE060B6F;
        Sat,  1 Jan 2022 18:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6458C36AEC;
        Sat,  1 Jan 2022 18:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641062479;
        bh=7a7oAGXWOWMWI6Gns9V7h0YPUM+AboUDHuLqBQp1L64=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ufQYKEcXEvz23PEajeVCGcT/eqqZdIAWx+fMIjnGUkdtS7c9GoQspTd/jXkYAShRz
         2guWUsM3HwMbVuti/PWDRmDicW40qWwlc4hcOhvujfIac0sjTMvFM1YxEFpAP9EyCZ
         OeoeXXsias2vX4jzg+eQrLAJghigKR2gWA6wlnb2C6EMEetbqezCmNvmX97Z1MDPSG
         bpVRCblkyULDGgBHXgnigPuwf43t2teGq+CbSwUAT0YLzveQcVbLKHajTAbe72kdvb
         ZSILGafM7xnRnzAeut0RJCKegr4ZSJDuKlDba29lrTglnBSCqGRxxl7twyA/SlBqnK
         n5EH+Ox8IIT6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A29DEC395E3;
        Sat,  1 Jan 2022 18:41:19 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yc/aYq9oWoj3byBe@google.com>
References: <Yc/aYq9oWoj3byBe@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yc/aYq9oWoj3byBe@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: bc7ec91718c49d938849697cfad98fcd9877cc26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 278218f6778bc7d6f8b67199446c56cec7ebb841
Message-Id: <164106247965.24142.5313419530910729338.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jan 2022 18:41:19 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Dec 2021 20:36:50 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/278218f6778bc7d6f8b67199446c56cec7ebb841

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

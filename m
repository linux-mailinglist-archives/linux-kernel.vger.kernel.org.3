Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227414A2FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 14:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352090AbiA2NzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 08:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351570AbiA2Nyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 08:54:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3CEC06173B;
        Sat, 29 Jan 2022 05:54:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C0E0B827C1;
        Sat, 29 Jan 2022 13:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AA22C340E5;
        Sat, 29 Jan 2022 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643464489;
        bh=l0FKbyS2vDBhv2WhOxpuZbA0euPAPfgYAbxZT/IRKsE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QI4Gx89JNmfz20QGXheuH5x7f3adkQltBBV5s++hwGSSEQXl9ANAu+NxU7rMFWoEm
         vkbnlRN39tj5Zz55OV1Uqd0xt1TiezS7fqH2y2/McKShnhL1O1C32cjRyefNhTXTRO
         7Ze40KBkBQpPJOdmsNP+6tjvSnnV0klAmJ5LszRgQP0/yxOhQme7JhDW9gS0Fq1ILe
         KQIyxdlLJnn2R9SpLq5LxWXVSuLovbXBDUimadL6L6oAww1unsGVp0U1bMIJvl2h7n
         QNWgLvkIhYNhEw5tf4idzg6TD1wjQLTvorhVM0XL1KiMNsqD5PGHcn2jGhEP4ijt9Y
         t76IOb93Ky1jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A780E5D084;
        Sat, 29 Jan 2022 13:54:49 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YfU9Bdjy8/Z0qQX/@kroah.com>
References: <YfU9Bdjy8/Z0qQX/@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YfU9Bdjy8/Z0qQX/@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc2
X-PR-Tracked-Commit-Id: 79aa3e19fe8f5be30e846df8a436bfe306e8b1a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44aa31a2bfaab2ad36614f05162cda88ade9ce65
Message-Id: <164346448903.28926.15367029804818060304.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jan 2022 13:54:49 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jan 2022 14:11:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44aa31a2bfaab2ad36614f05162cda88ade9ce65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

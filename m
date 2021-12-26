Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6886B47F515
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 05:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhLZECS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 23:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhLZECR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 23:02:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C59C061401;
        Sat, 25 Dec 2021 20:02:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E2EFB80D8C;
        Sun, 26 Dec 2021 04:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4AC7C36AE8;
        Sun, 26 Dec 2021 04:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640491333;
        bh=5oW5dTTd44pR/Z+MMBj5BYW0uOMCf1Dty2ZJWyFxM4Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cMJ58itdYQ+ARTHfyWYPfhMrhMAon4oT1rAzCJfP/CtLxp6st8utAJ7Y9nOwRKDUI
         N1Kg0TUnANZXbvTqDyDotNedLLL1/uUt5fJzLaLtIL9pdVXH06yGGkRCDE6jqMF3pR
         Hor1OR6j+IQ8uj04/c6DcDBR+Um/s/uVuMFblkyBDdIS3xcwHMZoX31W9qCJ0tf7P6
         7K5husWBV5vj0/leHPkNzdei1kBtemhTJn4FWxaJX1DejBPnoxm635iML8yT/EdhXB
         ZROv+VKCEpKmbFsdac/L7Wzs+Xs7DKgjoUxWcCiLHpL0zaOH7Ra45BJJJ4magg/3py
         m9iBmagmMAOZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7E57EAC068;
        Sun, 26 Dec 2021 04:02:13 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdaJMVS5vmw5KweS8c1ptz+OoEguifdqRFP4mzU_chH8-w@mail.gmail.com>
References: <CACRpkdaJMVS5vmw5KweS8c1ptz+OoEguifdqRFP4mzU_chH8-w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdaJMVS5vmw5KweS8c1ptz+OoEguifdqRFP4mzU_chH8-w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.16-3
X-PR-Tracked-Commit-Id: b67210cc217f9ca1c576909454d846970c13dfd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 438645193e59e91761ccb3fa55f6ce70b615ff93
Message-Id: <164049133363.407.11123026157818378174.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Dec 2021 04:02:13 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Dec 2021 04:15:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.16-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/438645193e59e91761ccb3fa55f6ce70b615ff93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

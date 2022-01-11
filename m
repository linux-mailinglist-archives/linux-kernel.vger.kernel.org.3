Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1583048B8F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbiAKUxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiAKUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFD0C034000;
        Tue, 11 Jan 2022 12:53:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 295FB616B7;
        Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D22DC36AE9;
        Tue, 11 Jan 2022 20:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934387;
        bh=SC5aelwjnHnDj54LGOzD6PRK4LTHsKbl8BmqQufhD9g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CiySeMNFSzLMRTzUB8BCVrU4HBH7lXZws7aBtRp+lP54JmRaCaYjjqEx+3ieEN0SK
         mMMu/JXWMQd8MKvXcRNdkzwic27gCE4lMRjvIElm0j6h5yje9pDw4Jg6vP3URxeRyw
         QZFiZBwJXjBGpZ0mvUAdw/CHPhLpiaRzX5aOaUZPKw3XU1IhSn74uMgqIVYnqBTJ9E
         sA+uGKO0V25537cdFTSIaJU43YcdkkXsbU6ExliJwK/bepYs1wBxXLePYResqIZwZZ
         I6VYSVVYpaDKd54b+rboL/CWS8c6l6XLufVuEFKxHQBXSqmr+aehFLNeL8fPj5wkjd
         leBmXn2adUvzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C7D8F6078C;
        Tue, 11 Jan 2022 20:53:07 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110041722.2095990-1-linux@roeck-us.net>
References: <20220110041722.2095990-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110041722.2095990-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.17
X-PR-Tracked-Commit-Id: 00f5117c5f785b95b13663e52dcdcf684a47d4e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a110907a118346cfafc3aa3a75a632fac11b7a9
Message-Id: <164193438750.11435.13217514998372229845.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:07 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  9 Jan 2022 20:17:22 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a110907a118346cfafc3aa3a75a632fac11b7a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

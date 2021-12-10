Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67380470E32
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbhLJWud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:50:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43646 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344823AbhLJWu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:50:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 246C7B82A11;
        Fri, 10 Dec 2021 22:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7FA7C341CC;
        Fri, 10 Dec 2021 22:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639176410;
        bh=C2JzY9tX7KaQ2HOds8rX4N2O9jKgCtiqKeLn2qzgDiw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OgcCyIdNHkokcQOUJw+1TNEIUrW0LwbwLcQjQdd2Kcxco8QNx1RRyvYQmrUbiy7lU
         Anp7si5EoB5b+Rvb+UQ1FW0LQS+p/rEiKeZPz6RdV/8edxGn/flm+YT6ffuOW+fJO5
         V9nQdppb0mQnU0yMyqlgLnSShPyBFT/0S1xf5f/O9/S+9AjhdRN8fKd/i+CpmE+1U5
         u1Wqr+195+KfGaTHqr2aRPraYaA182qEPN7E9SeHh/Ia2ktDjMbb7aUV+nFFAsCfp+
         SjUtlHcfiUuxnMDZxD5dU3+frKfKeP2FplcmTBy82chqirCivLxkeBo8VbqibPs6y+
         2DR3KP0DQz8Ew==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D7EB6609EB;
        Fri, 10 Dec 2021 22:46:50 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211210204106.1663978-1-linux@roeck-us.net>
References: <20211210204106.1663978-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211210204106.1663978-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.16-rc5
X-PR-Tracked-Commit-Id: a2ca752055edd39be38b887e264d3de7ca2bc1bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e050cd539b843eefce6e742a46f82c4dcdf3c23
Message-Id: <163917641087.4787.17026916604256509238.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Dec 2021 22:46:50 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 12:41:06 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e050cd539b843eefce6e742a46f82c4dcdf3c23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

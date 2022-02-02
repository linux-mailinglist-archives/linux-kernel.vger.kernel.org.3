Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ABB4A7771
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbiBBSEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiBBSEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:04:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF30C061714;
        Wed,  2 Feb 2022 10:04:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39B4961804;
        Wed,  2 Feb 2022 18:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4B8EC340EC;
        Wed,  2 Feb 2022 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643825051;
        bh=/1Ld/hOtHvIe0ZHOphStNhUPELe76TiJfnxUQFN+SBE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SIIX+voswHUGSBDeuE4I0+Bd7ttakFvnUU7Kg4n/z9fE/wgpyfH0VHZccF/RVb7hO
         LvYOfybS/93Sw0pcUka6Bo5md0Gc0H/2Qc0MTiErFLfXZXnj56N5MJbrR69tULK5J5
         Ryf8WH80UvBA1AbC9CFQafP27o2O2QXU84dl8JPlj8wtDMV7lCIF26ekvZxf8W3TxK
         rFoOcUUZ6eOeUENYdffdLD8wDOTv1N6uALuYO57PNcjaVKssnpa9CQmy+P0BRNlv94
         1utJczD12+eyBQiSyENAlK2AHzRiGs0vVhIuNIkMGdf/IBNVsK8zL+NXHF+YauW2y4
         daKjFhwvNvanA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 898DAE5D091;
        Wed,  2 Feb 2022 18:04:11 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdanZHES7tKFdq6_VjL+1PVCUXHADS+q-KR-MJ3b8tjsEA@mail.gmail.com>
References: <CACRpkdanZHES7tKFdq6_VjL+1PVCUXHADS+q-KR-MJ3b8tjsEA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdanZHES7tKFdq6_VjL+1PVCUXHADS+q-KR-MJ3b8tjsEA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.17-2
X-PR-Tracked-Commit-Id: baf927a833ca2c6717795ac131079f485cb7a5dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e5832e923a9c3a12c76980f68853668d4675ecf
Message-Id: <164382505155.25739.10739136658219746150.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Feb 2022 18:04:11 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Feb 2022 00:56:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e5832e923a9c3a12c76980f68853668d4675ecf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

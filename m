Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE09057E7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiGVUIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiGVUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF88D5E8;
        Fri, 22 Jul 2022 13:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C17D261FB3;
        Fri, 22 Jul 2022 20:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E27AC36AF4;
        Fri, 22 Jul 2022 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520478;
        bh=fqVa7RSfwPh1h6geZ3vlLSxox2ISb3tdaKqZ6VSqQqY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BZ6tbGP3Gx6RFxPfsC1wyb+fewQRReVWR7xOW3YFwtXyEXv7STLAOmt7ruKrVCQAW
         +RKk8FHZiSbI2q2jx9Q2/LKjcNqB/Rk1/oinsQjwXPi74jurD6aoNXdFv3jILvDQw/
         7wwJ010J0Orx+4iEAas6/3Sabh220P11PEI6BLVriDMrXjgKbKULFxESrWW+mcFeN9
         lco5VLqn4ywYiPv9funbPoyc+E7WFksH2haeRcHUoETTE6MsSDbzRgXJBhnZn45bmo
         cA2Kt4ugdICYiFPVnsvp45qR1RXmyUfr4DK5ultWW0Ew6avLKtEPvnpcE4Qvdo/lO0
         9zQGSi+nRjHag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 169FCE451BB;
        Fri, 22 Jul 2022 20:07:58 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYD6anQsCdZcC=RbRUVRraWm2hOauYB314bE0rxJ9PN=A@mail.gmail.com>
References: <CACRpkdYD6anQsCdZcC=RbRUVRraWm2hOauYB314bE0rxJ9PN=A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYD6anQsCdZcC=RbRUVRraWm2hOauYB314bE0rxJ9PN=A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.19-3
X-PR-Tracked-Commit-Id: 4546760619cfa9b718fe2059ceb07101cf9ff61e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 614719111265a7a76d0ae54758f23d8614966b82
Message-Id: <165852047808.15752.14220270706093235366.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jul 2022 20:07:58 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jul 2022 14:24:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.19-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/614719111265a7a76d0ae54758f23d8614966b82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

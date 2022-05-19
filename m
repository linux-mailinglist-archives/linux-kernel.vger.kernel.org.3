Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76152D9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbiESQOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbiESQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC6DC9ECE;
        Thu, 19 May 2022 09:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C0861C4F;
        Thu, 19 May 2022 16:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26A41C34113;
        Thu, 19 May 2022 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652976874;
        bh=Pou/TZQExnVirFTKYSnpCZucwyny64NVFtmEnYss5ho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=baR1NYG6/ncNV5U7wX/CiE3pVvyhoktAhZZiX5vaoZnukMblPMv9VYQy/YGqstBqo
         Y4+flsL1FiLLi+YKCGo6HUDauKpC8alo9rqf7dyNXGZgkJktApuiSiuW83TiQd8WRJ
         kEySLIBxQu+Iqvyy0Oir2jEnrLD5ncc8p1Bf3hdKNgXZbYzMPqhbdIW/hAuc/fVbXy
         9eHhpRukqMqU6qBc1A/z/YcvQQYGwj1+LDii2hvbUwTO2KKmKfZ7i1zRHXleKQiEl5
         HjqHz5wBRi3XgUjj8OO9LBLwZr0MJE3Vh8AQCmqGaWR9Dd9zFiwDntEPvmyqu3vxjX
         DH2kiSPZkU/Eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D5A5F03939;
        Thu, 19 May 2022 16:14:34 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdY4_vWpeKKKNrKPuMy8wJ52Y0z6MjyxpM5RwQXM4652KA@mail.gmail.com>
References: <CACRpkdY4_vWpeKKKNrKPuMy8wJ52Y0z6MjyxpM5RwQXM4652KA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdY4_vWpeKKKNrKPuMy8wJ52Y0z6MjyxpM5RwQXM4652KA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.18-3
X-PR-Tracked-Commit-Id: e199975b775a37750903025915f7bc0ccda829e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18e471dde0e3d09874f50aa399cb70169abfa158
Message-Id: <165297687405.7702.6657984407539085542.pr-tracker-bot@kernel.org>
Date:   Thu, 19 May 2022 16:14:34 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 May 2022 14:47:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18e471dde0e3d09874f50aa399cb70169abfa158

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F13956A9F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiGGRos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbiGGRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:44:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2107564F9;
        Thu,  7 Jul 2022 10:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86269B80522;
        Thu,  7 Jul 2022 17:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CA52C3411E;
        Thu,  7 Jul 2022 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657215871;
        bh=yipsckzcPtD2I1U8bB0T6DXG2jxNDWbUWeVDZOK9WvE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QLb35Bi/KPX0BUF2xOPLVzVSNcEcwBkuhpgDVZiITuZUkOOICTzpH9F+ROpu0R10J
         SmEWxQuYCOU+W62h21eMG31tJhuhF4XZLL2DudGfJn6LansUL7hLT86D0hELVYEmSM
         6Dlm/QlL6lHRQUa7kMYb+0ZrLRoevXJlENG56B6zI3PreUaX+vAXoiIUHeRDjN9RRw
         J9xDyrqiaLtdcLXhRCefNrN1xUSGHu6KDpFaxKWmIVGbFE/YwAZeZwefsr9ZkoWewz
         gppTMe5BjNprkgnItFudo02n9pN2WYy62WCJeA8EkD73ZMFWEJ89dqHMJDabrS7V/w
         xz83Q46c5vy1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B354E45BD9;
        Thu,  7 Jul 2022 17:44:31 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYD-mnt-vypLAXP9J2pgzXOOYhS7fNeEKLK7T2q-45USg@mail.gmail.com>
References: <CACRpkdYD-mnt-vypLAXP9J2pgzXOOYhS7fNeEKLK7T2q-45USg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYD-mnt-vypLAXP9J2pgzXOOYhS7fNeEKLK7T2q-45USg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.19-2
X-PR-Tracked-Commit-Id: a1d4ef1adf8bbd302067534ead671a94759687ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 651a8536572ae0dcce608b3e6720ae844155a787
Message-Id: <165721587110.16533.6121533424382096395.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Jul 2022 17:44:31 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Jul 2022 11:05:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/651a8536572ae0dcce608b3e6720ae844155a787

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

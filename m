Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF058F261
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiHJSdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiHJSdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:33:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8EA7C1A3;
        Wed, 10 Aug 2022 11:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27CB8B81C0D;
        Wed, 10 Aug 2022 18:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3D7BC433D6;
        Wed, 10 Aug 2022 18:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660156415;
        bh=CsfkFcX2R9anwO+kvg7mllQ5ReSJ6Wm0nCtsLoiU40Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tW477pDoTM/cykDy7qaLVa94UfjMCA+l7G7M5Sr5wYnyGBZ0WWee+2Q+iAFP3Lrq4
         M2y2oI7jlBWRFzR50PR6ZZcKoa8w0VAK7MhsJ3BavXUR20e6e8GpkLL/RVXVOKhxXz
         AfOAw4Ic2rbDV9e6/WhZb/NqzlmVyG+5vceNRKcJzpiucB3ftHA9Dut/Ducma4QmFI
         mxEAzSC5VqADroDdTHUaPYur5O/AYRF/7UoU8RRu2uh8pQv+4hzVE7KUof6E+Mq4C3
         74QIRtFnymSjBokTrCxPfZvXAp2jTVWWzqxeFGPXy05UfSVSMM1Ay1ahTNyjTrd0E4
         KRavttG4+grSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2CC4C43142;
        Wed, 10 Aug 2022 18:33:35 +0000 (UTC)
Subject: Re: [GIT PULL] pin control bulk changes for the v6.0 cycle
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdY1pDDQyEJmD0+H-N8e1g7E7M8A6cbYfDr=Y=+cqB+otg@mail.gmail.com>
References: <CACRpkdY1pDDQyEJmD0+H-N8e1g7E7M8A6cbYfDr=Y=+cqB+otg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdY1pDDQyEJmD0+H-N8e1g7E7M8A6cbYfDr=Y=+cqB+otg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.0-1
X-PR-Tracked-Commit-Id: 5b045200b53a9b95f87409b5c13f43adb6f1da6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e2e7383b57fa03ec2b00c82bb7f49a4a707c1f7
Message-Id: <166015641579.32353.8042341927644793462.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Aug 2022 18:33:35 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Aug 2022 23:53:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e2e7383b57fa03ec2b00c82bb7f49a4a707c1f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

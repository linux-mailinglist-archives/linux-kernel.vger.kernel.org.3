Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF59546C56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350449AbiFJS0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350421AbiFJS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C62D1F4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43119621E4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D5EEC36B08;
        Fri, 10 Jun 2022 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885573;
        bh=HpN/QBuW6xjgnEsZyN2cFZQ8mrb2SGkVG9UjC1+lDPg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iL4YvPhInNrf8Om3wLaC0PlkjEyHx/Jq/ONyi26Z1g/pSnVGudQ53uk5LOadgAQhd
         ewwlugQHrfVoVXtcRZYpK4fgZqvx/T5DsFPtDyY7U7X2hQOq0PsICUNrVRESjN0Zck
         muG7noNWpr3CWUAnSw6IgnrlGTmtNaQKQdmtvEsSaDVNciv25kP7PjczQKXUKuag+c
         2ywEsCDbbsW0s7fjNP5ynMlOWm+Uc/1sdsXKrQGLMWms0pJCgNTzn9gct1g4tGAIj1
         vVk8WpoCFA3my/PtHX5peUgpO4SfQM1nMEa6OKzhPpQT+YgBFT5537o1P++8tXQCBN
         hOzN1i6K1dyVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A6B7E737EA;
        Fri, 10 Jun 2022 18:26:13 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sfodlzn3.wl-tiwai@suse.de>
References: <87sfodlzn3.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sfodlzn3.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc2
X-PR-Tracked-Commit-Id: 5f3d696eea916693b2d4ed7e62794653fcdd6ec0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f7ac50c97d30ae5ae48da3b516510d05a67b9e5
Message-Id: <165488557356.32117.9655555285957107237.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 18:26:13 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 09:57:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f7ac50c97d30ae5ae48da3b516510d05a67b9e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

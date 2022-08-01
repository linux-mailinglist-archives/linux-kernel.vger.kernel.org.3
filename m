Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A429586F88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiHAR1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiHAR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A3E12767
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD4D9B80FE4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C878C433D6;
        Mon,  1 Aug 2022 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374826;
        bh=4S8d6eeOof1twwvrJ52VodhRaz765GulC0qN7tyHu/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UQT9DvysT6wbq18weIxBadaKY4GMCsx0aTtEhg8fUTxvrQGh0G+xQSFrNmgHo0+JF
         xu9ioQ4nG/wQpJJQO6lkpitxhDdynKci+tP0A93Lw0R7nypqbDhJvHQSOyL7fXnACW
         Lc/9P/QbbckYGx7Wn2LVXrkXj+PkCHaAo2xDX01YLXPUHyWkMK2BEh9BcOEs158ogG
         ipqWp1FtLqzm+B70RNQjCE38Jj8i8RR1zyjxjagJY8YodV/Ls6zMGqz1ClqRSQ8oEz
         8Y7hsy+Rql3nikOP6WLA8XEsxdlG98Yd5NelFhvLGsIcwrrpxpH0CmbUZZxFAiymMA
         XdSJCqh0F6sEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62E51C43140;
        Mon,  1 Aug 2022 17:27:06 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YueMqE3muQn3rebB@zn.tnic>
References: <YueMqE3muQn3rebB@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YueMqE3muQn3rebB@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.0_rc1
X-PR-Tracked-Commit-Id: 891e465a1bd8798d5f97c3afb99393f123817fef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 296d3b3e05ec8aafb279acea3e8d7e86974795a7
Message-Id: <165937482639.24126.1318809639620205534.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:27:06 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 10:19:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/296d3b3e05ec8aafb279acea3e8d7e86974795a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

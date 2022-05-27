Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508BE536900
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355149AbiE0Wpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352286AbiE0Wpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:45:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302C8217E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 729B6B8264B
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 22:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23718C34113;
        Fri, 27 May 2022 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653691544;
        bh=cnsercazjJFgKJLnu0XpEKBZZVJ9ajaURjhCXCksSBs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X5HdBe0QOR85LWbalGDQxzvLmmNdNypXmFRGZzlUkP7WT08CYfOp0XyrIyTIkoeJk
         eykjpawmJ+gtXD6L7JEg6KlcSlhf98HrLL/Eoq7hwOZYKgzVc3gGqA8j/NuADGW+jp
         iS61zHKZwtyat/rJw+qSvfVHf6tgGp1jWVH2npmDy8JDSYwaeONJgDp9745/9MgfqW
         uxVKVl9j/lo9aFpuIN4dLyX1eUTJwM86gsJMbsskLfU/s6cMXw2C1RERL+tKX/fucY
         6vKwSCYsjZndlYTesrxIqpCmMffmfElcHHNffmRpFZKq6VyBkUVXakYbGKQck0/Y6w
         J7fm7slhlkfEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12730E8DBDA;
        Fri, 27 May 2022 22:45:44 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpC8PScrQLKP8pyO@google.com>
References: <YpC8PScrQLKP8pyO@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpC8PScrQLKP8pyO@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.19
X-PR-Tracked-Commit-Id: f93afd8e7567fa9dcf0089ff4ce5a713bfb5dae7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea6c3bc6ed93dd032568427e92424f6d33deb99b
Message-Id: <165369154407.860.15878338171604580341.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 22:45:44 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 May 2022 12:55:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea6c3bc6ed93dd032568427e92424f6d33deb99b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F381D57E7F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbiGVUIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiGVUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:08:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3554FA8746;
        Fri, 22 Jul 2022 13:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AFE461FCF;
        Fri, 22 Jul 2022 20:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC79EC341C6;
        Fri, 22 Jul 2022 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520477;
        bh=ohmSvi0K7c/bHcdN+W16xxW1NzHhb+6rgP3yTO0JkHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p320JNphPswO6m8mpoPdiVHmNEWRCzJOqpf2kJsnyjeFnsTv6uQoHx1MVzy8NIhim
         lnVMkJgflVlPG7gLWOmwQx6LWt/zhlpxu2yHgAAf9B0avFJSt4MREozJRXrwbKfiFS
         yKYQFpYocUosMMEXJQh5qUuBup4oznGcPdwQ6RHmhQY8Oyxwb85+9gsnGtjyZfgOZy
         vqTWn/mclzJMFVS3adZcPToBn0a474h9ShstCYcPHCVjhqCgFEv4TPRQIbfYIj2Swb
         9uOyqtOkgVLUW/nA2mpxcSSpNpn3a1FKLUXk9uYx21k1u2l00do3P8EhpLCCKrDVjy
         ys82/mkbR1xBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B54D8E451B3;
        Fri, 22 Jul 2022 20:07:57 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220722094737.50886-1-ulf.hansson@linaro.org>
References: <20220722094737.50886-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220722094737.50886-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-rc6
X-PR-Tracked-Commit-Id: 51189eb9ddc88851edc42f539a0f9862fd0630c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85029503fc95ea16e0c0856251f5cba750847c85
Message-Id: <165852047773.15752.15759375835312020414.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jul 2022 20:07:57 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jul 2022 11:47:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85029503fc95ea16e0c0856251f5cba750847c85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

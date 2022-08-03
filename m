Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA14558946D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbiHCW3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbiHCW3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:29:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D1A5D0E7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73ECC61631
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA0C2C433D6;
        Wed,  3 Aug 2022 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659565764;
        bh=7dTvqxebVgWCjd5EeelmJS63j7UBYYKpt+w2pPBV3JY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gg+LfGKs0BeQMmgrxPkhAWwD0QLo31/WApeSFAq1GQt6nlhKcxywmtA4sVNt8qU1d
         5+nitTgeO/J6Aerd5+ZPIdr5j+PAP8Q6d7tADvvDqAlujEoD+vHJ5UNkW64c/8X1nH
         k/IojopW/Hr/SPXPgCLqhMLcTe4ODxZDLoLaA++LlprJxzYHwRGjvnqU8E6wI+0w0f
         B6i2FgsVafGrXbvU5TZ+D2j2nreuBsxP2/C43+Lz7JZV4dOEl2S8Tq6zc0aR0AGXHn
         gb1Tggx6FxWXppHSIRtTCOOrR9yfuCOPaeJB4ypP+amEt5gIpW894c6ULg6+Mc4msR
         aTnvYjMbcfHcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9E81C43142;
        Wed,  3 Aug 2022 22:29:24 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS fix for 5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1659542557.git.dsterba@suse.com>
References: <cover.1659542557.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1659542557.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-5.20-tag
X-PR-Tracked-Commit-Id: 5abbb7b92820cf6ba9154a35cff6d64b62d7f273
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e4f8c729db5f3c0b8ea8b1b99f1ae124152e8cc
Message-Id: <165956576482.24057.3594637051480368460.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 22:29:24 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  3 Aug 2022 18:08:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-5.20-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e4f8c729db5f3c0b8ea8b1b99f1ae124152e8cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

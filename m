Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0534C5AB834
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIBSaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiIBSaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:30:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED9C5927C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B693862220
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 18:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8770EC43141;
        Fri,  2 Sep 2022 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662143408;
        bh=c5hR3Z7saE4Kmnb1TXqeVV1zbeuFYjbQ2muN/mtDcdo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I3G5O3ty93uzE/CqsWCA17TG+Dp3brQQudxjVKe1cm8whwNajIkbW0qyHRjsvw0N0
         4sHJ4IwSvjMmPxpYkqY5kyo2BJiPTd5j3rrYgJv947zvs9FeQPu4FS1ZXp3DsumHSU
         M9FjR9K+le3nm+t54pbZzArl1jwYiqqxZVTAuKt4gFKbcEuf0gqrNyOUV8VY6bNAkw
         RKdZLCj30PwhLksRnf9vodCNeGg4i6cModthPud+JwVqrf83QwNs7Wi/2thPsZrUz2
         xFbAzbFedNLCdsMNrEgtEYGiMg8ySxTZBvYdYeeOPpUV3ggMEL9CU0ntDz8GpbJHb7
         9c6RL+QeZe8hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 740F6C73FE0;
        Fri,  2 Sep 2022 18:30:08 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YxIht+ev+gXsF6ZD@kroah.com>
References: <YxIht+ev+gXsF6ZD@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YxIht+ev+gXsF6ZD@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc4
X-PR-Tracked-Commit-Id: 789bba82f63c3e81dce426ba457fc7905b30ac6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b3acd1cc0222953035d18176b1e4aa06624fd6e
Message-Id: <166214340846.20636.8844058236120920137.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Sep 2022 18:30:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Sep 2022 17:31:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b3acd1cc0222953035d18176b1e4aa06624fd6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

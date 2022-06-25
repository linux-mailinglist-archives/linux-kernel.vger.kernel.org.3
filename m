Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141A755AC16
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiFYSaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 14:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiFYSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 14:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F57212A99;
        Sat, 25 Jun 2022 11:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2A7560ABE;
        Sat, 25 Jun 2022 18:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97EA1C341C6;
        Sat, 25 Jun 2022 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656181805;
        bh=mr0EPKWftMUQBZ3R8JQHBFfDl2BQOUehCprlVi9OPb4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jsy8Pv0YYv/jdvAUG/VlzteKZjDnqjW1reyQXDfklV3td7w42hZCXIvtahTNz02pq
         rva9QEAfOzXobY9wIg8EvS3JTC8haIDi1XMzrLc2S18zT/CKcyqBvRZRpr4PHFyarM
         ci4COQKPhMEfn1aKfzOh8Xyt6JdsFFlg1EcUl4k4KZo+hRmHYsJERd6umYvWUztU3K
         ogzZOdFQO1M12WNo+A9q93umID0X6QyadXqzx7VYQGXkZ+Aml27vUSQHwGzPKfjqR9
         WGsnSNd0vhUas/5GErnvqjjL+7/wFoT7R0wT+Ddy1IushxZAX0QG2FjFuiifYL3XOE
         Vzo2KV1yTYm9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 809FBE7386C;
        Sat, 25 Jun 2022 18:30:05 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YrcerztKA0mJxjVh@kroah.com>
References: <YrcerztKA0mJxjVh@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YrcerztKA0mJxjVh@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc4
X-PR-Tracked-Commit-Id: b24346a240b36cfc4df194d145463874985aa29b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c24eb8d6a5b2da4cbef6a053f58ea9818c6dd659
Message-Id: <165618180549.26648.2841966637601024152.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jun 2022 18:30:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jun 2022 16:41:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c24eb8d6a5b2da4cbef6a053f58ea9818c6dd659

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

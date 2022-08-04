Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4058A137
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbiHDT1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbiHDT1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:27:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7116D9F8
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B17E5616E4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AEC2C433C1;
        Thu,  4 Aug 2022 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659641236;
        bh=0rCuNgZOxULPG2qvHCzaLnP+fDPrAtbGBFtJcFBoLmU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bwqsJrynymxXqSRdrvkDe/0B6ibfu3Zb27/vYuoOSGfC7xs3S8138Bih6vfumjntt
         pkCpFgy1eZi2oH0uSHIg6GyxRgtmQSeXlVs4i7CJ9WbozveOuYMtUPPNs3SENuc9ut
         B8VbuxgETCG9+6NhkfTm091ocd6Y6i6fA0hFpG7/M35Et/3RK/oYzgG4q1yMAWygg5
         5U0a5mh9+zBZ4mq4duoE2MIJ9OM3DeIaO9CwJVahpyl7Tmqn9LRlq5zLP5VW7QT5WC
         ZbLV9EBMr/KqFnN1xc3bw+q9ZN7CuJ0ee8iFGui3UbBC6m6y2Zwq6rn6LhOnyDj38I
         NAn46LQhWRmIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B2C3C43142;
        Thu,  4 Aug 2022 19:27:16 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuqBnlRPjwdAJhAo@kroah.com>
References: <YuqBnlRPjwdAJhAo@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuqBnlRPjwdAJhAo@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.0-rc1
X-PR-Tracked-Commit-Id: b5276c924497705ca927ad85a763c37f2de98349
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 228dfe98a313f6b6bff5da8b2c5e650e297ebf1a
Message-Id: <165964123603.8981.14648088145470299874.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 19:27:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 16:09:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/228dfe98a313f6b6bff5da8b2c5e650e297ebf1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

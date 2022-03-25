Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638384E7D1C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiCYT4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiCYT4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6D22BD6A;
        Fri, 25 Mar 2022 12:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E46261BB2;
        Fri, 25 Mar 2022 17:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72C46C34110;
        Fri, 25 Mar 2022 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648228683;
        bh=I4ZY1QiAn+JiHTDswh4ozEtAdUVk9QXS1bMoezDChkE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Bisfk+WqHKK46kLcQmzHi5fePegfrZ0hguwsVPEXWpKv4HYnRDQ9LoEeB857U+717
         hPeX8NpL3t/wBx0UjTk13C6lL6SHcmpRjTlLC2U/ffvNQxXoCnffkyWwQ0awfcfCbn
         lVyNL1kcvffUl9b3kXbrJ9s58upW4NQ3eorQhdpkXBK/1gtO1v620LovcOAc7TOzLW
         t2L/XR/Rae5b0JQI1you860eHo10CgC8WBsoUC/v/C9GE8KlqIZ2T+DqEfVYsl0/Wc
         XxtdZMxnnkduG0DycWYoUAHCFuSdkWg8rzgLRFUnwS0P9j21y3j3YpRFUqdFWc3p3u
         wpuwE1U/F5J4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EF5CE7BB0B;
        Fri, 25 Mar 2022 17:18:03 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220325144706.GA9428@alpha.franken.de>
References: <20220325144706.GA9428@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220325144706.GA9428@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.18
X-PR-Tracked-Commit-Id: f8f9f21c7848e63133c16c899f3d84aa54eb79fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a8b3d5f71eb74b1b95927bd320b1070866a119a
Message-Id: <164822868338.13188.17500314349084591736.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 17:18:03 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 15:47:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a8b3d5f71eb74b1b95927bd320b1070866a119a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

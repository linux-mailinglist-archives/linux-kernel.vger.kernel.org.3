Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6203B57E7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiGVUII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiGVUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE71AF72B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01C4B61FE7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 20:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67239C36AE3;
        Fri, 22 Jul 2022 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520478;
        bh=047vuiVh4+fUv3R154SIkND9ErP2jOTV1nb7kERwWyY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ltSWbRFuZPSAb7I1djmAzkCi3V/IISG/hxhZntTTTA7F4GYy2ZDp/H/1Jxj3ul4Rq
         qB//eQyMKBLEWPHdzFlWrz3LgSyYT8Kp9T0Lrfnqo9JMNWtn2cY4j/vQ3ejCY2VKu0
         05XBIgX4u030Y2z+8XcoqYFczVpM0eQoWdnPHdqqONBms29JjwFi4q2jYmXfMi6FXZ
         7u7dUrPXAprD9c2UiCMf5rdT+CVIqPfpI2gH+YbqZeGjQZuQ4P7V57eudp4NlzP/fK
         3sBZGCkiChEPirjfzl+t5I+CqhBCP9nNYs7jvv8toMByOBPOupBicOUxTGv1bkGkiH
         W+fzHcCRSbJrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54C20D9DDDD;
        Fri, 22 Jul 2022 20:07:58 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-84a83727-f880-4d8a-b9df-0c45accff355@palmer-mbp2014>
References: <mhng-84a83727-f880-4d8a-b9df-0c45accff355@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-84a83727-f880-4d8a-b9df-0c45accff355@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc8
X-PR-Tracked-Commit-Id: c1f6eff304e4dfa4558b6a8c6b2d26a91db6c998
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70664fc10c0d722ec79d746d8ac1db8546c94114
Message-Id: <165852047834.15752.10120575058452443828.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jul 2022 20:07:58 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jul 2022 08:52:11 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70664fc10c0d722ec79d746d8ac1db8546c94114

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

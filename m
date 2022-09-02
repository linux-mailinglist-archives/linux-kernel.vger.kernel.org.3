Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F55AB832
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIBSaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiIBSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:30:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CE95244F;
        Fri,  2 Sep 2022 11:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8028FB82D08;
        Fri,  2 Sep 2022 18:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30BC5C433D6;
        Fri,  2 Sep 2022 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662143406;
        bh=PJkTFOfwdEddaB++EeEmUDJRqKpt4gnmHEon4YuJIik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gSCZE+5BaLaUqxFC3qz0QF1YqpklEJQesCJfA9NaMVgnCl8xDRFQVelnwAG7dqeTp
         wHqSSfEntl0tj+qhpa8pOZRUxWf5A8iTGy1ZkaVnwW9VMZ7KQClmrphe/6udIgfoj2
         C/I8nlQUYYwytG2WxboLMHIQJoObjI+m2+vqiaC9nC5IgrvCx4rlo+PWAhi609FLy/
         RiikcKZhACmMWIhdYMrT6fQLefpCwFRxlceZz+ymVY/+Rj/7Ov4ekNypa5+RyhfYKK
         M+94L1yiLkoCtiN3pPq2R/y+9Naus5h956Dpc7CQyTPrr/XxxwRNQYHaabvXBRR3Tu
         zhQigV+hP092Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B0EFC4166F;
        Fri,  2 Sep 2022 18:30:06 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver fixes for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YxIfXoyXB6UQulWv@kroah.com>
References: <YxIfXoyXB6UQulWv@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YxIfXoyXB6UQulWv@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.0-rc4
X-PR-Tracked-Commit-Id: fe0a2ac7c627b064c479ad0c3b25e531d342e048
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd59585c420df1fc2df33bea2ed925b3373fbae2
Message-Id: <166214340607.20636.11398411994836723090.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Sep 2022 18:30:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Sep 2022 17:21:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd59585c420df1fc2df33bea2ed925b3373fbae2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

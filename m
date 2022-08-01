Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620D8586F85
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiHAR1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiHAR1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E2B13E0B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D9A6B815AB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F48FC43142;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374827;
        bh=8FkXK2gJ1JLX1Iv2LEpm0cdI/63ufcgour+ooeFnZKQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LUJODk9cYjvWLIjm/BBcc3P5X59enVQ2slFaK8jiQ3Mn/IW79FFEi3ujXK1ze/mol
         9UQhKWQd8REs2utPfrTpzYB/acus6z0zWrrejD3RUd2vePPKxPGAGOURpNhEZnRHlB
         UGw/xuXKN+q7IcuGZ3KVUYFw8gynk9+tqQrvcyeubHK3glVdcTgvaWK+bRzsryTwa9
         4A2XlcvMgwIzdsERAC3tv2aHGK/a8MZfz23/7WxnDOq3zJHbE0CG22TguNX+F09+Hj
         I3IGWPu/pDFD1lxJIKTjPFsd9hy6fJhxdqmv08SM3lr5dnZ8Sm/7KhDZvdWmmEAgsJ
         zYqUeLuEK9RRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED730C43140;
        Mon,  1 Aug 2022 17:27:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86/fpu for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yue0ecyVdbrK9TpY@zn.tnic>
References: <Yue0ecyVdbrK9TpY@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yue0ecyVdbrK9TpY@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v6.0_rc1
X-PR-Tracked-Commit-Id: 9f01129382774d98ec21526f13da26a0630ee3d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 650ea1f626ab4d939fda00b7cca57698dcf57e5e
Message-Id: <165937482696.24126.12093771721419202667.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 1 Aug 2022 13:09:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v6.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/650ea1f626ab4d939fda00b7cca57698dcf57e5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

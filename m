Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B658CDDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbiHHSnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244477AbiHHSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F910F3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D049B61262
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CED8C433D6;
        Mon,  8 Aug 2022 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659984126;
        bh=ePxumCSBfFzGSnKGc9mgQ/zezFfiqvOGFsKicTWV8Ic=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AMyAeDcykGtM1NcmUiPwmEX5CCuGudJG9qroNNxL1OV6+d9fc8PWnCtp/9bxALejA
         jTuM0cgyBfz65O9LsYRCHbeoO8kb2OD+ZeKw1wGWNRBSqGXt8F/6RnC6mpw95ZJBFM
         LOdZKVXuG33ZT9yg23H7qfhqzqZ89pITjMlhymeWhkLXXsc87v+3agAa1bqj39Covp
         t/P+8OhMl06NYVkg5lidPZ9ks283XnfDV763UvYgnuwOjQZpmycF4xajJzmbXlUlE2
         qahHTKBsAAskwxoeId5my77OGo107QhcbKL7St6PSgH3SbqeYwZR8l8SaxBbVavJjJ
         tgpsGQwUCMIkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2079AC43142;
        Mon,  8 Aug 2022 18:42:06 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvE6fO1r0znOdr60@google.com>
References: <YvE6fO1r0znOdr60@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YvE6fO1r0znOdr60@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.0
X-PR-Tracked-Commit-Id: 01fc4b9a6ed8eacb64e5609bab7ac963e1c7e486
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1daf117f1d6b5056e27353fa289ef1bbcb619e8d
Message-Id: <165998412611.757.4082441541287492652.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 18:42:06 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Aug 2022 09:31:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1daf117f1d6b5056e27353fa289ef1bbcb619e8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

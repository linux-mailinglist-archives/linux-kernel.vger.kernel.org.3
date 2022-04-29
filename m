Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20851402A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353879AbiD2BUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353873AbiD2BUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:20:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D72C89334
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 444F3B8328E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB69BC385AA;
        Fri, 29 Apr 2022 01:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651195047;
        bh=+1+Pa7/k7iU0K7EVW6U9WrMKZNxIwirWlYL+7ZzpGFw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MEaERdWJtyUY9Ry/GAT/NWc7Hl1ALBWWdfAxOX7uo52BuN74XDT5sYVofNBOWg5ZV
         KFSuP6pyVOfuWsO4+7Rze0m2a7hoqZGQyUpJjLbqR4EDcdP0a778vIpA6BFfGlXbz9
         1zeJpexlr08dLs4vhUk7dTSuC78fVCJjV8O0NRuExlgGbhIwcI8Fcq+IMULavQ/VQB
         0pLIYO9E1ijKAYUcCScobvSkHAxhD9cL1nCjWFklr+ttHT5UeEaLlh6eG8YfpLJxi8
         uqCTHrYiu3k/b0m/7fWBB5biD4lpYFceCrsyqYD68vhJr4/LtxS9+/iP913tqCcCMR
         hxs/vMnBqabQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D72B7E8DD85;
        Fri, 29 Apr 2022 01:17:26 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tydvfoBFBAY_Vba2vX=26ePwBZumRxnKWA7Lj5+G+tr5g@mail.gmail.com>
References: <CAPM=9tydvfoBFBAY_Vba2vX=26ePwBZumRxnKWA7Lj5+G+tr5g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tydvfoBFBAY_Vba2vX=26ePwBZumRxnKWA7Lj5+G+tr5g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-29
X-PR-Tracked-Commit-Id: 9d9f720733b7e8d11e4cc53b53f461b117dab839
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4
Message-Id: <165119504687.10581.12524472299040777629.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Apr 2022 01:17:26 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Apr 2022 10:50:25 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38d741cb70b30741c0e802cbed7bd9cf4fd15fa4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

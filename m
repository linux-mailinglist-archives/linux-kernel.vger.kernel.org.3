Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D637B4E318B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353205AbiCUUOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354024AbiCUUOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:14:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF20653A51;
        Mon, 21 Mar 2022 13:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83BCBB819C7;
        Mon, 21 Mar 2022 20:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C2B7C340E8;
        Mon, 21 Mar 2022 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647893546;
        bh=rCtnPLwKWKSgcE3f4N+j+E1IB0JhpuyKvIJs8eI24WE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hyvT1Zpw6jp4YmkXxhCcTH09OFlwnUJBBdcOBBFc7fm6cg3Coj6gxb9b1EzKme+Tn
         00ONcpwie8DUr1WrzQVRPSx3y2fuwVk9y/UEsmyY3dvuTQFwZjBmNSf8SVGpKeofSq
         yapuVVFtitKG4J33Ick/mnv/6VArOrjw2LlDcYCbQ6BQpPqsTsezw54KqYeW4a04bT
         J0Y/CsZjYf+94k+uXu5GzIddjKvY+7ga3dcmp9W6lmIutUdiqYqaytb5njXLbMZco6
         Pm9htENqAHRJp/iYRucztTRhl7zX0K21xt07PqugSdH2BfzzmILjIr/dJ8gjeofi2G
         /2fN43I7Pnogw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39FD8E7BB0B;
        Mon, 21 Mar 2022 20:12:26 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjiyOIc71r53GME+@p100>
References: <YjiyOIc71r53GME+@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjiyOIc71r53GME+@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-1
X-PR-Tracked-Commit-Id: 53d862fac4a09b9c56cca0433fa9de5732fd05a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a04b1bf574e1f4875ea91f5c62ca051666443200
Message-Id: <164789354623.19380.3760360425035563977.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 20:12:26 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 18:13:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a04b1bf574e1f4875ea91f5c62ca051666443200

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

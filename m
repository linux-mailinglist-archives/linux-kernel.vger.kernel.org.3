Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3859558CCD2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbiHHRkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243918AbiHHRkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:40:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37F9167ED
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5679AB8103C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 17:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09E9AC433D7;
        Mon,  8 Aug 2022 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659980407;
        bh=2pAeFwMkCQ+/kndiBXqNtsVJkIxJ+NQ/c5YWULj4Zxc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LgzChbt5C6bpbprNBzM6xD7VT2zwOyFrrb4a4Yo79+nPs/8BANddrWeKZBy8XGOyq
         xwz+WXopNzHy1M26d/UGQP7AtBa2NgYTjw/YBYBDOBr6vj9MB+Qd35ml9a3gAP+BN5
         R+miRryySTabJVOETjkL9VmAVsQEAZAx2pBES6O1zbXicv9ZuCog7/g9VRr/rCmp2K
         oVZLoW0hP89Q5iG15Rnv43aZheBAJhAmWJWt67eSmcgqYs37yb2zkh3ow/Xc5KSSXK
         AJptPZ16URAy6cBrbs/yRWCwo5+iMWdhX22xlQA6oDNMeVZ5ghz/bLpPtmpgv7YY46
         fvnhEdSWIPIKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB285C43140;
        Mon,  8 Aug 2022 17:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2gc3bDOu8v0vCizsdrSr2BQxGW1tuvpBzjCrRr64e7MA@mail.gmail.com>
References: <CABb+yY2gc3bDOu8v0vCizsdrSr2BQxGW1tuvpBzjCrRr64e7MA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY2gc3bDOu8v0vCizsdrSr2BQxGW1tuvpBzjCrRr64e7MA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.20
X-PR-Tracked-Commit-Id: 8a8dc2b9596e6088522d30bc79306b834c681943
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92ceebf920aa9f103b89d102f98fc59c6b990cc0
Message-Id: <165998040695.21911.7863332452858909555.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 17:40:06 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Aug 2022 22:43:21 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92ceebf920aa9f103b89d102f98fc59c6b990cc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

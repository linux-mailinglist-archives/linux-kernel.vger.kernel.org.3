Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E135AC15E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 22:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiICU3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 16:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiICU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 16:29:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8362350727;
        Sat,  3 Sep 2022 13:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 419A3B80BAA;
        Sat,  3 Sep 2022 20:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBE17C433C1;
        Sat,  3 Sep 2022 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662236951;
        bh=Yh2FGLdGSTMaVVCLjZEu9qf1zvs2khzdtw/oOGyW48E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=doBqrcJ48sPmCx32T7vaJNRvMk3wtZ6WoDSVWxuL0LvI59Nu/CloCt489Q2y4lUTF
         dlKQcgXrRmqhn1DCQ3X8LkW1U59JjXm2Fyl8HRAhjZU+jV/qZhyn306bi3eCStvOrj
         mAXUPr3dbp3PvRRj9m6chdzu+vPqL/XlPR2Lg76r0p7xKkm6QGqyFhSCJmvL43qZAW
         WRtuZ569J0QY0tpXLb/zbW7OLjgfCkzNQ7Y07cTPA/t0iB+nqiHwlmXVrM5/rmTn0R
         W7uag97NiheLaWhfIV2B+tOcL3ToPJL4F4jqzD/6Wg9yqRafGJvjFRNen7qehs9XFe
         7RtjXvX/7YxNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB42EE924D9;
        Sat,  3 Sep 2022 20:29:10 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YxOzfPVU+ogFrEb8@google.com>
References: <YxOzfPVU+ogFrEb8@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <YxOzfPVU+ogFrEb8@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.0-rc3
X-PR-Tracked-Commit-Id: 9c9c71168f7979f3798b61c65b4530fbfbcf19d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6433fe06f698936e02f79bf18f69be766e4f53aa
Message-Id: <166223695089.8828.13485836366674501098.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Sep 2022 20:29:10 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Sep 2022 13:05:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6433fe06f698936e02f79bf18f69be766e4f53aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

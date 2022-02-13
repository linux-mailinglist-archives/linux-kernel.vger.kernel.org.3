Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311C44B3CC0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiBMSEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:04:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiBMSE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:04:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF115C34D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5297BB80B51
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01F54C340F6;
        Sun, 13 Feb 2022 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644775459;
        bh=W94HjpoB7xMVU/EKK/RtnitlgOzg8l2/F8SVXHaOI3o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S0DMsotPhPTaiFrXwcqyB4TwTajG/HgtCyw4hHbD2X+QOlwHUz4FaAlK4IkekpUwQ
         4k6lpncNIDI/lNge8elpKt16OXFlX4GNrZnpUeThzOHss4qWlaapLnvkPRhhT+2ZJr
         vIsm3bsCSOhMk8o95ULZp0TlhlItSkxoVUW19egkUCZ5g/EZ9FPccO3x8lGqtsL7pA
         G7bVtXfmZ706CfPOiAqgH2WxBzLK5TRtg+iEbBjQPZ2Ml6gvoefoI1x/AZ9s+Gy7ob
         LfiDU8pWOoRhulPkytAvZ4nMXgtvexqQPNrEmVzdcIL0zH5Qhio2HzKrwfm4spKNCy
         JIPv6eVSzfwxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5E77E5D07E;
        Sun, 13 Feb 2022 18:04:18 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ygj8gS3RoDHJ065K@zn.tnic>
References: <Ygj8gS3RoDHJ065K@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ygj8gS3RoDHJ065K@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.17_rc4
X-PR-Tracked-Commit-Id: bfb1a7c91fb7758273b4a8d735313d9cc388b502
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42964a18f81c9e514dce2d11277b7cc546146723
Message-Id: <164477545893.17492.4431879632110978986.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Feb 2022 18:04:18 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Feb 2022 13:41:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.17_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42964a18f81c9e514dce2d11277b7cc546146723

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590A24ECBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350150AbiC3SWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350307AbiC3SWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6CA42A37;
        Wed, 30 Mar 2022 11:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D2B60F7A;
        Wed, 30 Mar 2022 18:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FED6C34110;
        Wed, 30 Mar 2022 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648664413;
        bh=hhmokJELwaMPMD8KLVN3TL9iq6KbaM684ysIX0F+Q8w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rn530w3YVekxu8DpwfdX2Pkt4fJuF1dOJ7hVkSFcKUd/vpAuc3VpcwgvFkbNqhUIk
         yFKlYjCiMkEsH/MSaP1ukn+ORSPm8TRNjutbMola7luIUiru3rxDAAJLrUVvsSECxd
         4qPvr8JQ3y0NbGmrkSlp1kpBNV/2u040ZHqZtQbjShrTkINAPjpYGPMUOA8LbdaAnX
         6FEpzx39W7CB7XaSQG+H05f/yO6BqybIuSsKrPb/5yHtgVyu2yJlx+Oc7sM9MVM9wU
         wf41v/ChBCewk9g4apqeK0PvKWqsCwFAnePTMzPk8h3SNbiNAJ9u5peeBcPpdSSCsd
         QKlkOYig+iH0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68DADE6BBCA;
        Wed, 30 Mar 2022 18:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220329212732.4111049-1-sboyd@kernel.org>
References: <20220329212732.4111049-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220329212732.4111049-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: cf683abd3913d5e6e51169de75d65ea193452fbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95124339875c8d9c092eb2fa3993e4751e1be48d
Message-Id: <164866441342.5472.2622819469102869175.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 18:20:13 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Mar 2022 14:27:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95124339875c8d9c092eb2fa3993e4751e1be48d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

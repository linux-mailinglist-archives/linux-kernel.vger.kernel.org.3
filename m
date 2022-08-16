Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7C59630B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiHPTVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiHPTVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:21:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCAD80F53;
        Tue, 16 Aug 2022 12:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89364B81AC8;
        Tue, 16 Aug 2022 19:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EAD6C433D7;
        Tue, 16 Aug 2022 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660677674;
        bh=rqQmPKuzb5daA5RCPob+5rcVn2W7ybe8QvI6YIJDO3E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l0dZfbIkhuB8AlPUuvD0geY5Laq02s/CHu285rGn7/DkgwatbikvlbzlBL7xdKuC4
         xq6gu/nevxWpKHpo/HHljO5/qrg0lyo+4KkWQvLBS3xUGrK9+jY/+vrXbn/ty/eNSl
         jx1UpmKNmGel0nTFp8+J9KdTfRIsr4Z1uT4cMCT2rsoHuZ24WeqhL0xWr+IG145gJI
         IqzDafbpmj5sOGB29ZEz4vKj8LmQShvpiBT21FwP2tQLE1JsVCc8rCXBXr09kuTQjY
         iebZ5TEQdSHlUJYgnw+aQkYyM84hpOMr2rrrAph2Xhzv3jNsSv9yfpQZnuEqB1SOLT
         kumjIO3a1wQ2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2319EE2A04C;
        Tue, 16 Aug 2022 19:21:14 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220816112317.47721C433C1@smtp.kernel.org>
References: <20220816112317.47721C433C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220816112317.47721C433C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.0-rc1
X-PR-Tracked-Commit-Id: 2fd92c7b8fe2cfc634613dc093d0f507c7389ea8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 339800d50b411d617fb3298d478921e6626032e7
Message-Id: <166067767413.31662.688858607098166502.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Aug 2022 19:21:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Aug 2022 12:23:07 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/339800d50b411d617fb3298d478921e6626032e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

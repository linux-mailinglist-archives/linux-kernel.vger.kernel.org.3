Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E954F9B07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiDHQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiDHQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:51:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E3F127BE1;
        Fri,  8 Apr 2022 09:49:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FCBCB82AB3;
        Fri,  8 Apr 2022 16:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F95BC385A8;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649436554;
        bh=n8OefGfWJmU2Q8NJK8cALcPoHUUvnBG35UH0onnI9ac=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EcFXGi4EbqOJHDbFg8ZvEpnAVrBxeMks1WJbp1Zm3rKiB5/pF2q8aw9RgldfPoYcg
         xlcj0OmYGFP768J/8zEPgPm5lesKu7a2MEd6bvhVXCxVxMQ3G0bdlGHzBuzOmOoM8d
         bXG5CCguMAzGs6+VYPjk90zMdCmKA8PRM78ab3RBBvXALDclKX6tgF5Yl/XYpvNqb5
         Y9EvGpoLwbvGYoU3ByOHuUFmlQ2d4t8x82gBkX+bE6DXVaFKY+TTnGUnOlTjP6z/mk
         F5wa+S24v61tlNw4d83qgzF0h9ynCiq6IeMcKM++Ti4PoM4vthBk25ulKzP+yo1U19
         VnMsnwgOZNPiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28F70E85BCB;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220408145718.166A6C385A3@smtp.kernel.org>
References: <20220408145718.166A6C385A3@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220408145718.166A6C385A3@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.18-rc1
X-PR-Tracked-Commit-Id: 2c7d1b281286c46049cd22b43435cecba560edde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d00c50b35101b862c3db270ffeba53a63a1063d9
Message-Id: <164943655416.24432.10191237600657481484.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 16:49:14 +0000
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

The pull request you sent on Fri, 08 Apr 2022 15:57:02 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d00c50b35101b862c3db270ffeba53a63a1063d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6CE4C4FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbiBYUpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiBYUpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:45:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F71C2F40;
        Fri, 25 Feb 2022 12:44:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D4861A05;
        Fri, 25 Feb 2022 20:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A726C340F4;
        Fri, 25 Feb 2022 20:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645821878;
        bh=TpRW42P3UNrEKPjsDkEiukf7IFfon7bd7xqSv7mHkME=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c711kre2cf35hWM7JSxdZsAMri08As5zp6Blhqwd9qAaDKLbTO+C6CE3DOejXhfpP
         ZRLA1axBdapeUaByQMx33X6obEUUtboB7rTt8ui6qe8xaM326OyplDqUHS4T8RVOZw
         jj2/LzSMby+YVc6lRGUtXubiJwGz7ZKE3rsTXcv2Jx8R0gQ3v/gV9GXMcs8Wh9eeta
         X0B4rPp/JHvN1JjVecc/hbwMUTRFyeYEIsIqRdH+NeH4+Wj9Bz92ktPsvQWbD6O32x
         /aCEF203RLQ+UT4fqrlcEAs5vrwNFPruZr0l8Z9spwiubhon5eDTnzrY+QVlf3IgZs
         o6B3UrOTH86FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 189C9E6D4BB;
        Fri, 25 Feb 2022 20:44:38 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220225165555.702FAC340E7@smtp.kernel.org>
References: <20220225165555.702FAC340E7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220225165555.702FAC340E7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.17-rc5
X-PR-Tracked-Commit-Id: 80808768e41324d2e23de89972b5406c1020e6e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b23c6ecefcc9c15ae3d2f09d529151ab214b97f
Message-Id: <164582187809.27616.7514840842436326050.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:44:38 +0000
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

The pull request you sent on Fri, 25 Feb 2022 16:55:44 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b23c6ecefcc9c15ae3d2f09d529151ab214b97f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

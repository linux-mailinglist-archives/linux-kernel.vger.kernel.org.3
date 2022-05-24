Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5FA53337E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbiEXW1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242577AbiEXW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BDD35DDD;
        Tue, 24 May 2022 15:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2BB2617C8;
        Tue, 24 May 2022 22:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 335A6C34117;
        Tue, 24 May 2022 22:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653431258;
        bh=19ZvQfpIGV2ZftGlzIf7iu9jAwZ9Hq+cnlSjOEN3WGA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BidN7tt8Pn6IctHZ0Bjl8fw087tw6KEdnDpCGHbLYXL5Ooq+8MhXWsA8RyA8VnEq6
         x3xCHvFpDHEJzKQAc+Jcd1gQAWhriWDfT6KYcYb49luI0ZjLAM6T/5KljFFyI2+9K2
         RDnGo+NuG7nBMxLE5s7bCNlJTtFomPY4Lg7En8qL1RY4mLmVeVu4LGH8e7akWWeDax
         bWdM0D9nb86Q/+3AZbuv23XHgVZLUKPShhzuh1dRuNLerRDeJFM8stEQ+3d9+bKh2N
         8pVwCsxYl3Bd1wby2D/vi1WrYRFLptb1IIoGm7w6Fp0hgVFP8GcOl2j/y2JP78k9B4
         BPi7hy7yN0TJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2282AF03938;
        Tue, 24 May 2022 22:27:38 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon patches for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220522211353.1003672-1-linux@roeck-us.net>
References: <20220522211353.1003672-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220522211353.1003672-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.19-rc1
X-PR-Tracked-Commit-Id: 8877ecb0fc8d7662218a8e7ebb0650f320467935
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 076f222a690e11b433d2b1e218dbd9bdb08fb190
Message-Id: <165343125813.3997.17731533979701522120.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 22:27:38 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 May 2022 14:13:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/076f222a690e11b433d2b1e218dbd9bdb08fb190

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

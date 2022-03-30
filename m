Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394374ECBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349980AbiC3SZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350117AbiC3SWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A9A42EDD;
        Wed, 30 Mar 2022 11:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CF9160BAD;
        Wed, 30 Mar 2022 18:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F03AC340F2;
        Wed, 30 Mar 2022 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648664414;
        bh=91UB0IFqmXpvIJ4DT848fqBhJttGUqvJwcHqmWbLDfw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dg6KynI3GlF4M3F19/k+ilWscgL66EX6yXnq282nXhE8WMMtsLQDldnTn7MLq56Ra
         M/T3MknHJ4BOtsMGkRquGDra6eITUiJs7I5n6LgxZYL7kuu+a31ML6izD/r7RMueVd
         bHrff6YSlbb6uFWZyLP10Eldu27nu8lItwE2w5gscDxXCdNwKKZDpjAhYToBrIwi2O
         2I8yN4bXTXsvdR50CocenPRv2R18VrnpPvQiZkfBVWW99cvN9mbsPv76cuCeqAky72
         xmmRTOY2w3tAGsuArw5Wf8F/V2rbGoqOsRI7t1YFlfDkjyVA4wjXioOg9to8Ol2Gue
         TppwQUXgUcDBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED10BF03849;
        Wed, 30 Mar 2022 18:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220330023642.187977-1-bjorn.andersson@linaro.org>
References: <20220330023642.187977-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220330023642.187977-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.18
X-PR-Tracked-Commit-Id: 8109517b394e6deab5fd21cc5460e82ffed229c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3312db01db06ace51bb4934e9de64da62fac3f38
Message-Id: <164866441396.5472.6947530138274710955.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 18:20:13 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Tim Blechmann <tim@klingt.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Mar 2022 21:36:42 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3312db01db06ace51bb4934e9de64da62fac3f38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

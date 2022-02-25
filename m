Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08EC4C4FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiBYUp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiBYUpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:45:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE031D0365
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:44:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 289AEB83302
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9B29C340E7;
        Fri, 25 Feb 2022 20:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645821877;
        bh=WOCc2PQIsQsm/iJx6vyvbC5v8aZhj+zRPljDes6/c9s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=teUXmRsC4qSu8zY0ED/xy5LqPIMKT4mwiM5967D9g6I8UXorkkihqJfhS2W7YY4yK
         Z1KxocVCMU+42nD+cXKPCHYi9H6xtF859zHq4fk7BJL9StlSIBaj45tZZPC6/fYnM6
         GpBQX/MROPr3jBLzdcnof3nrJG9fYZPZLbiO0i693Cn61TUkVq6JqPzdMfBW/IHwyJ
         iHnuACs9s+eT6Q/DiX0sKZ4InjQtTrgsjeQfXdNEerY80ov0QyJzq1mIYONJnPCKYW
         IuKG2nLfZe6VRIuNceqBzU0k84WvoBfQjPZ6abnefPji40AM+cl7aRxSqQZKugLWTT
         MZwRNWiSGgA5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC499E6D453;
        Fri, 25 Feb 2022 20:44:37 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220225165516.678CAC340E7@smtp.kernel.org>
References: <20220225165516.678CAC340E7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220225165516.678CAC340E7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.17-rc5
X-PR-Tracked-Commit-Id: d04ad245d67a3991dfea5e108e4c452c2ab39bac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e9894e6aac2c591da00dae91c448c02d1ca6373
Message-Id: <164582187770.27616.17600137215496809938.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:44:37 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 16:55:04 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e9894e6aac2c591da00dae91c448c02d1ca6373

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

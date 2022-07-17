Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9965776E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiGQPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiGQPGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:06:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FA7120A8;
        Sun, 17 Jul 2022 08:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0A6B2CE1027;
        Sun, 17 Jul 2022 15:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 985CEC341C0;
        Sun, 17 Jul 2022 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658070377;
        bh=mYIRy6jXcHV8VZxYmRjw1YEHpJ0lpz3O6PWl1fvlM+w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fS6eT+jeTMm1WCcNImt+SfbAnKwTnwE53ODjDerlPtC0YkC0HV2k/SZs4ak6BeiOW
         xRhR+87Rz1Mcol0rIZtL+ufmGm6hY4FTbGxYAqrenUVUgPs35SV3NK/5ww6z/YuXu1
         s0LSAxhcjCupnQj1QjeqtI2lC5WW9OYV0D5CH1PXGHlpoENB0Ec+yIsIXpw+SJZeNr
         vTKqYLA9b8VmbCsQQlDlbHLQdA3EX14VttH133JGmjiUDurf+MX7nJT1NCiXPkM0KV
         T/swY6gtjDQ+JZaD5AAjeLCCzS6qHl/6tk2go8TT1mI5XLcU5hFPGsTt5uGQZ+CveT
         pQ0uPkaxU/Txg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84856E45225;
        Sun, 17 Jul 2022 15:06:17 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 5.19-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220716232446.ndivv2hcrufezcz6@mercury.elektranox.org>
References: <20220716232446.ndivv2hcrufezcz6@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220716232446.ndivv2hcrufezcz6@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.19-rc
X-PR-Tracked-Commit-Id: 093d27bb6f2d1963f927ef59c9a2d37059175426
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 396df7005ba0f02646e96e05456a14b52e0f02f4
Message-Id: <165807037753.25191.8873801509077197045.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Jul 2022 15:06:17 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Jul 2022 01:24:46 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.19-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/396df7005ba0f02646e96e05456a14b52e0f02f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

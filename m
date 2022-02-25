Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C594C4FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiBYUpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiBYUpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:45:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EA01D306D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:44:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A5962CE27D6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0D25C340E8;
        Fri, 25 Feb 2022 20:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645821878;
        bh=7/E/0fdNCInS7CQvAsn8w8LNc2epMounittDJlNyDq0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=txGYtJc5LutWEofGmQEVkQbgd2JZz9j3/qJkFXuZIvN6myzB5wZuUaIk70bRp+V5i
         E5qCzzyiDEYJA4ekgYmfLkUBQkOTHhOlIfv+yRt+7EBsiKgkZx7lIpi4lysHK44kUA
         3sqDC3JMNopU99W8Lln2SuLUJjCNnC4cD+7vXDZpxCHUfE+M8cxZleg6glvczekZFc
         wwfYkFuooRIcbIxWMcDGU8mVNUdDQUq4Vfz1qDaTLhr85KNLiGeMqaK/px7kUjKMpO
         hJBsjfygk6eukQJFBjn3f4VU4a6wuj1Cwath3h6nrOk3UEQM62wq9qlZNSCWhrgwq2
         f2meQF+Gkz+5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8F28E6D4BB;
        Fri, 25 Feb 2022 20:44:37 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220225165537.E9E91C340E7@smtp.kernel.org>
References: <20220225165537.E9E91C340E7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220225165537.E9E91C340E7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.17-rc5
X-PR-Tracked-Commit-Id: 9c7cf33c53ce833b58de9e5c192b4736dbd09cb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64b5132b897caeb4188fcbafd46fd73dc96be4a8
Message-Id: <164582187788.27616.15005278999997821608.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:44:37 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
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

The pull request you sent on Fri, 25 Feb 2022 16:55:23 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64b5132b897caeb4188fcbafd46fd73dc96be4a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

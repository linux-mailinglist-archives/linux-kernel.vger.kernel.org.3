Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06942578A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiGRTTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiGRTTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:19:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB802ED40;
        Mon, 18 Jul 2022 12:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25E4CB81705;
        Mon, 18 Jul 2022 19:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA6D8C341C0;
        Mon, 18 Jul 2022 19:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658171974;
        bh=5JaMD+HuAu8izb9UBXDSbl43MABbjBtiQasG7N6IfHU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NRUO+OOC+A+k1tBDxLh+5mCDFVBz5lG8GH6NX865wkFjfEVuD/VAGVOXBnCi6Fkis
         nQxtJTgiM9UDhxGnm2se3Z87KKgSMoLfnF/q+zzEELZcpeUoYEmOoLo7iMj9Hp6Ukc
         VgZvu7bisBQqlhHjgommaZW5v3vAhSWv+3bGJ8WlgnvsYWNnPmb/BdswgpKFzbStHs
         KfoibyOVbxHcn9NxtWmfrbk3V+NLncLXTx74HmKCvDQJLYQMLsBNVJSehhAkEl1d1K
         SiCPJ2+XEAbM3zrL7q8y4DjW/eozJ6XKOOPWde+HPk5aVvWnj1G/+uhLo6ElS3ekMZ
         jeM3vk3kc4Snw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C32CDE451B2;
        Mon, 18 Jul 2022 19:19:34 +0000 (UTC)
Subject: Re: [GIT PULL] hte: Fixes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220718175145.1945060-1-thierry.reding@gmail.com>
References: <20220718175145.1945060-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-tegra.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220718175145.1945060-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/hte/for-5.19
X-PR-Tracked-Commit-Id: 85ff37e302efdf173cff6d1a310c2f7f38f1d069
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80e19f34c2887a8881084b7bb7480e9544d56b91
Message-Id: <165817197478.11636.9862062654333129934.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Jul 2022 19:19:34 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dipen Patel <dipenp@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 18 Jul 2022 19:51:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/hte/for-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80e19f34c2887a8881084b7bb7480e9544d56b91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

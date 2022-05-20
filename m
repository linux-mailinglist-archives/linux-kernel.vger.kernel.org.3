Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB2E52F30E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352902AbiETSgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352814AbiETSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:36:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B34E3BC;
        Fri, 20 May 2022 11:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25026B82D77;
        Fri, 20 May 2022 18:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6DB3C34114;
        Fri, 20 May 2022 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653071782;
        bh=dEOQIT7ynCC7SaYMlrL3ioz9MUqf2dL0s3gA4Tjs9D8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=olF+iAjxCrH03mMgPNohsO85KaP3HQivf2QWCyEtu/7WxzhxUmrIQF+gVwZWcfzzo
         9CQ9zKt5q/7mnPZAElXpsYLo1udQAqjgKtGSUnMfzxd2VMk5NMu5+60UFEJdgKxsD6
         DpyYFkWA8LMkigiST5haZ2hC1eTJ8295CwvT8mBS0TVbdY9+But39ThVPXM68JqwrW
         ZB0nr2yDgilYB1sYM4CpmvWHnzv5cm2cCgjrh/HKH5QLkDf63V944kGujiV4Pkn+lO
         KTrLPhUaRIvhtQw08P96n0r2/YRgXEnKfGeRx4ZL9jvMk5ROiV54V6maDJFnMwdKTt
         t8TkvhftNVhtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7B9EF03937;
        Fri, 20 May 2022 18:36:22 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.18-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220520123625.46331-1-ulf.hansson@linaro.org>
References: <20220520123625.46331-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220520123625.46331-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc4-2
X-PR-Tracked-Commit-Id: e949dee3625e1b0ef2e40d9aa09c2995281b12f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 317de3dbe2f16eb732de685cf49390349ecff2f3
Message-Id: <165307178274.15282.5846610142505705559.pr-tracker-bot@kernel.org>
Date:   Fri, 20 May 2022 18:36:22 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 14:36:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/317de3dbe2f16eb732de685cf49390349ecff2f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

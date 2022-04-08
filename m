Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27DF4F9B04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiDHQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiDHQvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531D35275;
        Fri,  8 Apr 2022 09:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5D516211A;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2626DC385A3;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649436554;
        bh=asfFPVE4GWVSvyU3lTGK4Jym4ERe1Og4JwpM9nhJNYw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KCIoz4n4lbpwuQyeDN5EJijjJtmO5qjkpK2sxosLjApIBraw8w/YB8E6i+WYgtncE
         JPfkEBHq79Gqn0dtVu9785wZ9VVHE5A/z2CRCRRLGUyENxuOGnqYZVGN5WDGoLUgMy
         keFsxhjdXz4fyOAxp9G5JyIGqkqSvSA0ZjKT/kX37Rl591Nodzp6AwsW4UvBfhztIt
         g0/N48DbpfShExSC8N5Tgl6/anU/g1qJHVKrbAzEQf6ru1rwJRFFfsIHubV9Dhrivq
         3PQtSDArcTatnS+IYiwXiTJsmjN+I4pbzcV9hmZ+R1JJasMCyBDC/HJjL7DPy1YCiO
         y7PtmBJLIngKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07212E8DBDA;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220408140654.119255-1-ulf.hansson@linaro.org>
References: <20220408140654.119255-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220408140654.119255-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc1
X-PR-Tracked-Commit-Id: b71597edfaade119157ded98991bac7160be80c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ccab01401c89cc846913fcba6130f76034624c0
Message-Id: <164943655402.24432.9494439471398652257.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 16:49:14 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  8 Apr 2022 16:06:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ccab01401c89cc846913fcba6130f76034624c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

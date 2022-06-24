Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3835355A34E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiFXVIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiFXVIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48EDFF7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4853762373
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B095FC341C0;
        Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656104886;
        bh=naPwGNaPpaFVVsgjAaBGhFwA3PUwcfFRiUHy8SWC0Kc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PRh6WkUFkpas5Xv4mUjMn65Ue3aPM4oKSVkZ2dWX+SsqFVktxEov5Sqo2smfW+nXi
         fL6UEjEtZOuoLi4d5AIQmaGeENY64odmQ74vD6oNtdR46xU1LO3/qbo9gzVb2QVwzc
         CdHVz0NGH3+G7CjIIC1K10AldqPdiLvnOTBDyZEjTyzb2ZUJwbQ6gpTpakvXvdjhlj
         fo7KFDdTOzkURDMiWMhSIhMn5d+N4dZ+xY+aTcE2VHzjlgXECCK8jTp5JcAX4yOnig
         LutmONjc2c/oyR3ilruOqe8pzAfqmTrjeUYZNtS6CVy1idI9LJJa8899TXm/L+Svur
         LOaf6J6qiP9hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91896E85C6D;
        Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220624165338.79927C3411C@smtp.kernel.org>
References: <20220624165338.79927C3411C@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220624165338.79927C3411C@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.19-rc3
X-PR-Tracked-Commit-Id: 3f05010f243be06478a9b11cfce0ce994f5a0890
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bc83546079a378ce91ef83fc2c6da195e9df0cf
Message-Id: <165610488659.13803.17929609208178128641.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 21:08:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 17:53:28 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bc83546079a378ce91ef83fc2c6da195e9df0cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

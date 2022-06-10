Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04154546CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348051AbiFJTAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347008AbiFJTAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:00:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBBC2C27BD;
        Fri, 10 Jun 2022 12:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1185E61EA7;
        Fri, 10 Jun 2022 19:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68FF6C34114;
        Fri, 10 Jun 2022 19:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654887636;
        bh=F4a7BtqRfxfc2nXQbMRSKR8Ni/VWaZ2oAhg+75yLm8Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rmVEJTU5d1kYAK9EYz2amBkRRA682V6ufo0fgeAgAyp60UCo9ZLqO8ABHYMSwAssk
         BRH1ITq90PEmOBRxbLSJbHeWYY0PWZEIbt52iFhN3PgFlL3JbTT7M0/XItA64OeVYi
         ScyvfAi2u09aemv95UKjGY7X/3IrSPL1Jdsg7gqRnbQY6VEJ7jQRCyRk+39lAeptFD
         nMuVTJ4VK07EVWD6Z5We4XYxHF4Ae9QjoqlnyG7zNVnIiuNnku8M1K5i7a1vov79BZ
         BvfwLtVp2I6neh86J7ulOM3FSSPq4MUK7bkcF3lnAw1Z2txCh+MPGIeMHhFuDsPpXM
         ymRRC4oFH4BqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5512BE737EA;
        Fri, 10 Jun 2022 19:00:36 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.19, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220610185457.GA2005396-robh@kernel.org>
References: <20220610185457.GA2005396-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220610185457.GA2005396-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.19-2
X-PR-Tracked-Commit-Id: 0b9431c8221cfe73d06f6b9cd37b813fa52be8ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa3398fb4b3f67d89688976098ad93721b6d7852
Message-Id: <165488763633.19537.9517015664730364180.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 19:00:36 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 12:54:57 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa3398fb4b3f67d89688976098ad93721b6d7852

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

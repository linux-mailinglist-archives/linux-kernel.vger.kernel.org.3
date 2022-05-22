Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCCC52FFF0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347942AbiEVAWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347812AbiEVAWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:22:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0052B3FBC2;
        Sat, 21 May 2022 17:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB655B80ACD;
        Sun, 22 May 2022 00:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69BA9C385A9;
        Sun, 22 May 2022 00:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653178950;
        bh=S7aWvg0W8yGCjlz05fJEcXjRJKVxbyiFhAoewJ4N7UQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XXxePaPyNL59MEd0UktLo2zLruViwk53NynG8LvQOPm26AuQzV+qYf5Yw2FxqOd3b
         sMj5RO9uAB4RKb2XmjrjdG798tWBnpLsrPFqjCFa/3TgriVebyEsTOm1St9QUoBllv
         1M/tLfNBLcp+4QO9+TeW2ARPc1uMpXkKP+at5LdCgP21AqYTtRo8t5B6z8/ekcZm4v
         +7pWdfkmi7UUKMQ2CAuBBfH+oT9HIx0tJ6rUKcPsYIqlSSp+7JvOMPCr++f7waTcMV
         +XO2A3xRY2wXHPUMhtq6JRLgbSvtengeEBSZiUUG4Mr+qDrdTiyVGa+Hzq9VuWa+Gr
         WP779py9q0Dhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55FD2F03935;
        Sun, 22 May 2022 00:22:30 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YolI/0sPArJSnlIZ@google.com>
References: <YolI/0sPArJSnlIZ@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <YolI/0sPArJSnlIZ@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.18-rc7
X-PR-Tracked-Commit-Id: b26ff9137183309c18cdfe931e1cafcf3c1a980d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c493b1a41274c3f9b754036cd8431903306cdf3
Message-Id: <165317895034.14812.10838795355484600283.pr-tracker-bot@kernel.org>
Date:   Sun, 22 May 2022 00:22:30 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 May 2022 13:18:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c493b1a41274c3f9b754036cd8431903306cdf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

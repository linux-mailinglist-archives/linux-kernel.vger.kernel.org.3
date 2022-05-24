Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E543C53337D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiEXW1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242562AbiEXW1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:27:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2B35855
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:27:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC1D3617B3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C610C36AE3;
        Tue, 24 May 2022 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653431257;
        bh=0/gdY3/qf3nt8CaGhYiLvknHYmLj9oilZf94ifwRrcw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=npxK6HKQH3T7GmYI1wyOHNYj01zx3NQ5oB4vUe9gJXqxq3ga/CKlsjJ90cgJkFDaq
         dXoH+Ew3pi3drWepkvXs+2MU4tqGe5V9wOd3yCvhMg48iQXerKt8ejzIhBAWefsczI
         yX6ae5R/j0Zs/FFEIeOWXOkwkiWstz8xw2td4hgdskEVZx1EmvS4AV8EZ64wmMM9JD
         +wFBLDsWO6NTjkloEnW31nidQNJOOb3rniiznI8aoNqb3XQ4QaW/czN2RQpY6i9JPW
         GyVwfh3EcNRK5zo0sBDqXYiWYIgiupn8GVdQGbO0obYU7XBYfrpzXg34F4gMD5i5e9
         58mfcW06hpj4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B19CE8DD61;
        Tue, 24 May 2022 22:27:37 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523112459.29000c2d@xps-13>
References: <20220523112459.29000c2d@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20220523112459.29000c2d@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.19
X-PR-Tracked-Commit-Id: 2c51d0d88020b4d3c9bbe7d9df2796b2c2ce05b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d335371940179318df97d66baef13987ee6e796b
Message-Id: <165343125723.3997.9953251172151290451.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 22:27:37 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 11:24:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d335371940179318df97d66baef13987ee6e796b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

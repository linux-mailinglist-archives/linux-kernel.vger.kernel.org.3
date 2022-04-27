Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C54251205C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244085AbiD0RZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244083AbiD0RZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:25:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B346141
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B49A561E24
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21038C385A9;
        Wed, 27 Apr 2022 17:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651080141;
        bh=C17umZ80pqXyiS0BNYvHMaWCnzCctB6Ewy43lndyjHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BIxihUk5AmTF3yOpHk3hEC2BRKRdETtmLUJDSWWuAO4Qljx02yuSurPpsTiPBb3rW
         Pan1xF/8JgB2bTQm6MjEDnEBhJudY3UPpqUONc2uWli3idQtU+g4EPL0nZf9WTPkbf
         E0lOE/py+Z/k9gfSx92g0qJIOjpeRKXbDc2KNRGgDxPJmdOwxsNkXZAdhqgFwOBQjZ
         69jn4IzVUPeMGGWjSnE+rXkaf2TF+MLnRIV9Dzm++EsU9Gxg1FWECNsM1loBAWuoWu
         +fH7glqMxRaTm7NHrLTgNwn0ylD417dpKgCs8hhHC5D7PInvOK0fCpeNwu7ZuYcHiH
         LLv+Ct9tq2pEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B41BE8DD67;
        Wed, 27 Apr 2022 17:22:21 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220427114222.75209cb3@xps13>
References: <20220427114222.75209cb3@xps13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20220427114222.75209cb3@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.18-rc5
X-PR-Tracked-Commit-Id: ba7542eb2dd5dfc75c457198b88986642e602065
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03498b7131b874166724ca016178932d0b5781aa
Message-Id: <165108014103.26868.7126308954756150435.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Apr 2022 17:22:21 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Apr 2022 11:42:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03498b7131b874166724ca016178932d0b5781aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

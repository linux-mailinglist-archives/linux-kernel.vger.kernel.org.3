Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3A58A507
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 05:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiHED1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 23:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbiHED01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:26:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844111D0F3;
        Thu,  4 Aug 2022 20:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04A6560DF4;
        Fri,  5 Aug 2022 03:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66B14C433D7;
        Fri,  5 Aug 2022 03:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659669981;
        bh=9Tod/kirw+6lP0s9IUJdo3RTG5JbPnbDznD0hOHgNPk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=So5xsCls7Tc+ZeoyMU5zSGOtwcmbmgPhXyxq1nrScsM+/FXNz4ZCLrcYDhvV7wVkT
         GMM470FmBO1DPf+W1i1ahsGKeAgfxkSBCkoYZ1zB2Wi8JyWJV9o6TVCwJLm6HT6p38
         QWnSWqhl61bf0XuE8+wYhPkYmSjb7rgz35/f8KMdBMBqg/oNnpyncJUH50exSLAYBR
         3n8lljYsDyRO5k/XcTBSEuYLSZGFsffwvY146hq/OND4YfN24thOF0xpspIMJHY7po
         fu3nPd2XkwGdyj1MJzQkQZzMS40wV5C91Dt/MAcN8Xp4SscgZAA/15i90yEJhzjMWp
         ILrDg5hVDmf/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5724FC43140;
        Fri,  5 Aug 2022 03:26:21 +0000 (UTC)
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.19+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e8b94928dcadff82e7b7eabb80f75ed12fc1a394.camel@HansenPartnership.com>
References: <e8b94928dcadff82e7b7eabb80f75ed12fc1a394.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <e8b94928dcadff82e7b7eabb80f75ed12fc1a394.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 8fcdc238ce1b492e1f57a73a2ce4131d63f45397
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 746fc76b820dce8cbb17a1e5e70a1558db4d7406
Message-Id: <165966998135.9883.13888364317460181969.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 03:26:21 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 04 Aug 2022 11:14:10 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/746fc76b820dce8cbb17a1e5e70a1558db4d7406

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

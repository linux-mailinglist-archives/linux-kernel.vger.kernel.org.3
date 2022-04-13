Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E87E4FEC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiDMB1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiDMB1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392962DD67;
        Tue, 12 Apr 2022 18:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB857618D6;
        Wed, 13 Apr 2022 01:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3749DC385A1;
        Wed, 13 Apr 2022 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649813091;
        bh=WhlDFinBh4vmtooro06L+WOsfE9MytUf3BRTPx/YISc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uNztEsZTcUVuzSlUNai7Vi9d9dfVLMG5muMIhL+F+6Qe1mGlDwUa1WRbH6sBDzUHX
         p4WtveHdsRnl9GPcpG0fOf8Ddga60vrel3ZwKUz1KbtJz0fAQPYmPnE+1R91aXmYaO
         x+7F5AE1Ty6axiVpIT5KzSDyMNYF0W92Mqlp4QQh/iTj65HjG6W4nr0HfBuLKLA56i
         HS5i4fIaicPQRc/cVz755+b5bC1FRlRyRCdlk1sKtqPhDM7xHVY0UTQxwPQdV0wGrn
         o1ODgnAJvSjtyBswyUE3qDbyqaHENWB14AYItSb/UDAbq/c1NLnY5OZFiwidMfZVlL
         ryoXW5IOVRlGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B1DEE6D402;
        Wed, 13 Apr 2022 01:24:51 +0000 (UTC)
Subject: Re: [GIT PULL for v5.18-rc2] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220411233714.448cdc01@coco.lan>
References: <20220411233714.448cdc01@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220411233714.448cdc01@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.18-2
X-PR-Tracked-Commit-Id: 3ae87d2f25c0e998da2721ce332e2b80d3d53c39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7083b89ef3e9a6ec362585026f81cb165c51b78a
Message-Id: <164981309110.9925.24954998548446455.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Apr 2022 01:24:51 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Apr 2022 23:37:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7083b89ef3e9a6ec362585026f81cb165c51b78a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

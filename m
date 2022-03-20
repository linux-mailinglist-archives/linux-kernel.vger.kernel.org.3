Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4844E1D00
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 18:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbiCTREg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 13:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245605AbiCTREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 13:04:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89604186D1;
        Sun, 20 Mar 2022 10:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E643B80EE8;
        Sun, 20 Mar 2022 17:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E198BC340EE;
        Sun, 20 Mar 2022 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647795786;
        bh=LZ8cS+UI1HymolUMFov7+mXDFuMsK0sFHs1abitcohg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X1LOaeKiH9YodIdUATPttRyYZwMW8kd/slBGFao4t4ZGm9743OAZmTU9LTU3IKP4R
         0IG6rwMN7WcgWv1PTgteRSHer8uQI1LqQDjmHx3ZzsbunRLEcjgGNR0depGBDtvLty
         okAHxzBk1OX+/7OvhSjs5dCoIj95Rze0TwOH3Y8l4l8lbctXzCQD9CIx9QP3uhYgOh
         mLCded2qZsZpsA8EBnoYMCt31bSbqJ6NNWhnjW7z6/B9jJBosLMZRNPuTge+gYIVGU
         e70G1dYy59/iLGq5JoCvZKvsXWrgviIi4Re44jAdB1imsJbg4PKZ7rJoHEwYtSGx1+
         oJcxeEyuxqM4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCA01EAC081;
        Sun, 20 Mar 2022 17:03:06 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.17-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjbOCoICMH/mL9rx@google.com>
References: <YjbOCoICMH/mL9rx@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjbOCoICMH/mL9rx@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 5600f6986628dde8881734090588474f54a540a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e0e7a6a28f877312b93cd12a1448c8d53733b55
Message-Id: <164779578683.15217.12789709191870031695.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Mar 2022 17:03:06 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Mar 2022 23:47:38 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e0e7a6a28f877312b93cd12a1448c8d53733b55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

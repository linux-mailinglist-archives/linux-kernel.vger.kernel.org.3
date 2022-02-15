Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901284B7871
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242418AbiBORSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:18:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbiBORSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:18:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFF2140DC;
        Tue, 15 Feb 2022 09:18:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1909F61575;
        Tue, 15 Feb 2022 17:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B812C340F0;
        Tue, 15 Feb 2022 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644945510;
        bh=loJNfziP5x5OSoelOJGo2doEquGsGTCzrWIiC3mF9MU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OZxIUtehTfs6hE5EWhpCsfXL4xPXGuD4ttRGWUoSD5MP9Ehdx4h91J0ZTQqZKbKiL
         DxWgt9jxJ6YOFqLe0GTisVfeBLxmqabVOrqbKlXtJZS4kCbMLRf6iadEfEEaCH0BW8
         Rn43/7c8N6ZVLGgc5TeyJTbLRgxN12dm3LdqYU+UhRKQkHZRDd1WScT+yDCrVbIhJP
         AKQD4azKmDP7ld00/en9A9hQK+SCgNHnFubcEJFT7HQjJTttGlRehNEHPJ2iibSSph
         hFqyK1kFL6Ui/+3JpRJNR16McHJVWONJqS/XrZsQlVYlamWYIaZERq7DTMqdqMLhub
         pMfipGFGnFb5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6792AE6D458;
        Tue, 15 Feb 2022 17:18:30 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YgvAdaab22aRk18r@ls3530>
References: <YgvAdaab22aRk18r@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YgvAdaab22aRk18r@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-3
X-PR-Tracked-Commit-Id: 6e8793674bb0d1135ca0e5c9f7e16fecbf815926
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2572da44a51192ad181482c1989e66e5eb47dcbe
Message-Id: <164494551041.28256.4169809147321829116.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Feb 2022 17:18:30 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Feb 2022 16:02:13 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2572da44a51192ad181482c1989e66e5eb47dcbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

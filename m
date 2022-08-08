Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97A58CDDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbiHHSnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244485AbiHHSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C9644B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D184A61269
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43CC1C433D7;
        Mon,  8 Aug 2022 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659984129;
        bh=nDBZ7+jqRiC7ltkTNVo9XxgU9CuLvcDeNwP2VctjY/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hJ86FNABNKYawXYbmVACymxPmU5kHIsFThtH+9i/XCToRF720ti7C6Ii4XBgvJqmn
         z8DVh3GfC2PPQp3w4n6FuXvIbJsnVaqpAO6LPyXNUC35CAcx4XS0y8B/2Q5nuWNRp3
         oma8qY5OI33ZUzC9JyOF2Vn9I9n1BaQ6CAAIHTk/JZpLEoI6xYJ5kcgfGAFbG1IO7K
         /qlBmD/C0/1eeFYDea7PQi69KsPYHFZ8cKEHxoOS11jEn6A2Fmm/oGEFAuagnQwbUV
         pygDXq6crCTQcPCPEDKDj42oZbogo8IFxhqHaHakwZCseHIs0XtHhIaZtXOW2nKFV7
         Y5g8nupU1Nbcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 243C3C43143;
        Mon,  8 Aug 2022 18:42:09 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd_tBecDJSiJF0LLRzkC5UfwzXVU+mvcBn-7+e1mzbgagQ@mail.gmail.com>
References: <CAKYAXd_tBecDJSiJF0LLRzkC5UfwzXVU+mvcBn-7+e1mzbgagQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd_tBecDJSiJF0LLRzkC5UfwzXVU+mvcBn-7+e1mzbgagQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.20-rc1
X-PR-Tracked-Commit-Id: df13a3477635414f243d53344bb4b510385e994d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f72fb74b8218f9aebfcc691b7e9bb641920dbc13
Message-Id: <165998412914.757.13811333358933697594.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 18:42:09 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Aug 2022 21:16:25 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f72fb74b8218f9aebfcc691b7e9bb641920dbc13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3544D5334
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbiCJUq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245438AbiCJUqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:46:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB93D13D57F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:45:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40FCDB8282C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3A3FC340E8;
        Thu, 10 Mar 2022 20:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646945119;
        bh=mhUtbM3wRrn6Skgaj5bIvRY3lwKfocab/Xwf8+Q1hvQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tl3Ft+UWBYJGb3dw1ibpB8YfWAremrjvriOkjc7H08WgWt8eBc5yFRgNsZy2VDkHe
         S4R1AD/yc+RbgntRWVAS6io9XTWgo2SN9cDm2MIec9tdQl1FV/4svkJj18HQWx4GT7
         Uj15my7BrtQp1bx4388bZcFG3rzwhSfMNiRLIKs16rYDO4O6xPPQElQ7fSlV0b8wFb
         dK8T5W+pMt8Ibtr5krqzUtvDBfrFqAP8sOlbl/PspG4KOXK/7MClEXJSQ6F6u4zDU6
         kVvvhrJKkwzfhWug0Epfs7D8sdZVJav+kh5YCDMVyQlVaSO0kw2OzpqrWsxfeuuMno
         /Z4HCGnZObbqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEBAEE5D087;
        Thu, 10 Mar 2022 20:45:19 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 5.17-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YipceDbnLhoJKnWW@kroah.com>
References: <YipceDbnLhoJKnWW@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <YipceDbnLhoJKnWW@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc8
X-PR-Tracked-Commit-Id: 342e7c6ea58200e45bcaa9bdd8402a5531c4777e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c30b5b8cfb72cc83c10793588ce94471a4769409
Message-Id: <164694511983.2368.7024714747924479553.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Mar 2022 20:45:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Mar 2022 21:15:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c30b5b8cfb72cc83c10793588ce94471a4769409

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

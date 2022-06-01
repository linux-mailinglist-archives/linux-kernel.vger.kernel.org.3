Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA053AC45
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiFARz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355963AbiFARzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:55:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE78194181;
        Wed,  1 Jun 2022 10:55:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6653EB81BBA;
        Wed,  1 Jun 2022 17:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09F84C385A5;
        Wed,  1 Jun 2022 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654106150;
        bh=MLr8AMawc4C1Yd/HPD7cttpmEtgnwSe6B2HsG+8LnBo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UjaGDxBemEWegjO3Uglpf0pCYBWtYCnI+HO+S38JDTFlaWGwT8a8GqAId5q2vmkTO
         WN1p4jzb3mmY//uAKmvKl6BhhqFk+vQL6dwsCij9I2AGDjlOcPGbdyBdayeQN1BUjl
         kckECLquIPQ/8fHOtfPj9wnbP88yB/y+ioKDnH3k3srLGwaJ9Yx8cFPm/plMaQfyp/
         Ga4/W75xi2yATvXcK0ZWdDK+Ur5Q0ywynahueCPXn/FzW7LhkP9y2D05GsrCWNbumG
         UYKwYF014yRTQr7gChmKasJWjQj1OibowagHBnto9Uu8jAB1KDHcSJ91tSVyLtrD0/
         0tQP5o109TVLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC62DEAC081;
        Wed,  1 Jun 2022 17:55:49 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220601143839.3893139-1-thierry.reding@gmail.com>
References: <20220601143839.3893139-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220601143839.3893139-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.19-rc1
X-PR-Tracked-Commit-Id: 3d593b6e80ad2c911b5645af28d83eabb96e7c1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8eca6b0a647aabea3d1d2907dd6245fc436f98e7
Message-Id: <165410614996.7706.1482182484083714794.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 17:55:49 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  1 Jun 2022 16:38:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8eca6b0a647aabea3d1d2907dd6245fc436f98e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

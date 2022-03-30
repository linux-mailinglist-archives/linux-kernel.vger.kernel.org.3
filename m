Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C9F4ECBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350446AbiC3SW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350314AbiC3SWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2745AC3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1748060F84
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D20D4C340F2;
        Wed, 30 Mar 2022 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648664414;
        bh=TqUtCGbVl7S3CC2RwlX8WMCuZ1lYrt6u3ONUTwoDxV8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FCkNm9fKiJ53bODuMehtfTcriMFXehN0WIYUO0KWD6UqPKUX/u9wdrtvD0x+ghB5m
         5GwJ1nbZQTJJoQ+JTLMYcyUj6iZHWepmCGEQK8NOSCPuTV18vO2vqBDi3plSYtLjq/
         M9W5fV/Q+ZewbA2qGlWLzlk67Tv8d44LxI/eU7PPlcT50aGK3a/jgAW2A0QzhwoQy8
         1NKNXWVkJDlbK46dl0Lk+lhoelQEhpqwxIq87i7YcQDWXhDi55Tghl+z8TIPENmR5t
         enbsB2K7jwDEEISK/kxwy9jYKj7eQBVVF9TSRyX2Xut2YiL7lWHV+UcsGQb8GzCX2o
         DwpNyIc5IWgXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9229F03849;
        Wed, 30 Mar 2022 18:20:14 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220330115736.03D86C340EE@smtp.kernel.org>
References: <20220330115736.03D86C340EE@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220330115736.03D86C340EE@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18
X-PR-Tracked-Commit-Id: aefe5fc3000a24869edbf7bb657adf28372ec158
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f3730117f162b17147795eaad44421cc65178c7
Message-Id: <164866441475.5472.13042695329571080357.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 18:20:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Mar 2022 12:57:21 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f3730117f162b17147795eaad44421cc65178c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729AD563A62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiGAUJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiGAUJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:09:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34DE4F1B5;
        Fri,  1 Jul 2022 13:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94303B831C3;
        Fri,  1 Jul 2022 20:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44526C341C8;
        Fri,  1 Jul 2022 20:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656706188;
        bh=2lGxWEol/mvUPZza0odaYG64YzShIQ2TfirLTGkKdbo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nbZHiqZbqWJcNyhs6Cl132zvhcGlq4nf89Z09oFgz56AT9r3xDKzX7/Zg0aiyoCZb
         ulCq/tmOb3vzcr2qvhx5pXUuvXJip+RGzCFnvFpupTObUbKovU+3MAPy3B5RCF1Vwz
         hv7vl9TmHKBedSqO6d4kcNtlfKSw8Z+tzfa06D6RYkyXtrmQk8hXv+iRdH3mgRmGiH
         osWWUTgBZgAzrV7PB0CD7AiJ7PJOOEKq1ZLzEKJSnINbpXHveNa8P3AvOMJmrncz1b
         Y0Fn1pGM0BjUMNojU8HqxUZrrg8lHPOkgshbk7bGdFVVu0+a2HNuUMKMdwX9tUOppF
         bFhxBgOGnL38Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BE68E49BBC;
        Fri,  1 Jul 2022 20:09:48 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control update for v5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jKzEmLLUnoSBDZawHmm0NaU8v4KC+QLVKh0DvhvLbzjQ@mail.gmail.com>
References: <CAJZ5v0jKzEmLLUnoSBDZawHmm0NaU8v4KC+QLVKh0DvhvLbzjQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jKzEmLLUnoSBDZawHmm0NaU8v4KC+QLVKh0DvhvLbzjQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.19-rc5
X-PR-Tracked-Commit-Id: 62f46fc7b8c639bc97cc9c69e063c40970b6e14c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ce8c443e95698cecc32cc8ed5ff4b72da61eed4
Message-Id: <165670618817.9587.17709412715634209709.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 20:09:48 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Jul 2022 21:55:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ce8c443e95698cecc32cc8ed5ff4b72da61eed4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

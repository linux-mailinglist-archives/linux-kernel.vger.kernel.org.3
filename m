Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4DE5090FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381898AbiDTUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356700AbiDTUDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:03:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D83D1F1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0363E617A6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 673D4C385A8;
        Wed, 20 Apr 2022 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650484820;
        bh=yExGq1YU6tLczqxA/fli9OOpheAn0JRxdqvYfn51/E0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Bg1fRdgmbYK4G+LlW7OVfwzEBHgQ9DNA4EnCQrkx+ZbjkeNr0Ny+qwFoz5OqOSa9/
         gatEuqiXHk/lSPwoxeaoMVpFeO7ivn8v+TaEqPBhoFWkjB6sJqcajXm91/GtKfVQR8
         YJPU4+GG/teDM8sIZhdrYQVCm6lOs+4ykeb0roQdbUcfKbM2m6KDDhp1DHVbcV+iqO
         tygFlj9TGWOGO8LZ/NZBgH62I49X0ttyYyKV4hGsqClj8yqhMReQmTewRpAcIxvlXs
         3beIVG6aEtlf/PzZ6yEgF2AInmj6knIAC4x7FZC/M7d1YIBPQz8hWYgQ/bw9FTtROP
         9/CH3vCBi51FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FBE0E8DD85;
        Wed, 20 Apr 2022 20:00:20 +0000 (UTC)
Subject: Re: [PULL 0/3] xtensa fixes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220420061611.4103443-1-jcmvbkbc@gmail.com>
References: <20220420061611.4103443-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220420061611.4103443-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220416
X-PR-Tracked-Commit-Id: 839769c35477d4acc2369e45000ca7b0b6af39a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b253435746d9a4a701b5f09211b9c14d3370d0da
Message-Id: <165048482032.8655.17694839536231994638.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Apr 2022 20:00:20 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 Apr 2022 23:16:08 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220416

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b253435746d9a4a701b5f09211b9c14d3370d0da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

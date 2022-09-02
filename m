Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC35AB837
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIBSae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIBSaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:30:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7145C366
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADCFFB82D07
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 18:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60ADAC4347C;
        Fri,  2 Sep 2022 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662143408;
        bh=VZL7x4fiFihyUNnHvWEbZ16JY0mId6o3BwIXs348NE4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FRdA0JbpdR4LsEd0sVj9NOwSo81vTUSa/g4Tx5B3TtVh9BkSP1+mO1+kKMMAJVcgT
         5U4MkyRMMHA6PslMSGj5l0xFzgammXpxKYQDNxhffKJtCtAa7oxoMlZHDgoV1n0jKU
         XRcZD3bC95KVQlkHPnDtAHGvmflUikAAty0jjzCGWOjnK+nq+axTS7oF477AK0hCkq
         ZdHr7IaxU2DdkT4HajOoDo1YuUR3HKWs9GNToAaynwkhcqlWds+V8QvFchdGPAAthi
         H9dbEgRqpt41Mo2rBnS3JsenWiwcV+oFdvEwz5u61cJmcSL+ZmwKF8whMnNWZNESuv
         ocE9993/rt/FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 485CDC395DB;
        Fri,  2 Sep 2022 18:30:08 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YxIgXZNrSK+us7Vi@kroah.com>
References: <YxIgXZNrSK+us7Vi@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YxIgXZNrSK+us7Vi@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.0-rc4
X-PR-Tracked-Commit-Id: 0f022aaac9ff2ceff683231b43923c650c90b47e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffb384c269dce238c588e0e8e3a85c0ec098a904
Message-Id: <166214340828.20636.14025568612912092514.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Sep 2022 18:30:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Sep 2022 17:25:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffb384c269dce238c588e0e8e3a85c0ec098a904

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

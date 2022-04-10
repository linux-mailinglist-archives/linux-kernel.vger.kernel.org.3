Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C654FB009
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbiDJUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242054AbiDJUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E44B1CF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 13:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19F2F611EF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B79CC385A5;
        Sun, 10 Apr 2022 20:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649621542;
        bh=OB/9w2kURv9vwHBi5CS4bnLPjUTr0g2RxU2i1mbSCRk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lLWn+OIZYjUZ0wXQocaD+Wr85mexxzl2Xor3hAAYDM88vrYL5ANppi858oMVfu1Er
         SaK+AVGMWQ0VARBxspM65cy1tL0pqkukSTh4RCQ3xPvfRueRuu7QdUlJx+Dpcw4aKF
         eGjgX2cOKKx0jpEXva3N6VenVoAieXckJj+ZkSTMqzqKdK3TdHzhDGV/YH+qT4EWKY
         vcmDGgjcVcHmBvzyxarQummr365VAFitH28bUB6cr+qS12Gjl775tCF4Q1xKyiV/VR
         D75Zsp0715zGuIa9EzH8DbS0uQcXUYdanNKV0/7RkNPw0dL8P/GStJfubXLwLnsvGG
         2bmnufK98FaxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65541E8DD5D;
        Sun, 10 Apr 2022 20:12:22 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fix 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlK/M8Va5si3UQ+y@kroah.com>
References: <YlK/M8Va5si3UQ+y@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlK/M8Va5si3UQ+y@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc2
X-PR-Tracked-Commit-Id: 94865e2dcb46c1c852c881cfa769cec4947d8f28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f58d3410c5586bc22ceae2e65a17754378fc4a7c
Message-Id: <164962154240.385.4976020006594554032.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 20:12:22 +0000
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

The pull request you sent on Sun, 10 Apr 2022 13:27:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f58d3410c5586bc22ceae2e65a17754378fc4a7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

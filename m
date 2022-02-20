Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35494BD129
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbiBTUDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:03:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiBTUDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:03:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56403C5B;
        Sun, 20 Feb 2022 12:02:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E26D660EFE;
        Sun, 20 Feb 2022 20:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 510C2C340F3;
        Sun, 20 Feb 2022 20:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645387377;
        bh=hsWquXulE9oGWQFIfWlBOdzNrp47fNKNDfEBf2Pc4ZA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Aj8UrZ+lXYipRB7Pmae/sDznWYjg4b29GYFJ3GxR40owP7e/HplofzZxfI6uup7uB
         5aYQaHh7QAsFTy4Ujp74X0308dtjHMV5bThe526ZYCKuvN3/W8Nb+a+ZvdYjJT323t
         tIBivzHBIba8r3SGFf9epmvvFkYN0XEZYLgDP4MXQ4Fx0qmlC/24IPY/aU0tWoJk1K
         YhZ5DZsx4CypYDK14BZch3V/Ir1cERI6XPrQnmn1zPvKe6DPCG/PodtUxACUnYJP31
         nxGCh0dXmyuxpHea6ZxTMvqOimnvaPCvR+j4gCl0iJrCSXPju6OI8iXvcmJsfG6rZ0
         zWzTzOVjTbGbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 405DDE5D07D;
        Sun, 20 Feb 2022 20:02:57 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f6af0e7becb42dcf5f52f797c81550bda81c73fb.camel@HansenPartnership.com>
References: <f6af0e7becb42dcf5f52f797c81550bda81c73fb.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <f6af0e7becb42dcf5f52f797c81550bda81c73fb.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 10af115646171afc0217177d6eae92917b785897
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e268d7084a90c740198579abc069813f903120aa
Message-Id: <164538737725.17727.135441218979779977.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 20:02:57 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Feb 2022 15:03:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e268d7084a90c740198579abc069813f903120aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

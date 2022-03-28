Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DADF4EA17A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbiC1Ual (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345815AbiC1Ua0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAAB1FA78;
        Mon, 28 Mar 2022 13:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD8AF61490;
        Mon, 28 Mar 2022 20:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D330C34110;
        Mon, 28 Mar 2022 20:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648499324;
        bh=lA8wzpzQTd8cNFVN7AOOrY+UNhAzP3Rv6HIIcPxD+3c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HrsGER3/3UFkNF0FA7SEgVI23IRmCB4ySW5r4fXaM3g5UrHRUF4cDgkotMpgCbjoR
         19k0uSEWeGdEChNUV9ndz7qSbLDly1iBclyN84T6jPI+HZx/Ur0IiEsX1Exvsz9N0E
         01xeE5/9I9YuvEMqI9ZO1/MQ0CsfbzL5m9G7Rrp8L5Zn+DXrTOMp2G1/GOBQXHio5J
         g9sjgwzFF/YhpoTvteE72IBNtoMJE9kre6orkQfidPmNs2RTsa+roF8x2G5utGLvSM
         rQ9MgCRo9kALWNIQ6hYU4HUjxhSyy9xqKPoca9XSa4QVgWbLYEENGEK3xMbpfWp/qr
         SBqVnRkbe64rQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B1F8E7BB0B;
        Mon, 28 Mar 2022 20:28:44 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkG68oNE448ucfPD@kroah.com>
References: <YkG68oNE448ucfPD@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkG68oNE448ucfPD@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc1
X-PR-Tracked-Commit-Id: b31c41339f4f8a833cb9dc509f87aab6a159ffe4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7203062171db6669f746d14148c4af76af619e74
Message-Id: <164849932417.7875.308580921083211883.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Mar 2022 20:28:44 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 15:41:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7203062171db6669f746d14148c4af76af619e74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

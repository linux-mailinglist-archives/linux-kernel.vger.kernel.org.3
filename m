Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD94EE4A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbiCaXYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbiCaXYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:24:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D332182AD3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1428DB82295
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D23A5C340ED;
        Thu, 31 Mar 2022 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648768976;
        bh=p9c6mAkztJWuLmDG7umbW8w15HYGZoRSvxkQNVEeU1o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JC6gcklF/sQihUQZq5DNWo5QhGHPsmr9/iNF/x/QiDwJlfXewhFft4n2E8jGlu/O/
         vSIva8jtebnBrupCXTHZtT3231b8wFTUq/HG38Kr1hoJrdzpniU1mu6/pXUpQJ14n9
         x8PfKRm8QlT5FkJFUjTAex5W6vFdOw7vYlstjgd/MoJ3PUgA+Nc0MF0RZb3SupXiAj
         aKk4FusGageTG02F/7JBHBdFnelCZtdZS/Sok3kG8q89BgZHk4Yah2YWdkqvr889r/
         aLo6NVWgr0ZyIrN3c1loTTdok4a5uZfrAc55PFifk0Xx3m7x/wfs8B6oadAAaKNuZ+
         sXTR9U6vfWyTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C09A7E7BB0B;
        Thu, 31 Mar 2022 23:22:56 +0000 (UTC)
Subject: Re: [GIT PULL] JFFS2, UBI and UBIFS fixes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <678407645.204324.1648760660133.JavaMail.zimbra@nod.at>
References: <678407645.204324.1648760660133.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <678407645.204324.1648760660133.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.18-rc1
X-PR-Tracked-Commit-Id: 705757274599e2e064dd3054aabc74e8af31a095
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a87a08e3bf2decaed29c4dfde3916676f9b966a8
Message-Id: <164876897678.28012.16351343936896890210.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 23:22:56 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Mar 2022 23:04:20 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a87a08e3bf2decaed29c4dfde3916676f9b966a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

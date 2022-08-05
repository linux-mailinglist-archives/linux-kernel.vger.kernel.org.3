Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F414558B119
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbiHEVZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbiHEVZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:25:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9C61260E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0BF5B82A50
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 21:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B254C43141;
        Fri,  5 Aug 2022 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659734731;
        bh=8daNeUFJUbtUNVfJoQFeGANuiGWkDw9DmZzEoODYOoo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fJn+idQ1wSbM9AKQVY44vRWmePauqou/AmkONBWDnF1XRpr/uW8Toi+0U3S+b0AB7
         yHa+kmK4Mo4e/oIUzoHObiIJUKvwkdCznkfj1MJHY4W7+q+FjLKVIF/OlZ3BvImM7C
         xYy/QB5xwn/1ZXXAHXi1TitNv41e2y/nc6c3ddJ+by28K3LCkIFdj6e0MEmlqEOeMK
         AH71aoL0f0SQqaTpJlWH5f6pFpyzd/N0wulN4GfJ6IbzRt+ONeg1inwf5aGZuxPAAO
         8tIJVQtod4iv8obrSfUgKZL0DEPotqZhFNeDipV8VCTsygZGdiZW1i19Qc/Z90LyKa
         JOgyxbMW0klRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89D1EC43140;
        Fri,  5 Aug 2022 21:25:31 +0000 (UTC)
Subject: Re: [GIT PULL] MTD changes for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1047109049.69854.1659733300067.JavaMail.zimbra@nod.at>
References: <1047109049.69854.1659733300067.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1047109049.69854.1659733300067.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.20
X-PR-Tracked-Commit-Id: 7ec4cdb321738d44ae5d405e7b6ac73dfbf99caa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74cae210a335d159f2eb822e261adee905b6951a
Message-Id: <165973473156.8747.6504412873304188452.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 21:25:31 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Aug 2022 23:01:40 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74cae210a335d159f2eb822e261adee905b6951a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

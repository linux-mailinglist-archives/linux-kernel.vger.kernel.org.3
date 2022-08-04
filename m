Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B1958A138
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbiHDT13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239894AbiHDT1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:27:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04DE6BD69;
        Thu,  4 Aug 2022 12:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0230B82718;
        Thu,  4 Aug 2022 19:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5548AC433D6;
        Thu,  4 Aug 2022 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659641236;
        bh=cGh4BYfLRpyvCEbTkyNzUakXTF3RwU2wYJMG6Of3Pdw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WAVG1rHX+iCpF+9cq/EHsFgKDMDiP+g+q54z5vRHyj48JU2uy/BCgpFm9pE1E/3Pz
         W5t82cTY/+9Sh1/u70DXsYqFARhkzmSziXmn7+/qRfV5ZjxhStBuZ7s0KGClC1tpW/
         VO2v6U5i5iM7ZAe75W9Uff81G9F/kb62YfBWofFtE0PbEB0ZPaQ+9EIsmCInu95hhE
         VHmnt1ulfFxedgn3/vHQeZ0Vpe+SSjxzoxnHhX/Sgpd2yXQt5ycX/8tiqN7UioQ20k
         fBhgXejQzy7+5vFtydr2HJaxGvBG+bBl+7OjYegZz79thLjPwpp7mRk+8f6ZxNopyd
         qo+0tiIJZ9UJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4729EC43140;
        Thu,  4 Aug 2022 19:27:16 +0000 (UTC)
Subject: Re: [GIT PULL] SPDX update for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuqBtvFv1gaAkD+E@kroah.com>
References: <YuqBtvFv1gaAkD+E@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuqBtvFv1gaAkD+E@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-6.0-rc1
X-PR-Tracked-Commit-Id: 58301e1c15db89c0edc6a122c8f6fb5af271954b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1c76700a0d6e6090ccfe1209527f14c21b6681b
Message-Id: <165964123628.8981.13216930391133803828.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 19:27:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 16:09:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1c76700a0d6e6090ccfe1209527f14c21b6681b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

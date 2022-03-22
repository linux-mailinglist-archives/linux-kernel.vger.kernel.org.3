Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F5F4E360D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiCVBl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiCVBlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:41:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C59140C5;
        Mon, 21 Mar 2022 18:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F7AB615E6;
        Tue, 22 Mar 2022 01:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C777C340E8;
        Tue, 22 Mar 2022 01:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647913189;
        bh=G5H8w5mqAL4ENp8+r75RAkSrr2fjFv9lkRanGon/i84=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bWqWCBYIeDhXS3MBx78TY7uKtdtErAhCMTHNAogdNhVjyI05cG38nQ9SqD5izL5EG
         +VojfNVv4Ty8jmUMwheOMzhPWhKCxdRzGMnp+nrDYjX0ooHLtohCBH6irdtgOMV66G
         FGMrGel1QXnVdxw1sbAawiEDzLghu6O0QnZEhAj0My0sSwKFLH7GV+Xt2hkYKdOAFs
         RQ/4Wbb/3EerSh7xYI9NdMOyozwmY4BVec8HHzItc5Dl4gAs+tSqQ2fNq1ym0ZR4GM
         uH0XhUUUolqHklkEnSeOz+agCVm4k59Xhfxw0hbEPawX2ZmgsTtSIchxl/FetdWcVi
         4/yq1x26I7WBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0050E7BB0B;
        Tue, 22 Mar 2022 01:39:48 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220320231317.2171300-1-linux@roeck-us.net>
References: <20220320231317.2171300-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220320231317.2171300-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.18
X-PR-Tracked-Commit-Id: 6ba463edccb978e3c0248c3a193b759436b51ac8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd276877917ac6ea86c2541757d846bbd0cdc5bd
Message-Id: <164791318897.2267.3204823801054249263.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 01:39:48 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Mar 2022 16:13:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd276877917ac6ea86c2541757d846bbd0cdc5bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

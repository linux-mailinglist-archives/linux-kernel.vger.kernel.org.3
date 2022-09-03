Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7145AC010
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiICRhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiICRhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCE652E79;
        Sat,  3 Sep 2022 10:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D72660BA6;
        Sat,  3 Sep 2022 17:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D609DC433D6;
        Sat,  3 Sep 2022 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662226626;
        bh=D6/Bv4oN1b8ebqE6mtie8cFD421rJnSwGSwI/H+JjZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nE3wnRitnhWcl8td1O8kZDGc+mRMYIPXIuDJKt/KXcT/rZ/BIkvUy7r3WkIes2HNa
         sqxIUpOGiZK88HqdKSjjiqwqjJXAdxEFsMmfZtYTsdOE9blfo8kZst5dFMPw2i0UO0
         HA6sp1a7E3cfb5jJQOa5DIghiB1ZkQYgvIw01r5Y5T4L5Qkt0McD9WFpmiqpi98vDe
         eiLnfERlhbZboOgkmFoaOWWM6Hv2R2pOuhOEy2D1aQMf1arE2qlZhA7vpiTsfRRF0u
         v/7fwq7MH+yqerPPszcdD6/PLJwtlosVEJJUnGEa9n0Z8iBV9o++DaziJC5Q34wo1p
         Q1rKxEmnBzQJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C39D0E924D9;
        Sat,  3 Sep 2022 17:37:06 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220903020142.852288-1-linux@roeck-us.net>
References: <20220903020142.852288-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220903020142.852288-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.0-rc4
X-PR-Tracked-Commit-Id: f233d2be38dbbb22299192292983037f01ab363c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 777464261d12f4b011fff68de36a4a1075691cd9
Message-Id: <166222662679.30432.5127708521397179171.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Sep 2022 17:37:06 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  2 Sep 2022 19:01:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/777464261d12f4b011fff68de36a4a1075691cd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

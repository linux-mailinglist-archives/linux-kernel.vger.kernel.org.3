Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DCA4DEA65
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244011AbiCSTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbiCSTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D9A1959C3;
        Sat, 19 Mar 2022 12:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED91260C2B;
        Sat, 19 Mar 2022 19:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58645C340EF;
        Sat, 19 Mar 2022 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647718140;
        bh=Rfzy1Lut8EkX7L3KZjJ5kzMvOCltkpLJ0C61l0aZACE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=em/gImJWbl3SltNus2/K+8HqONC7MrhjP5/o76jACjn31QJ6zyelmVrjMRK7hhL19
         bRhDcnBZGg6xWtf+NaLFi0h1lEICQl2vr3t+AiLQ08gFO27NmBKnBxg60V4fjGOQ9A
         PMO/C87D1+X8X31zO/cHhPl2T2D8suyI9a8BE7uwJZ+W+6AIjUgqT2uhbs+XjZ8KRe
         D90pdJx5+ruHkgGpNQR37Zu4/t+GroBRGrMFnydj2DoqBczyCj2qccRdJk+jCeAS3q
         0Fj823cN5hea9mlDDl945Y98jeS+2JiHhgtKF73toVfurEEPMtwkc+e/xB9NTFBC6Y
         kcxG6szzy7cgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42B42F03846;
        Sat, 19 Mar 2022 19:29:00 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.17-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjWS3CaN65nJNHEj@kroah.com>
References: <YjWS3CaN65nJNHEj@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjWS3CaN65nJNHEj@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-final
X-PR-Tracked-Commit-Id: 16b1941eac2bd499f065a6739a40ce0011a3d740
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6aa61c12a43bb365296e72251e7346b661030b52
Message-Id: <164771814026.23927.6644446405642889764.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Mar 2022 19:29:00 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Mar 2022 09:22:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6aa61c12a43bb365296e72251e7346b661030b52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

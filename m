Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6674E841B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 21:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiCZUTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiCZUTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB9201AD;
        Sat, 26 Mar 2022 13:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AFF60DE7;
        Sat, 26 Mar 2022 20:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89277C34110;
        Sat, 26 Mar 2022 20:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648325879;
        bh=t9TqTzHBMH9CC+VthsB8t8Y6SaXZs2Sfvo6XYeWkERI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AI+8tw4ZgSQ8fo43Msvj7UkRwwDYGJuHsskUN6lYe2UDnXt4iFTe8Yn9leaGvJCQ6
         plXoEOkfwDaTBLM0FbIVucQCb+ozsF5snWaGOP+0I4EH7kVWQd0y0uGYuCWKLBBGAg
         Uy4Fq/FqDoNBOThg78fB5o/091WCalweF/y+TUkZeWUio4x4QWaVEWhYdOam4u1Dp+
         4xplMWEKL5bHTZe71jjPwno1Vk6IMhEb2CEf4LnynwtYudRYreDw3I6TRBVHNo9maE
         2NQuatoVJfHsMECDOZk4oCX6BY9WlcT6cDMby4BHwGOxNVEGpKYNQVD+8jgYnTWZ+I
         6pPgsD4JmqbPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77A36E6D402;
        Sat, 26 Mar 2022 20:17:59 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver changes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yj7vGtn8fILavjyL@kroah.com>
References: <Yj7vGtn8fILavjyL@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yj7vGtn8fILavjyL@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc1
X-PR-Tracked-Commit-Id: 46d2c20b0b10cf07a2a24b047a09195ba96c84f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 710f5d627a98e86f821aceb840b8f2f1fcc6cf75
Message-Id: <164832587948.7233.13743974093479078315.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 20:17:59 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Mar 2022 11:46:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/710f5d627a98e86f821aceb840b8f2f1fcc6cf75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F924546C47
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350433AbiFJS0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241779AbiFJS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:26:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BDA2D1CA;
        Fri, 10 Jun 2022 11:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D704B836F6;
        Fri, 10 Jun 2022 18:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36C52C3411C;
        Fri, 10 Jun 2022 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885571;
        bh=UPENPVLVv8JSaT98f62sRrKQHDCAQ7O2mVi27++iWnw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rev5psLGF4I4wKrcgdLNhRxCBHKfGxoPqKLyIKL8Ip09OVxajZvSbdOV1cLsa2yjN
         E8VsS+gpxokWi5PMG4aa5h7xhcMV1tHY3BnNWtfr08hT+Q08+D1RuBHj3EEx9YV6UL
         gRubwsxRpGDdx7KejHnrEkBF+pDPP//6nigjKzg4fl+XbBC/tLRNM7WYhf4EmrPjBu
         CzVAaQjF+oqjP2g1IDYlh4vOryrAE934Wq2rnLMs+FZ/lm6RGMjCaCxaqBt+EMsTyL
         aka0glnvmBzz075xSi8PFi2YwVN1i4VPIJ9WVwsbbQcmfiRXZhzrjsfVzX/U6KTyQY
         HK4jYw8qY+S0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22942E737EE;
        Fri, 10 Jun 2022 18:26:11 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87h74s77e2.fsf@meer.lwn.net>
References: <87h74s77e2.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h74s77e2.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.19-3
X-PR-Tracked-Commit-Id: 387c67afccbb271707cbe6de2817f4e4c76287ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe43c0188911885a70d0dd405f89ca4f1300e7db
Message-Id: <165488557113.32117.5474621163444297169.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 18:26:11 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 11:31:01 -0600:

> git://git.lwn.net/linux.git tags/docs-5.19-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe43c0188911885a70d0dd405f89ca4f1300e7db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

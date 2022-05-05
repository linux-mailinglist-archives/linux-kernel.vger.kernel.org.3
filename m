Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B54E51C868
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384845AbiEESwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384478AbiEESuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158E243AC8;
        Thu,  5 May 2022 11:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C30E7B82EA7;
        Thu,  5 May 2022 18:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C551C385B0;
        Thu,  5 May 2022 18:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651776361;
        bh=rl+qPo3F8giMdsph4oWF3TwI6uGBCTTkXfhRyf6fKY8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tgSEQ785L6mmK3Mz24k88WQ15JmW8urNnDlrUKJyol5GbArakGrtBcIMG0yZfiux6
         zXy4wCAGttJaEEsG+zp/YdqxrLyFJFMO+dyPaHZk54BXYTYU+TUp7B6BUyi8WZSHAO
         OzjWYLxNt8klSd1WXaFCn8DUSog4oimylHple5IXoQkAATtK/QseR2j9KUbkkyosbM
         QQzcusI/qwEFZWprvCfhgfz2Av0mLTvcl1G0Rao7A0ZKem0ywBjxHakCfEk9D51fRE
         qC5gVY4p2RsjrJaD6C+uyVEmI3EwaKsr+HqFA+jtf50WqS83a7AZddl3dQEhBaHjQA
         ax41R/CufMNDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7321DF03874;
        Thu,  5 May 2022 18:46:01 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YnPFjuBYZw/dj01U@osiris>
References: <YnPFjuBYZw/dj01U@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YnPFjuBYZw/dj01U@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-4
X-PR-Tracked-Commit-Id: a06afe8383080c630a7a528b8382fc6bb4925b61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f5d752b1395e777ef81e28886945e5e939b7c8a
Message-Id: <165177636146.18464.9738843422576681682.pr-tracker-bot@kernel.org>
Date:   Thu, 05 May 2022 18:46:01 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 May 2022 14:39:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f5d752b1395e777ef81e28886945e5e939b7c8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

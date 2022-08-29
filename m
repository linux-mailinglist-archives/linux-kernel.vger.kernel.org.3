Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394925A533B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiH2Rep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiH2Ren (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:34:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E05497EDA;
        Mon, 29 Aug 2022 10:34:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FA0DB81199;
        Mon, 29 Aug 2022 17:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8074C433D6;
        Mon, 29 Aug 2022 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661794479;
        bh=LBDvS6XoZVRJEJmWa+ZXxNpovfkLbLIkGFHkPfJWv0c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CMLLzI7mtPYjexxfjl9CMmOKdfKn/MPGUOSvKL5GbOPE2NRRY70bQdMF+w/2yYpkV
         DYJu42PZrnlPh31ZryyDcYEdmgg0mMT1vou5pLKfJ21Dgmf6O4cSAR46N0JEQ6zoLf
         x2sfPJr1COu9J8sJm8hB9ltCRWiF/otr/BbM5zw2t3tIMEgQxB6P4QIYtvZocE3Nps
         C3HkImZZsUDZl5HSrjp6JJ5fGo6vy3xJC9ubtdt5Meg79A5Sq0aQuLv8iLLgWBnar/
         vG+qc20375xczOgrImEQ28J+kycaAJ796q30eBlr+t+bomaklzVbFxZYSC9mHz56W3
         M5EdpekNR7tKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A462EE924D6;
        Mon, 29 Aug 2022 17:34:39 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871qszrr9s.fsf@meer.lwn.net>
References: <871qszrr9s.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <871qszrr9s.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.0-fixes
X-PR-Tracked-Commit-Id: 5479d6d4bf122d4b137659559a7bd17784b97b7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d68d289fbec70b50a25f5818964b26349320ddb5
Message-Id: <166179447966.12590.7460232277544887852.pr-tracker-bot@kernel.org>
Date:   Mon, 29 Aug 2022 17:34:39 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 29 Aug 2022 09:41:35 -0600:

> git://git.lwn.net/linux.git tags/docs-6.0-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d68d289fbec70b50a25f5818964b26349320ddb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

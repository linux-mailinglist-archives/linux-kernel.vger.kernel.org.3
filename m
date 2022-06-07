Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21914534755
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiEZAJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348092AbiEZAJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:09:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E55662CC7;
        Wed, 25 May 2022 17:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA7B8B81EC2;
        Thu, 26 May 2022 00:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B62C2C3411B;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653523753;
        bh=94hvPQ/QqKI9wl/tXyNOv4qagCeS3S7RKPJVCSiX67M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Np384ROLfmAT3DdOOZEGnDo7N46Us7c/8E9IxsQ+mj9XGYr6FGa6/1FRXMLcghsR6
         QJ9QXh5XipgRoZzBT5biAqV0Rz1mU4RFHPcriE8JakFprNJZ41HcSFPmoQ0Y9j/UIQ
         7Ecw5z0KBVpDiJyraIvTzD4AtGpn1sPQHpHq/Qa+X887exZ7styBt4kAmk3SGeBgE5
         vjQjqeTg3wCfu6Qg1DEyThCovER4k0djKG5BECZ5ZgAicEN4GFvOMRHturGhPjLv/w
         cd+pQliS4Lig92cxU/Iig8nbL5v4SeXjUA+YnP8rg+mbT/vuNucITrTtS5FkJ9hbpM
         wcbrfeC8WswZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5FA3E8DBDA;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
Subject: Re: [GIT PULL] checkpatch.pl changes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220524222927.GA7839@embeddedor>
References: <20220524222927.GA7839@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220524222927.GA7839@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/checkpatch-new-alloc-check-5.19-rc1
X-PR-Tracked-Commit-Id: 73f1d07e5f8a1dec989a5ec964f5f2ce5b6f8825
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e908305fb262588471958f560eb3c6c18cc683a1
Message-Id: <165352375367.5177.8655640421136528844.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 00:09:13 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 17:29:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/checkpatch-new-alloc-check-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e908305fb262588471958f560eb3c6c18cc683a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

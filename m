Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55104533384
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbiEXW2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbiEXW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:27:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B947366BD
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 645C6CE1B9A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9DA0C34117;
        Tue, 24 May 2022 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653431267;
        bh=4w6WU++Uvu5HDHBHlSaHvjJmIRg8lo1YnKXc4590qCE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gr9t8b7XcF7UR+9fRFbNDxGNnnzR9avPhEKHXvmiakv4028R7fSNXpnR64Ge4A6h8
         bShuRiflJWMTpkLUBNiI/uwy7pZPGzpbpG6v6CLl6upJ3XdKNMnCosCRFmRqGe4Ks2
         4AbEEookxJ+hOMIfw7ByJda3Ay4HrLdW6DfCtoYBaM3freq85rUoGYuGPZJcNiCLu+
         j8M1gqQpfWdRcFLtVvd+6nNb2m1mCRtAIYImuYyWTdz2NQoO+x5GALMO64K0tE8dZ7
         KONQKcOMWPdl8Iks3C3hww9cKyr9yhQQptgF04PpgSF9xTvUyGXwu48kxk2qaFs7mh
         LtD9emQJyvpsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96DBEF03938;
        Tue, 24 May 2022 22:27:47 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2205241107530.28985@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2205241107530.28985@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2205241107530.28985@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022052401
X-PR-Tracked-Commit-Id: 07d17217c668d5b9974572b2d69c6736f60b9925
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa051d36ce4ae23b488489f6b15abad68b59ca23
Message-Id: <165343126761.3997.6527730865682987195.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 22:27:47 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 11:11:25 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022052401

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa051d36ce4ae23b488489f6b15abad68b59ca23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

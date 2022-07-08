Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08CA56C3B0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbiGHUdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbiGHUdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:33:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08988A2E45;
        Fri,  8 Jul 2022 13:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA372B824C0;
        Fri,  8 Jul 2022 20:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70A08C341CF;
        Fri,  8 Jul 2022 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657312358;
        bh=1tPXpVG/Ml0a3RXii5mlbRyVNrajog25HL71TNtWBNY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CSfG9dPTmvmgAzDbzMF9SEXY84/tXm9WRWlAvh1VTsPDIM6O5zJHscGHR/ykhhENB
         74iU+TnZU/0bN0XrUEHrQ9fI4z7Q4Uv7TrIqfUSkzugXCJ68Pivb52CSuz8AVGlcHJ
         CZQwX7TofhDK+RAOigr0/P6OQMioM4zOxaIC7IGuzKXxrnEz+x82oH404wJnMjSJIH
         Gd8/DCYedWNoZlCAl5gNoV39lKcNe3qhkKJZiU5j7DY9HJ/L0IKyAyZaLKaJNuHPvo
         HzacNMV378jGvwbEGlODRMwsQF73EE1420dRfudDIED5RlLb5lAftqptj6i35h46X2
         Fjk/d5rC3ACbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5331FE45BDB;
        Fri,  8 Jul 2022 20:32:38 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hEZmJ4PJZs43m4tbrEVX4Hx3Jd1jvSsTzU09uaqbm7TQ@mail.gmail.com>
References: <CAJZ5v0hEZmJ4PJZs43m4tbrEVX4Hx3Jd1jvSsTzU09uaqbm7TQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hEZmJ4PJZs43m4tbrEVX4Hx3Jd1jvSsTzU09uaqbm7TQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc6
X-PR-Tracked-Commit-Id: fe7c758c07c4729a16f940eb1d77027ad032ab29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3784fad934c5bd68551f0af4252821697957a72a
Message-Id: <165731235833.2541.17663215306032983349.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jul 2022 20:32:38 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Jul 2022 21:18:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3784fad934c5bd68551f0af4252821697957a72a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

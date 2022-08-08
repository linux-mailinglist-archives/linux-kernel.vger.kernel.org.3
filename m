Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C258CDDE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbiHHSnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbiHHSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:42:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F472653;
        Mon,  8 Aug 2022 11:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1253FB81058;
        Mon,  8 Aug 2022 18:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7452C433B5;
        Mon,  8 Aug 2022 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659984126;
        bh=IcKbQrEu8fvCNUssOuYB2qG3dSNG44WeXb5EOxESOXo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ckHnJveum2Ldsm5QWQhqpuo+/b6Nh0AT/z3NysNuoRtBvZlkT2Uklcj3t5XO2/59L
         rzcEfAXG44fg5GnAk2pxgNF7cFKZ/kDNTCkY1aGYjqBnCI2ekRFNye8rdG38H4K29z
         PMtfsps1PYtqU/7QD3MRVzY7o75SokmkGWCj27Cb2v64sk1XFsh8Q0h7MqARo0UJ0c
         pGxj2ISfqsn5AoV1mIaMRyZBmpvR6ySkxFoOMnmS3XoAjyw2IiFVIezSS5+/RLRrzN
         qVcT/rUnGjn7Z++/TfLCNTjzFcgLd/4GPuta+3JTP3rMzw65QMOp3fzwfubgEAqkWQ
         CE36fyfei0E6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6D3DC43140;
        Mon,  8 Aug 2022 18:42:06 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs changes for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220808135201.GA22949@duo.ucw.cz>
References: <20220808135201.GA22949@duo.ucw.cz>
X-PR-Tracked-List-Id: <linux-leds.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220808135201.GA22949@duo.ucw.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-5.20-rc1
X-PR-Tracked-Commit-Id: 38ba0bb291aacd92d8eaa4a1aa8b63ce4286e797
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8a684e2e110376c58f0bfa30fb3855d1e319670
Message-Id: <165998412667.757.10353759158812252195.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 18:42:06 +0000
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Aug 2022 15:52:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8a684e2e110376c58f0bfa30fb3855d1e319670

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

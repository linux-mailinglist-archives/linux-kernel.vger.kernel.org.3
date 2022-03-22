Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D5E4E4611
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbiCVSdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiCVSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:33:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA9A90FFF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3FE7ACE1E74
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE290C340EC;
        Tue, 22 Mar 2022 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647973923;
        bh=56pMLYS62NlbI9+1QeTpYPBinGiZHOomY/pRjTYFL/o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LHMYjtnlF9b8M50iF/fewdFw5UO8Ifb3H8ZX32WPn8LmTyNlXKVhQ1bCmy3wj3lEE
         oOFLcoFkOonXvmOETpTKkOaufFVS36HLEb9AkF34pn7FvyWj+XAP1Gp5Sye8Hs2jJm
         vy4RElpf0brOc9L/fP5BSwt8NbeKZ4CC4VAgzAuFIT8ZSL7IKi8uC45+EPftnGR38F
         /D35RqkybBK3uzSCuSvqZsWY+vsBF6QX69HdhGdC7AhSn0kYE/lx869p9h2x3s9sde
         Bhccq+AgV0gPgnZFemolPFKgm2IJGvaQ2MnhtVmeIFoXejpjAw69Mvs67xu1wmKBf+
         y5e2XZ9fGIkmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BCE5E6D406;
        Tue, 22 Mar 2022 18:32:03 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjjihIZuvZpUjaSs@google.com>
References: <YjjihIZuvZpUjaSs@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YjjihIZuvZpUjaSs@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.18
X-PR-Tracked-Commit-Id: 5b5b4f85b01604389f7a0f11ef180a725bf0e2d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef510682af3dbe2f9cdae7126a1461c94e010967
Message-Id: <164797392362.17704.11716595490664039978.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 18:32:03 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 13:39:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef510682af3dbe2f9cdae7126a1461c94e010967

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

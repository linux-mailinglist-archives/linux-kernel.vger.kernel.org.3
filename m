Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E65557DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiFWO12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiFWO1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135CE3DDC4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A404461E0E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18D14C3411D;
        Thu, 23 Jun 2022 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655994431;
        bh=xfRCvAE+e/PW1dBExT/88qXEsZv0NNJVoFgTymZw394=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W37Bw7F1A6/EarlChY3FitCxl/fQuse5TI/TPt5IpTvyb1Dh+706k4eC18GpRtxwa
         rrPGI949IDc4ouZWqdo3kVsmNlBPew5mh6BCquisyPH1vykncUkAdm2Fyn6CSpaIUB
         VbCmyI1e+R9z4sx0V6o18j3YhGYSziaDGfAqfC3EuPzf3icu2nhdgNrhMVLFpStqMB
         rrJtfgnSBs/oaBe1SwBSshxS3fVm/sPev/BaY4FCT/kz+QWrJO4xvhEA6BmbhTpE6I
         N6UvIWq06fA0+JxQOolTH/nFZ4X9ugvKIEqSlmfSRWOZimdxXyR4Mjjw6yUuMykOQW
         d0JZzrUgTlJ3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04855E73856;
        Thu, 23 Jun 2022 14:27:11 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874k0bn8jm.wl-tiwai@suse.de>
References: <874k0bn8jm.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874k0bn8jm.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc4
X-PR-Tracked-Commit-Id: 627ce0d68eb4b53e995b08089fa9da1e513ec5ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddfe80311b81a83d3fde7e59fddc6aa822a5188d
Message-Id: <165599443101.515.1463818827761593002.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jun 2022 14:27:11 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jun 2022 09:27:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddfe80311b81a83d3fde7e59fddc6aa822a5188d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

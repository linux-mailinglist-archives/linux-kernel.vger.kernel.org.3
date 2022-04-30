Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3A515F90
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 19:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbiD3RbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383240AbiD3RbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:31:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE7329C88;
        Sat, 30 Apr 2022 10:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02B3DB8077B;
        Sat, 30 Apr 2022 17:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB78BC385A7;
        Sat, 30 Apr 2022 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651339665;
        bh=6RwrSte+0OOhScDLw6D2gMHS7TVD1ib5wGF5PO3OjxI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cnrMGAy3Bu3BQkBIpMJACR1kHwLgLYD3NvSfmspHtsYMhCZOu9vDzNnxYNtrIo/J+
         CIPP8AqElo3guw56dOmcA6OM6FTuIaksbosmdmLwWgaARrK/3VIC9GeGqk4Jp9g/K7
         yqADd70+3UgAPiyaDI8w5eO/GuU/FOsLk7z17ofap6sZUnpY8nc+a5ATHigb2xDGNn
         wLy0P/vISHH4g1FZk8WL/iZzCoEeIGUIWJpl8UK50pCgg6+hHTq0/eoaoaCo4AmoDa
         xLNGzGmOz9Z/ucIQl+8pdvAWCaOPsVvJAeGvER7IIpSa0KUd5ij0WzhmjL/o9b2drK
         7id6tGUDpy5hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA685E8DD85;
        Sat, 30 Apr 2022 17:27:45 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ym1bTC/HwRF70D+S@kroah.com>
References: <Ym1bTC/HwRF70D+S@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ym1bTC/HwRF70D+S@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc5
X-PR-Tracked-Commit-Id: 03e607cbb2931374db1825f371e9c7f28526d3f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da1b4042bde22f208b2d172751c8c8aadcf74acc
Message-Id: <165133966569.20469.7108439068860296342.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Apr 2022 17:27:45 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Apr 2022 17:52:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da1b4042bde22f208b2d172751c8c8aadcf74acc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

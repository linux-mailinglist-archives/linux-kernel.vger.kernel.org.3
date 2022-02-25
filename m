Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9344C4F79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiBYUSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiBYUSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:18:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD6D2E692;
        Fri, 25 Feb 2022 12:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39AAD61852;
        Fri, 25 Feb 2022 20:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B257C340E7;
        Fri, 25 Feb 2022 20:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645820250;
        bh=hprxKo1mems9HtIZuPLBMknaY2V/I1MaW2suqmU8ECk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OFmE+6nCxn74yBaqSAQPBG6naOcxkGqDwGXWlqN6AZOvWnr8IASoBrFi8lmbuT7DK
         f3QG95WgskguzAPWahinUyKLlYlej1ZptMpjiHX13feFddinvOVChSiAxsDgTl5muo
         bOSlu7oKbfFFVAd4829aJaCz4F6inFDsLHyN44LtgcM09g15sBd+Wn2rIMWZLmnGf7
         fmuZYwtvMvkHn5DhJwkvVJcVCVxvE4FiUqIGQPOlPIPy/9/BB905CpZFTOvk9aHbOI
         lVneWUla0cw/QkvIzqapbaBfk0eG4bMn/LH1zG04mzjr7zTrrtLH/a/BTYNUYlBDxL
         PlPhULBGgUXpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86A49E6D4BB;
        Fri, 25 Feb 2022 20:17:30 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhjYDWv9q/44eWZu@kroah.com>
References: <YhjYDWv9q/44eWZu@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhjYDWv9q/44eWZu@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc6
X-PR-Tracked-Commit-Id: 19eae24b76c27dedfb166dc06a8c48e052cbc814
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 548b1af45d1a10a6e2a04255c29d06cc14c10870
Message-Id: <164582025054.12222.151194858760593130.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:17:30 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 14:22:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/548b1af45d1a10a6e2a04255c29d06cc14c10870

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

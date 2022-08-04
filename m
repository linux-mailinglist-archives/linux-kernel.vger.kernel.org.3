Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94500589682
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiHDDSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbiHDDSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:18:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1B95F133;
        Wed,  3 Aug 2022 20:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDDAF617E8;
        Thu,  4 Aug 2022 03:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39D8AC433D6;
        Thu,  4 Aug 2022 03:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659583073;
        bh=xqhtcXkQbwWX3OV0VgYBRtuj4xRK7FMTLObP5UTLS8M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yz8+z5JpqiXPuRm9OK4WYCSn1EqZ4ATnyXM8fGYaqPHcZyOncckQCkK1Ho9HJqNBt
         Wutc7b1GlIxn9PWo4OMbWPQoi1Y0pvBz0imlKqy9hEZrklDXdUJwK7ux4eWY1/lqi1
         UJpIu4SNvhJj7pRNQE+5aCoXQcfPSS32SBtij/1shBG/Fo+fjDfmJJh/E4mbA1YVFx
         zctZC1vWUIHwX8BB/6/gX4TcE0d9MzjIJQnBU75Vn4opkTcJXEUMJvbynjLlqQru7x
         6xV0ph2MxucQRD40BEiynAQ84htKbbPw1t9Xxe1Q61Oj8aUvYuMd3sDgXoQ4HEDKi8
         5gTEnzH7FrNgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D298C43140;
        Thu,  4 Aug 2022 03:17:53 +0000 (UTC)
Subject: Re: [GIT PULL for v5.20-rc1] media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220802164658.4e533a24@coco.lan>
References: <20220802164658.4e533a24@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220802164658.4e533a24@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.20-1
X-PR-Tracked-Commit-Id: 485ade76c95ac5ccaa52fee9d712471c9211b989
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12b68040a5e468068fd7f4af1150eab8f6e96235
Message-Id: <165958307311.6841.12164356508888014819.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 03:17:53 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Aug 2022 16:46:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.20-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12b68040a5e468068fd7f4af1150eab8f6e96235

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

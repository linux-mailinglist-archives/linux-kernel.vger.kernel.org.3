Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601D64E33D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiCUW76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiCUW5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E93B6D9B;
        Mon, 21 Mar 2022 15:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DECA16126E;
        Mon, 21 Mar 2022 21:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CEC8C340E8;
        Mon, 21 Mar 2022 21:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647899631;
        bh=+M3Fdarms7dMG4DlDXK74jXwiBdgmceCZdc+ZeiPZMw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h7YLbA99WYyti6a7KNcMT5OFQoDjF/EzqdyB+F8huq6xOxaJFLf8qTZrY8gxRX1gh
         bCgU1ZpFcTIn3ebQ0Y3tWOc7hAu4vEXMpLecNVLKWYgC+qbwHtK9viodr6SF+v1Vvi
         duxdUnLCvL9vJIFOoiTKnisyhZsm9mDbcCeh6Vuwj7pTfN2JuLnQpcisu4tmjqa4o4
         GIB6AaaU9OvN3bgQ7YhRpy/CU7pxEc3Jl+Z/46I1QdrWd9AtxmVI2W2NrvePD9aC1W
         FUmJViHMzMTgA2QF354PvU8v4E6VTkGGJyKc7x0lYtxOvxpf0NIU+VdqkLrE7yjF9x
         5hvnj8HXsxsUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C076E6D44B;
        Mon, 21 Mar 2022 21:53:51 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8735jbnudi.fsf@meer.lwn.net>
References: <8735jbnudi.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8735jbnudi.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.18
X-PR-Tracked-Commit-Id: 75c05fabb873367d9e64f063dda8a310c4c58826
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 346658a5e189f35b61206fed2f9f60d4bb34b881
Message-Id: <164789963124.9856.17068123514272273098.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 21:53:51 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 10:27:37 -0600:

> git://git.lwn.net/linux.git tags/docs-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/346658a5e189f35b61206fed2f9f60d4bb34b881

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

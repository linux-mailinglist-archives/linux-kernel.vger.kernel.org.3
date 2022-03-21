Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9224E30B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351208AbiCUTUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352721AbiCUTUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341CF56439
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D74D960B72
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43F12C36AE5;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890314;
        bh=z/IVU7yUDPyD4kBZ7kfM78K5GPE78ozUe0JivWh0PDU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MVkxNcGXW7X7d7U/aYs4Vbv1yO/vl9oY88hxPLjs0zQvjQynst04xzoe4ArxzwqNT
         HlMu4G9u9py6RVynh6aQY/3PuOZwn9tw9voBfo4Wp3C7llCNFutqQbiFeF1rQjXWro
         C/Y2bZl4sWogvJv41J9MZ6d/uWpP5P5bu9P82ZWT7qKrTr1Fw65xGXFbmuaT5+xHLu
         8kuxWz4NrqvHS19QBhuOTZ9+fguldFlVrB/QNAWq9mNppXZUxYgCoQUEMfGPOFgJ0O
         GvjrjWz9o2D1cHcp3NhsYjZdzR2wk7TUCm5cQZ7Cgx8aPTKd9l/9hg+6yKDHpvpjdP
         QLm3VZFEjd8ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27E0FE6D44B;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjhUMfbawBB5YZaC@zn.tnic>
References: <YjhUMfbawBB5YZaC@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjhUMfbawBB5YZaC@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.18_rc1
X-PR-Tracked-Commit-Id: 4eda2bc3431ebe5c8361580877a4666d10ea28a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e10821b8a0350530bedcbe725c030ecfe5bd08c2
Message-Id: <164789031416.24158.18293249540860331575.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:34 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 11:32:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e10821b8a0350530bedcbe725c030ecfe5bd08c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

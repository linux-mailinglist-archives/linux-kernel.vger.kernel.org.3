Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095B252F30B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbiETSgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352804AbiETSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:36:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6053466B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6053361AB0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 18:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8921C34100;
        Fri, 20 May 2022 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653071782;
        bh=4V8UnRGgHl3Vr8Z6NpBh9QUuMq42vEd6Jg/+gRKSmmE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OYgSD5NAYjqNkJReIWuL9vlrIMvtkshcCsNAv1MgHJGXDK/v5SmInZX2uTmwkns0+
         /K/PvHxCTIWejmakRlxSItwTx8oiJljUkVPordyIXfFZ/ll02D7JOyCOTX+cKXV/ln
         GleNC4aAdK2isWeWUeq/Z6JhECu0SI6Nj6qEgx/BsYFPUkppzw+CR0noSHQ6h3V4mJ
         NwiLQt5qcd7Z5tOI/ncDF+SHj1HFHb6AUSQqeVS5nfRo+NooHUHU1bz8RfnSf+bFFR
         2swkqgleTIJGFuXePowJLN9NkAne1Y+uAcwCPGDuStjrb1xyFbJUp801bf4yHJkp1o
         qqQMKM039Af2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A440BF0389D;
        Fri, 20 May 2022 18:36:22 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc8/final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220520115250.GA6700@willie-the-truck>
References: <20220520115250.GA6700@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220520115250.GA6700@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 1d0cb4c8864addc362bae98e8ffa5500c87e1227
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a956f4e281fe548a541a4970a6e8a0ec283b0d6d
Message-Id: <165307178266.15282.16444731786720667906.pr-tracker-bot@kernel.org>
Date:   Fri, 20 May 2022 18:36:22 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 12:52:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a956f4e281fe548a541a4970a6e8a0ec283b0d6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

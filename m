Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA2258DCB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbiHIRDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245523AbiHIRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085472BCF;
        Tue,  9 Aug 2022 10:02:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9680E60B31;
        Tue,  9 Aug 2022 17:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 062ABC43470;
        Tue,  9 Aug 2022 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660064559;
        bh=mQDt0npPXNFoZ3KBEh4dScC/zr0s5mbBmqrzC+Hxpr4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aJH/ue90JxRWZTJpBScyYjh8lwsX1EBOAb3p3Ene1fOMQI12zHsHvjL0HGwTeCXvK
         AWiPiklNNuQwblrEQVowSxS0pR+YwiVNAAMTMuP17L9fbARk+SrZS0qfuZPd0p/eQi
         NHjRiFPcLj5YknIHF6MQP3Z4Ph5c2CuEl0NEUfW0fh5vwF/7mDb+YrD5iJnqn1DSjb
         MMVplSawq8VSBRJk3hpvfTvooWtDDWza+5hEv+mcjwoXcbVRDQPYp/d2hbSz6MFSAR
         E3qlHipZP1/7NlC38G3DO8O6gzp9PCsqT3/+4/7i0vejHIBk1QiQGePtXedJeFfJlo
         v2W3TPzrgyiFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9B41C43142;
        Tue,  9 Aug 2022 17:02:38 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c42ca36d-3535-bd31-e965-2b86840a03f7@linux-m68k.org>
References: <c42ca36d-3535-bd31-e965-2b86840a03f7@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <c42ca36d-3535-bd31-e965-2b86840a03f7@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.20
X-PR-Tracked-Commit-Id: 472e68df4a5eacdbe4fd07cffef1b5ffdd95516b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15886321a426c7f4f1a0ff788f5b48e49230c0f3
Message-Id: <166006455895.27167.16373185895979067980.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Aug 2022 17:02:38 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Aug 2022 10:33:27 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15886321a426c7f4f1a0ff788f5b48e49230c0f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

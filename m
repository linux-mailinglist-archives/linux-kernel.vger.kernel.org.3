Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A89532223
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 06:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiEXE1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 00:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiEXE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 00:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C363BC9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 21:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B31ED61363
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 204EAC36AE9;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653366443;
        bh=KOl0Xhflc+NhTubsN8i4aFZYkyaSYAbxwvvH0Ar5HnA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tsOwKwCHHeQDsJ896lIsWkitMdbi14GZIQxTh7ZTfS0lnpFO0AKaCdYfdBUcsnFqf
         xFcd1IOrRP82MP6eDAfoASF+VUTAtkQfTw8Mb6zLKQU0ATKH1CtCMb0tJG977lMRwO
         Ff98VJgl6B9C+BvTKkaCp0luuw54q3qslpXCmgi//EwhEInLb7zRMDJD0ZhViPFfI8
         2vhpHt31fJsUlK3XnSQpW012sSEAwG8dlSJR39k8z8v5faUvYon63KULV7eoIw3fe3
         QErtwzhmkrj0LGcl261UiN7Myb9gjC6qScpeODZiXOYcuV5Yw4uekRrQqLm3UVehTJ
         rWmysQVcC0RWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E147E8DD61;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523092200.889682-1-geert@linux-m68k.org>
References: <20220523092200.889682-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523092200.889682-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.19-tag1
X-PR-Tracked-Commit-Id: 30b5e6ef4a32ea4985b99200e06d6660a69f9246
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdd8f6585cef1c8c0fac745c1baa687301d55a90
Message-Id: <165336644305.29742.8792031862656031506.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 04:27:23 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 11:22:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.19-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdd8f6585cef1c8c0fac745c1baa687301d55a90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

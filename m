Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7682E5925AC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbiHNQ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243053AbiHNQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32DB60522
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 09:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4A2D60CF5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 16:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11A83C433D7;
        Sun, 14 Aug 2022 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660495871;
        bh=vzVnaFp0971LgW+nI119bBxbVBISBojFw517CMH9Pdk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RXpvlT8RrQKWejPhsqg/5NOroFl+dtCF6JU5IU2nPLS3SdmBRKtTfn2HGnR+E90DD
         KC7z1DG/Hv6+dYAvKRU6E5YJRRkkPkbklcQaN9YxVgAqHul9/CdjHkWtC/tZrSmWzE
         +IBzSCHiX3IYmvOb/eGXXtmuZcpcDQ9YcHGrNAXOqq104pnq1qbBULWfsLwBVvjjlF
         RZZnvXyCXkTSHvM2duRUaSifRxj7ebkmb7YQ3oWF7XBB9MKxwcmCJ5A9MBQIZIrN6V
         2jMEzmkKpX00zJjVg2PvnYsQj2s3Xl0waPbyX80bblTNzMRd+bJfaUo52UeDwDK6ia
         xze+F7+tmkztQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00F62C43142;
        Sun, 14 Aug 2022 16:51:11 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.0-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87czd3d8ra.fsf@mpe.ellerman.id.au>
References: <87czd3d8ra.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87czd3d8ra.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-2
X-PR-Tracked-Commit-Id: 83ee9f23763a432a4077bf20624ee35de87bce99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d785610f052d7456497cdec2a2406f6d4b16569f
Message-Id: <166049587100.14047.9978212155674014743.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Aug 2022 16:51:11 +0000
To:     mpe@ellerman.id.au
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
        ndesaulniers@google.com, ruscur@russell.cc
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Aug 2022 09:27:37 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d785610f052d7456497cdec2a2406f6d4b16569f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

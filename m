Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022E953222B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 06:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiEXE2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 00:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiEXE2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 00:28:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE538A32B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 21:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43549B817AC
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B80AC36AE7;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653366443;
        bh=tSVBxTgohRKBAQhj5O40WZe0CbYNivujTya4nWgBhB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NN3i+mXqofAwzFW+XFNChSWJ7ZnaTF25jmG+qMltMAPYr8X6oxM3CQO1KWYa5OkZx
         hlk0v+foH1xe5kadZdxvMnKsMPaGFNL02urv6b7dGs2IaCeWeIerQKfNUHat0yxUA4
         x++p8yq5ct9GeJqMNqfjZmd3ai6m351MwmXY0XDgb5j1WvECPa3bs+yy6kXGQAjaMA
         s/QqDHToiQ/n94SHC1dLGgIqwpauRcSccmKnNRBbF24MW5o046RZ856cQDxpvgTpmR
         Hoc5IyRSIOQl1UCumfrTPoiA+raZEWcOFNqJ5JPnK88Y/vFGw9SUfa97kbxNOJGDlj
         gfUbx93GzmRrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED88DF03947;
        Tue, 24 May 2022 04:27:22 +0000 (UTC)
Subject: Re: [PULL 00/36] xtensa updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523080107.720784-1-jcmvbkbc@gmail.com>
References: <20220523080107.720784-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523080107.720784-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220523
X-PR-Tracked-Commit-Id: dc60001e1a305ad8bba1ddaf09484e0e150aba60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17a05c8f1e18b3ef846d0032a19002568282ac29
Message-Id: <165336644296.29742.2382267729258729261.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 04:27:22 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 01:01:07 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220523

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17a05c8f1e18b3ef846d0032a19002568282ac29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF274F8DED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiDHFks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiDHFkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:40:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59596188A32;
        Thu,  7 Apr 2022 22:38:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B449B829D7;
        Fri,  8 Apr 2022 05:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF428C385A1;
        Fri,  8 Apr 2022 05:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649396315;
        bh=QLVlWrKAHEpEH/oXkUUTSLaQGR0aOiZ/iOvi5Grxgcw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jZTfgJfEHeLtKcIhMomoErL10riEOHHtW7Ft7sAsx7Q+xHLC4lvhZrRNRFcWZ8Bz0
         puf59w+9SQ6+GehmgOogWpM9hL9FKqYJfAcKVQx8FKqpMb14i05a7NlWkn8KoMpR8l
         nSlTWfM57+K+0DLn0QJnNK9O1m4eaq/ZtGeT/DdcPVQKKYI9jNyvpjEhSBVQPgSEBy
         C6AHUpGw66v3KMXsBRcQm4qW2+WTXM8JBtuq8Isye4QyQ/Gb3SXkJf/0D4YJOw3oJx
         l5jzDCkl/0b8H6cqJrkVYRV9vSwIHQdSlHOj95xgeNI+3mZVwYTl7S9NOuSWNP4DZ4
         bkDRL9zWJnmEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBBA8E85BCB;
        Fri,  8 Apr 2022 05:38:35 +0000 (UTC)
Subject: Re: [GIT PULL] cifs client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtTvgsopF33=mxKxMW5WJDs_ErLGG4p-PPofDEM-cwwkQ@mail.gmail.com>
References: <CAH2r5mtTvgsopF33=mxKxMW5WJDs_ErLGG4p-PPofDEM-cwwkQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtTvgsopF33=mxKxMW5WJDs_ErLGG4p-PPofDEM-cwwkQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-rc1-smb3-fixes
X-PR-Tracked-Commit-Id: 7cd1cc415dd8d0dca7244c9eafb9a0adc8036805
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a5dcfd1e8789053730908c96639151b4151c4d0
Message-Id: <164939631583.5614.13271867538823225589.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 05:38:35 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Apr 2022 17:43:59 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-rc1-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a5dcfd1e8789053730908c96639151b4151c4d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

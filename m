Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FA35355FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbiEZWFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiEZWEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:04:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF375DA3A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37A2FB820D9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE3B5C385B8;
        Thu, 26 May 2022 22:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653602686;
        bh=3YahBxcqwrlACESTCA7z3PCyV1FncahlTuC/rwvUouY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h7wXT+9Bzx7WMvqlD48DS1I4bIyr4yG0YsvlcweLxq34AiCbwlbYGiBSQR5D1QOWr
         LlHm40N1wSRXKqv3JunoIsVzc3qvH9ao8VVzLYKxN72f3yTuhjS2BD2E+8ahk4zMrW
         0VnNnypgfqFDsuuKlbXrCIv7Uw9kVw+29gehWR/E6ISj9yOsGf1H7nbClxR5RyWFid
         +1kq0FBLu32MbfNCIYgdkvCKva22pH2QwXuVZI9pfLKWPQfOY7MyJCHLQQ0IbW7oGK
         r6GD8unSAaQqwsDuGnA1HsDsq11+UPt/8I7eg/f0YrJkf3JoWwu/0MJB11gxnuQcGu
         OGCuhZJZycycQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB1A4F03938;
        Thu, 26 May 2022 22:04:45 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yo7YztZklByTINZp@google.com>
References: <Yo7YztZklByTINZp@google.com>
X-PR-Tracked-List-Id: <chrome-platform.lists.linux.dev>
X-PR-Tracked-Message-Id: <Yo7YztZklByTINZp@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/ tags/tag-chrome-platform-for-v5.19
X-PR-Tracked-Commit-Id: abd4fd43f2af03e2e852e6b1b98faeee9e3eae55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1f88bb51f1ae9d7eec9ef871355dea033bac02d
Message-Id: <165360268589.24340.12642622200377938586.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 22:04:45 +0000
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     torvalds@linux-foundation.org, pmalani@chromium.org,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        groeck@chromium.org, tzungbi@kernel.org,
        chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 May 2022 09:33:02 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/ tags/tag-chrome-platform-for-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1f88bb51f1ae9d7eec9ef871355dea033bac02d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

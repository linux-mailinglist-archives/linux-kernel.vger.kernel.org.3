Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43356C1C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbiGHUdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbiGHUdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:33:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABF2A2E47;
        Fri,  8 Jul 2022 13:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD1F5B8296C;
        Fri,  8 Jul 2022 20:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82371C341CE;
        Fri,  8 Jul 2022 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657312358;
        bh=4ghO7709zqtRzcG888UFLc3SNVYYK8d4TwSLquewVno=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=phWM5KmWj6bm5zi07Q67ib9HXaLNo+tq5KSzXUyl9RSpfCHGBfWpRhCYmipVgHTrV
         z/NV5SCZNRWaqOmyxfFO16G9zlSIA//RsvCQEJWRqjgLhfhjtYqSInAOfSMEAjw/I9
         ZgDK0q4o6I9P6C6yYzPLUru+vULdg1YhHh8EAQe0zuxfg5ptJ3DJo+B4p96B8KMpDi
         QgX1J90Ln+lVZz2jx/CxznxxHyJIhSkvI53/g8M+smdpNJmXEyKCXPX3q0IlX9gnL0
         m7pgQn5itXrCX6sQQOIVuG43WE3wWps5cCtOO6YaL8+ohOqVllQOf9PijF4iorNY20
         xGmNoUa7r1iGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E11BE45BDA;
        Fri,  8 Jul 2022 20:32:38 +0000 (UTC)
Subject: Re: [GIT PULL] cxl fixes for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e3b03cdf0c0ef173a11d30262eadb3d355e7dfea.camel@intel.com>
References: <e3b03cdf0c0ef173a11d30262eadb3d355e7dfea.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e3b03cdf0c0ef173a11d30262eadb3d355e7dfea.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-5.19-rc6
X-PR-Tracked-Commit-Id: e35f5718903b093be4b1d3833aa8a32f864a3ef1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 483e4a1d83db1a6d339cd76f7966bf9e1748f752
Message-Id: <165731235844.2541.4007951243022725056.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jul 2022 20:32:38 +0000
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Jul 2022 19:21:04 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-5.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/483e4a1d83db1a6d339cd76f7966bf9e1748f752

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

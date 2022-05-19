Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460E152C8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiESAf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiESAfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1371B195794
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37266617CB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98090C385A5;
        Thu, 19 May 2022 00:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652920518;
        bh=wuyS1mwcRAj75EAvdOibrn6SrHd1AA9h0bpI7ToYXXo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Mic/E4A783+GVxW3KPsZm4oKSeZFMed3DtBgrBu67E/4ac3+ZGazJmN1E1p6dT4sv
         vz3bUJisKVzv3f2EncfY9tk4kLmCy2+t01WtWh2dUFUnnrSaeaV2E3fqaydE0xXzhP
         TiTuyCL4TCWNAgxvfP4JqF2GAv7Wnt5hMDRPYZ4P+VxYf9Bzws9OtmoNoAxb/S5ScC
         uUp8j5867PYI+2IQbaBsfNLyFuIIcCX//j/PxHRI3SEh4h2dgs+XALdlkU0T2F2oIn
         rQaCCU8rBhnVEqqXVn1HN1L6DDafkT13zvR0awAxn7rXlqvIwf5qbzK3FzR69UVXjt
         v0J0mFIqZhWTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84ADCF0383D;
        Thu, 19 May 2022 00:35:18 +0000 (UTC)
Subject: Re: [GIT PULL] Audit fixes for v5.18 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhT+4RXb_q=OkBQY-p1L9OpGF3n8GG+3T3xm=3gGzHKZFA@mail.gmail.com>
References: <CAHC9VhT+4RXb_q=OkBQY-p1L9OpGF3n8GG+3T3xm=3gGzHKZFA@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhT+4RXb_q=OkBQY-p1L9OpGF3n8GG+3T3xm=3gGzHKZFA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220518
X-PR-Tracked-Commit-Id: 69e9cd66ae1392437234a63a3a1d60b6655f92ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8194a0089207e8fff75a4dee2b98b0a537be2c54
Message-Id: <165292051853.29647.269420528956906637.pr-tracker-bot@kernel.org>
Date:   Thu, 19 May 2022 00:35:18 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 May 2022 14:17:09 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220518

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8194a0089207e8fff75a4dee2b98b0a537be2c54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

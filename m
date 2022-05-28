Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3846536AC2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 06:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355779AbiE1EeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 00:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355688AbiE1EeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 00:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09A5D5FE;
        Fri, 27 May 2022 21:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA44660B56;
        Sat, 28 May 2022 04:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13C91C34100;
        Sat, 28 May 2022 04:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653712448;
        bh=Zz0PDhW/cfQuL+8IPPj/9mTD5ewL3zI9sgHvV+Vf2+c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EU+m/8lcL9GyxUSVPJlOf2o0N1yKnwUJYvaAz05Lb0zmr22bjWEjrFXqViRieXa/L
         8o6XKyz79FBPeMVhvb7PbOhbVaBQekn9FPJ1J8yoCjet1aiZVbIr590tmDufy5TzRs
         7Cxu6/5DWf6IpI6pYTt6yxW+Mzj+RtnPJMi+CH4JBx2feDjFLsUyECHXTig0QDCGy/
         +f7ygVpfNZ7CIfCnIbgOAx+6HvwfUH1CjNcM/TKkLWfugui0qbc6U93AS7ryTRjvlA
         wIWdyGPs4ZvmEp07NvYIK9/DgPM6EQTPHsqrIkcHmA7k8wY7gptZ3i6GOBOyqqE/wf
         yos3eKKAo2+1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 020DEF03942;
        Sat, 28 May 2022 04:34:08 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gmk-69G+eqtxqeNUoy0G9XPvdTJg1h32_F9qudbx4SOw@mail.gmail.com>
References: <CAPcyv4gmk-69G+eqtxqeNUoy0G9XPvdTJg1h32_F9qudbx4SOw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gmk-69G+eqtxqeNUoy0G9XPvdTJg1h32_F9qudbx4SOw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.19
X-PR-Tracked-Commit-Id: 34e37b4c432cd0f1842b352fde4b8878b4166888
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d004b2f4fea97cde123e7f1939b80e77bf2e695
Message-Id: <165371244800.8420.17303389715375838317.pr-tracker-bot@kernel.org>
Date:   Sat, 28 May 2022 04:34:08 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 May 2022 16:02:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d004b2f4fea97cde123e7f1939b80e77bf2e695

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402CB59181B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 03:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiHMB07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 21:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiHMB04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C9797D6C;
        Fri, 12 Aug 2022 18:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3DCB618F2;
        Sat, 13 Aug 2022 01:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21951C433D6;
        Sat, 13 Aug 2022 01:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660354015;
        bh=lyRmjFGIbs4ko2ouk9DOxHN1kpnt7xd8zDXs/O0/pR0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I559PTEJjGDjqCuDr8jf78ccPS3UN3EmYZ+2dgO789XIfxdodeQypyO6B6Nm2XP5K
         yFKtmcHdXDCbkviqMpacg+TOHKtS8elQZUCASAei9KJD3bLohWiYdTf3wKT8NgaLQ9
         mioiEjCsAO0bNS4JvQ8yJupp0JAdpXqeXrcM06j0IANwHBEUlMqdDI/gtvfD8AUIac
         a+kuQCLyvb6toQMilfavW5rTte/HCbMn38sLQ99kAAaQF4d5V9apHgNaq5edxt9lj7
         YmTJzT274Gq5kdo8wVdzxpOOfEMObuK0hKnzMkcqRpj8cZltIHL82NueW2W54nbxX6
         kXQ5ka4ipsSpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E803C43142;
        Sat, 13 Aug 2022 01:26:54 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.0, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220812181158.GA462401-robh@kernel.org>
References: <20220812181158.GA462401-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220812181158.GA462401-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.0-1
X-PR-Tracked-Commit-Id: 8f426582e0e0c9bbd58e170e1b209334eb5df79e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c833c0581f1c15db2e0344da19360cba75a3351
Message-Id: <166035401405.11884.8218962261872216983.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Aug 2022 01:26:54 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Aug 2022 12:11:58 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c833c0581f1c15db2e0344da19360cba75a3351

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

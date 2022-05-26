Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F6534757
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348158AbiEZAKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348029AbiEZAJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C7D62CC3;
        Wed, 25 May 2022 17:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 706B961265;
        Thu, 26 May 2022 00:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8F5AC3411D;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653523753;
        bh=529V3ZtFytlwcGl2dJT4JDAdZbCo4Wzy4dZEg097m5c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DDbBOTo9+QeAWtKHElom8+/kTnO4dUK7Mqw8guZWtXbjphc2Gn3Qq2FQS4C6G/iju
         1gArRCFr3bD3kxSgDhkzY+CuWfjTAJ/gEx53RlIaK3bfqr+qxL0Zc8Eb4F4i54Ov/s
         RuvMgOAEblBDETKTP3gNkRF0urN5iea8XeIgtcRPUCl2srHQ6nUCNTiNRB6SoGHfVC
         rEKHW23EjsRzflx6wkOQPG94N2fonb1QVhdBRSTn6miqFjUdcgoVCOQT6EV4IUKVRH
         zKuZ0aEs4CdUj3PvFRGh4toGX4l371CNL6CHSo9glE45FvI035Vn+aXue+A9jDsZrr
         VDOjDuLWZeIJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C83F4F03942;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220524224404.GA373873-robh@kernel.org>
References: <20220524224404.GA373873-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220524224404.GA373873-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.19
X-PR-Tracked-Commit-Id: d036d915b61f23b9e80d93f8a606eebf3bfab73f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86c87bea6b42100c67418af690919c44de6ede6e
Message-Id: <165352375381.5177.9424932820877351997.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 00:09:13 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 17:44:04 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86c87bea6b42100c67418af690919c44de6ede6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

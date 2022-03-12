Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33FB4D7071
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiCLSor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiCLSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:44:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573FD75C0B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 10:43:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94D3760AC9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 18:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09EBCC340EB;
        Sat, 12 Mar 2022 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647110614;
        bh=SOEtNXca/Xag3RtSB9diIP6WIHevhXQY97WA683OjJs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X0LocuaKjNUxM/g7b1eZkZB3B91HhGe14MAHhvyhbxViQ6LKaIjxZgTDBrvZMTTpO
         Twjsgk1VpIpDHnS1RPFWH1wSAyv6sq6GSgMRIWFFBMV1dPOr5BLVI9BzArv5nQJaec
         qrvhhtPr+BOKCv1YVD0TcHV8hWQCRi6reIBCkN3oGQBDe0df/JsnWrcIdwsVtOh8Df
         +9n8edZFb4PXjHCsuA0OyrTferrvxLmkHCo+RcxCSsjYqMPkF4ZVGzB5vhxnGdpjyJ
         XwSmybUCyAO02jcD4GdMP8NoKa+B3C147eBLAAw9U98NPfDoHssuHqb5pT0xUO2Lpg
         3hQak5r7goy5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA498E73C2D;
        Sat, 12 Mar 2022 18:43:33 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.17-rc8 (kconfig fix)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyAqzcvaba2OffVt_EEP_1tQc3UV6h1J92An0uKOF1TJA@mail.gmail.com>
References: <CAPM=9tyAqzcvaba2OffVt_EEP_1tQc3UV6h1J92An0uKOF1TJA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyAqzcvaba2OffVt_EEP_1tQc3UV6h1J92An0uKOF1TJA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-12
X-PR-Tracked-Commit-Id: 3755d35ee1d2454b20b8a1e20d790e56201678a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1518a4f636b39718788c81154420d7abc62fd839
Message-Id: <164711061395.14941.8983804138437798191.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Mar 2022 18:43:33 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@leemhuis.info, Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Mar 2022 17:45:38 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1518a4f636b39718788c81154420d7abc62fd839

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

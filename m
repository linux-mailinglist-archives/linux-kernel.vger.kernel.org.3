Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B596953AC38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356502AbiFARzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356446AbiFARzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E58939EF;
        Wed,  1 Jun 2022 10:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D7D361644;
        Wed,  1 Jun 2022 17:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC6DFC385A5;
        Wed,  1 Jun 2022 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654106139;
        bh=0ItadwMm29vJ1zHfzLVPLhBgFIzFEnmSYsCzUYRqPno=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gxovU47OO9hMBZmtdFQOs1LZHMF+EU6kmuVI111ORfSdlxYEvau+TjuDiMxMpRGLH
         GhnXlsVkg2vtxBgXYf9IpWpd5r3UCo2P6WYu+gpwexfwQ48P3rARYPNxpG+wMaoY1u
         juJTb5vsADLmmVWQ1U2MqGW4DOCIibYHr3YVLiw7qKVhw3zEa2WoFed/pBL/BMyzxB
         fNlnmXGz1hReVvGMuSCmmqyYVWxoeCVWoK5/6ubp1vpT6f0G3mEsDKqLRxmco1Jdnp
         lJwy9bh1P+1j/hGcMFXwTmQQTVuTqR0Rz1979nnO9I+ys46yZponSCyNdJzIIKlhjs
         Ruokit6eAW6Fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C40DEF03944;
        Wed,  1 Jun 2022 17:55:39 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.19-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220601080749.B1672C385A5@smtp.kernel.org>
References: <20220601080749.B1672C385A5@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220601080749.B1672C385A5@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc0
X-PR-Tracked-Commit-Id: ebf2a3521738520e12849b221fea24928b3f61ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 129bdb30fb054875f2068ccce376b865076d9934
Message-Id: <165410613979.7706.6418260632355087647.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 17:55:39 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 01 Jun 2022 10:07:46 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/129bdb30fb054875f2068ccce376b865076d9934

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

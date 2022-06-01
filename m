Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A398753AFAC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiFAVxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiFAVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C599021270;
        Wed,  1 Jun 2022 14:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 638546135F;
        Wed,  1 Jun 2022 21:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9F8BC385B8;
        Wed,  1 Jun 2022 21:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654120383;
        bh=2ef3IVdlKcVfrNV1wmzB14KcX264rHauUU7I1DoOyjQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WiFyOVlwugMVfCb4Lu9oeF2o3pnYumCIrgPYM0fzgfVGW8Vx4vj2uR61K63dxflsn
         ERgVpaY5bsjVJ0V2Fd9Ck9Y+UyLhV2rdpCV8aq37sZKcaRSnkvWcrV+mtkRAK2hZuh
         T1DSjkNnmiRX20McC1DaRm2hl6U8TTkeoOFQNZ4Iqp2b2RuBZT4NLrLodmBVkNFq0b
         +GybdCqaXlvULVrCyT6K3bfisaZ4EivZxKyKBR90UG9wLHP8rM6bYU6TbR0dLy1eSm
         7o/QReeEmYJ82aAYCRhM1b7C2ZXFRhKFqbCtdlthvKs3I+UidDupOVxv9UYtw2eQTo
         UGr06fCnUvMVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4300F0394E;
        Wed,  1 Jun 2022 21:53:03 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v5.19 Merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220601164751.GA15198@www.linux-watchdog.org>
References: <20220601164751.GA15198@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220601164751.GA15198@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.19-rc1
X-PR-Tracked-Commit-Id: 5d24df3d690809952528e7a19a43d84bc5b99d44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96752be4d7b443e6f1e322428d61f777d7d8bd4d
Message-Id: <165412038373.5556.14925725235196892855.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 21:53:03 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrej Picej <andrej.picej@norik.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        David Heidelberg <david@ixit.cz>,
        Eliav Farber <farbere@amazon.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>,
        Miaoqian Lin <linmq006@gmail.com>, Peng Fan <peng.fan@nxp.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Primoz Fiser <primoz.fiser@norik.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Runyang Chen <runyang.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Xiantao Hu <xt.hu@cqplus1.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Jun 2022 18:47:51 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96752be4d7b443e6f1e322428d61f777d7d8bd4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

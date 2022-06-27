Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0BF55C93F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbiF0XAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbiF0XAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB54120F5E;
        Mon, 27 Jun 2022 16:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 672DD6152E;
        Mon, 27 Jun 2022 23:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B91F4C34115;
        Mon, 27 Jun 2022 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656370813;
        bh=Cz/mDLhtdOHDanqNZb29JFI8MUxivS35BpGxClMYb/4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vIUOwrANsGFnJKMs0wcS/+4g7TJ2Tl/KKXsuhRKu5Nl1vZinaHOcdIT6f9kx+AJkx
         rWuU8NZcpnQajR+O47at7kYCtapC5ZqMMV7SJmiZA2KygQQ9WG+y//e6AgAjf81diB
         s414gD+9B8inUlu8XZlHD/ET+4EHqEuWusj2M9hNT3dxaEzdKsET24RKpfofSas4Iu
         GwhnGYniaG2r5OFkRFVRBDGWZEoFkc1Vod/VqmpdINNDl+crmHsKlKHTqGY+uVvAXQ
         cqL0Zuddg8rlH+eoXzGmV6Qo0HHIZ//m/IkUhW0cTuk4N4wbktHXQB+0oerAgzv+RO
         GFCTLIEkGQlgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96E0DE49BBA;
        Mon, 27 Jun 2022 23:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btmtksdio: Add in-band wakeup support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165637081361.14351.14905070415572630432.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Jun 2022 23:00:13 +0000
References: <848d3d5baf23eb78411a9672b8973ae3c593db98.1656285304.git.objelf@gmail.com>
In-Reply-To: <848d3d5baf23eb78411a9672b8973ae3c593db98.1656285304.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yake.yang@mediatek.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Jun 2022 07:27:36 +0800 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Commit ce64b3e94919 ("Bluetooth: mt7921s: Support wake on bluetooth")
> adds the wake on bluethooth via a dedicated GPIO.
> 
> Extend the wake-on-bluetooth to use the SDIO DAT1 pin (in-band wakeup),
> when supported by the SDIO host driver.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btmtksdio: Add in-band wakeup support
    https://git.kernel.org/bluetooth/bluetooth-next/c/681ec6abcd7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



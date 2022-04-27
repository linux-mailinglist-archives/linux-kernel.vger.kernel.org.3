Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1491D512228
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiD0TLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiD0TLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996384EC2;
        Wed, 27 Apr 2022 12:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8152B6151F;
        Wed, 27 Apr 2022 19:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAEE3C385AF;
        Wed, 27 Apr 2022 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651086011;
        bh=BR8Nx5V0ctF4VhQqy59tGJCpM99Usfg6y5bXRmiMcUE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=APZkRWMJTnxGEVNnIEjEvi5wwO1L7qm5TyI6nzt+XU16+Aw7GgQT/QLtiFlH/Nv2s
         RjGxhZserePOc/zKKHOy84W+8RNvzIAc2knWKXi4Mz1yvRxVAng+t7Q3as4rhB7vBS
         drqSEtJnHAV7hiaci/EjLSLccGZ8QqM2/VLnlBj7q4rnOoTrKKJPt0ozZCBzGnBppx
         Q9zheUXwtzFVE3KJis8O6MQ3L+rm8yJ4dD76sOJOAkGI7qVImHQ8cZLSKY4YjvBN2y
         d3FuRw8GDKlZrpdoRvSz8WITMbjokXEdrfHqR1b0z3Ual4Ox7rqd95HQNqJB2J+df3
         N4SsZQ6C8njJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB4FAEAC09C;
        Wed, 27 Apr 2022 19:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add a new PID/VID 0489/e0c8 for MT7921
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165108601175.12854.4715052613865968017.git-patchwork-notify@kernel.org>
Date:   Wed, 27 Apr 2022 19:00:11 +0000
References: <1b7d9428ba0c6d572d7da1da166240833350786e.1651082524.git.objelf@gmail.com>
In-Reply-To: <1b7d9428ba0c6d572d7da1da166240833350786e.1651082524.git.objelf@gmail.com>
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
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu, 28 Apr 2022 02:38:39 +0800 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add VID 0489 & PID e0c8 for MediaTek MT7921 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add a new PID/VID 0489/e0c8 for MT7921
    https://git.kernel.org/bluetooth/bluetooth-next/c/48b57999e387

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06BC5A8957
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiHaXKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHaXKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8590A4F195;
        Wed, 31 Aug 2022 16:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CF1561BF7;
        Wed, 31 Aug 2022 23:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E02EC433D7;
        Wed, 31 Aug 2022 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661987416;
        bh=f3qOYIe1QSt67LuPHFAD+HBeB9IZ+ctIbxbt2beu2tQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TGXxfSVTvBclj1I5dBxzfDEHnw8aiVZTp58g0GYg19jEMXORAxf6cyxuYDu0erJMI
         sHP866M8Sew/vyUh6o9jNAiC4TS2DzCoFjRLKVntjpTamrvVTqm8au6xDBve6C+l2Q
         nuJkv7Ipvnqihu8ZGlWLIXWuG/rGCtAs7PK94GQ1J9nBDhIouHeb2NCohrDZtKRLsS
         E4xVv2yYKcNhjtEPO4JGKidc1j6RmlkITc+LlekzCo+Vf+pVEUlcy8qB/kHoLZxxeM
         ph+mojQT0CL19z5rH0zhe+VkjhxHknUtCyYPl51F4+Atpx94/bPASDvBJkoRvDlWGw
         ZZL4lASLrmmmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 437D4C4166F;
        Wed, 31 Aug 2022 23:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: btusb: RTL8761BUV consistent naming
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166198741627.19908.15124677919927831058.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 23:10:16 +0000
References: <20220825224208.343700-1-labuwx@balfug.com>
In-Reply-To: <20220825224208.343700-1-labuwx@balfug.com>
To:     Szabolcs Sipos <labuwx@balfug.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 26 Aug 2022 00:42:07 +0200 you wrote:
> Based on photos available from the FCC, all currently supported RTL8761B
> series USB dongles have the same chip: RTL8761BUV.
> 
> rtl8761bu is often used to refer to this chip.
> rtl8761b sometimes refers to this chip, and other times to its
> UART variant (RTL8761BTV).
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btusb: RTL8761BUV consistent naming
    https://git.kernel.org/bluetooth/bluetooth-next/c/d8daa3991652
  - [2/2] Bluetooth: btusb: Add RTL8761BUV device (Edimax BT-8500)
    https://git.kernel.org/bluetooth/bluetooth-next/c/c7577014b74c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



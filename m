Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD057BB47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbiGTQU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiGTQUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF510F9;
        Wed, 20 Jul 2022 09:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BDE7B81FF0;
        Wed, 20 Jul 2022 16:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46480C341CB;
        Wed, 20 Jul 2022 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658334017;
        bh=02mfOT/LNfo1htT3gJX5Keg7sCR5gHvTONV+tS55ZaI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kKMVE/G8mhQXxQB2v9O0HtfO2d+P4niXl7ZwIjSce5yLuwgFH5p8BgGj9uNXAveDF
         kOI9JX9b5U5dDUUdGA31OfRGXSjG+pXhSBLsSNeLKlOTDrxrTFFpizM35ouV6pgZqo
         rpE529faYr97oLdFMLzdUG6WE5QVT4Tii6hjPLijR786GpsfcZf+jpfJxLcT086yWG
         kpnMMiJ5AaWqsvxjl+ohV5qovXA+AOMuY3/MvNcVDWue381ZrS9wNSQ0EWJFd34sUp
         2Ucpc7NlZDTcbue7eYctDlcCnAijEh7nNqOjcoYx1l5LPDW6s3rLhTYvzVDjvxoEQE
         FnmYUgoEGRc4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DC37E451BA;
        Wed, 20 Jul 2022 16:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] Bluetooth: btusb: Add support IDs for Realtek RTL8852C
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165833401718.6265.12264941461051970407.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Jul 2022 16:20:17 +0000
References: <20220714112523.13242-1-hildawu@realtek.com>
In-Reply-To: <20220714112523.13242-1-hildawu@realtek.com>
To:     Hilda Wu <hildawu@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.chou@realtek.com, alex_lu@realsil.com.cn, kidman@realtek.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Jul 2022 19:25:18 +0800 you wrote:
> From: Hilda Wu <hildawu@realtek.com>
> 
> Add support IDs to usb_device_id table for Realtek RTL8852C.
> Support VID, PID as below
> 0x04CA, 0x4007
> 0x04c5, 0x1675
> 0x0CB8, 0xC558
> 0x13D3, 0x3587
> 0x13D3, 0x3586
> 
> [...]

Here is the summary with links:
  - [v2,1/5] Bluetooth: btusb: Add Realtek RTL8852C support ID 0x04CA:0x4007
    https://git.kernel.org/bluetooth/bluetooth-next/c/5ce548c49ce0
  - [v2,2/5] Bluetooth: btusb: Add Realtek RTL8852C support ID 0x04C5:0x1675
    https://git.kernel.org/bluetooth/bluetooth-next/c/35de797dc6c7
  - [v2,3/5] Bluetooth: btusb: Add Realtek RTL8852C support ID 0x0CB8:0xC558
    https://git.kernel.org/bluetooth/bluetooth-next/c/aec73886e6b5
  - [v2,4/5] Bluetooth: btusb: Add Realtek RTL8852C support ID 0x13D3:0x3587
    https://git.kernel.org/bluetooth/bluetooth-next/c/f0dc2393fbbf
  - [v2,5/5] Bluetooth: btusb: Add Realtek RTL8852C support ID 0x13D3:0x3586
    https://git.kernel.org/bluetooth/bluetooth-next/c/8dd512ca4609

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



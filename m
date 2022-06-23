Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F72355894E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiFWTlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiFWTlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5748314
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0D8B619AC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A561C341CA;
        Thu, 23 Jun 2022 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656012723;
        bh=phMTE8CzqM5mBvwWHtWEHzVtgbVj6FCykiDNoK2d+oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGu6X7+W+gOcPWmM8juqj1oW0Rb8iSYd82y4LXnfFawxMY025/7DEQiZbWdJbtfeJ
         6YzwgOtNO/odbyvRyfJ8KY62k2uz8XCbnO96voar4d9noZmX7v9gcMm/wB072vMxy8
         spdCJnyMsx/Em1REU6MPKzKVmMVrr6ssp9lJcx4pUDJpBDisZdrSFUJXA/JCsN8kHp
         pRtf+ZHRP655zARZZ8mlmJw+VL2qmwwMyukKbtT/wgzK9CqP7KzgmPKNPTLStQ5x2f
         cCBzoa4x6Zm7RaQJiRU9PgS2GSSj2AoIGyq5ZCydCbBl6zyTddFlJqH/e1/STWcJ3q
         kmQd1sFJ3GasQ==
From:   Will Deacon <will@kernel.org>
To:     Nick Terrell <terrelln@fb.com>, Jisheng Zhang <jszhang@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: boot: add zstd support
Date:   Thu, 23 Jun 2022 20:31:37 +0100
Message-Id: <165600561071.3000949.3078410310675163227.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220619170657.2657-1-jszhang@kernel.org>
References: <20220619170657.2657-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 01:06:57 +0800, Jisheng Zhang wrote:
> Support build the zstd compressed Image.zst. Similar as other
> compressed formats, the Image.zst is not self-decompressing and
> the bootloader still needs to handle decompression before
> launching the kernel image.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: boot: add zstd support
      https://git.kernel.org/arm64/c/9f6a503d5238

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

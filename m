Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116A2565895
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiGDO1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiGDO1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF5F6367
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C67A61680
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 14:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F916C341C7;
        Mon,  4 Jul 2022 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656944833;
        bh=UHu9NiSpBxsagmxd5UWxkbaTuX2dneSMeeiV154O3tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uy9t21/cJ2X32Z/uNfrP9gaiJu9OsyM4tfKwKQVT5E35B51AxnN6n7K4trMDFRIwk
         nPeh/ElfyTYKLhYl9ePx88wVvu1oiTy0AYnxbMIdaZrCkzGDQa1FpnTG9vLc5Wo/Zw
         VfPWL0NdmGgjdTkCDqciiTnaFt4f/CuqsEMNA8+HUzi7+gXxOnudZStNEKAQ82ecZU
         I7UfIv+yCl/h6BvMbWEX2uvl/Tf63FN0Ksfe4ZtxwuIAIzDUcCoMLiFOR4xVbp0Azn
         Zv9nJBqao2V6OaagigcMZSfokX1gHgA9/0xkNd4C++f6hTFHlCXhsnniBkuIxGl0Y9
         dRj9+Fx9OQVfA==
From:   Will Deacon <will@kernel.org>
To:     hewenliang4@huawei.com, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Martin Ma <Martin.Ma@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        haibinzhang <haibinzhang@tencent.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH V2] arm64: fix oops in concurrently setting insn_emulation sysctls
Date:   Mon,  4 Jul 2022 15:27:06 +0100
Message-Id: <165693354046.771971.2373295195543693899.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <9A004C03-250B-46C5-BF39-782D7551B00E@tencent.com>
References: <9A004C03-250B-46C5-BF39-782D7551B00E@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jul 2022 05:43:19 +0000, haibinzhang (张海斌) wrote:
> How to reproduce:
>     launch two shell executions:
>        #!/bin/bash
>        while [ 1 ];
>        do
>            echo 1 > /proc/sys/abi/swp
>        done
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: fix oops in concurrently setting insn_emulation sysctls
      https://git.kernel.org/arm64/c/af483947d472

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

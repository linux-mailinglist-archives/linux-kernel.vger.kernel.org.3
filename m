Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3BC5328B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiEXLRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbiEXLQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:16:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E48C2E0BC
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:16:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s845DZdz4yTV;
        Tue, 24 May 2022 21:16:04 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
        YueHaibing <yuehaibing@huawei.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220517094900.14900-1-yuehaibing@huawei.com>
References: <20220517094900.14900-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] powerpc/kaslr_booke: Fix build error
Message-Id: <165339057419.1718562.13519076380982149999.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 17:49:00 +0800, YueHaibing wrote:
> arch/powerpc/mm/nohash/kaslr_booke.c: In function ‘kaslr_get_cmdline’:
> arch/powerpc/mm/nohash/kaslr_booke.c:46:2: error: implicit declaration of function ‘early_init_dt_scan_chosen’; did you mean ‘early_init_mmu_secondary’? [-Werror=implicit-function-declaration]
>   early_init_dt_scan_chosen(boot_command_line);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~
>   early_init_mmu_secondary
> arch/powerpc/mm/nohash/kaslr_booke.c: In function ‘get_initrd_range’:
> arch/powerpc/mm/nohash/kaslr_booke.c:210:10: error: implicit declaration of function ‘of_read_number’; did you mean ‘seq_read_iter’? [-Werror=implicit-function-declaration]
>   start = of_read_number(prop, len / 4);
>           ^~~~~~~~~~~~~~
>           seq_read_iter
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kaslr_booke: Fix build error
      https://git.kernel.org/powerpc/c/cdf87d2bd12cf3ea760a1fa35907a31e5177f425

cheers

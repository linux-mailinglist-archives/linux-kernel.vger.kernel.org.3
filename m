Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05F535546
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbiEZU6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiEZU6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:58:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A336E64EC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:58:30 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nuKYt-0006bZ-PZ; Thu, 26 May 2022 22:58:27 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        hch@lst.de
Subject: Re: [PATCH 0/4] riscv: some svpbmt fixes
Date:   Thu, 26 May 2022 22:58:27 +0200
Message-ID: <3505332.hdfAi7Kttb@diego>
In-Reply-To: <20220518170254.3178923-1-heiko@sntech.de>
References: <20220518170254.3178923-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 18. Mai 2022, 19:02:50 CEST schrieb Heiko Stuebner:
> Some additionals comments and notes from autobuilders received
> after the series got applied, warranted some changes.
> 
> So this is a small collection of cleanups for the svpbmt v10 series.

I've just sent a v2 of this which added another patch onto the series.

See https://lore.kernel.org/r/20220526205646.258337-1-heiko@sntech.de


Heiko

> Heiko Stuebner (4):
>   riscv: drop cpufeature_apply_feature tracking variable
>   riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol
>   riscv: make patch-function pointer more generic in
>     cpu_manufacturer_info struct
>   riscv: fix dependency for t-head errata
> 
>  arch/riscv/Kconfig              |  9 +++++++--
>  arch/riscv/Kconfig.erratas      |  1 +
>  arch/riscv/kernel/alternative.c | 18 +++++++++---------
>  arch/riscv/kernel/cpufeature.c  |  5 +----
>  4 files changed, 18 insertions(+), 15 deletions(-)
> 
> 





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC2A513133
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiD1K0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiD1K0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:26:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC711C1C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62AB761E0B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74574C385A0;
        Thu, 28 Apr 2022 10:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651141386;
        bh=pW5AkClgtgif1M44ZzNbijRHv2tpBkE6aFgaCTHtRDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMMQ1lV6tn8qLAy770WrJmRL1aTPgDjpxYBBaYLkNno7Vg8e8DuwMYiBGZJ37uMX8
         3JS1f2RRPW210PErlb8DQQFTHwOMqAP4/i/pgq5JPSOdyOR3S/mK3lUltj1f/VG2ox
         P1N9ngpbTjAkUBL9hKyjmQ7y5Pf/gSx9m5g+JtsMBfbiajCpGTIoIMkMsPXroIEMp/
         FV2px9r3jeC+ZyakRNvyF0msy7vH1ICEBbWtbyO0iYSCzd2cMwc829Tag1A+pH0LpZ
         arZLAsiPSxjGhhdONyzxQ2sYKlEEzIxxjzYnrSBRtcyR+JPur16Td8TVCMVMSMPI/r
         Or0Rqukays14Q==
Date:   Thu, 28 Apr 2022 11:23:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2] arm64: add the printing of tpidr_elx in __show_regs()
Message-ID: <20220428102301.GB14123@willie-the-truck>
References: <20220316062408.1113-1-thunder.leizhen@huawei.com>
 <165108481148.3292741.14737552201298089977.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165108481148.3292741.14737552201298089977.b4-ty@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 07:40:15PM +0100, Catalin Marinas wrote:
> On Wed, 16 Mar 2022 14:24:08 +0800, Zhen Lei wrote:
> > Commit 7158627686f0 ("arm64: percpu: implement optimised pcpu access
> > using tpidr_el1") and commit 6d99b68933fb ("arm64: alternatives: use
> > tpidr_el2 on VHE hosts") use tpidr_elx to cache my_cpu_offset to optimize
> > pcpu access. However, when performing reverse execution based on the
> > registers and the memory contents in kdump, this information is sometimes
> > required if there is a pcpu access.
> > 
> > [...]
> 
> Applied to arm64 (for-next/misc), thanks!
> 
> [1/1] arm64: add the printing of tpidr_elx in __show_regs()
>       https://git.kernel.org/arm64/c/9ec393c812f2

heh, I wasn't expecting you to apply this, but also hadn't realised nobody
had reviewed it. I've replied with my concerns, so please can you drop it
for now?

Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6824B5547BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354650AbiFVJXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbiFVJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:23:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD1BE0A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38A20619F6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCA4C34114;
        Wed, 22 Jun 2022 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655889793;
        bh=7fHHDkehM6lB1LRrqP2RiWl21e6DoMxp5gJe/CIGdJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iG+IDZLHRd0ylSv2ya+cSbnljLkg7WuUBnRqdj7LzZfq9/wPXCJb7o2yg1t5b6Q0U
         48pZ+SyFFQgSe6/nj/DQ/FLoSizevAQc+q+koMCX+tnG4OSSiuADqVvG7Tsg0HGo2i
         16owVOIrR8TMmGP6FvkoCLAZTEx7mcF4NtPvDqEmBDDbHq+1FVW95KKK39zS1Gc4j8
         x4OIGVrsx1qJHt0E/P0H/YS/PsjauPSoTthfUQk5E6ZdoiFGG5i7YtTciYVA4VyAk7
         2YCriC3CQG7rLV1Ea+qG+3B6G0KtN2USOmpBIjfjp7NwKhAGXtlHyBNKy+E3cfh+Gr
         iip10jnddtt/A==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o3wZr-002Ge5-Eo;
        Wed, 22 Jun 2022 10:23:11 +0100
MIME-Version: 1.0
Date:   Wed, 22 Jun 2022 10:23:11 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, joey.gouly@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64:kernel:Fix typo in comment
In-Reply-To: <20220622091951.53449-1-yuanjilin@cdjrlc.com>
References: <20220622091951.53449-1-yuanjilin@cdjrlc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8470ae8156fece707c949524925d862a@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuanjilin@cdjrlc.com, catalin.marinas@arm.com, will@kernel.org, joey.gouly@arm.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-22 10:19, Jilin Yuan wrote:
> Delete the redundant word 'ARM'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  arch/arm64/kernel/cpuinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 8eff0a34ffd4..bf61222c2c69 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -241,7 +241,7 @@ static struct kobj_type cpuregs_kobj_type = {
>  };
> 
>  /*
> - * The ARM ARM uses the phrase "32-bit register" to describe a 
> register
> + * The ARM uses the phrase "32-bit register" to describe a register

No. the expression "ARM ARM" refers to the ARM Architecture Reference 
Manual.

         M.
-- 
Jazz is not dead. It just smells funny...

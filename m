Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FF52B2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiERHE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiERHE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:04:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933A3985AD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 513A3B81E9B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C4AC385A5;
        Wed, 18 May 2022 07:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652857493;
        bh=5/SVsqjHtSz5a25oyFP2C2XiAM7dJCptaoUIfgrtXDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWw3wk+yMKhbEONY1F/y8qGpl/BwzUVdexM1njLQMEgLiXxY4+mUMrZ1As5X/Mnv1
         +kZAV7pQ/zQ7FDrP3EuH/NazlpUs661Ge8h5LH5Tf0wDIM8vRiCN7+2WRwPMrgoAQn
         44T1z4qccxjiIcLBR4T5qqKeIsuWMbDKITQP/GU4=
Date:   Wed, 18 May 2022 09:04:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
        mchehab+huawei@kernel.org, eugenis@google.com, tony.luck@intel.com,
        pcc@google.com, peterz@infradead.org, marcos@orca.pet,
        conor.dooley@microchip.com, nicolas.ferre@microchip.com,
        marcan@marcan.st, linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/8] drivers: base: Add Kconfig/Makefile to build
 hardware prefetch control core driver
Message-ID: <YoSajCpRsxlrHXcS@kroah.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-3-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518063032.2377351-3-tarumizu.kohei@fujitsu.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:30:26PM +0900, Kohei Tarumizu wrote:
> Adds Kconfig/Makefile to build hardware prefetch control core driver,
> and also adds a MAINTAINERS entry.
> 
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> ---
>  MAINTAINERS           | 6 ++++++
>  drivers/base/Kconfig  | 9 +++++++++
>  drivers/base/Makefile | 1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6d879cb0afd..f188403bc2e9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8620,6 +8620,12 @@ F:	include/linux/hwmon*.h
>  F:	include/trace/events/hwmon*.h
>  K:	(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)
>  
> +HARDWARE PREFETCH CONTROL DRIVERS
> +M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> +S:	Maintained
> +F:	drivers/base/pfctl.c
> +F:	include/linux/pfctl.h
> +
>  HARDWARE RANDOM NUMBER GENERATOR CORE
>  M:	Matt Mackall <mpm@selenic.com>
>  M:	Herbert Xu <herbert@gondor.apana.org.au>
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 6f04b831a5c0..8f8a69e7f645 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -230,4 +230,13 @@ config GENERIC_ARCH_NUMA
>  	  Enable support for generic NUMA implementation. Currently, RISC-V
>  	  and ARM64 use it.
>  
> +config HWPF_CONTROL

Shouldn't this have "GENERIC" in the name liks the other generic
implementations in this directory?


> +	bool "Hardware Prefetch Control driver"
> +	help
> +	  This driver allows user to control CPU's Hardware Prefetch behavior.
> +	  If the machine supports this behavior, it provides a sysfs interface.

But this is not a driver, it's a core function that a driver uses.  On
its own, this code does nothing.

thanks,

greg k-h

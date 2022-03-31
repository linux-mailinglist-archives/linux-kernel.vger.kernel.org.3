Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E824EE209
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbiCaTo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiCaToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:44:24 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F82623F9E4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:42:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bc27so605297pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qEPi6DppYoxU2evZZ00sDfEbEQwJezvupzY4bXgJJvE=;
        b=Qp2w4QzXAGQcQb2QyAc3nBMAFCSeUx76gQmZDosS+jKF7BpXGCT6LbReoC97lWREGw
         sNi6rgxHqqmrU/2aDpVIu0WJ1VNKxZIteBrcpUILZrFroLwxpnc4MvCnNskS3Wlxljdl
         GtWF2YK8rRCio8mJpu5gygNrl/88fy21roa7bzD2oSLL2Faji9RiW2hOMYGiT3N61jKt
         BYA0VgZoILLcQjDJrhvru95osHwJ6cMKsUJDsAKEPAibflN6tpanKHydJkFa4z9Bmlzp
         j8R/gjHNvXMKqg0oRIryiGeVyt1hTp5tZV4Ohw2ND6mBOGbOsI4nHCfiy33yozmcPkZ7
         lbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qEPi6DppYoxU2evZZ00sDfEbEQwJezvupzY4bXgJJvE=;
        b=ZcRwSNQukxkbh5bwHUbqcpZN5MuY1M5qeFPXF2G3S0DjcP2lPGfPlMlibsv8XAXbOZ
         AEQUnyr1Uj2xXMIMGvKSZGTjf5A6+xgLTG6usq5A1fs3gqJ0BrHO0Lif8Arn+DigC/hk
         gbR/JfE9NDmTmKX7P3bhoU71Ep0xm6phZfpWO3QSaxdJB85nJncNxrxzHRBvIJXLWtKd
         Se5iGjIH9bp2DfFTlFUVcGEnCVJewMuGbaSjjLBA9z031Im3EcXBzbpH7BY3JC9e8fAI
         kr8hjQ6cTpslkpn3nhECLuwRrNFiLO76OLQhD5fwEZob2CZgaWejL+y9G6MimVk/MuWf
         +XmA==
X-Gm-Message-State: AOAM532JjvbtpVx1VGXyBWAAGfjkL4KMILYhwflmXOnaWlCCCZ7JS2uZ
        AmxuMjNwp40teftCS4g/3i9VEppwU2v9Kg==
X-Google-Smtp-Source: ABdhPJxOP0vT3aSLvEQxxYn+4QTXcAAgQOlP3eNSJqVjCYYlah9s+sO3FQhgnfu6MpB47iCXqhK4+g==
X-Received: by 2002:a65:4503:0:b0:382:aad5:ad7d with SMTP id n3-20020a654503000000b00382aad5ad7dmr12186621pgq.488.1648755755822;
        Thu, 31 Mar 2022 12:42:35 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u204-20020a6279d5000000b004fa58625a80sm278641pfc.53.2022.03.31.12.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:42:34 -0700 (PDT)
Date:   Thu, 31 Mar 2022 12:42:34 -0700 (PDT)
X-Google-Original-Date: Thu, 31 Mar 2022 11:37:08 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Increase range and default value of NR_CPUS
In-Reply-To: <20220319121206.95919-1-apatel@ventanamicro.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     apatel@ventanamicro.com
Message-ID: <mhng-9cbb2a46-8bcb-4bfe-b927-0ed469dbd3a6@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2022 05:12:06 PDT (-0700), apatel@ventanamicro.com wrote:
> Currently, the range and default value of NR_CPUS is too restrictive
> for high-end RISC-V systems with large number of HARTs. The latest
> QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> restrictive for QEMU as well. Other major architectures (such as
> ARM64, x86_64, MIPS, etc) have a much higher range and default
> value of NR_CPUS.
>
> This patch increases NR_CPUS range to 2-512 and default value to
> XLEN (i.e. 32 for RV32 and 64 for RV64).
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
> Changes since v1:
>  - Updated NR_CPUS range to 2-512 which reflects maximum number of
>    CPUs supported by QEMU virt machine.
> ---
>  arch/riscv/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5adcbd9b5e88..423ac17f598c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -274,10 +274,11 @@ config SMP
>  	  If you don't know what to do here, say N.
>
>  config NR_CPUS
> -	int "Maximum number of CPUs (2-32)"
> -	range 2 32
> +	int "Maximum number of CPUs (2-512)"
> +	range 2 512
>  	depends on SMP
> -	default "8"
> +	default "32" if 32BIT
> +	default "64" if 64BIT
>
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs"

I'm getting all sorts of boot issues with more than 32 CPUs, even on the 
latest QEMU master.  I'm not opposed to increasing the CPU count in 
theory, but if we're going to have a setting that goes up to a huge 
number it needs to at least boot.  I've got 64 host threads, so it 
shouldn't just be a scheduling thing.

If there was some hardware that actually boots on these I'd be happy to 
take it, but given that it's just QEMU I'd prefer to sort out the bugs 
first.  It's probably just latent bugs somewhere, but allowing users to 
turn on configs we know don't work just seems like the wrong way to go.

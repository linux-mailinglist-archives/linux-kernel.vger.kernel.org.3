Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975F746364A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbhK3OSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242098AbhK3OSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:18:04 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF41C061574;
        Tue, 30 Nov 2021 06:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KgWIeLOf+hPIIUfEYbPiR7H+jakBISA9A6p+Lcr3OXA=; b=A1zJXn471mfYkvMNW9l0NjuGUL
        l5uTdpnbOzaMWtdgY36EnpDQ5CmQ27S8Cej1bprF6hA5vSbWEa7L9RR0Soktpsy6YZlYHsVh5Hbtf
        lQt8wPxRTTevFRlJXsRvG9EVldp5mFQxayVlohVoQkS9IIhqR4Akc8oBN4sI421gu0uxD7x3xaHLU
        9bh8zpbqrKRjgdg0G/jaoZEGBItdSMAnJwULoW6WDKeRhxZclK8Vb78MiAwUamXHBUHwZgXZnToEd
        SukoSAwT8M5FfgL69eJsCV5YRNrZqTcf35IsuxC9M80NqQGyPvkEoopL04f1gyb55Y/ikhx+qAkqR
        2Ha3vhEw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms3tn-001Sgj-P4; Tue, 30 Nov 2021 14:14:24 +0000
Message-ID: <f6c47b8c-6c88-f64f-fdaf-3bb240d4dab0@infradead.org>
Date:   Tue, 30 Nov 2021 06:14:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 5/6] crypto: xilinx: Add Xilinx SHA3 driver
Content-Language: en-US
To:     Harsha <harsha.harsha@xilinx.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     saratcha@xilinx.com, harshj@xilinx.com
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
 <1638262465-10790-6-git-send-email-harsha.harsha@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1638262465-10790-6-git-send-email-harsha.harsha@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 11/30/21 00:54, Harsha wrote:
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 51690e7..5df252e 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -796,6 +796,16 @@ config CRYPTO_DEV_ZYNQMP_AES
>  	  accelerator. Select this if you want to use the ZynqMP module
>  	  for AES algorithms.
>  
> +config CRYPTO_DEV_ZYNQMP_SHA3
> +	bool "Support for Xilinx ZynqMP SHA3 hw accelerator"

s/hw/hardware/

> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	select CRYPTO_SHA3
> +	help
> +	  Xilinx ZynqMP has SHA3 engine used for secure hash calculation.
> +	  This driver interfaces with SHA3 hw engine.

s/hw/hardware/

> +	  Select this if you want to use the ZynqMP module
> +	  for SHA3 hash computation.

thanks.
-- 
~Randy

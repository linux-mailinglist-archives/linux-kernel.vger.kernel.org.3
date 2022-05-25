Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC40E533693
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbiEYFwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242912AbiEYFv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:51:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382245933B;
        Tue, 24 May 2022 22:51:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q4so17680520plr.11;
        Tue, 24 May 2022 22:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sGMC9J3i2A0JEMEBRMvIAV6dTYRQjIEP1weGgAQj+xI=;
        b=DiEqRXuQ0GoU9KOzRPRrrP85Totp4N3hDUUUgE0VkGyrk02TPDqDfZBf70fDXvngz0
         mRai2GwSRPKbCa31jEvrNpaxeYx36xCanlyV1jjlbx98ff9RWsD6vnYfgrUPrtW7T7kt
         42JTkzlNn1glDLKL3mN5I69G1L1fgFFgtjELNHlXMA9xZkSV5ip/IzmXs8EG2kRn/BV4
         k+u4LL7A/ObwbTk+/E5XNX82YHAVXOMHdR0sGY0oaBIJEk6sw415oGineHm28+2MAsy+
         jz1lMhLLi6AEbMMo26XkRoKRnvYWV1OYi1nNcCotDO2m78AXiwHkYO1Z4hpj0hR1xiUI
         LfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sGMC9J3i2A0JEMEBRMvIAV6dTYRQjIEP1weGgAQj+xI=;
        b=yFrAJfvKS3xvboGBgqlGG9nFznLGMzkUbBsAqPz7QjNlos70MPXC5A4qG/2pKv/y9F
         5ZvfEiFa8fRQ44LEVXTkA6khkxAAvGsehHv7WD25QJPUgc4+qTljAWd+A27UrsLfGgHc
         WBqkpIqI5KuYtyqtNS7P6jGtecxgmlv7BiwQd8lvL9s72PsBZirq3aDwgFeTfm2LLw+G
         BV+LhCPm6KTviP9XB5xuNxJQN+k+AxuTXVsghKjJ1cQwOE+djFY8T/lmd32D3//TvmA3
         dduRGD8uS7FAs0rAPX9lpDH7r5OeUvBa/GF2ncqajT1lOI/B5sMgiCGACiakQ9GPxj6H
         UqZw==
X-Gm-Message-State: AOAM531S/ZXJEiIa6e6z+CJJiwchund2lHBZgZ5YfRNS1D5PIDUubQmt
        sg5/PBwdKueKIn9Byymdnr8=
X-Google-Smtp-Source: ABdhPJxNwMIEFHQuS5DfF434R//xq5CeNTJMpPj7HDMaFR3KodwuH3+S+ROhhzxSfE9XyFoU1wt8SA==
X-Received: by 2002:a17:90b:1e46:b0:1e0:10de:f8e4 with SMTP id pi6-20020a17090b1e4600b001e010def8e4mr8587987pjb.7.1653457914739;
        Tue, 24 May 2022 22:51:54 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a782:286b:de51:79ce])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902821100b0015e8d4eb2a8sm8134043pln.242.2022.05.24.22.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 22:51:54 -0700 (PDT)
Date:   Wed, 25 May 2022 11:21:49 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frank Rowand <frowand.list@gmail.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] of: check previous kernel's ima-kexec-buffer against
 memory bounds
Message-ID: <20220525055149.f4nqx2ocnh3pqnpr@riteshh-domain>
References: <20220524055042.1527968-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524055042.1527968-1-vaibhav@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just a minor nit which I noticed.

On 22/05/24 11:20AM, Vaibhav Jain wrote:
> Presently ima_get_kexec_buffer() doesn't check if the previous kernel's
> ima-kexec-buffer lies outside the addressable memory range. This can result
> in a kernel panic if the new kernel is booted with 'mem=X' arg and the
> ima-kexec-buffer was allocated beyond that range by the previous kernel.
> The panic is usually of the form below:
>
> $ sudo kexec --initrd initrd vmlinux --append='mem=16G'
>
> <snip>
>  BUG: Unable to handle kernel data access on read at 0xc000c01fff7f0000
>  Faulting instruction address: 0xc000000000837974
>  Oops: Kernel access of bad area, sig: 11 [#1]
> <snip>
>  NIP [c000000000837974] ima_restore_measurement_list+0x94/0x6c0
>  LR [c00000000083b55c] ima_load_kexec_buffer+0xac/0x160
>  Call Trace:
>  [c00000000371fa80] [c00000000083b55c] ima_load_kexec_buffer+0xac/0x160
>  [c00000000371fb00] [c0000000020512c4] ima_init+0x80/0x108
>  [c00000000371fb70] [c0000000020514dc] init_ima+0x4c/0x120
>  [c00000000371fbf0] [c000000000012240] do_one_initcall+0x60/0x2c0
>  [c00000000371fcc0] [c000000002004ad0] kernel_init_freeable+0x344/0x3ec
>  [c00000000371fda0] [c0000000000128a4] kernel_init+0x34/0x1b0
>  [c00000000371fe10] [c00000000000ce64] ret_from_kernel_thread+0x5c/0x64
>  Instruction dump:
>  f92100b8 f92100c0 90e10090 910100a0 4182050c 282a0017 3bc00000 40810330
>  7c0802a6 fb610198 7c9b2378 f80101d0 <a1240000> 2c090001 40820614 e9240010
>  ---[ end trace 0000000000000000 ]---
>
> Fix this issue by checking returned PFN range of previous kernel's
> ima-kexec-buffer with pfn_valid to ensure correct memory bounds.
>
> Fixes: 467d27824920 ("powerpc: ima: get the kexec buffer passed by the previous kernel")
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Cc: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>
> ---
> Changelog
> ==========
>
> v2:
> * Instead of using memblock to determine the valid bounds use pfn_valid() to do
> so since memblock may not be available late after the kernel init. [ Mpe ]
> * Changed the patch prefix from 'powerpc' to 'of' [ Mpe ]
> * Updated the 'Fixes' tag to point to correct commit that introduced this
> function. [ Rob ]
> * Fixed some whitespace/tab issues in the patch description [ Rob ]
> * Added another check for checking ig 'tmp_size' for ima-kexec-buffer is > 0
> ---
>  drivers/of/kexec.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 8d374cc552be..879e984fe901 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -126,6 +126,7 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
>  {
>  	int ret, len;
>  	unsigned long tmp_addr;
> +	unsigned int start_pfn, end_pfn;

^^^ Shouldn't this be unsigned long?

-ritesh

>  	size_t tmp_size;
>  	const void *prop;
>
> @@ -140,6 +141,22 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
>  	if (ret)
>  		return ret;
>
> +	/* Do some sanity on the returned size for the ima-kexec buffer */
> +	if (!tmp_size)
> +		return -ENOENT;
> +
> +	/*
> +	 * Calculate the PFNs for the buffer and ensure
> +	 * they are with in addressable memory.
> +	 */
> +	start_pfn = PHYS_PFN(tmp_addr);
> +	end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
> +	if (!pfn_valid(start_pfn) || !pfn_valid(end_pfn)) {
> +		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
> +			tmp_addr, tmp_size);
> +		return -EINVAL;
> +	}
> +
>  	*addr = __va(tmp_addr);
>  	*size = tmp_size;
>
> --
> 2.35.1
>

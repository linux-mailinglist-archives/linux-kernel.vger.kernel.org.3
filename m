Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5EE495848
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 03:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348540AbiAUC2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 21:28:42 -0500
Received: from foss.arm.com ([217.140.110.172]:33982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237728AbiAUC2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:28:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BF42ED1;
        Thu, 20 Jan 2022 18:28:41 -0800 (PST)
Received: from [10.163.74.170] (unknown [10.163.74.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E30F3F774;
        Thu, 20 Jan 2022 18:28:35 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: mm: apply __ro_after_init to memory_limit
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, rppt@kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com,
        geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3204def4-df7b-4a0c-1b8d-045ead96f0b2@arm.com>
Date:   Fri, 21 Jan 2022 07:58:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/21 12:15 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This variable is only set during initialization, so mark with
> __ro_after_init.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index a8834434af99..db63cc885771 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -172,7 +172,7 @@ int pfn_is_map_memory(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(pfn_is_map_memory);
>  
> -static phys_addr_t memory_limit = PHYS_ADDR_MAX;
> +static phys_addr_t memory_limit __ro_after_init = PHYS_ADDR_MAX;
>  
>  /*
>   * Limit the memory size that was specified via FDT.
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

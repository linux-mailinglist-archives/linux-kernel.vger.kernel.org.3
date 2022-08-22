Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F48F59BF45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiHVMJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiHVMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:08:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A75B175A9;
        Mon, 22 Aug 2022 05:08:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47C0012FC;
        Mon, 22 Aug 2022 05:08:58 -0700 (PDT)
Received: from [10.57.14.241] (unknown [10.57.14.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11DA13F718;
        Mon, 22 Aug 2022 05:08:52 -0700 (PDT)
Message-ID: <638e0a6e-10d2-8552-a61f-c4c001a2cbe9@arm.com>
Date:   Mon, 22 Aug 2022 13:08:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/2] cpufreq: CPPC: Change FIE default
Content-Language: en-US
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        robert.moore@intel.com, punit.agrawal@bytedance.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20220819162547.141333-1-jeremy.linton@arm.com>
 <20220819162547.141333-3-jeremy.linton@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220819162547.141333-3-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/22 17:25, Jeremy Linton wrote:
> FIE is mostly implemented as PCC mailboxes on arm machines.  This was
> enabled by default without any data suggesting that it does anything
> but hurt system performance. Lets change the default to 'n' until
> hardware appears which clearly benefits.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   drivers/cpufreq/Kconfig.arm | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 954749afb5fe..ad66d8f15db0 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -22,7 +22,7 @@ config ACPI_CPPC_CPUFREQ
>   config ACPI_CPPC_CPUFREQ_FIE
>   	bool "Frequency Invariance support for CPPC cpufreq driver"
>   	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
> -	default y
> +	default n
>   	help
>   	  This extends frequency invariance support in the CPPC cpufreq driver,
>   	  by using CPPC delivered and reference performance counters.

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

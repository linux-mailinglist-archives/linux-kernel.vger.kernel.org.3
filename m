Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1EB52C66F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiERWk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiERWkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:40:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD8199B36;
        Wed, 18 May 2022 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=GgPwDRKqmwh+3nf8RK2HuPZBwmSHU5n4+PACGphCjCg=; b=hxTeOn0zISLG/VnFdZjRUun7ad
        JB1mLXvP1pVAyPEim1QmiD9im2kAd+8Xi5EKsDP2fr/Ov7vLEokFCRIhMWQqfm8gr5mNxf6qeM403
        dudw54WQaqkhBnQfmbY2aXxC98A2hkbaIgmhti6JfcMYGCTAoYgpXBF15I4JgajJMmq1kVPQIQyP5
        bLzHNgEXdnsqatZzgCfnsVZz9PzIgZ0jTOigGIXLxfhj4cnDHKvy9ujhGfZ+lq8RY06nuYWTXKZ1S
        rFysqISE6RLID0/CHQZaBwRnlCHmYZ95yVU1N86QO0pNia+wELr3oxHi4d/LW3+nB3ncUUGgWaWR8
        NscroP8A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrSKv-001fuK-Vu; Wed, 18 May 2022 22:40:10 +0000
Message-ID: <65f17e84-83e4-c33a-1718-fbb5841cef46@infradead.org>
Date:   Wed, 18 May 2022 15:40:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: linux-next: Tree for May 18
 (arch/x86/kernel/cpu/microcode/intel.o)
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
References: <20220518202934.730a8aba@canb.auug.org.au>
 <8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org>
 <YoVlwN/IeVXoMaq1@zn.tnic>
 <df5ed1d0-6304-89b8-ad68-0cf6a59d8614@infradead.org>
 <YoVzUxSwhoim9TOX@zn.tnic>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YoVzUxSwhoim9TOX@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/22 15:29, Borislav Petkov wrote:
> On Wed, May 18, 2022 at 02:54:45PM -0700, Randy Dunlap wrote:
>>
>>
>> On 5/18/22 14:34, Borislav Petkov wrote:
>>> On Wed, May 18, 2022 at 02:05:28PM -0700, Randy Dunlap wrote:
>>>> on x86_64:
>>>>
>>>> CONFIG_PROCESSOR_SELECT=y
>>>> # CONFIG_CPU_SUP_INTEL is not set   <<<<<
>>>> CONFIG_CPU_SUP_AMD=y
>>>> # CONFIG_CPU_SUP_HYGON is not set
>>>> CONFIG_CPU_SUP_CENTAUR=y
>>>> CONFIG_CPU_SUP_ZHAOXIN=y
>>>>
>>>> CONFIG_MICROCODE=y
>>>> CONFIG_MICROCODE_INTEL=y   <<<<<
>>>> CONFIG_MICROCODE_AMD=y
>>>
>>> Hmm:
>>>
>>> $ grep -E "(PROCESSOR_SELECT|CPU_SUP|MICROCODE)" .config
>>> CONFIG_PROCESSOR_SELECT=y
>>> # CONFIG_CPU_SUP_INTEL is not set
>>> CONFIG_CPU_SUP_AMD=y
>>> # CONFIG_CPU_SUP_HYGON is not set
>>> CONFIG_CPU_SUP_CENTAUR=y
>>> CONFIG_CPU_SUP_ZHAOXIN=y
>>> CONFIG_MICROCODE=y
>>> CONFIG_MICROCODE_INTEL=y
>>> CONFIG_MICROCODE_AMD=y
>>> CONFIG_MICROCODE_OLD_INTERFACE=y
>>>
>>> that builds fine here on tip/master. Or is it linux-next specific? I'd
>>> hope not.
>>>
>>> Can you send me your whole .config pls and how exactly you reproduce it,
>>> i.e., on which tree?
>>
>> This is linux-next-20220518. config file is attached.
> 
> Ah, got it, that's the IFS thing which uses microcode loader functions.
> 
> I think this below but will do more poking tomorrow on a fresh head.
> 

Thanks. If you like this patch, you can add

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

to it.

> 
> ---
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 60e9be91250e..ba1e509d11bb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1321,7 +1321,6 @@ config X86_REBOOTFIXUPS
>  config MICROCODE
>  	bool "CPU microcode loading support"
>  	default y
> -	depends on CPU_SUP_AMD || CPU_SUP_INTEL
>  	help
>  	  If you say Y here, you will be able to update the microcode on
>  	  Intel and AMD processors. The Intel support is for the IA32 family,
> @@ -1341,7 +1340,7 @@ config MICROCODE
>  
>  config MICROCODE_INTEL
>  	bool "Intel microcode loading support"
> -	depends on MICROCODE
> +	depends on CPU_SUP_INTEL && MICROCODE
>  	default MICROCODE
>  	help
>  	  This options enables microcode patch loading support for Intel
> @@ -1353,7 +1352,7 @@ config MICROCODE_INTEL
>  
>  config MICROCODE_AMD
>  	bool "AMD microcode loading support"
> -	depends on MICROCODE
> +	depends on CPU_SUP_AMD && MICROCODE
>  	help
>  	  If you select this option, microcode patch loading support for AMD
>  	  processors will be enabled.
> diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
> index d84491cfb0db..aaaa5503951d 100644
> --- a/drivers/platform/x86/intel/ifs/Kconfig
> +++ b/drivers/platform/x86/intel/ifs/Kconfig
> @@ -1,6 +1,6 @@
>  config INTEL_IFS
>  	tristate "Intel In Field Scan"
> -	depends on X86 && 64BIT && SMP
> +	depends on CPU_SUP_INTEL && 64BIT && SMP
>  	select INTEL_IFS_DEVICE
>  	help
>  	  Enable support for the In Field Scan capability in select
> 
> 

-- 
~Randy

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B727D50F0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbiDZGK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiDZGKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:10:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 173EF97BBD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:07:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A2C823A;
        Mon, 25 Apr 2022 23:07:48 -0700 (PDT)
Received: from [192.168.225.134] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 726A83F5A1;
        Mon, 25 Apr 2022 23:07:46 -0700 (PDT)
Message-ID: <63deb092-4002-d798-410e-1db2081f0ef8@arm.com>
Date:   Tue, 26 Apr 2022 11:38:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] xtensa: enable ARCH_HAS_DEBUG_VM_PGTABLE
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org
References: <20220425180540.880632-1-jcmvbkbc@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220425180540.880632-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

Thanks for the patch. Just wondering if you ran with different config
options (which might impact test case selection) on/off during testing ?

- Anshuman

On 4/25/22 23:35, Max Filippov wrote:
> xtensa kernels successfully build and run with
> CONFIG_DEBUG_VM_PGTABLE=y, enable arch support for it.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  Documentation/features/debug/debug-vm-pgtable/arch-support.txt | 2 +-
>  arch/xtensa/Kconfig                                            | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
> index 83eafe1a7f68..ff21a83abe62 100644
> --- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
> +++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
> @@ -27,5 +27,5 @@
>      |       sparc: | TODO |
>      |          um: | TODO |
>      |         x86: |  ok  |
> -    |      xtensa: | TODO |
> +    |      xtensa: |  ok  |
>      -----------------------
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 2ed897299f19..903b910ebc10 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -4,6 +4,7 @@ config XTENSA
>  	select ARCH_32BIT_OFF_T
>  	select ARCH_HAS_BINFMT_FLAT if !MMU
>  	select ARCH_HAS_CURRENT_STACK_POINTER
> +	select ARCH_HAS_DEBUG_VM_PGTABLE
>  	select ARCH_HAS_DMA_PREP_COHERENT if MMU
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU

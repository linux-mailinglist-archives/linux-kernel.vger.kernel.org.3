Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F6C56650E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiGEIcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiGEIci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:32:38 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7139D;
        Tue,  5 Jul 2022 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1657009953; bh=EV/+FK0A80HVNjbe/Kswv8enUhc6feszv49QHR3ih80=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kbwBT7oePB/btU9gL35wABbCrXjx7kHq5BcaO8yQnvhel10BaRGjLqO66DRk41vQx
         /dzOscml65oeFYpiG1uZo4qDvHbwKHGRUPs2XaUGgn1L5JmM1Fz2z+tzw9Ldy2hxzx
         Sz0RdB1sDddHoV8DjR8CsAnfA46oSLbU0UxnZdzY=
Received: from [100.100.57.190] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id EB62C60114;
        Tue,  5 Jul 2022 16:32:32 +0800 (CST)
Message-ID: <f84bb217-7e2e-7919-6213-4a25ea76bf4f@xen0n.name>
Date:   Tue, 5 Jul 2022 16:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH] LoongArch: drop these obsolete selects in Kconfig
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705073405.29618-1-lukas.bulwahn@gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220705073405.29618-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/5 15:34, Lukas Bulwahn wrote:
> Commit fa96b57c1490 ("LoongArch: Add build infrastructure") adds the new
> file arch/loongarch/Kconfig.
>
> As the work on LoongArch was probably quite some time under development,
> various config symbols have changed and disappeared from the time of
> initial writing of the Kconfig file and its inclusion in the repository.
>
> The following four commits:
>
>    commit c126a53c2760 ("arch: remove GENERIC_FIND_FIRST_BIT entirely")
>    commit 140c8180eb7c ("arch: remove HAVE_COPY_THREAD_TLS")
>    commit aca52c398389 ("mm: remove CONFIG_HAVE_MEMBLOCK")
>    commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
>
> remove the mentioned config symbol, and enable the intended setup by
> default without configuration.
>
> Drop these obsolete selects in loongarch's Kconfig.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Huacai Chen, please pick this minor clean-up patch.
>
>   arch/loongarch/Kconfig | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 2dee595bf4b6..9be4d0eef299 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -54,7 +54,6 @@ config LOONGARCH
>   	select GENERIC_CMOS_UPDATE
>   	select GENERIC_CPU_AUTOPROBE
>   	select GENERIC_ENTRY
> -	select GENERIC_FIND_FIRST_BIT
>   	select GENERIC_GETTIMEOFDAY
>   	select GENERIC_IRQ_MULTI_HANDLER
>   	select GENERIC_IRQ_PROBE
> @@ -77,7 +76,6 @@ config LOONGARCH
>   	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>   	select HAVE_ASM_MODVERSIONS
>   	select HAVE_CONTEXT_TRACKING_USER
> -	select HAVE_COPY_THREAD_TLS
>   	select HAVE_DEBUG_STACKOVERFLOW
>   	select HAVE_DMA_CONTIGUOUS
>   	select HAVE_EXIT_THREAD
> @@ -86,8 +84,6 @@ config LOONGARCH
>   	select HAVE_IOREMAP_PROT
>   	select HAVE_IRQ_EXIT_ON_IRQ_STACK
>   	select HAVE_IRQ_TIME_ACCOUNTING
> -	select HAVE_MEMBLOCK
> -	select HAVE_MEMBLOCK_NODE_MAP
>   	select HAVE_MOD_ARCH_SPECIFIC
>   	select HAVE_NMI
>   	select HAVE_PERF_EVENTS

Looks good to me, thanks for the cleanup!

Reviewed-by: WANG Xuerui <git@xen0n.name>


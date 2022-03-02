Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6984CA5F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242212AbiCBN1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiCBN1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:27:12 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E474AC4B7C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:26:28 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K7vyn5r5Lz9sS9;
        Wed,  2 Mar 2022 14:26:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bws1KgY2kVPG; Wed,  2 Mar 2022 14:26:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K7vyn56R6z9sS8;
        Wed,  2 Mar 2022 14:26:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9EC1C8B76D;
        Wed,  2 Mar 2022 14:26:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VHSrabEcIYa5; Wed,  2 Mar 2022 14:26:25 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 81F458B763;
        Wed,  2 Mar 2022 14:26:25 +0100 (CET)
Message-ID: <318681e5-f65a-45e8-14f9-2cc341fb9b9a@csgroup.eu>
Date:   Wed, 2 Mar 2022 14:26:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] powerpc/pmac: remove not use symbol
Content-Language: fr-FR
To:     Zucheng Zheng <zhengzucheng@huawei.com>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org, oohall@gmail.com,
        akpm@linux-foundation.org, rppt@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210409093519.118000-1-zhengzucheng@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20210409093519.118000-1-zhengzucheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/04/2021 à 11:35, Zucheng Zheng a écrit :
> sccdbg symbol is not used, so remove it

You could mention that it hasn't been used since commit 51d3082fe6e5 
("[PATCH] powerpc: Unify udbg (#2)")


> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zucheng Zheng <zhengzucheng@huawei.com>
> ---
>   arch/powerpc/platforms/powermac/setup.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
> index db5107c80485..df9ea37d5708 100644
> --- a/arch/powerpc/platforms/powermac/setup.c
> +++ b/arch/powerpc/platforms/powermac/setup.c
> @@ -83,10 +83,6 @@ extern struct machdep_calls pmac_md;
>   
>   #define DEFAULT_ROOT_DEVICE Root_SDA1	/* sda1 - slightly silly choice */
>   
> -#ifdef CONFIG_PPC64
> -int sccdbg;
> -#endif
> -
>   sys_ctrler_t sys_ctrler = SYS_CTRLER_UNKNOWN;
>   EXPORT_SYMBOL(sys_ctrler);
>   

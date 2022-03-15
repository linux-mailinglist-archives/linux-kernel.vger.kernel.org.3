Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EF34D983D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346901AbiCOJ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiCOJ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:59:28 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF231E0BB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:58:16 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KHpkb2Q5cz9sSm;
        Tue, 15 Mar 2022 10:58:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SiX07j7Fb2Py; Tue, 15 Mar 2022 10:58:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KHpkb1MJQz9sSj;
        Tue, 15 Mar 2022 10:58:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ECA078B770;
        Tue, 15 Mar 2022 10:58:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tC4XK945PlwD; Tue, 15 Mar 2022 10:58:14 +0100 (CET)
Received: from [192.168.202.50] (unknown [192.168.202.50])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1342A8B763;
        Tue, 15 Mar 2022 10:58:14 +0100 (CET)
Message-ID: <1ee4d3e1-5d56-cb60-fb98-d8861e674c74@csgroup.eu>
Date:   Tue, 15 Mar 2022 10:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] powerpc:entry_32: correct the path and function name in
 the comment
Content-Language: fr-FR
To:     chenzefeng <chenzefeng2@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@c-s.fr, tglx@linutronix.de, bigeasy@linutronix.de,
        npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zengweilin@huawei.com
References: <20200807101956.67454-1-chenzefeng2@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20200807101956.67454-1-chenzefeng2@huawei.com>
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



Le 07/08/2020 à 12:19, chenzefeng a écrit :
> Update the comment for file's directory and function name changed.

The function name changed again with commit 714acdbd1c94 ("arch: rename 
copy_thread_tls() back to copy_thread()")

Please update the patch to just drop the file name. Users are able to 
find where the function is by themselves.

Thanks
Christophe

> 
> Fixes: facd04a904ff ("powerpc: convert to copy_thread_tls")
> Fixes: 14cf11af6cf6 ("powerpc: Merge enough to start building in arch/powerpc.")
> 
> Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
> ---
>   arch/powerpc/kernel/entry_32.S | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 8420abd4ea1c..9937593d3a33 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -696,8 +696,8 @@ handle_dabr_fault:
>    * to the "_switch" path.  If you change this , you'll have to
>    * change the fork code also.
>    *
> - * The code which creates the new task context is in 'copy_thread'
> - * in arch/ppc/kernel/process.c
> + * The code which creates the new task context is in 'copy_thread_tls'
> + * in arch/powerpc/kernel/process.c
>    */
>   _GLOBAL(_switch)
>   	stwu	r1,-INT_FRAME_SIZE(r1)

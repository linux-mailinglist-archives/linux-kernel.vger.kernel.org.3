Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CC84D986C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346976AbiCOKLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiCOKLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:11:02 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA33A5F1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:09:49 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KHpzw3hG5z9sSq;
        Tue, 15 Mar 2022 11:09:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YGMcKsXpEFIz; Tue, 15 Mar 2022 11:09:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KHpzv42Qhz9sSp;
        Tue, 15 Mar 2022 11:09:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 77E4E8B763;
        Tue, 15 Mar 2022 11:09:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pG6GkzyZ-p5f; Tue, 15 Mar 2022 11:09:47 +0100 (CET)
Received: from [192.168.202.50] (unknown [192.168.202.50])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E06898B774;
        Tue, 15 Mar 2022 11:09:46 +0100 (CET)
Message-ID: <c30b26fa-0495-89aa-c504-6fee09f86c56@csgroup.eu>
Date:   Tue, 15 Mar 2022 11:09:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH linux-next] macintosh: fix warning comparing pointer to 0
Content-Language: fr-FR
To:     jing yangyang <cgel.zte@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Zeal Robot <zealci@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>
References: <b12b200502312957065a12f8d78e8d250c244d21.1629193159.git.jing.yangyang@zte.com.cn>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <b12b200502312957065a12f8d78e8d250c244d21.1629193159.git.jing.yangyang@zte.com.cn>
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



Le 20/08/2021 à 04:34, jing yangyang a écrit :
> Fix the following coccicheck warning:
> 
> ./drivers/macintosh/windfarm_pm91.c:152:12-13:WARNING comparing pointer to 0
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>

WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email address 
mismatch: 'From: jing yangyang <cgel.zte@gmail.com>' != 'Signed-off-by: 
jing yangyang <jing.yangyang@zte.com.cn>'

Please resend.

Thanks
Christophe


> ---
>   drivers/macintosh/windfarm_pm91.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
> index 3f346af..568f8a2 100644
> --- a/drivers/macintosh/windfarm_pm91.c
> +++ b/drivers/macintosh/windfarm_pm91.c
> @@ -149,7 +149,7 @@ static void wf_smu_create_cpu_fans(void)
>   
>   	/* First, locate the PID params in SMU SBD */
>   	hdr = smu_get_sdb_partition(SMU_SDB_CPUPIDDATA_ID, NULL);
> -	if (hdr == 0) {
> +	if (!hdr) {
>   		printk(KERN_WARNING "windfarm: CPU PID fan config not found "
>   		       "max fan speed\n");
>   		goto fail;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E0B4D1822
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiCHMoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiCHMoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:44:19 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CE83A5FD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:43:22 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KCZkC5HhLz9sSV;
        Tue,  8 Mar 2022 13:43:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vgeW9xfmRpr1; Tue,  8 Mar 2022 13:43:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KCZkC4WH7z9sSR;
        Tue,  8 Mar 2022 13:43:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BAE98B779;
        Tue,  8 Mar 2022 13:43:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ay1nmVgEpnG8; Tue,  8 Mar 2022 13:43:15 +0100 (CET)
Received: from [192.168.202.9] (unknown [192.168.202.9])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E8BBF8B763;
        Tue,  8 Mar 2022 13:43:14 +0100 (CET)
Message-ID: <227e1408-4be3-9793-c604-d26875d0a586@csgroup.eu>
Date:   Tue, 8 Mar 2022 13:43:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] powerpc/ps3: Remove a couple of unneeded semicolons
Content-Language: fr-FR
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210508095150.2942-1-thunder.leizhen@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20210508095150.2942-1-thunder.leizhen@huawei.com>
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



Le 08/05/2021 à 11:51, Zhen Lei a écrit :
> The semicolon immediately following '}' is unneeded.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

A more recent version of your patch are available at 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/01647102607ce9640c9f27786d976109a3c4ea7e.1629197153.git.jing.yangyang@zte.com.cn/


> ---
>   arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
> index b431f41c6cb53ab..5c739267ddd2174 100644
> --- a/arch/powerpc/platforms/ps3/system-bus.c
> +++ b/arch/powerpc/platforms/ps3/system-bus.c
> @@ -603,7 +603,7 @@ static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
>   	default:
>   		/* not happned */
>   		BUG();
> -	};
> +	}
>   	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
>   			     &bus_addr, iopte_flag);
>   
> @@ -762,7 +762,7 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
>   		break;
>   	default:
>   		BUG();
> -	};
> +	}
>   
>   	dev->core.of_node = NULL;
>   	set_dev_node(&dev->core, 0);

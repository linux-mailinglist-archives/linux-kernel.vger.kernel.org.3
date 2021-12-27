Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171E84802E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 18:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhL0Rm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 12:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhL0Rm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 12:42:58 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BD8C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 09:42:58 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id p7so26047160ljj.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 09:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z/Pzs7cNZuKis90GG3bbsIu5TMKHsaB8FDneWM7eJxw=;
        b=K4bQIMvfBces3htJK287EvIQWGCqtRE442DkSrqrgTioEuTPI0TZphdrpMQrGIIVqL
         LMxhbgdGKYmrKWHg57eVKMA4uyyDHtBA4Ea/6hoJyAVkxT46mCWnLDmsNeVmVqarGHWU
         4I2+ecSZZN7sLla3yosSbdVBoyN1e35E4NebS099GRSWJOu/0022hpypM+pHw2SFK6nV
         q5TRI7FBhUDylzAlpxVZSRAJb2BmfuU1tM/Hyr6wAJ4CLHu4kXz4E+KdWEKwEwRvyVSk
         qGoBdH/Y64hFhVpCbB1wYBi8Ntgf434Me+ocJrBTGj6POIWeDi5Qrh25rLb2SXOiaA3x
         FErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z/Pzs7cNZuKis90GG3bbsIu5TMKHsaB8FDneWM7eJxw=;
        b=IoZ2wjRECXeqUEdabwjjtuzAZWNe1Dk3SsxgpH4L4z6FqbEUTgvxyTKKd9031DTHLU
         sabN0JUSWLUGN8vPy2RDqihOj6OaeBn7cRKTujBoS9+zifsAfo4weypXoW5UnZZJpUmW
         F4UjHatLBLJuY2gMOH2gmbqZHrOQftYx/1w6hfiEHHm+BAMOe85jzKAOW7M27PVYePya
         EYjf89Ht7D+ztfnx2SEFpeMypfHIBtFc2IgHatxoj6+3y7w7VcTDetLJhQs4G3HjFQdE
         o0KhgpMOUOXEdQF+2zp1KZBJA6Nhzrmu4u5ZDQTbfQyLczO0/DQHBIqHWiNoncodOEMZ
         /hpw==
X-Gm-Message-State: AOAM5300Zc4PgadpPVvHCKl2oPojs6HupiLALgzPdIX27nJ0NXJfOAeN
        mvYizh6kfPfrwFlidy5wB60=
X-Google-Smtp-Source: ABdhPJxTMynXzIeEeGWkYSA2Y4LAC2J4FkDRiycHyqOmu948dvds5O4/stRGWxQJzIgcV7HuMhGrJw==
X-Received: by 2002:a2e:4a0a:: with SMTP id x10mr14374504lja.322.1640626976434;
        Mon, 27 Dec 2021 09:42:56 -0800 (PST)
Received: from [192.168.1.11] ([94.103.235.97])
        by smtp.gmail.com with ESMTPSA id b14sm377920ljj.89.2021.12.27.09.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 09:42:56 -0800 (PST)
Message-ID: <671aa7f6-7dd2-792c-73bf-a8092f9e7910@gmail.com>
Date:   Mon, 27 Dec 2021 20:42:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] staging: rtl8192e: rtllib_module: add free for error exit
Content-Language: en-US
To:     Peiwei Hu <jlu.hpw@foxmail.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        trivial@kernel.org
References: <tencent_D7DF0257121D1A21F136595372ED101BA10A@qq.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <tencent_D7DF0257121D1A21F136595372ED101BA10A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 11:07, Peiwei Hu wrote:
> Original source code of alloc_rtllib returns directly in
> error, without freeing variable dev.
> 
> Signed-off-by: Peiwei Hu <jlu.hpw@foxmail.com>
> ---
>   drivers/staging/rtl8192e/rtllib_module.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> index 64d9feee1f39..18d898714c5c 100644
> --- a/drivers/staging/rtl8192e/rtllib_module.c
> +++ b/drivers/staging/rtl8192e/rtllib_module.c
> @@ -125,7 +125,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>   
>   	ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
>   	if (!ieee->pHTInfo)
> -		return NULL;
> +		goto failed;
>   
>   	HTUpdateDefaultSetting(ieee);
>   	HTInitializeHTInfo(ieee);


This one is already fixed in staging-testing branch. See commit 
e730cd57ac2dfe94bca0f14a3be8e1b21de41a9c


With regards,
Pavel Skripkin

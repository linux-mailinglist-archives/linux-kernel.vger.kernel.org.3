Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3C50D44D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiDXS4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 14:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiDXS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 14:56:13 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB1EAFADC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 11:53:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m23so2658841ljb.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FC/8yLdSqiq2IyvCXByJ/UPgQYfMYiDtun4dRAazNxU=;
        b=Q78roLaBQBx0gfXmK715idh3BO84YfUpV+y9xmJ5vf/qCZ6phRouk4OLl1ZVPxD/lc
         i2eh2l3J5ZYsGpGFPJVPmWsurzpr540+spGY2f6ikvXipHnjkeMVTyD81Jd7Kg6T4KP7
         g0W+nUb1rbm6HX1h/tlcI8aVwRf4lsMJzX8w5SA0B1w1nxf9pFK4AGSfHDGY0G5r4eqG
         Noe8KRdZUjEXnEGIRwNFzjsVw+VwfHQwwirwkilemBQ716SMj6UFDeaxVB7NxbkbbHH1
         2PekuhxRCBhDnAT84Z+97/q2YPpdHBn29KvVUBOUDQCLX6O/6LUs6537AvBtkuWJ6NuW
         ZSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FC/8yLdSqiq2IyvCXByJ/UPgQYfMYiDtun4dRAazNxU=;
        b=TsbTnG/hEfvy0nT3WFnovyetGq5Mch/BRaGbPcaCM/fkNG5PSs818rzFh/UU9EwbEa
         2Rt/Jba4GJUrWR9DoQXEfG/djxRLkUjq8w/+M2mEXQKwJAbBa4OVIlbdxRt6Agi8PayG
         ZvPAQIu8D+LcVDjKUrnTGzS28gMS5VjMv+/do6xrV8RKMvso1G8n4h9GiuWFIOH2VHKR
         CHEKXkqhHuO+6DlGpRpVIjvOWfSpO5DFu8OaO6PSk9fpGWmzgelGgjvGzsXaXnQmSaMZ
         5CX4KGh6AP264c3XhnCJTdWH21BLRJRWCVMu5I8YNqRl6WBlNd/xjn8pozrChGy4Dkz9
         tcjw==
X-Gm-Message-State: AOAM530KjTyBd47LDdhRqAgifdm2zC3JQbTAcGbU2yDugh68UsbjZoKH
        b76RIkanCQXawApVjUU+e3DNZvpS8fo=
X-Google-Smtp-Source: ABdhPJybHN9XnQZfI3riHPEAJN67QQsQUACTyDDu6Fl0+w3A3H5LdF/DAlyKBRYxsi8w/Wmc31Ubfg==
X-Received: by 2002:a05:651c:17a3:b0:245:f39e:f2d2 with SMTP id bn35-20020a05651c17a300b00245f39ef2d2mr9346694ljb.490.1650826390054;
        Sun, 24 Apr 2022 11:53:10 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id l26-20020a2e701a000000b0024f0d5fb1b0sm340283ljc.94.2022.04.24.11.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 11:53:09 -0700 (PDT)
Message-ID: <85f946c9-235e-cc69-4d19-1ebf972cd935@gmail.com>
Date:   Sun, 24 Apr 2022 21:53:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] staging: r8188eu: fix null check in
 _rtw_enqueue_recvframe
Content-Language: en-US
To:     Vihas Makwana <makvihas@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220424163132.37007-1-makvihas@gmail.com>
 <20220424163132.37007-3-makvihas@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220424163132.37007-3-makvihas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vihas,

On 4/24/22 19:31, Vihas Makwana wrote:
> There's a NULL check on padapter in rtw_recv.c:189 which makes no sense as
> rtw_recv.c:184 dereferences it unconditionally and it would have already
> crashed at this point.
> Fix this by moving the dereference line inside the check.
> 
> Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_recv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 4cf9b4b8f..7d306a3c6 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -181,12 +181,13 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
>   int _rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue)
>   {
>   	struct adapter *padapter = precvframe->adapter;
> -	struct recv_priv *precvpriv = &padapter->recvpriv;
> +	struct recv_priv *precvpriv;

Actually, `&padapter->recvpriv` is not a de-reference, it's just address 
calculation, so in case of padapder being NULL precvpriv will contain 
offsetof(struct adapter, recvpriv).

>   
>   	list_del_init(&precvframe->list);
>   	list_add_tail(&precvframe->list, get_list_head(queue));
>   
>   	if (padapter) {
> +		precvpriv = &padapter->recvpriv;
>   		if (queue == &precvpriv->free_recv_queue)
>   			precvpriv->free_recvframe_cnt++;
>   	}




With regards,
Pavel Skripkin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB850D459
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiDXTEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbiDXTEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:04:34 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279EF6339
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:01:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y19so4162483ljd.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+tusk1aAliVBnk698Wzreusezn6ixz2Ndj0yD2FT6oc=;
        b=IJ3yiYTbx1PS6R8J/dzPgtTLTnGNzwwOcXou8Z3ksezDlwUWJs6VmBY+p1ftGw7tSl
         mjZ9rwHSjgcfX5WknNLLAq1VLL8pB5N+rSDR5sXPk6a/ZbekHE3gxKK3gLkVMzFXnD28
         Ewz2+k9IMYx/Evk2TXQ6evAdofCjh1Ha/V3juheITvbC7/KcJ8mxQ3fBFGBbks+ko0zH
         j8D5MXMN1/M7z0yZO5B7Rba/qvyyhtmw+CgcL28eTchETC03Fj+7sP2a1pYzK4Ojg8oW
         0vMe0S3KxO8oj5nbZ/FPdDnx4cJSaFPmNca27EAZ8Swd3UMA4OmEA5hbI8pk9OiabUHK
         TKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+tusk1aAliVBnk698Wzreusezn6ixz2Ndj0yD2FT6oc=;
        b=leBr2/2HVGZf5XP+pEc+g5uFE2F58P6giU3s+pWVOAZunJOzcLbEwyiTV1wOn9kBSd
         KoU79nja9HVHALqxUiu/UIFES6fF5IexgcUMB413kEPb8qzSaOv1z2tMIyzQq4hl00fg
         wVntSL+zc2IY5cjkkIznJvjErrkY7myq1bwn6wp+QcMuyzjTYKI3Ojmx5qHRIgmEK9BE
         8+IDjA0a19vlaxpKwtkLSOoWYreQWBrsT4hT250g25XEURYp0cK/e3z3ZTzLnKDdvMYm
         vZ8T+gGlKpcHfE23nSJhbtZw0xG5VpaNOfcE55zxTWO1RNXyniFzmnM7epw2VQD5KebW
         yxMA==
X-Gm-Message-State: AOAM532N+WNUx/+hk3c6YETqrPEk/JOAvse4L2U/xJ5cVvd90BL18mQL
        MHYk05E1xTf2o8XIGFJ6/Qs=
X-Google-Smtp-Source: ABdhPJy6nfIi6y1OenfKsFPHIu8uWbc7mMPb+DsfPiY5lIpUSHJ15Zj0P3YBXEC0akZH5wGrwWh0yg==
X-Received: by 2002:a2e:9e19:0:b0:247:deb7:cd9f with SMTP id e25-20020a2e9e19000000b00247deb7cd9fmr8622396ljk.261.1650826891258;
        Sun, 24 Apr 2022 12:01:31 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id x16-20020a19e010000000b0046bb663f05csm1113153lfg.99.2022.04.24.12.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 12:01:30 -0700 (PDT)
Message-ID: <88d617e4-419c-0d57-b0e2-f743d208c766@gmail.com>
Date:   Sun, 24 Apr 2022 22:01:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] staging: r8188eu: fix null check in
 rtw_free_recvframe
Content-Language: en-US
To:     Vihas Makwana <makvihas@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220424163132.37007-1-makvihas@gmail.com>
 <20220424163132.37007-2-makvihas@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220424163132.37007-2-makvihas@gmail.com>
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
> There's a NULL check on padapter in rtw_recv.c:170 which makes no sense as
> rtw_recv.c:152 dereferences it unconditionally and it would have already
> crashed at this point.
> Fix this by moving the dereference line inside the check.
> 
> Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index c1005ddaa..4cf9b4b8f 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -154,7 +154,6 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
>   	if (!precvframe)
>   		return _FAIL;
>   	padapter = precvframe->adapter;
> -	precvpriv = &padapter->recvpriv;

This expression just an addr calculation, so it does not lead to panic 
in case of padapter being NULL

>   	if (precvframe->pkt) {
>   		dev_kfree_skb_any(precvframe->pkt);/* free skb by driver */
>   		precvframe->pkt = NULL;
> @@ -169,6 +168,7 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
>   	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
>   
>   	if (padapter) {
> +		precvpriv = &padapter->recvpriv;
>   		if (pfree_recv_queue == &precvpriv->free_recv_queue)
>   				precvpriv->free_recvframe_cnt++;
>   	}




With regards,
Pavel Skripkin

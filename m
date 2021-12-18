Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C503A479CAE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 21:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhLRUzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 15:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhLRUzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 15:55:14 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A05DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 12:55:14 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b40so12288582lfv.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 12:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=auxuvnZ7svhFSb9Rzfvb/JIfRxgci9V2UAifzlMOcTM=;
        b=ECYyBf96vaAHbThdqPJPqvy55VCW5ptYXqjca/Iny5gNxCMMRjjalHGlc/ey3bsDhw
         XNgYbcMmGR1jI+/nSaKJv+7FhD1ysd2X025a/k57GFrdC5g3o7fgjMY4SU/Ev/CBK8ub
         NOIkSiTXNtW93m6zN3RSeUk+cnW9XaRKkvFBwFAKyU0ShourbZ/vzvq14hQ8XngAh0uN
         zLZpyT7L1gL8gRe7SuhBvHllWUQFQeTt3SWXBB9wJHuwxsDDPAXhD0nyZpscrWy3OimC
         xWY6DuMw8w7w7BJmS+yXBBHCFfYtIw3grPCveJYkTOfiwqOPXch7GcK1MpwQ9q49B2z6
         pArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=auxuvnZ7svhFSb9Rzfvb/JIfRxgci9V2UAifzlMOcTM=;
        b=EnVMfzJe9iOo9HJ1WRJCKQZYUgj3hCGf1gvcQscvCdgZwmtEs2cmysWoXc2bcuZcBD
         f2QnNYAimfME7bDuVdfB736m1IXH5fL8VaviTCL/jZr/8bKiD4Ro4RUD5aaQwlU41DIG
         HByvoRT/3cSKZod3QcwuB54uCM04P5yAwCB1gYSg60wy25ak2hAscyUuuDrt/SzFGkw6
         g4OWhEMRHr0MNwz1BFJrM9zsczV3CkA/r0p/OVzNVlo0Jr635MjD9SCEy3hPntLVKoQU
         W5VPRFawgYfW1F3TgjAkt3dqdSObL7eJyiK2/B85IGBiVABcjUxCLGSK2INx5M8+TcZT
         dp0g==
X-Gm-Message-State: AOAM533OCX9pZATpAl0UnK5hrCfaLY58QqM8ZRyZzjehYZTShIdjZk3S
        E1FOFKzyBseKyD45JPWRtaevWs0kPaZTNw==
X-Google-Smtp-Source: ABdhPJwf5tLCYkS2sGY7VDb8SZxpGfIppK2DwajY7sfHp3THVu5O4SLuPJGD0ZAEshdlNhzdr5Ft7w==
X-Received: by 2002:ac2:4113:: with SMTP id b19mr8853709lfi.449.1639860912390;
        Sat, 18 Dec 2021 12:55:12 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.239])
        by smtp.gmail.com with ESMTPSA id j15sm1816002lfe.157.2021.12.18.12.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 12:55:12 -0800 (PST)
Message-ID: <63ff3ff8-e428-f0f6-eafc-3c517f34cb6c@gmail.com>
Date:   Sat, 18 Dec 2021 23:55:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] staging: rtl8723bs: Fix styling issues
Content-Language: en-US
To:     Ismayil Mirzali <ismayilmirzeli@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, simon.fodin@gmail.com
References: <20211218203647.24486-1-ismayilmirzeli@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211218203647.24486-1-ismayilmirzeli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/21 23:36, Ismayil Mirzali wrote:
> Removed extra whitespaces and brackets for oneline if statements
> 
> Signed-off-by: Ismayil Mirzali <ismayilmirzeli@gmail.com>
> ---
>   .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    | 20 ++++++++-----------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> index 7fe3df863fe1..7807b2a6cdc5 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> @@ -32,7 +32,7 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
>   	pHalData->SdioTxOQTFreeSpace -= agg_num;
>   
>   	/* if (n > 1) */
> -	/* 	++priv->pshare->nr_out_of_txoqt_space; */
> +	/*	++priv->pshare->nr_out_of_txoqt_space; */
>   

I believe, commented code should be just removed

>   	return true;
>   }

[...]

>   	rtw_unregister_tx_alive(padapter);
> @@ -311,7 +310,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
>   					pxmitframe->pg_num = (txlen + 127) / 128;
>   					pxmitbuf->pg_num += (txlen + 127) / 128;
>   				    /* if (k != 1) */
> -					/* 	((struct xmit_frame*)pxmitbuf->priv_data)->pg_num += pxmitframe->pg_num; */
> +					/*	((struct xmit_frame*)pxmitbuf->priv_data)->pg_num += pxmitframe->pg_num; */
> 

Same here


With regards,
Pavel Skripkin

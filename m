Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B034F6BDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiDFU6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiDFU5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:57:52 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F3B1A6355
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:22:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c15so4576515ljr.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IY7OoR//ShblW6kyrlBUUrXswtml+giyXaUgcmjOBHM=;
        b=cZSnajyumhDtwlZYKn5Kp6i7W3fmPF/lT40N9AKwMp/3M4ctrp/0elgIYKElOlxYuJ
         dNwH7Xt/YjA9YFJYQ/6E2NkeEqjGU4UX7Ic2yIEv1U7Dsqxo9sSeWgbFz3MhUtEYojyf
         9nYNiTrRwNhm61lkiu2KM/0xw9MS2ds35jIRMGBXsE2q3WmA0HZbgowV8BeWg7zNNpCf
         xnduV0oNV5ZsyxbKgEI4Fvh0D/wHCwPG4Cw7l+3CdHiEueTN5CCjWSM4Z7vwIh9vUEH4
         5FqsIL7t577nlmGFq/yDI0ari3NiRHdubB4D+MLsew7XiY6oM0EEsrE/YE9JU43Xdaa7
         xxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IY7OoR//ShblW6kyrlBUUrXswtml+giyXaUgcmjOBHM=;
        b=KW0OyWXyIdG0FkrZF7uxQoInwQ2VmqiGJowBUeajEZ5tE2wYeTo9bNx35mvrkzygm2
         cCb+7ulk8pgtus6fLJPHFBLsC8m1K+f6BY28JBuKuVclrSoKPeT8bvbR2Do6G9Ecrvo2
         wX2ketMf+u2y0PY3PXGyguKvk9L7Rj/DTSeWj0aXLj9gTn0SxOG4rCP3ID+0Gz/KD2xL
         i7Y9yltINwtMWbho3zGgawOgwYoc6n7csHOXch7/O1h3Ao7p9RLcXYK6fAHtYYAMk75o
         stymS2WhUsu+YKDjVyTfrt044T0UykYMYVQIz0UuoqmRdWcP1N0qJPmDKRxyuRweBs0x
         Ij/g==
X-Gm-Message-State: AOAM530MVdA6Amh+5C7sKPE9SzoGL/hbDUKrQ2Iauzb1eb2KHrkrgHfc
        tHYmEaIOO38Ruu9ge5h0RGA=
X-Google-Smtp-Source: ABdhPJxxrgebjuuBB7dcPiuGRipD55DeXg8mm2ww5jZSdBNZmrcUrW0k92dF38UmLa84zsunOxtpbA==
X-Received: by 2002:a2e:bd09:0:b0:247:e127:5e05 with SMTP id n9-20020a2ebd09000000b00247e1275e05mr6239533ljq.212.1649272941671;
        Wed, 06 Apr 2022 12:22:21 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id h23-20020a056512339700b0044a15d1c6adsm1919834lfg.26.2022.04.06.12.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 12:22:21 -0700 (PDT)
Message-ID: <9c307f1e-aa95-08e6-3a01-825caba19a30@gmail.com>
Date:   Wed, 6 Apr 2022 22:22:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] staging: r8188eu: check the return of kzalloc()
Content-Language: en-US
To:     xkernel.wang@foxmail.com, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <tencent_5AB92A7786438342357C5669E7BF0C249505@qq.com>
 <tencent_15C23F2EC8197361EE200714C54E78B45206@qq.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <tencent_15C23F2EC8197361EE200714C54E78B45206@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xkernel,

On 4/6/22 07:30, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to handle the return
> of it to prevent potential wrong memory access.
> 
> Besides, to propagate the error to the caller, the type of
> rtw_alloc_hwxmits() is changed and another check is added in its caller.
> Then if kzalloc() fails, the caller will properly jump to the
> corresponding error hanlding code.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> ChangeLog:
> v1->v2 update the description and adjust the sequence of patches.
>   drivers/staging/r8188eu/core/rtw_xmit.c    | 10 ++++++++--
>   drivers/staging/r8188eu/include/rtw_xmit.h |  2 +-
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index 865b2fc..92a1ad3 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -176,7 +176,9 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>   
>   	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
>   
> -	rtw_alloc_hwxmits(padapter);
> +	res = rtw_alloc_hwxmits(padapter);
> +	if (res == _FAIL)
> +		goto free_xmit_extbuf;
>   	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>   
>   	for (i = 0; i < 4; i++)
> @@ -1490,7 +1492,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
>   	return res;
>   }
>   
> -void rtw_alloc_hwxmits(struct adapter *padapter)
> +s32 rtw_alloc_hwxmits(struct adapter *padapter)
>   {

What about plain 'int'? I know that s32 is typedef for 'int', but 'int' 
looks more natural

just my 2c,


With regards,
Pavel Skripkin

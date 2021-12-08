Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860B846CDAE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 07:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbhLHGYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 01:24:53 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:44782 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbhLHGYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 01:24:51 -0500
Received: by mail-ed1-f49.google.com with SMTP id l25so4649131eda.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 22:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yLFaiVXI2PKCCjRQYkyNoYqPAYr0aGkvcoNe9DPOoAc=;
        b=6h4X2rcMgwYHUH0QrXiiqsz+qeNMfqAJsIITockET2074um2RQUTQ0BfUhoTuiE64V
         OKPz/eRTDcwCUkgv8UUX4W8RgIGn8vQQylWCbpXAGzpVjQJSujbLVMIRRA1dO8nCe39q
         sUaxtHsryzYYq5/r9hrIK76IokNX2qyflpWxPash06tWINt66U0Rron3uoje2ddHjIX4
         wtp43+5ygF+PrCgnM0ROdQGQ+a4OCl8Askb1y2ncyJPUbja8MxU9FgAg+v/HZBkM5HHC
         Zamk7KIxRtqQ3lOIlwSkS0Mmpzs+DQ+d3LBduFUJjcPrcod78sqMLq15WLf7/vwGFa/R
         S6Pw==
X-Gm-Message-State: AOAM532MlOulYs12bq792luug2TZ67k+3EI/VKsBYNlRvNIwdpLE6iJG
        a0f05lWTJJ7pWgT0imGI14a+OwDtoB8=
X-Google-Smtp-Source: ABdhPJynEwfxQRkePYnRDNk+Iqmb9wLorNxcoSaGkRkVKj5jAC1I0CfMaofIlbsEvO3oRjIrEZh6mg==
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr16291073edb.175.1638944479314;
        Tue, 07 Dec 2021 22:21:19 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id sa17sm902191ejc.123.2021.12.07.22.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 22:21:18 -0800 (PST)
Message-ID: <cf8de843-fb92-3ce6-2617-d324f4d0e411@kernel.org>
Date:   Wed, 8 Dec 2021 07:21:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] tty/ldsem: Fix syntax errors in comments
Content-Language: en-US
To:     Xiang wangx <wangxiang@cdjrlc.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20211205161544.12104-1-wangxiang@cdjrlc.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211205161544.12104-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 12. 21, 17:15, Xiang wangx wrote:
> Delete the redundant word 'are'
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Maybe you can add also a period to the end of the sentence.

> ---
>   drivers/tty/tty_ldsem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
> index ce8291053af3..3be428c16260 100644
> --- a/drivers/tty/tty_ldsem.c
> +++ b/drivers/tty/tty_ldsem.c
> @@ -163,7 +163,7 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
>   
>   	/*
>   	 * Try to reverse the lock attempt but if the count has changed
> -	 * so that reversing fails, check if there are are no waiters,
> +	 * so that reversing fails, check if there are no waiters,
>   	 * and early-out if not
>   	 */
>   	do {
> 


-- 
js

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3D55720E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiFWEuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344351AbiFWEVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:21:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3C72D1E9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:21:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q6so1460810eji.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UvEF84n19lSXOqhpJPPSQblDfpd6XZf1X0P1snbWIog=;
        b=Vl9rLwUwaeKipQIahhDvfesL7mLKD5q5lG+qEJ+AyqMb/Xw5nUurD3i3YIkSpsfHF9
         Ypp7wduhLoSWdVOuDBEF3w86EKbL650iusZN0MRzJoARloBjmDf7l63cuUCYDebI/DgM
         6bQ+eSHEKrXqoiO59CBd0G8idqfUVJvpjOdomBL3X2rKwXFDhVxd7NH42QsOFXAjt3eQ
         B9mKPH0NufWSXD7/QLoqk2z8vHtLn5g3GTwuADCAqpKTeYg1XJRZWdC71MwrGKJ14JQE
         EhWzEQS3SzdDkmR4d2Lncqw6Q9t3D9MnWfYAuqq9rakTfgbv0HKvjHANVFAEO7H9Sh5k
         79ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UvEF84n19lSXOqhpJPPSQblDfpd6XZf1X0P1snbWIog=;
        b=ICUW2uqpayw/c4jMr4Y3pMgDWFO3YrQnajfniw8orbhHaD/1qYCu56Cc5oGOKddZcI
         pU8peAOTeqdrZYTdOd43UB+fHDfdPXhZRkCxr57FFvytyj/5UoFXbdQrWMN7fj0mMCnv
         AHVu0N3hbNYCSdecMCpUJmN8IO9yGaAjqKOhfPwprhz+JF+nhaLlSmgZ+EwYWfUDrDRM
         gk0XLrBVyOn1Wwbhzr6lMa9fB+dC/ze96KpIcBcUmjPnWtghMS/u7Lu4l4OZ5v+Fll+c
         6JSa+0xZyPu0FKmfZ4mxPk3xhflgucy7xhJe44gQvHGSCQ43s9ermdsv94erTappMO15
         sVOA==
X-Gm-Message-State: AJIora+VIQfCPRzHOlKP4pm4Fs5l1DxaUV8FyxHQqipspNRg4Fsq8EEl
        bty48ak35gCwT254lL810Fnz9tMrS4Y=
X-Google-Smtp-Source: AGRyM1tcKwNKAopT/HBbeTPOpaKjfT3ou8JklgW1MgoCthPWnzDd8ytOhYyfoiOuT1VAZsPHz51DLw==
X-Received: by 2002:a17:906:7292:b0:712:3880:3e7b with SMTP id b18-20020a170906729200b0071238803e7bmr6143374ejl.118.1655958083170;
        Wed, 22 Jun 2022 21:21:23 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6923:8d97:93cc:4023:b7a9? (p200300c78f2e69238d9793cc4023b7a9.dip0.t-ipconnect.de. [2003:c7:8f2e:6923:8d97:93cc:4023:b7a9])
        by smtp.gmail.com with ESMTPSA id w26-20020a50fa9a000000b0043575ae2051sm10806022edr.62.2022.06.22.21.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 21:21:22 -0700 (PDT)
Message-ID: <be6cc1a5-3eab-d0d0-fd93-68afeed7d7a1@gmail.com>
Date:   Thu, 23 Jun 2022 06:21:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] staging: r8188eu: Make rtw_signal_stat_timer_hdl a static
 function
Content-Language: en-US
To:     Chang Yu <marcus.yu.56@gmail.com>, Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220623022425.395000-1-marcus.yu.56@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220623022425.395000-1-marcus.yu.56@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 04:24, Chang Yu wrote:
> Make rtw_signal_stat_timer_hdl a static function instead of a global
> function.
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index cc91638a085d..599d3e55be76 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -24,7 +24,7 @@ static u8 rtw_rfc1042_header[] = {
>   	0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
>   };
>   
> -void rtw_signal_stat_timer_hdl(struct timer_list *t);
> +static void rtw_signal_stat_timer_hdl(struct timer_list *t);
>   
>   void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
>   {

Hi,

thanks for your patch. I think you need the "static" for the declaration 
and the definition of the function. So it is missing in line 1789.

Thanks for your support.

Bye Philipp

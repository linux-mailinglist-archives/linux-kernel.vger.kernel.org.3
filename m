Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E9655B01A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiFZIAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 04:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiFZH77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 03:59:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC32912D03
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 00:59:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c65so8996152edf.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FGfEJIfpAO3ifCYE+j+FKpzzCLL1fsOI/LfCuS4Ctx4=;
        b=hVsKPanAgPTlQQ2KlEaZgSJCN4WxJ/bhyVoaAKC+GQRtuQEu5XciAohatfOVQ3n9Gd
         R1G5Pm4M6YIITh9nNpstLoNeDk0hzFNdjB0s73S1G3S8IBqcTGh+GlDwJdt/OsKD6GjG
         WQ9ZpN850Ujb4FFkBOrqcm7pLmYjHAYWap20quk02z5UqmiQd/XnNU6UnIrfBUmal2gy
         oUEs2rJp4B5Nc21fMX/+fVoEk/1e2HIqXRx8f3O7A5KgOm+hWynQ586DxO8O1hF868Wd
         SZZoHkwJhshVj0Kr0GH0AZC6UlFwHv3/eddFWlukCwDeZSWgkeT2Sl6uF8LhHbLX9MLq
         nsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FGfEJIfpAO3ifCYE+j+FKpzzCLL1fsOI/LfCuS4Ctx4=;
        b=GOecjCegT5g1YfrF3ayN9PbM2amIgoC2PTh7Kg0XOLvi4sCQPO+qkCvmdnfgzyBDJc
         4GoQCqhMezePpsKBZtVBjS+QsOOJGgVtU3T9YD16TdjOYNVMpZvU9dEo/+wXCKq7lKEl
         AVPkSS5czdEazAxMCuZq/YY/IZ2CmTRTqpAOYiuKBLZCNw5Al4fsY5DPaGFHyAbNLpen
         bAqDfmxv2Wqe0WirSaIZAVJNhaSMeIVBy4btzqRjfA4p3ABjDDhfe/U9akJlGXsKn53D
         /hAh4jbFyv0D/81ouq8LSqtrFQAdDXWl/XtnI0e1J98jGki+84WjwheDwwarD0RII64M
         Epgg==
X-Gm-Message-State: AJIora+Dab7p13AAxqIWs7EMiGDzxwxEvHzlTdBHNhW2cerHCi626UmP
        KrxLy3pJQ+w3m+2XkvCRzc4=
X-Google-Smtp-Source: AGRyM1tPjcCuJHZxbH40IV1VmbKiRpV2PzJITE7bIs848u8Bdot8X2fBkY++nMGLzarOKkGhagn6uA==
X-Received: by 2002:aa7:d294:0:b0:435:5d12:867f with SMTP id w20-20020aa7d294000000b004355d12867fmr9426843edq.147.1656230396316;
        Sun, 26 Jun 2022 00:59:56 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6976:d31e:943a:debd:7240? (p200300c78f2e6976d31e943adebd7240.dip0.t-ipconnect.de. [2003:c7:8f2e:6976:d31e:943a:debd:7240])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b004356d08bbbasm5442946edx.40.2022.06.26.00.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 00:59:55 -0700 (PDT)
Message-ID: <ae8d0b5f-3371-f6ee-6744-cebfc1a0d010@gmail.com>
Date:   Sun, 26 Jun 2022 09:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] staging: r8188eu: Remove null checking before freeing
 functions
Content-Language: en-US
To:     SebinSebastian <mailmesebin00@gmail.com>
Cc:     skhan@linuxfoundation.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220626074417.661312-1-mailmesebin00@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220626074417.661312-1-mailmesebin00@gmail.com>
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

On 6/26/22 09:44, SebinSebastian wrote:
> Fix the following coccicheck warning:
> drivers/staging/r8188eu/os_dep/usb_intf.c:376:2-7: WARNING: NULL check before some freeing functions is not needed.
> 
> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
> ---
>   drivers/staging/r8188eu/os_dep/usb_intf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 68869c5daeff..f5f1119b5444 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -372,8 +372,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>   free_adapter:
>   	if (pnetdev)
>   		rtw_free_netdev(pnetdev);
> -	else if (padapter)
> -		vfree(padapter);
> +	
> +	vfree(padapter);
>   
>   	return NULL;
>   }

Sorry to let you know that this patch was already send in:

Please read the following patches:

https://lore.kernel.org/linux-staging/CAD-N9QUpBHgtu8kssuf-22n94RnLDshioDaJTcFWNipvAuh08g@mail.gmail.com/T/#t

https://lore.kernel.org/linux-staging/20220614133239.147076-1-dzm91@hust.edu.cn/T/#u

Thanks for your support.

Bye Philipp

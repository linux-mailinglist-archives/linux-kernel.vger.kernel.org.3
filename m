Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB671596D55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiHQLJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiHQLJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:09:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A550B5143C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:09:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k17so6534953wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=WteKT+4JLVA9wGjzOghyLW0uiafqET9lTaWrhBtJk4U=;
        b=wTRvga5wMHoZtMVLL03Xy4b8gVmm2ULHgfoHcpDI++jIUm0SOD7yfLG5Ys71Uy46cI
         5X1PTEIXC7yQn3969B9aurqgZ7etJLFNweSPZOEPE8+0YwT4EcW/76GEa5IoHdEeRWtA
         YjhLyaybUS5xish4T73nPFuZ49jbuoffs3E2vvKVai4KOTL8Gt7B7CjFmEIU9bCSAQn0
         OvDEPRC8S6aQyBxISnZ8obqmhY1Y97aOvLUuUxBUYoGKjdw/pHSIN8XWHnOl4snrrmIE
         599Hu0AdGrzV4k47RWnk402mN35O0jJKDSRvHQ/qhRMaKJfVzc1/wxSa1Ce5P1jbiHpv
         Uxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WteKT+4JLVA9wGjzOghyLW0uiafqET9lTaWrhBtJk4U=;
        b=ImJreZ5TOnt4Cfk7mpG3JvsKO955sJ9ZVTlNsrdb6tF+g27FZzWc9nY5YaPABRazt0
         Ce8todZywoYmRpGzNexY+H4D0ETIEcq/qj4Z7N6sermtIQQWZmcjfWbeibaqrV2c/1tn
         DKUKNGT2sPCP9zNuC+v0IwPHO9FHeTf9Gnb+6tiUCCfuw0aMKTqwco+FOcRrfUb+eioD
         MNCoqdXm5FUNnAhRSLnIJyq/YNKlKQoc4CM90SW53PoWMbKVr0iSzM9UT1PhRdf++B4X
         ARHWnNEINVX+rGyWTW/eyqYs+EAKROHpuw9g3VWZmKUYkIzORaP388JExMFKUmK2nYaV
         7C4Q==
X-Gm-Message-State: ACgBeo3wEtRHUNONS47No0KlGuosWgYDjh4T57uCPbB8dUga86eA/M0n
        oD/dwpCBoTPU54UjJ0dNwyTCNQ==
X-Google-Smtp-Source: AA6agR4NGW5TXBJHvBkcxOr/0X71qoVLfzTASLnxl5VhIoA1sJ/NOYfw0x1xyH4uAMOuhVdzoT4oeg==
X-Received: by 2002:a7b:ce05:0:b0:3a5:c069:25b3 with SMTP id m5-20020a7bce05000000b003a5c06925b3mr1788560wmc.87.1660734539082;
        Wed, 17 Aug 2022 04:08:59 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id e2-20020a5d5942000000b0021e13efa17esm12660364wri.70.2022.08.17.04.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 04:08:58 -0700 (PDT)
Message-ID: <f3fca555-9a66-2028-0435-1a8b41eec95c@linaro.org>
Date:   Wed, 17 Aug 2022 12:08:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] misc: fastrpc: Use USER_PD define in
 fastrpc_get_info_from_dsp
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220816105528.3222763-1-abel.vesa@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220816105528.3222763-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2022 11:55, Abel Vesa wrote:
> There are defines for each type of protection domain now.
> Use the USER_PD instead of magic value in fastrpc_get_info_from_dsp.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Amol Maheshwari <amahesh@qti.qualcomm.com>
> ---

LGTM

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
>   drivers/misc/fastrpc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 93ebd174d848..8895ca593911 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1515,7 +1515,7 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
>   	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
>   	args[1].length = dsp_attr_buf_len;
>   	args[1].fd = -1;
> -	fl->pd = 1;
> +	fl->pd = USER_PD;
>   
>   	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
>   				       FASTRPC_SCALARS(0, 1, 1), args);

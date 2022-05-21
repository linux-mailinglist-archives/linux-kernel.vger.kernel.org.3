Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FA52FF5E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbiEUU16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345338AbiEUU1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:27:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C4946B07
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:26:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p4so18133155lfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rFZPrpZu3gCblZ0S2r/HLOnWi7BksfWkFQaou0zer6Q=;
        b=Hh5iMIFPohMgn1+pPdJ9rp8ZM8CCFYxsJ0AABPJqPB4xv/NY1rYh/zxd+RhsBINswB
         +w7f2RvBTSOB32E6OJLabSjRqCrCUzmQI9rU1+HakAXfQmWa/CEg/zCZ7PRYR3knUVu4
         8xltIFArO/sNUIZ+7+L44AYTKN6+kMH190bvG5MUQFU5T/dJ1+Rk4WsCRwxY92TGg0F6
         a6/mQTFp0QXjEKbJZBt7GzYpVEk4lzdKJ7t0BeqNrYR//Ts+JPnc5s4iToXzmI5RMz/D
         NKJQZzS9XNb1WQAR3VnRZxZjIIZ5zGbDRbL0cmYdQcI5VFikBfNF9gh+2P1bN70CEsbr
         s3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rFZPrpZu3gCblZ0S2r/HLOnWi7BksfWkFQaou0zer6Q=;
        b=XyvKxSzl7qV/ilFj6j7iJKfaYgt6PDLrwe/BjCD+snNPMJpXa7EAg2EbToCjvYOEm5
         f1cTzn1Vb26fu9DyhR5bgBEdgZIorpZ03oGqcMXffygLcMZfwOMdGCwBoeBqrHs2+G7L
         +KnWyEavRW9Hnv1JEWwF2fFpsiQEFVl1b09iFoiIcm+tgFeS5Lfiy0xUUOmP4ljunk9s
         FS86eTCpFWM7JuwgthS6RUyCbZIPTO7q/WjE9e1K+YTnCQmiYR22ybgmdaKq5xCLksxS
         BcFTPqT14VcxGPKltdfPQZ0q+yAfoxQNRCcVB3gtEhHgJrO/B3FfSX3KMeVy9GXTA92Z
         38Qw==
X-Gm-Message-State: AOAM533lw65yYpSuAFbUGCA8JtGim1LyE1J7ieyzHXrYEEsaeFbuM7o4
        VpGGUcUGew8vk8TaZ9T42F8=
X-Google-Smtp-Source: ABdhPJyURZ4TeVQzybWTSxvy0p0IGHn2v0MTIp9h5YROf1N0HyWyi0URQBLXHUFKb2a3HshJc1xjpA==
X-Received: by 2002:a05:6512:2625:b0:478:5a51:7fe3 with SMTP id bt37-20020a056512262500b004785a517fe3mr4702884lfb.158.1653164817623;
        Sat, 21 May 2022 13:26:57 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id a16-20020a05651c011000b0024cac53a82csm859433ljb.0.2022.05.21.13.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 13:26:57 -0700 (PDT)
Message-ID: <8fb49b5b-106b-3346-a75d-d54e0a065587@gmail.com>
Date:   Sat, 21 May 2022 23:26:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] staging: r8188eu: add check for kzalloc
Content-Language: en-US
To:     Martin Kaiser <lists@kaiser.cx>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220518075957.514603-1-jiasheng@iscas.ac.cn>
 <20220521155017.7jjz7prdnspm2276@viti.kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220521155017.7jjz7prdnspm2276@viti.kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 5/21/22 18:50, Martin Kaiser wrote:
> 
>>  	for (i = 0; i < 4; i++)
>> @@ -1474,7 +1479,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
> 
> 
> res is still 0 here - but the caller of _rtw_init_xmit_priv compares
> this return value with _SUCCESS (1) or _FAIL (0) and interprets it as
> _FAIL.
> 

I think, it's time to make

s/_SUCCESS/0/
s/_FAIL/-1

since developers from outside of staging are confused.
The main problem will be with functions that return an int (or s32).

Will take a look.



With regards,
Pavel Skripkin

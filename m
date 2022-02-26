Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4529A4C5723
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiBZRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 12:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiBZRde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:33:34 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642804926F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 09:32:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id t13so2638506lfd.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=S6VT3HN2IRbsIi5o911BX4SW84hwNa5voGHttJrK4Jw=;
        b=hHgmboyLosisGAkcLt2JhF9QgbqUC2scITXSxCRmvWU0ms2g75Lv7zM/Y08zHzjq1Y
         2U+13GO5wi/KUVDIvlTLQiEAl+tpeSekXhkgJJnZ9CT3Tn9U1dCkT4OTIxqZ7fLXndAH
         iZhCs9Hn9KBVMsH5MSIOydfcvlQBCy85EEOUpfgBkZOYuPEnV3oC+yJhRhQkCu1OIps2
         cGhI7LrMjJW6zXryu8TpQGXCMUkk5HB8fG43hOihfTTcaKGYzsWRgBK2b903+4Hb641m
         NailEuNwnNUcds46Ov1WulKolgGo96283HNjjfQklFVZq6gYWXAVYaaq087vLtT7j2EL
         RvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=S6VT3HN2IRbsIi5o911BX4SW84hwNa5voGHttJrK4Jw=;
        b=Tc1cr8eP8zC6JsPyTUmPWeisy8R24FJBB4YumvX0TzHj/xzGMXRpY+6nP96+eHlj7J
         I4DK/EAwOGrDFIhXZDUyo8YBy1wex9wbFlzbE8h2USbkPldT6Qs46iAbtWOVAMtefWCe
         CP63mzX7vXELh5YSIGLCS5NrKmv7RdshGIpHuTgfL0mTsFG1WDZei9soEBdQJ/ftK6pg
         rVkcCXw2tuL7hbyk6VPuh+Yg62+6b4cJ+uIi2Dh3RqNo3rItW2KuTJYuIw9mNmvTYWvf
         epDqOoXkn0YIw20pdaqVtH192TjRoQwFDXeHx/lMuTjK3WOaP1SSXSXV24+jEIrWCd/H
         izUA==
X-Gm-Message-State: AOAM533eFTNZjUcalKnVlijSbje7GKlfces85L2lt52cl6Shuhuv15Lv
        GORlAhbZH9PC1rDzs92vM8w=
X-Google-Smtp-Source: ABdhPJwI9oNaDgrJBvTYu2L4to0gFqre6Dn9V4cXbBKGULhD8E7HGzBlxDpozKL+mM+VWoVQpkOePA==
X-Received: by 2002:ac2:4577:0:b0:443:fac7:d701 with SMTP id k23-20020ac24577000000b00443fac7d701mr8136269lfm.384.1645896777200;
        Sat, 26 Feb 2022 09:32:57 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.64])
        by smtp.gmail.com with ESMTPSA id b23-20020ac247f7000000b004435ff1ef17sm499218lfp.23.2022.02.26.09.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 09:32:56 -0800 (PST)
Message-ID: <184f741c-60ed-fe32-5705-08f9769e926a@gmail.com>
Date:   Sat, 26 Feb 2022 20:32:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/6] staging: r8188eu: cnt is set but not used
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220226144843.1118951-1-martin@kaiser.cx>
 <20220226144843.1118951-4-martin@kaiser.cx>
 <1c44c931-5b90-03d8-94bd-5e68682c4787@gmail.com>
In-Reply-To: <1c44c931-5b90-03d8-94bd-5e68682c4787@gmail.com>
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

On 2/26/22 19:57, Pavel Skripkin wrote:
> Hi Martin,
> 
> On 2/26/22 17:48, Martin Kaiser wrote:
>> In function recv_func, the cnt variable is set but not used.
>> It can be removed.
>> 
>> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
>> ---
>>   drivers/staging/r8188eu/core/rtw_recv.c | 2 --
>>   1 file changed, 2 deletions(-)
>> 
>> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
>> index 0144c4642911..9a2e2bc2e294 100644
>> --- a/drivers/staging/r8188eu/core/rtw_recv.c
>> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
>> @@ -1798,11 +1798,9 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
>>   	if (check_fwstate(mlmepriv, WIFI_STATION_STATE) &&
>>   	    psecuritypriv->busetkipkey) {
>>   		struct recv_frame *pending_frame;
>> -		int cnt = 0;
>>   
>>   		pending_frame = rtw_alloc_recvframe(&padapter->recvpriv.uc_swdec_pending_queue);
>>   		while (pending_frame) {
> 
> Just out of curiosity: is this thing infinity loop?
> 

Hm.

This function is called only inside a tasklet. IIRC it's not ok to have 
this kind of loops in softirq context




With regards,
Pavel Skripkin

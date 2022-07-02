Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54805563EC7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 08:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiGBGLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 02:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBGLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 02:11:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF7914D07
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 23:11:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fw3so7488506ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 23:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3aWIGzftOvJgSc7kLPFVDtw9SRSW8DXOut6Ha66Gus0=;
        b=lxppe/hXgf3bd2z9Jajg0RHwNUwGxmDgihG9UWDwOb4JBre6MoEq8nFBTu5fZFs8p2
         mWndbvW1D26wLYtrPNLomAlw2v26YO7VoH3z0dzePvhfrGVhoyTY/MShkH+3O8Z+T3/C
         G4q4O/I7BEz8KD+7S8VCNWkaFm65yECLQv0wZfbO8EFMHT4MLC3qMLf+a34EMcbvsrMK
         Ro5ke87ynISrhQ41EpKsP8AJUX5sQ3DtikIn5Lu8/vF5QWupry7scYx/pmoM0nQKE1lu
         W1lqJVOIWjpnaxLdBqEN+dOOx16XAPiGnfmhNHRbw+1NLY4D+zeRD0raDrU1JY75wIUB
         /atA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3aWIGzftOvJgSc7kLPFVDtw9SRSW8DXOut6Ha66Gus0=;
        b=pLd5mcj42IH7Vy5GsDWckT+aIuoYTCZHqvvA72T6KJ+Nev+J+ZHLCPvht/7nhcvsBB
         wUxftjXsGMkOa7vRFlDGZALddFVOAlrHNsb0ui7EWrLEgfFJZNJ0tIVRAEdgH3BSl9L5
         CJpIOJaVoDaCI4u+ntPVntjGpzf+rg1qhG1hfquDiFnxsaHHGx1LHHpAdHLoR0IfeAEv
         WLcrNx0kSnawOt6EmIjY8F+yg6a4UCriCIRxdtSWxQzo5vP1XZ1QU2yOa7rMQyytPbaJ
         mNyLckbfLQamjoD8rtf+VJOqer8pCHHHnZHxY2Dg4gyNsoouJwaM2tyzUuhN8ydRTEUA
         Kxnw==
X-Gm-Message-State: AJIora8qdT2kF0SmnUyW0sTkV7EXDYr3Q6GholjASC22HdGPZsuCT8qJ
        +0kjzUAJWna+r+qP+y+lzV8=
X-Google-Smtp-Source: AGRyM1ujJGiXF/okyk+C3b/jsgAQMpVBMrfzx+EfKNQ1tZPSKkADlEJsSUTRMAyZADb/X0onNC7oOQ==
X-Received: by 2002:a17:907:608b:b0:722:f954:6e3 with SMTP id ht11-20020a170907608b00b00722f95406e3mr18071624ejc.550.1656742293524;
        Fri, 01 Jul 2022 23:11:33 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6912:39ab:4063:59d3:a7cd? (p200300c78f2e691239ab406359d3a7cd.dip0.t-ipconnect.de. [2003:c7:8f2e:6912:39ab:4063:59d3:a7cd])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0564021add00b00435a62d35b5sm16172127edb.45.2022.07.01.23.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 23:11:33 -0700 (PDT)
Message-ID: <6fe8c559-9bf8-62b1-caa3-37c22de318ed@gmail.com>
Date:   Sat, 2 Jul 2022 08:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 6/6] Staging: rtl8192e: Added spaces around '+'
Content-Language: en-US
To:     Felix Schlepper <f3sch.git@outlook.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com
References: <cover.1656667089.git.f3sch.git@outlook.com>
 <87628a2dd08ec0e5b02090485e7a9a1d91b7d2a5.1656667089.git.f3sch.git@outlook.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <87628a2dd08ec0e5b02090485e7a9a1d91b7d2a5.1656667089.git.f3sch.git@outlook.com>
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

On 7/1/22 11:24, Felix Schlepper wrote:
> This addresses two issues raised by checkpatch.pl:
> 
>       $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
>       CHECK: spaces preferred around that '+' (ctx:VxV)
> 
> Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
> ---
>   drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index 6b11908032d7..da2c41c9b92f 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -769,7 +769,7 @@ int rtllib_wx_set_gen_ie(struct rtllib_device *ieee, u8 *ie, size_t len)
>   	kfree(ieee->wps_ie);
>   	ieee->wps_ie = NULL;
>   	if (len) {
> -		if (len != ie[1]+2)
> +		if (len != ie[1] + 2)
>   			return -EINVAL;
>   		buf = kmemdup(ie, len, GFP_KERNEL);
>   		if (!buf)


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

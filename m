Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4935E52F4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352770AbiETVFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiETVE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:04:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8897A444
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:04:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v9so1665190lja.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HaUZAl6YfbHEQXiaIPa4mpZAp8nomzN9ZpQ9paddnxg=;
        b=P19vffmlkG1iJCTLs0sNasiEJUWVb3TPMdRDwEmxSbxScZ2NxMpIWzrSVF4JHrBPRe
         s3uiuRHwGScr2zQfomAlm9XfmvNZpibBT26naIE1Rb45EHMNr6oHnwNUuF0UthIpwSI5
         EKjtnFKrkm4CpDAjx+5OpK+zFIualtjiWo+cd+fprvcDWNnPEsvWBqsFYr/v7vfwMnYK
         ldO1b4TnQUeWbMKpAjsM+0jNft5X2r4HTHd59xA12FlwSTfBDEJPqkpOUfDr/fRipPgX
         HOK7tm0w4e3B9sTT1Mz67tQCxm0GCbZpoIPPNGcIKmZSxcWKRbjjKht7/be0pXDhTJLS
         rmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HaUZAl6YfbHEQXiaIPa4mpZAp8nomzN9ZpQ9paddnxg=;
        b=u8L6j7bQspjrIB0zfD7g4XkwjjhywHzdCSTJoRYhXQUli6iwuR6ozay5BzfqOEAXBk
         /OuaVilXY1J892NcjE7WMgzxitThgmyUC9AifchEwmmbo3WenWEE6OAi1zQejGhCKuHf
         CRLYOXx5YGVffxEw1pkAOHCmBoRLcAonsjseOeCmnlhdVG+cQVWxawIxfdFx6n2+DBD3
         jWHcCvkjSo7k1e5bQrpmyQWTIupFjmiVMVIW56PfM6cShzXSAA1WM+oZC6DFStBsgC6e
         WDE/bXmyLIFKc15EAbPNZBtVa3xlTlgNrOfLT3l0CLSlIJ19ezfNkjgswfbLf7U4QPR6
         7RJg==
X-Gm-Message-State: AOAM531OyVSkrA5wAF0Q58YBnojEJkisiytvEnl1/FZGelvysWe2Dpop
        jwHKqW4WU2TdZnTisF+XBNwnR8Nd4uc=
X-Google-Smtp-Source: ABdhPJxmM9jEolg3xExHgCFocx8NEIVlwbyAXz0ed+AqfNbI+CV310rzPcZkV8LG0jxUerhnAQ+R4A==
X-Received: by 2002:a2e:a810:0:b0:253:cb18:9058 with SMTP id l16-20020a2ea810000000b00253cb189058mr6528817ljq.12.1653080696019;
        Fri, 20 May 2022 14:04:56 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id i19-20020a056512007300b0047255d210d5sm791887lfo.4.2022.05.20.14.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 14:04:55 -0700 (PDT)
Message-ID: <44d12b0f-3ce0-42d2-a475-31d70dd4d699@gmail.com>
Date:   Sat, 21 May 2022 00:04:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] staging: r8188eu: remove include/rtw_debug.h
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, martin@kaiser.cx,
        saurav.girepunje@gmail.com, abdun.nihaal@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20220519221047.6940-1-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220519221047.6940-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 5/20/22 01:10, Phillip Potter wrote:
> Remove include/rtw_debug.h, as all it now has are:
> 
> (1) A load of unused preprocessor definitions that expand to BIT(x)
>      variants.
> (2) A preprocessor definition that expands to the name of the driver
>      and is only used in one place inside a pr_info_once call in
>      core/rtw_fw.c.
> 
> It is now surplus to requirements after fixing up the few places that
> include the file.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/core/rtw_fw.c        |  4 +-
>   drivers/staging/r8188eu/include/drv_types.h  |  1 -
>   drivers/staging/r8188eu/include/rtw_debug.h  | 45 --------------------
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c |  1 -
>   4 files changed, 2 insertions(+), 49 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/include/rtw_debug.h
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
> index bf077876ed3d..0451e5177644 100644
> --- a/drivers/staging/r8188eu/core/rtw_fw.c
> +++ b/drivers/staging/r8188eu/core/rtw_fw.c
> @@ -259,8 +259,8 @@ int rtl8188e_firmware_download(struct adapter *padapter)
>   	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
>   
>   	if (IS_FW_HEADER_EXIST(fwhdr)) {
> -		pr_info_once("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
> -			     DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
> +		pr_info_once("R8188EU: Firmware Version %d, SubVersion %d, Signature 0x%x\n",
> +			     le16_to_cpu(fwhdr->version), fwhdr->subversion,
>   			     le16_to_cpu(fwhdr->signature));
>   

What about converting this macro to dev_info_once()? IMO, looks cleaner:

[   27.985218] r8188eu 2-1:1.0: Firmware Version 11, SubVersion 1, 
Signature 0x88e1




With regards,
Pavel Skripkin

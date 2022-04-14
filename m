Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C346B501C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbiDNTjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbiDNTjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:39:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79BCECB3E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:36:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q14so7278871ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dUKmRYlawJRX3llP91jhphJWKyce5KIMsE/+iyIM6Do=;
        b=TwnvuxM3W/HeeQXZTzgBCJ+eYBl8t05kkmxSY+NiU5A9cQwWGdac8UE8G9/E85Simf
         au58FOVGEiHwLRzzsteNPABVogmV1eV/qOQ2A1bDJJWfdBW1drzM1Q3fGA+0Lc83XtzM
         9pns4fpxmSTysh5GPA0zT+TcSox6p/4A6ymLyHXOAZiXriUEjsUSvFiuJeyPHgsrtU/X
         sMOcVHU8445OL9UXQ4Tpr4ZtV+v9kK5Ug2/vvETPOTuO2wywSAR48/gmuceXwImjdPNu
         x4Bk1bRLCZxfhRUnZI4SUtsoSu1YJrvpuZA4+hAWRX4+P5ITUGkYzvTbtuU7mY1aRt6+
         s/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dUKmRYlawJRX3llP91jhphJWKyce5KIMsE/+iyIM6Do=;
        b=2HUisQ+hWJvyqGspBWxEQFY86y2/dMB/KLv3jQOix5sh9XYigsMcBRvvWSX7Ja1llL
         f27em21J+YLZzEsaZ9XPqv4cHtuwlj7ImLevPj5tfYpGnakE421dD8ILccFqhCxIKu9S
         MZ3bkYAHvun7+k/hkFUj5YGMEzoOMssaCbEPAS9i5nFmS1UfU++G4ZW8hAeRpeibWJs4
         6mGaclLMUV0Mx2JL+AhFUKIGwHbZGTVRtTlDn4xSG47nZjCY8it/EEjV+sMZMrzcxrk1
         kay4PrFY/Jo7qSgOVINp0XDgNoZNu8zL6rC9XAuUhWC/zaWuWAujxDFJg9+B3I9/cQzU
         jpUw==
X-Gm-Message-State: AOAM53126vFNBHdxyyGMwwOjcoX2E6wMHxOjM9qivUK6CCjPeVoONAy4
        i0uq3kTAZGIzUGfR81LvYJc=
X-Google-Smtp-Source: ABdhPJzC0RWXlDGEATAZdM1wk4Tjv4qdY+VMMpMHSAksal70KhmAT0/sLW4R2avFqQmGf5BLFXUNfA==
X-Received: by 2002:a05:651c:b24:b0:24c:7ebb:a99d with SMTP id b36-20020a05651c0b2400b0024c7ebba99dmr2464605ljr.314.1649965004896;
        Thu, 14 Apr 2022 12:36:44 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id p12-20020a056512138c00b0044833f1cd85sm89467lfa.62.2022.04.14.12.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 12:36:44 -0700 (PDT)
Message-ID: <0c468c33-980c-e657-65d9-33248c0c8144@gmail.com>
Date:   Thu, 14 Apr 2022 22:36:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/7] staging: r8188eu: use sizeof instead of hardcoded
 firmware header size
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220414083853.3422-1-straube.linux@gmail.com>
 <20220414083853.3422-5-straube.linux@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220414083853.3422-5-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 4/14/22 11:38, Michael Straube wrote:
> Use sizeof() instead of hardcoding the firmware header size.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_fw.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
> index 3da52a1ba23c..94526064f29b 100644
> --- a/drivers/staging/r8188eu/core/rtw_fw.c
> +++ b/drivers/staging/r8188eu/core/rtw_fw.c
> @@ -263,9 +263,8 @@ int rtl8188e_firmware_download(struct adapter *padapter)
>   			DRIVER_PREFIX, fw_version, fw_subversion, fw_signature);
>   
>   	if (IS_FW_HEADER_EXIST(fwhdr)) {
> -		/*  Shift 32 bytes for FW header */
> -		fw_data = fw_data + 32;
> -		fw_size = fw_size - 32;
> +		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
> +		fw_size = fw_size - sizeof(struct rt_firmware_hdr);


What about BUILD_BUG_ON(sizeof(struct rt_firmware_hdr) != 32)? To be 
sure we won't face same bug in future





With regards,
Pavel Skripkin

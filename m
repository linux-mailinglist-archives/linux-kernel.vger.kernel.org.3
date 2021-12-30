Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B700E482030
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhL3ULP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhL3ULP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:11:15 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D80C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:11:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g26so56463956lfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D5OpIvSfY687ZPsc4rtmiNJ18f7af4DJBRMrvJ8i7c8=;
        b=lBwV1MKOGArwVuJreNpk69P1xSjDiao+JLSeG8U2SC+re7P3K0WzovMoulqaHXAliu
         AQ8hRATVRxj7jTKVQa7efRJQlTdKLhQiIHiDzSnqQv6nAbKXSssHc3cb60l169z6C7Hc
         OIDH0xG2kYhSnPsO30XBOo6ECec0TEFjPVcG6XWkH3L7uyLwo15UuNqhdty6JqaaULgQ
         keKFVnY7H4H4pSdZ6vXkqF0rg9A3bfKTP+cfuewlt7hIp+a25iq2J7K+bRIrmwyx+vpb
         /0CuZvhQitlDHDlIQI+sW39WNgxax95weJ6It+Sviw3e0lF96TIYRMfZqV6MpjCcMfJd
         qMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D5OpIvSfY687ZPsc4rtmiNJ18f7af4DJBRMrvJ8i7c8=;
        b=dHp8du/EGJ8DHpXgIrG6+tc8ps7F6zPCR6F2r7QR7m0b+R0HZ6dvvFbZo8ySN5ndea
         HpVu3EUH83icD9Vav5PyhtN+O9GijBfYE1BgBS04StuRpPLYiTwWG0ZReV5J4qcystcn
         Hj9Qo3rniHPPkdzUTRPXhAAx6GbVNul/L5VVVb+5L0i2awym7m+ORMf2zJYg2Y+gpfQ/
         RikMoRCVlFAg/H3IToJHSb9QI6fCb5KJnaVsJbsA7wAVLmmW3dT3NpQXTTR2nUUGZYkA
         O8sD4poO1eTV9gNhMDJ3i6qFLdNdixGOU8O5unnq58b5IhYEnfFnrYk/zpiUF81nv48W
         +y8Q==
X-Gm-Message-State: AOAM531N4vJajy+2mJ4fDIOqBVc3faCtOqyAyu6+wFdDwqcv17DfUdDD
        KxkOHOtDvoM+Re6bkwOOb3hbj4abzxo=
X-Google-Smtp-Source: ABdhPJyxAQTnaDZ8/NtfWRTmPBqi8ZcRtkAX6434doC+Gj827J4c4344J+F0Aq7bHdqy4fQ/h/ORZQ==
X-Received: by 2002:ac2:5547:: with SMTP id l7mr29125759lfk.324.1640895072475;
        Thu, 30 Dec 2021 12:11:12 -0800 (PST)
Received: from [192.168.1.11] ([94.103.235.97])
        by smtp.gmail.com with ESMTPSA id n11sm914635ljj.70.2021.12.30.12.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 12:11:12 -0800 (PST)
Message-ID: <2838d56e-9618-1582-4127-9dc3d56ff311@gmail.com>
Date:   Thu, 30 Dec 2021 23:11:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 6/7] staging: r8188eu: IntArray and C2hArray are set but
 never used
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211230200059.13406-1-straube.linux@gmail.com>
 <20211230200059.13406-7-straube.linux@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211230200059.13406-7-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/21 23:00, Michael Straube wrote:
> The fields IntArray and C2hArray of struct hal_data_8188e are set but
> never used. Remove them.
> 
> While at it, remove the unsed defines USB_INTR_CONTENT_CPWM1_OFFSET
> and USB_INTR_CONTENT_CPWM2_OFFSET as well.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---

Hi Michael,

thanks for your clean ups!

>   drivers/staging/r8188eu/hal/usb_ops_linux.c     | 10 ----------
>   drivers/staging/r8188eu/include/rtl8188e_hal.h  |  3 ---
>   drivers/staging/r8188eu/include/rtl8188e_spec.h |  7 -------
>   3 files changed, 20 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 9ec55a77dccd..85bcde5ee79a 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -185,20 +185,10 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
>   
>   static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbuf)
>   {
> -	struct hal_data_8188e *haldata = &adapt->haldata;
> -
>   	if (pkt_len != INTERRUPT_MSG_FORMAT_LEN) {
>   		DBG_88E("%s Invalid interrupt content length (%d)!\n", __func__, pkt_len);
>   		return;
>   	}
> -
> -	/*  HISR */
> -	memcpy(&haldata->IntArray[0], &pbuf[USB_INTR_CONTENT_HISR_OFFSET], 4);
> -	memcpy(&haldata->IntArray[1], &pbuf[USB_INTR_CONTENT_HISRE_OFFSET], 4);
> -
> -	/*  C2H Event */
> -	if (pbuf[0] != 0)
> -		memcpy(&haldata->C2hArray[0], &pbuf[USB_INTR_CONTENT_C2H_OFFSET], 16);
>   }
>   

This function can be removed totally then, since it does nothing. Not 
sure if function removal fits this patch, but why not :)



With regards,
Pavel Skripkin

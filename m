Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F449BB59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiAYScA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiAYSbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:31:31 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567FC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:31:30 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id j14so16487685lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OlIBnpkTLBL6sH3W/KXcb2UEgw4pfOFIKhtFEyjrjXg=;
        b=FHIOwTMrIgkrHCmEbk0yOERz2+rKuWBQWNsU9Bdktyt5XpnW0LjleS/S/XQi8l6uGt
         03IeHKCGxGw3Z2tJ+ssmZQ1cYVVmWjsy1nkE+VjZ05Z2g72yZzSO71lefk/36q2L6mzr
         xTIGThNJw8EZz6dd2bLNK4Ff0Ldq05vSwJfrqAbSZZC9ZiVSDst1JBVgRK8NzvPmeesx
         wS5tJg+xaEBIZvhZjhW09UY20gQwlM5hTIMMfQsZ3dAwsXcoXPosqfRdPTez5qd4bwnb
         ZAeTPRaeVVKnqOQ17BoV5KavTeCb+WralSZgGk2fkjEpIpHBTAQnaRlVZxtBzSzEFJuz
         PQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OlIBnpkTLBL6sH3W/KXcb2UEgw4pfOFIKhtFEyjrjXg=;
        b=uP4hvTeUAh8rCZ7nsX0KUDPrjSGpL7HYL7/Fh9YdTgy3IZw8AgHtfl+J7hf6j15YPN
         gDwVEb4G7DY1B5ptHLnkVTWOPa2gZOnVfPa3QXhiMTJxa4lGS2om063udud9K8MaNNCc
         D3QF2aXmTds5oguSwe8XsolgW7EYfscAiln9eb4OfSs530Xy5RiCyRq0Di46Cteg0hio
         U4hta8IOwOMdHQ7+lmg6r8dGYddmwrbYoN6wIYd43JBd+D5+bZ0Saok87zJpTFmR3frN
         +UFmC3qCN9ckZ79NWh8JQ29t/1HsQNZ/zsO0+zLQKJMMjvpYQQSG2666xxC9Oim3IpOE
         3eYQ==
X-Gm-Message-State: AOAM533kIJqjdOxRg5gBeg3Z8ONYu6RDLVkgcvAxzTQdjKZfUR+W0dzu
        R/Lh9ZToEfVomEPwbyaouSM=
X-Google-Smtp-Source: ABdhPJzMETM7h/HoAr3mua4MEe+7OlBNZZ024HhjTIEUx+vZgj5sSn7S1MbNXwqVzy/XYnwYAxHWgQ==
X-Received: by 2002:a2e:80cb:: with SMTP id r11mr6131870ljg.359.1643135488614;
        Tue, 25 Jan 2022 10:31:28 -0800 (PST)
Received: from [192.168.1.11] ([94.103.227.208])
        by smtp.gmail.com with ESMTPSA id h6sm490020ljg.58.2022.01.25.10.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 10:31:28 -0800 (PST)
Message-ID: <f766f910-4f7c-d3b5-d7a8-4d0d9de33a66@gmail.com>
Date:   Tue, 25 Jan 2022 21:31:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 03/10] staging: r8188eu: remove DBG_88E calls from
 core/rtw_mlme_ext.c
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-4-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220124224415.831-4-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 1/25/22 01:44, Phillip Potter wrote:
> Remove all DBG_88E calls from core/rtw_mlme_ext.c, including the commented
> one, as they do not conform to kernel coding standards and are
> superfluous. Also restructure where appropriate to remove no longer needed
> code left behind by removal of these calls. This will allow the eventual
> removal of the DBG_88E macro itself.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---

[code snip]

>   static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
> @@ -7141,18 +6905,11 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
>   static void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
>   {
>   	u32 rx_dma_status =  rtw_read32(padapter, REG_RXDMA_STATUS);
> -	u8 fw_status;
>   
> -	if (rx_dma_status != 0x00) {
> -		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
> +	if (rx_dma_status != 0x00)
>   		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
> -	}
>   
> -	fw_status = rtw_read8(padapter, REG_FMETHR);
> -	if (fw_status == 1)
> -		DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
> -	else if (fw_status == 2)
> -		DBG_88E("%s REG_FW_STATUS (0x%02x), Condition_No_Match !!\n", __func__, fw_status);
> +	rtw_read8(padapter, REG_FMETHR);
>   }

Unused read. Can be dropped



With regards,
Pavel Skripkin

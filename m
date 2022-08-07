Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F208558B9C0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 08:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiHGGAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 02:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiHGGA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 02:00:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E60B7F9
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 23:00:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t5so7860035edc.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QGDfGBBx03TPaEgG0gy1rLVBLM5G9hC6tu/Kd9xOnRo=;
        b=qEQyCrPa6YzkfIqDNni632lVEPKfo+d4KcHyw2owK2x9DBLB+jhjea2cqx8QIPWBaQ
         qawa6urM0tCz2QrUJ9LxnedhFrCzcUlsb/NXrHemua3rFLzkhPVMRiLrs35NaBdf3UaK
         pdLZtXe8bIFMP76toHliaOI05bpmpmnpF3yJV1cx3bWNM7F3fOF3GuHiz31ga1EEcIpn
         7Knvdu8CkCxn9gE8Pbq18NWek6VD3n0VjIhiYEvnMiBhGflE7u2T+BeVS+m1U8xCWqzO
         3KHT2iQYdGnrxSbH9y4EETY0U4IOh54zjtFAAbT5kD9AMdH22QthE7iCCHMsigc09MIC
         gA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QGDfGBBx03TPaEgG0gy1rLVBLM5G9hC6tu/Kd9xOnRo=;
        b=2g8Q2hux7w4nVVBNQPu9+WboZn5DG8KtaYlzcPlraHcfiw/9e3/lOLoXjDMQgZUwkg
         Q2W1hfTV3xG2LReuYrO5gm5JAMFNhmeJv89NTOu/OqByYX1XaFUSKnRvO8snG7cq7qlU
         YdcYbH6UMjlFl4IESMrR7Uk+nfGsKctET8zgiRve1/Ao6qZEYK/e1saYqoafausfFsLB
         95iys1t+Iu3xLLNvTPiUEiGYeWGqOsEs0g83h3PCwiAzKgyckf45DhCGcpKB7wRqF7c5
         ARf7Jizw+zdyVzcLCVnkZE+xNPOUwMXIQi0BKhP1O+sWpGGDjaHxqo4ECfbRnt3lwl7R
         Pu+w==
X-Gm-Message-State: ACgBeo2ldC7ldVza3nPOrsDddd5DiujogdktXkAOtim74GulacRSP88l
        4ldrsSfmyx7AvVoW3fz35aA=
X-Google-Smtp-Source: AA6agR4qMzT5p5A2R+3gZQw17Fo67RkHgBTXS0edKd+HDhaOI5qGceAhqdXLpoIUyU3zKWfyO70ftg==
X-Received: by 2002:a50:fb99:0:b0:43c:d008:d4f9 with SMTP id e25-20020a50fb99000000b0043cd008d4f9mr13137666edq.13.1659852026839;
        Sat, 06 Aug 2022 23:00:26 -0700 (PDT)
Received: from [192.168.1.103] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id e23-20020a056402149700b0043cd06bef33sm2523063edv.97.2022.08.06.23.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 23:00:26 -0700 (PDT)
Message-ID: <3a544782-f99a-9f77-03ae-06facff79af6@gmail.com>
Date:   Sun, 7 Aug 2022 08:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: txpktbuf_bndy does not depend on
 wifi_spec
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220806194304.777059-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220806194304.777059-1-martin@kaiser.cx>
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

On 8/6/22 21:43, Martin Kaiser wrote:
> Remove the if clause that sets txpktbuf_bndy. Both branches set the same
> value.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c      | 12 ++----------
>   drivers/staging/r8188eu/include/rtl8188e_hal.h |  6 ------
>   2 files changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index efb529bb4c8a..8b36fb56076e 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -567,7 +567,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>   {
>   	u8 value8 = 0;
>   	u16  value16;
> -	u8 txpktbuf_bndy;
>   	u32 status = _SUCCESS;
>   	int res;
>   	struct hal_data_8188e *haldata = &Adapter->haldata;
> @@ -600,13 +599,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>   	/*  HW GPIO pin. Before PHY_RFConfig8192C. */
>   	/*  2010/08/26 MH If Efuse does not support sective suspend then disable the function. */
>   
> -	if (!pregistrypriv->wifi_spec) {
> -		txpktbuf_bndy = TX_PAGE_BOUNDARY_88E;
> -	} else {
> -		/*  for WMM */
> -		txpktbuf_bndy = WMM_NORMAL_TX_PAGE_BOUNDARY_88E;
> -	}
> -
>   	_InitQueueReservedPage(Adapter);
>   	_InitQueuePriority(Adapter);
>   	_InitPageBoundary(Adapter);
> @@ -647,9 +639,9 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>   	if (status == _FAIL)
>   		goto exit;
>   
> -	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
> +	_InitTxBufferBoundary(Adapter, TX_PAGE_BOUNDARY_88E);
>   
> -	status =  InitLLTTable(Adapter, txpktbuf_bndy);
> +	status =  InitLLTTable(Adapter, TX_PAGE_BOUNDARY_88E);
>   	if (status == _FAIL)
>   		goto exit;
>   
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index 5cd62b216720..fdc187f4deaa 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -51,12 +51,6 @@
>   
>   #define TX_PAGE_BOUNDARY_88E (TX_TOTAL_PAGE_NUMBER_88E + 1)
>   
> -/* Note: For Normal Chip Setting ,modify later */
> -#define WMM_NORMAL_TX_TOTAL_PAGE_NUMBER			\
> -	TX_TOTAL_PAGE_NUMBER_88E  /* 0xA9 , 0xb0=>176=>22k */
> -#define WMM_NORMAL_TX_PAGE_BOUNDARY_88E			\
> -	(WMM_NORMAL_TX_TOTAL_PAGE_NUMBER + 1) /* 0xA9 */
> -
>   #include "HalVerDef.h"
>   #include "hal_com.h"
>   

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

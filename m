Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA6503650
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiDPLXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 07:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiDPLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:23:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99010F1EBA
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 04:21:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so17485430lfg.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 04:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MkmORvIL2zULObkfbkJsVQHkLyWpB1iVIjReF7hXUtw=;
        b=AK2SOvHLW5mDBzz1jN0pHbMi/hJbTe6lyeB1udOyu8+VrB2al9YrqwA+5XFcZnPE6l
         rx5b68FFiM5I4Itu4Rt0QoXB5J2x5cN1JcSYTh2ajTZjl/MCalQOVTlZ7SK3io4x6A0V
         etjC+wgvRTsW36OPzwhLdT7B6Jgh5oT9VuidcUh+KqogWo+cuq79sXrORgF+IYGgrEy8
         eF2mJmaXs7PcfrGFuAy4pe/PSf9cw/HIlLXzWw6LMfGXOk+RSC/MSlS9uNqIvsVrR6x0
         GNG43BP2c8pDj9GfJEiM3Pip/fufgoZjnRCIvnfv5ka6VtgpmPogUJ9es63BVOj9ADF6
         gebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MkmORvIL2zULObkfbkJsVQHkLyWpB1iVIjReF7hXUtw=;
        b=NDBzDk9py6zTIMyVOUP802KFaHnTG69GOsUKuiI1utI5ZkTtaHB4wkrAiBBsv8a77j
         6H4NAXUKtajOI7aYKeCN7WW5pOXOKAoX9XzTLXVsqpCpRPbQjMfuJmqTsQL8hn2OORuu
         eOPzbNZVSEWtoUswJRhBQPKJr8sqNl9QCA9vuGicWTCVyKQ9u6OVuwUVByd4WstAP44h
         /G/w5HPUIwalCKS7+Bh8A9Q4g+mo/3EpO2FPYB1uUy30sZ4XarX4FX1LXnT7BvneZk3e
         MOxL48oKjOs/xtIJMiOQnEqQ1misqhm4rA0aGepfaQuv9ayF3uH3dS9ggXK0Eml0N9xK
         qCdg==
X-Gm-Message-State: AOAM532YbVZDpf0HehVWaLjVqTyv62Njpke/c4X/3iKFeOn25HViBsMG
        +ahSV+OlD3EUXxyEpMXAh8Y=
X-Google-Smtp-Source: ABdhPJz6HmqsVX9N3NnQWycGjKb8kCMfTcHXY06N+k8BoRP0nDeW0vE0IPwxjDswf9jdkRogIbYjzw==
X-Received: by 2002:a05:6512:3a85:b0:464:f83e:f680 with SMTP id q5-20020a0565123a8500b00464f83ef680mr2122985lfu.371.1650108067718;
        Sat, 16 Apr 2022 04:21:07 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id m12-20020a19710c000000b0046b985ed95esm638745lfc.100.2022.04.16.04.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 04:21:07 -0700 (PDT)
Message-ID: <63d56f0f-52f0-52da-675a-a18f5ce31b3d@gmail.com>
Date:   Sat, 16 Apr 2022 14:21:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: rtl8723bs: remove leftover code for other chips
Content-Language: en-US
To:     Artur Bujdoso <artur.bujdoso@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
References: <Ylqk7RQmpRfh/RxV@crux>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <Ylqk7RQmpRfh/RxV@crux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artur,

On 4/16/22 14:13, Artur Bujdoso wrote:
> Clean up unreferenced register definitons in hal headers.
> 
> Signed-off-by: Artur Bujdoso <artur.bujdoso@gmail.com>
> ---
>   drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h  |  36 +--
>   drivers/staging/rtl8723bs/include/HalVerDef.h |  74 ++---
>   .../staging/rtl8723bs/include/hal_com_reg.h   | 297 +-----------------
>   3 files changed, 49 insertions(+), 358 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
> index af50674b2a65..706aafe86d0d 100644
> --- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
> +++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
> @@ -70,38 +70,34 @@ enum btc_chip_interface {
>   
>   enum {
>   	BTC_CHIP_UNDEF		= 0,
> -	BTC_CHIP_CSR_BC4	= 1,
> -	BTC_CHIP_CSR_BC8	= 2,
> -	BTC_CHIP_RTL8723A	= 3,
> -	BTC_CHIP_RTL8821	= 4,
>   	BTC_CHIP_RTL8723B	= 5,
>   	BTC_CHIP_MAX
>   };
>   
>   /*  following is for wifi link status */
> -#define WIFI_STA_CONNECTED				BIT0
> -#define WIFI_AP_CONNECTED				BIT1
> -#define WIFI_HS_CONNECTED				BIT2
> +#define WIFI_STA_CONNECTED			BIT0
> +#define WIFI_AP_CONNECTED			BIT1
> +#define WIFI_HS_CONNECTED			BIT2
>   #define WIFI_P2P_GO_CONNECTED			BIT3
>   #define WIFI_P2P_GC_CONNECTED			BIT4
>   

Should be done in separate patch

>   struct btc_board_info {
>   	/*  The following is some board information */
>   	u8 btChipType;
> -	u8 pgAntNum;	/*  pg ant number */
> -	u8 btdmAntNum;	/*  ant number for btdm */
> +	u8 pgAntNum;		/*  pg ant number */
> +	u8 btdmAntNum;		/*  ant number for btdm */
>   	u8 btdmAntPos;		/* Bryant Add to indicate Antenna Position for (pgAntNum = 2) && (btdmAntNum = 1)  (DPDT+1Ant case) */
>   	u8 singleAntPath;	/*  current used for 8723b only, 1 =>s0,  0 =>s1 */
> -	/* bool				bBtExist; */
> +	/* bool			bBtExist; */
>   };
>   


Should be done in separate patch

>   enum {
> -	BTC_RSSI_STATE_HIGH			    = 0x0,
> -	BTC_RSSI_STATE_MEDIUM			= 0x1,
> -	BTC_RSSI_STATE_LOW			    = 0x2,
> -	BTC_RSSI_STATE_STAY_HIGH		= 0x3,
> -	BTC_RSSI_STATE_STAY_MEDIUM		= 0x4,
> -	BTC_RSSI_STATE_STAY_LOW			= 0x5,
> +	BTC_RSSI_STATE_HIGH		= 0x0,
> +	BTC_RSSI_STATE_MEDIUM		= 0x1,
> +	BTC_RSSI_STATE_LOW		= 0x2,
> +	BTC_RSSI_STATE_STAY_HIGH	= 0x3,
> +	BTC_RSSI_STATE_STAY_MEDIUM	= 0x4,
> +	BTC_RSSI_STATE_STAY_LOW		= 0x5,
>   	BTC_RSSI_MAX
>   };
>   #define BTC_RSSI_HIGH(_rssi_)	((_rssi_ == BTC_RSSI_STATE_HIGH || _rssi_ == BTC_RSSI_STATE_STAY_HIGH) ? true : false)
> @@ -122,7 +118,7 @@ enum {
>   };
>   
>   enum {
> -	BTC_WIFI_PNP_WAKE_UP		= 0x0,
> +	BTC_WIFI_PNP_WAKE_UP			= 0x0,
>   	BTC_WIFI_PNP_SLEEP			= 0x1,
>   	BTC_WIFI_PNP_MAX
>   };
> @@ -211,7 +207,7 @@ enum {
>   
>   enum {
>   	BTC_DBG_DISP_COEX_STATISTICS		= 0x0,
> -	BTC_DBG_DISP_BT_LINK_INFO			= 0x1,
> +	BTC_DBG_DISP_BT_LINK_INFO		= 0x1,
>   	BTC_DBG_DISP_FW_PWR_MODE_CMD		= 0x2,
>   	BTC_DBG_DISP_MAX
>   };
> @@ -235,13 +231,13 @@ enum {
>   };
>   
>   enum {
> -	BTC_ASSOCIATE_FINISH				= 0x0,
> +	BTC_ASSOCIATE_FINISH					= 0x0,
>   	BTC_ASSOCIATE_START					= 0x1,
>   	BTC_ASSOCIATE_MAX
>   };
>   
>   enum {
> -	BTC_MEDIA_DISCONNECT				= 0x0,
> +	BTC_MEDIA_DISCONNECT					= 0x0,
>   	BTC_MEDIA_CONNECT					= 0x1,
>   	BTC_MEDIA_MAX
>   };

All white-space clean ups should be done in separate patch


> diff --git a/drivers/staging/rtl8723bs/include/HalVerDef.h b/drivers/staging/rtl8723bs/include/HalVerDef.h
> index 8f654a49fb9d..42c8ff90e824 100644
> --- a/drivers/staging/rtl8723bs/include/HalVerDef.h
> +++ b/drivers/staging/rtl8723bs/include/HalVerDef.h
> @@ -9,38 +9,29 @@
>   
>   /*  hal_ic_type_e */
>   enum hal_ic_type_e { /* tag_HAL_IC_Type_Definition */
> -	CHIP_8192S	=	0,
> -	CHIP_8188C	=	1,
> -	CHIP_8192C	=	2,
> -	CHIP_8192D	=	3,
> -	CHIP_8723A	=	4,
> -	CHIP_8188E	=	5,
> -	CHIP_8812	=	6,
> -	CHIP_8821	=	7,
>   	CHIP_8723B	=	8,
> -	CHIP_8192E	=	9,
>   };
>   

Then why this enum is needed? ChipVersion.ICType looks set, but not used.

>   /* hal_chip_type_e */
>   enum hal_chip_type_e { /* tag_HAL_CHIP_Type_Definition */
> -	TEST_CHIP		=	0,
> +	TEST_CHIP	=	0,
>   	NORMAL_CHIP	=	1,
> -	FPGA			=	2,
> +	FPGA		=	2,
>   };
>   

Again white-space clean ups

>   /* hal_cut_version_e */
>   enum hal_cut_version_e { /* tag_HAL_Cut_Version_Definition */
> -	A_CUT_VERSION		=	0,
> -	B_CUT_VERSION		=	1,
> -	C_CUT_VERSION		=	2,
> -	D_CUT_VERSION		=	3,
> -	E_CUT_VERSION		=	4,
> -	F_CUT_VERSION		=	5,
> -	G_CUT_VERSION		=	6,
> -	H_CUT_VERSION		=	7,
> -	I_CUT_VERSION		=	8,
> -	J_CUT_VERSION		=	9,
> -	K_CUT_VERSION		=	10,
> +	A_CUT_VERSION	=	0,
> +	B_CUT_VERSION	=	1,
> +	C_CUT_VERSION	=	2,
> +	D_CUT_VERSION	=	3,
> +	E_CUT_VERSION	=	4,
> +	F_CUT_VERSION	=	5,
> +	G_CUT_VERSION	=	6,
> +	H_CUT_VERSION	=	7,
> +	I_CUT_VERSION	=	8,
> +	J_CUT_VERSION	=	9,
> +	K_CUT_VERSION	=	10,
>   };

and again...






With regards,
Pavel Skripkin

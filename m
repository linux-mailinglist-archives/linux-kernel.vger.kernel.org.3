Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59357F688
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiGXSkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiGXSkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:40:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8F111A1B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:39:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ss3so16762470ejc.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s8DMuam8HV9fhN0Z1q0G7Q0GrlatE75URDnKRQUVjwQ=;
        b=FM92IhLbG39vK8HOqaS04a0Dkyho1azIHkIzElV2Kf49xiOxTLnREGQrKM/6us7Hdd
         R2VcC6LYwyQWzYIlCtUFVs53g/8uzMuAjGIpqLkiA8AR4bB0lUI9QofzoqI+f0hLZQBY
         qI2EUqaBrAshKA+7ybpFArJods4ahe34BCMn1BWaQHG+SN7Q+D9yFMlT2rJ5p9kKrxZt
         iNT/RR8p+YBTqiyf4kJNoYD+obaW9Gf09Z7bLJb878KU1rp5DpkFpX/m1C/gxVTbA5hP
         AGnuJeOD5p4nhLJyFknDUwZ6/CHaTxTNpgCmLrJ9CY91uAeTGpPKqG/cAvu79oWIxZm9
         YkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s8DMuam8HV9fhN0Z1q0G7Q0GrlatE75URDnKRQUVjwQ=;
        b=Dp//kWL1F2ctjQC6KOMKg8yh69bIK/wFD3y5xg0UGUseL6bHqKf27y+Nul26q/ISnw
         gK+pxuRvqmLIBtKV0VPfi9lvF4m/rwP9P+VCc7WNau2Hbv+SFjD85NOMjTIDUk92vhED
         RzJqmIQahuEL6RWPUDKzjKnteGQvHV6NI8+ZyRDMDlEWrDv77pLBuaTZ1zYwv4Sy//gq
         n6CtzbTJ3LvYa4hkX50G3ltzkBPHeI32pfYIe1LuL7ttWFrqU+egBFdT3GS0avfjqeJd
         wrh7BIJVoV4lkNsY0ZSr6kHrfJeR+EHdJQRRgNw/odseyRSnMb3AzxttoD90w/4F1mFZ
         AdGQ==
X-Gm-Message-State: AJIora+A8dlV817XkxD946fd93e6vxxhRlW7wN/Q/rZJfo4Ab1gyaMl5
        UBR4OAfeN2bwsXFK4gv6Bbs=
X-Google-Smtp-Source: AGRyM1vmwanlNYrKpt1SY8DyuIUZhKXMKJISDoN1l2L7rUiQP9+2H+oY969BTGVXVoxJLzPybYbR/w==
X-Received: by 2002:a17:907:7355:b0:72b:977f:65 with SMTP id dq21-20020a170907735500b0072b977f0065mr7124095ejc.768.1658687997663;
        Sun, 24 Jul 2022 11:39:57 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id q1-20020a1709060e4100b0072aac7446easm4433754eji.47.2022.07.24.11.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 11:39:57 -0700 (PDT)
Message-ID: <bd498222-004a-9ac4-8c3c-4419f9ca9916@gmail.com>
Date:   Sun, 24 Jul 2022 20:39:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: make dump_chip_info() static
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220724182520.7794-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220724182520.7794-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/22 20:25, Michael Straube wrote:
> The function dump_chip_info() is only used in rtl8188e_hal_init.c.
> Make it static to reduce the driver object file size by 281 bytes.
> 
> before:
>    text    data     bss     dec     hex filename
> 530606   43897    7072  581575   8dfc7 drivers/staging/r8188eu/r8188eu.o
> 
> after:
>    text    data     bss     dec     hex filename
> 530405   43817    7072  581294   8deae drivers/staging/r8188eu/r8188eu.o
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/hal/hal_com.c         | 39 -------------------
>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 39 +++++++++++++++++++
>   drivers/staging/r8188eu/include/hal_com.h     |  3 --
>   3 files changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
> index e9a32dd84a8e..6a1cdc67335b 100644
> --- a/drivers/staging/r8188eu/hal/hal_com.c
> +++ b/drivers/staging/r8188eu/hal/hal_com.c
> @@ -10,45 +10,6 @@
>   
>   #define _HAL_INIT_C_
>   
> -void dump_chip_info(struct HAL_VERSION	chip_vers)
> -{
> -	uint cnt = 0;
> -	char buf[128];
> -
> -	cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
> -	cnt += sprintf((buf + cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
> -		       "Normal_Chip" : "Test_Chip");
> -	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
> -		       "TSMC" : "UMC");
> -
> -	switch (chip_vers.CUTVersion) {
> -	case A_CUT_VERSION:
> -		cnt += sprintf((buf + cnt), "A_CUT_");
> -		break;
> -	case B_CUT_VERSION:
> -		cnt += sprintf((buf + cnt), "B_CUT_");
> -		break;
> -	case C_CUT_VERSION:
> -		cnt += sprintf((buf + cnt), "C_CUT_");
> -		break;
> -	case D_CUT_VERSION:
> -		cnt += sprintf((buf + cnt), "D_CUT_");
> -		break;
> -	case E_CUT_VERSION:
> -		cnt += sprintf((buf + cnt), "E_CUT_");
> -		break;
> -	default:
> -		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_", chip_vers.CUTVersion);
> -		break;
> -	}
> -
> -	cnt += sprintf((buf + cnt), "1T1R_");
> -
> -	cnt += sprintf((buf + cnt), "RomVer(%d)\n", 0);
> -
> -	pr_info("%s", buf);
> -}
> -
>   #define	CHAN_PLAN_HW	0x80
>   
>   u8 /* return the final channel plan decision */
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index fe477438899e..5b8f1a912bbb 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -526,6 +526,45 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _size_byte, u8 *pbuf)
>   	Hal_EfuseReadEFuse88E(Adapter, 0, _size_byte, pbuf);
>   }
>   
> +static void dump_chip_info(struct HAL_VERSION chip_vers)
> +{
> +	uint cnt = 0;
> +	char buf[128];
> +
> +	cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
> +	cnt += sprintf((buf + cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
> +		       "Normal_Chip" : "Test_Chip");
> +	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
> +		       "TSMC" : "UMC");
> +
> +	switch (chip_vers.CUTVersion) {
> +	case A_CUT_VERSION:
> +		cnt += sprintf((buf + cnt), "A_CUT_");
> +		break;
> +	case B_CUT_VERSION:
> +		cnt += sprintf((buf + cnt), "B_CUT_");
> +		break;
> +	case C_CUT_VERSION:
> +		cnt += sprintf((buf + cnt), "C_CUT_");
> +		break;
> +	case D_CUT_VERSION:
> +		cnt += sprintf((buf + cnt), "D_CUT_");
> +		break;
> +	case E_CUT_VERSION:
> +		cnt += sprintf((buf + cnt), "E_CUT_");
> +		break;
> +	default:
> +		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_", chip_vers.CUTVersion);
> +		break;
> +	}
> +
> +	cnt += sprintf((buf + cnt), "1T1R_");
> +
> +	cnt += sprintf((buf + cnt), "RomVer(%d)\n", 0);
> +
> +	pr_info("%s", buf);
> +}
> +
>   void rtl8188e_read_chip_version(struct adapter *padapter)
>   {
>   	u32				value32;
> diff --git a/drivers/staging/r8188eu/include/hal_com.h b/drivers/staging/r8188eu/include/hal_com.h
> index 56ba356b5371..d7e333f6ce39 100644
> --- a/drivers/staging/r8188eu/include/hal_com.h
> +++ b/drivers/staging/r8188eu/include/hal_com.h
> @@ -131,9 +131,6 @@
>   #define REG_NOA_DESC_START			0x05E8
>   #define REG_NOA_DESC_COUNT			0x05EC
>   
> -#include "HalVerDef.h"
> -void dump_chip_info(struct HAL_VERSION	ChipVersion);
> -
>   /* return the final channel plan decision */
>   u8 hal_com_get_channel_plan(struct adapter *padapter,
>   			    u8 hw_channel_plan,

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4648563EE1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 09:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiGBHOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 03:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBHOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 03:14:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8014618E2A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 00:14:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id pk21so7715301ejb.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cwJr0Rj/cBbfz8CN3fmWkRtLbWhgFNVOHODvETM8Bh0=;
        b=m1j2IWcSiyfO8OkcvqFXdPLzraHX8gFmtOr0ZF1kegOUaK9q7r25ziI0KNJBGaUgOB
         EvJ2zz6WB9FVfLlrNBVQlzZCnohP51rFtqulbKd7/9St9T4KA2pxPX+fhhfQTeIabdHF
         VnTreh2Y8/SM6RGmRCbXY7rRsqrytwyOqa1bqi+r5oblszv+C15Rs0wKrA2jKEAFAs3o
         Ii8xW0qEkHiysDRbMUBeG8pbKc3cZExu+1ZCGaRCCLthKnDrxxy+EIPZW8KAFW/KO41H
         2tBl9fvIwXAtONMd9qqHWSXGM+CBiUF7QZn8dZrDBAPV/yYKGMazKK2wEuOvNp0VArTa
         pvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cwJr0Rj/cBbfz8CN3fmWkRtLbWhgFNVOHODvETM8Bh0=;
        b=FQca/oJEy4eGx1/U0s8NynqCKDAv6R7opvMpgmRD6s3lfQbNSh+T/X5ZUX7n2NbrRh
         jmlkHPKdLq94KTvEcXlKi0VC0SjFRNpwOq+25J2ejVdIXv/x1xMCwd0a3SA5lu4pU3Gh
         W6VEp2WqJbZ9swbnCk0wewuvyokS2gbnrPzGL8NvaKRYZZ2AWLdjEuL3Ati5Mc8xrInN
         ittC2J8iVQ3J9ZQO/Nk3csY579YRd/9uwjYNqhazS9bgv+U9muQY1m2SgyGMEQ9lYWFZ
         JJk9v1Y/Rh0l+lLgwiQDwzgqXYOG2EPo3Hfotc5W7SYguwpdMUrmaqg19ychkW/x3hBX
         T7YA==
X-Gm-Message-State: AJIora/uPwdEp7FTZLVzMzlGs9ROJHvkfIq440qg+LjCBD8jYNkovJTG
        nj7ebZroUV4dWSweI9/2JCQ=
X-Google-Smtp-Source: AGRyM1uc/1TG/ChbDHQt0Lvsl2WNSh8qXtz5nhM7dMHlWvkOEIh8aTk77gxbfLX5Uz2R5rnj73psvA==
X-Received: by 2002:a17:906:845b:b0:72a:4dbf:82e6 with SMTP id e27-20020a170906845b00b0072a4dbf82e6mr14478214ejy.149.1656746060086;
        Sat, 02 Jul 2022 00:14:20 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id t25-20020a056402241900b0043589eba83bsm5930978eda.58.2022.07.02.00.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 00:14:19 -0700 (PDT)
Message-ID: <ddbb1600-823f-86f9-e2be-4e6dbf501185@gmail.com>
Date:   Sat, 2 Jul 2022 09:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] staging: r8188eu: remove HW_VAR_AMPDU_FACTOR from
 SetHwReg8188EU()
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220701210753.8210-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220701210753.8210-1-straube.linux@gmail.com>
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

On 7/1/22 23:07, Michael Straube wrote:
> Remove the case HW_VAR_AMPDU_FACTOR from SetHwReg8188EU() and move
> the functionality to a static function in rtw_wlan_util.c. This is
> part of the ongoing effort to get rid of SetHwReg8188EU().
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_wlan_util.c | 28 +++++++++++++++++++-
>   drivers/staging/r8188eu/hal/usb_halinit.c    | 26 ------------------
>   drivers/staging/r8188eu/include/hal_intf.h   |  1 -
>   3 files changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> index 2d5fd654ead9..aa6b549fd54d 100644
> --- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> @@ -805,6 +805,32 @@ static void set_min_ampdu_spacing(struct adapter *adapter, u8 spacing)
>   	}
>   }
>   
> +static void set_ampdu_factor(struct adapter *adapter, u8 factor)
> +{
> +	u8 RegToSet_Normal[4] = {0x41, 0xa8, 0x72, 0xb9};
> +	u8 FactorToSet;
> +	u8 *pRegToSet;
> +	u8 index = 0;
> +
> +	pRegToSet = RegToSet_Normal; /*  0xb972a841; */
> +	FactorToSet = factor;
> +	if (FactorToSet <= 3) {
> +		FactorToSet = (1 << (FactorToSet + 2));
> +		if (FactorToSet > 0xf)
> +			FactorToSet = 0xf;
> +
> +		for (index = 0; index < 4; index++) {
> +			if ((pRegToSet[index] & 0xf0) > (FactorToSet << 4))
> +				pRegToSet[index] = (pRegToSet[index] & 0x0f) | (FactorToSet << 4);
> +
> +			if ((pRegToSet[index] & 0x0f) > FactorToSet)
> +				pRegToSet[index] = (pRegToSet[index] & 0xf0) | (FactorToSet);
> +
> +			rtw_write8(adapter, (REG_AGGLEN_LMT + index), pRegToSet[index]);
> +		}
> +	}
> +}
> +
>   void HTOnAssocRsp(struct adapter *padapter)
>   {
>   	unsigned char		max_AMPDU_len;
> @@ -831,7 +857,7 @@ void HTOnAssocRsp(struct adapter *padapter)
>   
>   	set_min_ampdu_spacing(padapter, min_MPDU_spacing);
>   
> -	SetHwReg8188EU(padapter, HW_VAR_AMPDU_FACTOR, (u8 *)(&max_AMPDU_len));
> +	set_ampdu_factor(padapter, max_AMPDU_len);
>   }
>   
>   void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 3908c46d2fbe..1a08de85a6ae 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -1209,32 +1209,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
>   	case HW_VAR_DM_FUNC_CLR:
>   		podmpriv->SupportAbility = 0;
>   		break;
> -	case HW_VAR_AMPDU_FACTOR:
> -		{
> -			u8 RegToSet_Normal[4] = {0x41, 0xa8, 0x72, 0xb9};
> -			u8 FactorToSet;
> -			u8 *pRegToSet;
> -			u8 index = 0;
> -
> -			pRegToSet = RegToSet_Normal; /*  0xb972a841; */
> -			FactorToSet = *((u8 *)val);
> -			if (FactorToSet <= 3) {
> -				FactorToSet = (1 << (FactorToSet + 2));
> -				if (FactorToSet > 0xf)
> -					FactorToSet = 0xf;
> -
> -				for (index = 0; index < 4; index++) {
> -					if ((pRegToSet[index] & 0xf0) > (FactorToSet << 4))
> -						pRegToSet[index] = (pRegToSet[index] & 0x0f) | (FactorToSet << 4);
> -
> -					if ((pRegToSet[index] & 0x0f) > FactorToSet)
> -						pRegToSet[index] = (pRegToSet[index] & 0xf0) | (FactorToSet);
> -
> -					rtw_write8(Adapter, (REG_AGGLEN_LMT + index), pRegToSet[index]);
> -				}
> -			}
> -		}
> -		break;
>   	default:
>   		break;
>   	}
> diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
> index c3704618bccc..b81144932d9a 100644
> --- a/drivers/staging/r8188eu/include/hal_intf.h
> +++ b/drivers/staging/r8188eu/include/hal_intf.h
> @@ -17,7 +17,6 @@ enum hw_variables {
>   	HW_VAR_DM_FUNC_OP,
>   	HW_VAR_DM_FUNC_RESET,
>   	HW_VAR_DM_FUNC_CLR,
> -	HW_VAR_AMPDU_FACTOR,
>   };
>   
>   typedef s32 (*c2h_id_filter)(u8 id);

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

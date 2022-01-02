Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F20482CD7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 22:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiABVoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 16:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiABVoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 16:44:15 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B8BC061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 13:44:15 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u22so53180428lju.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 13:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FMeedJAM/soUFft4dLwmEecukljurYLI/Ey+pp0EcD8=;
        b=o4xoodImPAky4S+E99OQAsZLmM7glmo90i5nznhNt9fNe35KpdFpmUfN+jiQ0mvLON
         HRpOiQqx6lOuvmPGPU4tr6Ml4ITr0ttmFpHUNCDvU0AX8lffhl7D/r+Pd1lz5BnWuHY2
         feGmHDNaf4obqR/lGE7lAVnxkLIhjZSlZOD82vnoj2dpTZllSFWaVMf0mMsNUsIIqY/d
         P0Y+P0NwSwfPJkrfCf3DTVC4DLkQR93qIfnSVBijcyffEjrwc4Jex/ZsjuGKHKxiTG7Z
         lDTLWAVM8Jj1GEdmcw4WNMfqyjzXhHFDH9mLn+AqtXSofm5OS8SHqiBWiQIR1b3cMjyW
         H8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FMeedJAM/soUFft4dLwmEecukljurYLI/Ey+pp0EcD8=;
        b=KbSCIVrn4DVyOlTRR9LfHhkwu8/1syOwoexBwbTqep8MXL5SUiVkGvbbIR8Wwtr9NE
         79N+kjvdchGa+X98vomEniJolkYnYc4ffzJ+KyJdGHmMPbAYOMtHDYtpYWJXwwd7aVwU
         ockue81TxxMz2tVQmMkOYQYAVwW7HscxGfsXAlME2Ff5eTaTNLZfoqhN4X9tFgWc26BF
         y9zJZu2LpQclVJYyaTevJjeVdIe2zZWx3AH6eHELeRoGVL6nar8bT5dqEdC0g0CMxfT5
         2BwK9BMwGjmrHAbSwh4Dz1YoHt51dbFOh9Hytkn8FunRTFXnSEOaFVKHWuTfelQsb6MZ
         wdXQ==
X-Gm-Message-State: AOAM530t+jV0i4w8D770U/TJgCA3baypeyIfUyf6TfwBapTmPOAAO+I+
        cjTBqOjDr9TCjh9dICq5XpttxCb2/jI=
X-Google-Smtp-Source: ABdhPJwWWGBrUDZA8W7z0CJAjMI9vIe+DXEUHcSgH2jJ/EpegvLIJ0MqC0o9vZLaJi86Yh142AizZg==
X-Received: by 2002:a05:651c:12c9:: with SMTP id 9mr36811289lje.474.1641159853363;
        Sun, 02 Jan 2022 13:44:13 -0800 (PST)
Received: from [192.168.1.11] ([217.117.245.177])
        by smtp.gmail.com with ESMTPSA id 8sm3245140ljf.123.2022.01.02.13.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jan 2022 13:44:13 -0800 (PST)
Message-ID: <6d33d346-b797-aeb3-8b1b-64332e05fb87@gmail.com>
Date:   Mon, 3 Jan 2022 00:44:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 5/5] staging: r8188eu: turbo scan is always off for
 r8188eu
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220102175932.89127-1-martin@kaiser.cx>
 <20220102175932.89127-6-martin@kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220102175932.89127-6-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/22 20:59, Martin Kaiser wrote:
> Turbo scan is always disabled. Remove the TurboScanOff variable and
> related checks.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 21 +++++++------------
>   1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> index 0b982cc7c86f..6e0231099986 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> @@ -87,28 +87,21 @@ rtl8188e_PHY_RF6052SetCckTxPower(
>   	struct hal_data_8188e *pHalData = &Adapter->haldata;
>   	struct mlme_ext_priv *pmlmeext = &Adapter->mlmeextpriv;
>   	u32 TxAGC[2] = {0, 0}, tmpval = 0, pwrtrac_value;
> -	bool TurboScanOff = false;
>   	u8 idx1, idx2;
>   	u8 *ptr;
>   	u8 direction;
> -	/* FOR CE ,must disable turbo scan */
> -	TurboScanOff = true;
>   
>   	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
>   		TxAGC[RF_PATH_A] = 0x3f3f3f3f;
>   		TxAGC[RF_PATH_B] = 0x3f3f3f3f;
>   
> -		TurboScanOff = true;/* disable turbo scan */
> -
> -		if (TurboScanOff) {
> -			for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
> -				TxAGC[idx1] =
> -					pPowerlevel[idx1] | (pPowerlevel[idx1] << 8) |
> -					(pPowerlevel[idx1] << 16) | (pPowerlevel[idx1] << 24);
> -				/*  2010/10/18 MH For external PA module. We need to limit power index to be less than 0x20. */
> -				if (TxAGC[idx1] > 0x20 && pHalData->ExternalPA)
> -					TxAGC[idx1] = 0x20;
> -			}
> +		for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
> +			TxAGC[idx1] =
> +				pPowerlevel[idx1] | (pPowerlevel[idx1] << 8) |
> +				(pPowerlevel[idx1] << 16) | (pPowerlevel[idx1] << 24);
> +			/*  2010/10/18 MH For external PA module. We need to limit power index to be less than 0x20. */
> +			if (TxAGC[idx1] > 0x20 && pHalData->ExternalPA)
> +				TxAGC[idx1] = 0x20;
>   		}
>   	} else {
>   		for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {

Hi Martin,

thanks for your clean up work!


It's a bit unrelated to the patch, but I found it while reviewing this. 
It's in the same function rtl8188e_PHY_RF6052SetCckTxPower():

89: 	u32 TxAGC[2] = {0, 0};
...
92	u8 *ptr;
...
129	for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
130		ptr = (u8 *)(&TxAGC[idx1]);
131		for (idx2 = 0; idx2 < 4; idx2++) {
132			if (*ptr > RF6052_MAX_TX_PWR)
133				*ptr = RF6052_MAX_TX_PWR;
134			ptr++;
135		}
136	}


What is going on here? Code just checks and writes to random place on 
stack outside TxAGC array? I might be missing something, but it looks 
wrong...

Just wanted to share, since I believe your knowledge about this driver 
is much deeper than mine :)

thanks


With regards,
Pavel Skripkin

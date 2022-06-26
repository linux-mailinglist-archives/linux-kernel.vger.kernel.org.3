Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B056C55B410
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiFZUpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiFZUpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:45:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3768EB5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:45:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o10so10467194edi.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/ci1+NPUxEsVxZZfKgEg6JySTcs1pF3WLyCCsnWy1KA=;
        b=R5/A1EFUSSujFY8sf4fu7RwPA4Dwc4d+8eOJdJpbOiGhnkaFTm8fcgNXS2u9w8Uh6M
         UhXsh0TFo6jgys/pJPT/MhgXuan6EAr8ye6XOW5FSYrd0xbNhbg3VOzKFSm+2NmtD7Vq
         JjqMjbYvbCnL+0fEVTjXP9JaCzi9Udzy0AVPoVSLNh3RkH9a3EEH36B4N4nUZKSIu73W
         L4r5VT8Bu3gAdJTNVNnykPn75BGe7gX3H1skZ3vfis6c3e4ubn4JCWXlj2XOwSJdcx13
         lx3spPfCCxcpDP06guSadAHfuiUoXjDrJSISVJeXFIaHeS2JSWmtxINPobRxoaymMfQN
         y0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/ci1+NPUxEsVxZZfKgEg6JySTcs1pF3WLyCCsnWy1KA=;
        b=zkKp1Z7jzEoaTIzvdc09EuwccGBDEdFk4t23ap/gg6W8WbTdosQkIMFmupbwKxLwpi
         ps/VYPXFpsYUex/YwHgRb5oxHXn34Fs+kizj38bLVFjU5TanBXFzA4g6JjFdjYv/TDzU
         5p36xDNnxj7es1/DIAAyO+CNVJsdN2j8WbBbJM+gMWz0QHXf/ax+n/7E/DQju2UJBx/L
         wUuSKSyLed8ZaSVSB51utoIXiI6IeWlL5uJw6iRLPqKqXAb4tLt9BMvAoGcqH6ENP6Iv
         QDGeJ4W08PwXLdzOsQqjxTXor7jv7qDghHRQM+hHjWNZp8KeQxPTVmPh6eqf5E5g9axk
         Q25w==
X-Gm-Message-State: AJIora9+EipYc458OhSHIdFFZBPobKZkSFU9vW0IdMdCkZr3r63NP7nO
        TnVngEig7ucHks1MylGKn18=
X-Google-Smtp-Source: AGRyM1vIrlrNeHZBHntI8u/d9LgSPfq6A2Tt7jtq59RDqKHRB3Qu0gFpnKHh4CmjCxecAVn0zyaYqw==
X-Received: by 2002:a05:6402:25c2:b0:431:932e:eb6f with SMTP id x2-20020a05640225c200b00431932eeb6fmr13078820edb.296.1656276338173;
        Sun, 26 Jun 2022 13:45:38 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id o19-20020a170906775300b007052b183d51sm4131367ejn.132.2022.06.26.13.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 13:45:37 -0700 (PDT)
Message-ID: <e048a607-6679-8a0d-f68c-91b4c4b42afd@gmail.com>
Date:   Sun, 26 Jun 2022 22:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] staging: r8188eu: merge two led structs
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220626181000.287225-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220626181000.287225-1-martin@kaiser.cx>
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

On 6/26/22 20:09, Martin Kaiser wrote:
> The led layer uses struct led_priv and struct LED_871x to store state
> info. Merge the two structs. Move LED_871x's components into led_priv.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/core/rtw_led.c    | 27 ++++++++++-------------
>   drivers/staging/r8188eu/include/rtw_led.h |  9 +++-----
>   2 files changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
> index 25989acf5259..d5c6c5e29621 100644
> --- a/drivers/staging/r8188eu/core/rtw_led.c
> +++ b/drivers/staging/r8188eu/core/rtw_led.c
> @@ -16,7 +16,7 @@
>   	(l)->CurrLedState == LED_BLINK_WPS_STOP || \
>   	(l)->bLedWPSBlinkInProgress)
>   
> -static void ResetLedStatus(struct LED_871x *pLed)
> +static void ResetLedStatus(struct led_priv *pLed)
>   {
>   	pLed->CurrLedState = RTW_LED_OFF; /*  Current LED state. */
>   	pLed->bLedOn = false; /*  true if LED is ON, false if LED is OFF. */
> @@ -32,7 +32,7 @@ static void ResetLedStatus(struct LED_871x *pLed)
>   	pLed->bLedScanBlinkInProgress = false;
>   }
>   
> -static void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
> +static void SwLedOn(struct adapter *padapter, struct led_priv *pLed)
>   {
>   	u8	LedCfg;
>   	int res;
> @@ -48,7 +48,7 @@ static void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
>   	pLed->bLedOn = true;
>   }
>   
> -static void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
> +static void SwLedOff(struct adapter *padapter, struct led_priv *pLed)
>   {
>   	u8	LedCfg;
>   	int res;
> @@ -75,7 +75,7 @@ static void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
>   static void blink_work(struct work_struct *work)
>   {
>   	struct delayed_work *dwork = to_delayed_work(work);
> -	struct LED_871x *pLed = container_of(dwork, struct LED_871x, blink_work);
> +	struct led_priv *pLed = container_of(dwork, struct led_priv, blink_work);
>   	struct adapter *padapter = pLed->padapter;
>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>   
> @@ -182,35 +182,32 @@ static void blink_work(struct work_struct *work)
>   void rtl8188eu_InitSwLeds(struct adapter *padapter)
>   {
>   	struct led_priv *pledpriv = &padapter->ledpriv;
> -	struct LED_871x *pLed = &pledpriv->SwLed0;
>   
> -	pLed->padapter = padapter;
> -	ResetLedStatus(pLed);
> -	INIT_DELAYED_WORK(&pLed->blink_work, blink_work);
> +	pledpriv->padapter = padapter;
> +	ResetLedStatus(pledpriv);
> +	INIT_DELAYED_WORK(&pledpriv->blink_work, blink_work);
>   }
>   
>   void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
>   {
>   	struct led_priv	*ledpriv = &padapter->ledpriv;
> -	struct LED_871x *pLed = &ledpriv->SwLed0;
>   
> -	cancel_delayed_work_sync(&pLed->blink_work);
> -	ResetLedStatus(pLed);
> -	SwLedOff(padapter, pLed);
> +	cancel_delayed_work_sync(&ledpriv->blink_work);
> +	ResetLedStatus(ledpriv);
> +	SwLedOff(padapter, ledpriv);
>   }
>   
>   void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
>   {
> -	struct led_priv *ledpriv = &padapter->ledpriv;
> +	struct led_priv *pLed = &padapter->ledpriv;
>   	struct registry_priv *registry_par;
> -	struct LED_871x *pLed = &ledpriv->SwLed0;
>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>   
>   	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped) ||
>   	    (!padapter->hw_init_completed))
>   		return;
>   
> -	if (!ledpriv->bRegUseLed)
> +	if (!pLed->bRegUseLed)
>   		return;
>   
>   	registry_par = &padapter->registrypriv;
> diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
> index 2c14cb23d9ad..d6b0c1c2f9a2 100644
> --- a/drivers/staging/r8188eu/include/rtw_led.h
> +++ b/drivers/staging/r8188eu/include/rtw_led.h
> @@ -37,9 +37,11 @@ enum LED_STATE_871x {
>   	LED_BLINK_RUNTOP = 13, /*  Customized for RunTop */
>   };
>   
> -struct LED_871x {
> +struct led_priv {
>   	struct adapter *padapter;
>   
> +	bool bRegUseLed;
> +
>   	enum LED_STATE_871x	CurrLedState; /*  Current LED state. */
>   	enum LED_STATE_871x	BlinkingLedState; /*  Next state for blinking,
>   				   * either RTW_LED_ON or RTW_LED_OFF are. */
> @@ -58,11 +60,6 @@ struct LED_871x {
>   	struct delayed_work blink_work;
>   };
>   
> -struct led_priv{
> -	struct LED_871x			SwLed0;
> -	bool	bRegUseLed;
> -};
> -
>   void rtl8188eu_InitSwLeds(struct adapter *padapter);
>   void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
>   

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

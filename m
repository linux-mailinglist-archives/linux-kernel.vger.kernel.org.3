Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6D14FFFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiDMU1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbiDMU1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:27:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1346F4BFE2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:24:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b21so5585605lfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QJ5sTyRXODAe6Yj1NqU8Svd2xdPO6Zu9E85WaAx9PWE=;
        b=DBUo9zxVWHLMuYWmfCttg/JIIivO3FPIzTfAeZ6zmB1pcjms7Sa0DQ+Ye5pvKqDvbk
         qVjqTKAKSH856P1pkVfdysbJuM5cuFVklYT2evCxvESxZn+5+9w3OQ8NAo75PEhHvzS7
         LHE/9ytcS+v/sCB3tKe9RWhvjW1ktxMKSVCECISVjXbuw5lFgg6+iCtBn6/LnoVg8t5p
         R+KKoz2KH2fPqJ7ak7S/vrguhXAuDwxAvlkv3q+zQXGGj2bcegQlK+YEQKc/CgjRfuWy
         hA/tI8EyShy5l3XlknAgF8r/wF2cEc86gGfIkIWfqyojgY/XhBNG03VRpWc0ZgqZ2pAo
         ztpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QJ5sTyRXODAe6Yj1NqU8Svd2xdPO6Zu9E85WaAx9PWE=;
        b=q6wNkeQy4nRS/LHTnCXZ3DLVu8cNIQWetqhNw3iwp7QV2J6l4VMo0A/etnQw/VWbq1
         dvu5eVsgZGle7E2eiEXyROTEnzLob+SwCnsHeywSKLLc5NM11zm04ERvFPVWrdr4eFIA
         mXb9aZA5Uu84Xr8WuQ/7MkSmLWwFmYgpW4SKOkRWlURFKGR012IqM19RAklaa/CISSwh
         R89PfwC5u45yvgVz4FRuDq5gGWlM3Jm1ddHrKFDEhwfZCSRGXQOhzjTXIKWrtK6YNCuO
         agSWu411yuGFBkiNcf8oyalmvHcp5JjWh6AGc+589irY2eQHpvsTqjRB2jif/1OvyI6u
         7+oQ==
X-Gm-Message-State: AOAM5337trGoZfTpsiymTCs9ad7FdyQjvIViwIdWvXGPSFW7YzQaBghR
        GXsqMVTFuXsMRAlOgMdp4kLNUp7skl3XGQ==
X-Google-Smtp-Source: ABdhPJw7Bb3Dr2VojoGI6uyIup0R4eK6b5vwAVrSnHxXRhrZJS9bNEgWl0PZYkHwswFBkIuDIkM2CQ==
X-Received: by 2002:a05:6512:3fa1:b0:44a:f351:5a00 with SMTP id x33-20020a0565123fa100b0044af3515a00mr29051943lfa.19.1649881488119;
        Wed, 13 Apr 2022 13:24:48 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id r23-20020a2e94d7000000b0024c7e0c3862sm543488ljh.58.2022.04.13.13.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 13:24:47 -0700 (PDT)
Message-ID: <3f4a6c08-4434-1865-bc96-984152af5af1@gmail.com>
Date:   Wed, 13 Apr 2022 23:24:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/6] staging: r8188eu: remove unnecessary braces in single
 statement block
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <cover.1649880454.git.jhpark1013@gmail.com>
 <4a0f2a0f24321c5b2039f0f8e6132cec4a2ef068.1649880454.git.jhpark1013@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <4a0f2a0f24321c5b2039f0f8e6132cec4a2ef068.1649880454.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaehee,

On 4/13/22 23:11, Jaehee Park wrote:
> Remove braces for single statement block to minimize the number of
> empty lines, without loss of readability. Issue found with checkpatch.
> WARNING: braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_mlme.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index 3e9882f89f76..d3f4d7cdfa08 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -112,9 +112,8 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
>   
>   	rtw_free_mlme_priv_ie_data(pmlmepriv);
>   
> -	if (pmlmepriv) {
> +	if (pmlmepriv)
>   		vfree(pmlmepriv->free_bss_buf);
> -	}
>   

If pmlmepriv is equal to NULL we would die in 
rtw_free_mlme_priv_ie_data(), so this check is just redundant




With regards,
Pavel Skripkin

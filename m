Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526E44F04FA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358295AbiDBQj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358233AbiDBQjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:39:24 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D0310F6EB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:37:31 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r8so5787947oib.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+SrOdpKkibueEZ8eDGW7T0xC56oTL11h6V+jlJthOQ4=;
        b=DsLi3EnN3YFbOVIJLaRoUhsgy/G0bmJh3Nn+pHdw4dxkDNV51PiTWHOioyO1/AIPR/
         ntrq5xU2V8b6NKpldeo+sKZDbTnB3bql3YT3691vtY7PGqi0w6mU6JqshXIdnYxqa4c4
         WasqcgIWXKJgB7I3Vgt/T/HjTVROp8+v2bzUeSeS+CBM88/7wSCCfA3hLsC+2PKIFUPX
         8NU2T01o+mlGVWZHe14VJtExQOh8ewctAeYfU/9RteMpHUZgg7VDnLcG8ZctUTxVKDGp
         Nh+hTQmYjh0niTcGvNjWMmBrMYY+dYuKYMsfygHhypxSesXtXgLnLuRRbjwHj/dD7T9v
         CMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+SrOdpKkibueEZ8eDGW7T0xC56oTL11h6V+jlJthOQ4=;
        b=UG53Ym81Ij/XAHmuJKhkfkxaHEoY0N5oGugrAXg/RJBCWqQDLgYw5sDpHAunkFuAFa
         42BgV8F13uEqVT6nTA93N39Xfag6QJvEdJtKjUYsu/pW3DfJL+L2ABTbXdiGVqr50u2x
         4U+CUfHXE0RxgDKWcA32Ocx1wTYmn5PR+bOScoiAAwJ/UJjj7n/thWvkHFLoDHbW1Jtb
         UD8VgxagFW+ucXK4ovPwEN58m3CcQ5vvpE8CEwscHAmr45lF5spUSeGJ7tT6sY0YqKlK
         FdmnCKCYWD7gswbH/6EC2nTnt5JvhK5IJZq69i721er1Nkhi/Lk9NtJ6KIy2YrJ0+kBW
         U75w==
X-Gm-Message-State: AOAM531XOpLUs64WVEIbCjHU6Fb3msl4lhyt1cdt+j1q635e7+6/Cjja
        wPwWU4MtOl/3B+0sSxdGp8peuXPNe9E=
X-Google-Smtp-Source: ABdhPJy/wqNp3hVjUDNjyBYFhnwTLbEVb2FrtK2I7HzzwTh3kUcZMXjmsIW5K+jVgs3+sybmcjibFw==
X-Received: by 2002:a05:6808:1444:b0:2ed:a247:e5e2 with SMTP id x4-20020a056808144400b002eda247e5e2mr7064762oiv.115.1648917450991;
        Sat, 02 Apr 2022 09:37:30 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1004? (2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com. [2603:8090:2005:39b3::1004])
        by smtp.gmail.com with ESMTPSA id s24-20020a056808209800b002da3b9bf8e0sm2235436oiw.32.2022.04.02.09.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 09:37:30 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <563ddd2d-b8b2-dde6-a0de-c7bbebcc834e@lwfinger.net>
Date:   Sat, 2 Apr 2022 11:37:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/6] staging: r8188eu: format block comments
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>, outreachy@lists.linux.dev
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1648888461.git.remckee0@gmail.com>
 <0387f3df49d89c17acf96cf072e70c98e81e58f7.1648888462.git.remckee0@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <0387f3df49d89c17acf96cf072e70c98e81e58f7.1648888462.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 03:50, Rebecca Mckeever wrote:
> Add ' * ' or ' ' to beginning of block comment lines
> to conform to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: Block comments use * on subsequent lines
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_cmd.c | 29 +++++++++++++-------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 2e135bbd836a..0c659b40aa1c 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -12,9 +12,9 @@
>   #include "../include/rtl8188e_dm.h"
>   
>   /*
> -Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
> -No irqsave is necessary.
> -*/
> + * Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
> + * No irqsave is necessary.
> + */
>   
>   static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
>   {
> @@ -97,14 +97,13 @@ static void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
>   }
>   
>   /*
> -Calling Context:
> -
> -rtw_enqueue_cmd can only be called between kernel thread,
> -since only spin_lock is used.
> -
> -ISR/Call-Back functions can't call this sub-function.
> -
> -*/
> + * Calling Context:
> + *
> + * rtw_enqueue_cmd can only be called between kernel thread,
> + * since only spin_lock is used.
> + *
> + * ISR/Call-Back functions can't call this sub-function.
> + */
>   
>   static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
>   {
> @@ -319,10 +318,10 @@ int rtw_cmd_thread(void *context)
>   }
>   
>   /*
> -rtw_sitesurvey_cmd(~)
> -	### NOTE:#### (!!!!)
> -	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
> -*/
> + * rtw_sitesurvey_cmd(~)
> + *	### NOTE:#### (!!!!)
> + *	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
> + */
>   u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num,
>   	struct rtw_ieee80211_channel *ch, int ch_num)
>   {

These changes are OK, but the rules in drivers/net/wireless specify using

/* abcd

rather than

/*
  * abcd

Thus, if and when this driver is accepted into the drivers/net/wireless tree, 
another change will be needed. I suggest doing that now.

Larry

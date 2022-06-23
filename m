Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702505572B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiFWFwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWFws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:52:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB21E3D4AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:52:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cf14so17180972edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qXZuzdMIsSYM+D0zF4cI4kdnqVrGeqluJlkjXVrbHUo=;
        b=br0BOd9JWtp3p8yPpF/OnoN29KXjf1tmUnKc4jHNFGjjLORcExuG2JlojRl7/L5GL8
         zF2cEZPR4ZOyUmukMngnnFr3+Q+uxoigPeTF4sA6nRbIBTPwU89208f3rUHltsE1LLUw
         Bw0L8AJfn9S7WntbgFmEjuzZxQLYX/k80b7xROQvwgIqk8y+pjz5LkbT2WkgAiwBYphR
         kmLA5kb2eT55+zxT6MXQv1XwLzvTkCwSbENx42gyZHZXMPNsGD4zwqz2qhT962h2+eW7
         omrx2hZof+scAN/42UuPX25pnZ5Sp5xBieX/yocickgoXzq28v1JFhuUDr3gFseFZpvu
         amgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qXZuzdMIsSYM+D0zF4cI4kdnqVrGeqluJlkjXVrbHUo=;
        b=fFaQv7K6ZEugH3Cch1sIgRkUofsQeKU9573A6+2oGtikrRQRdaExww8y1pFuo/Qvrz
         3Bj4/u2O9R7E5b4FKUFsWDmN0VHfmuuGBhCQynE3y1491m5hFHArWFn6Of1F4VHsLPkV
         OoG66PNZi0Iev3H2NT/fSy9EvUtiStrPobt77OXTDb4RfkVTLn5NH+DLTaARHypmjzas
         tEfX67/KlTXxq/0tYehqlWHsc2CmlIX43s9f45X3aO0hH2jmyrHM3+FrP/6PBYQHM7CF
         HcozGQFypZnsLc7Xv129FmHYrMkq2OS2RSUulOZe1CreGbVlsAFL5cXfpkLvIRUemFBg
         mtVA==
X-Gm-Message-State: AJIora8FDvG2Y8IfvzDWmgjROaknBWLFdLc59tkzx/IPJdesmomP49fI
        xc+NeHqmpOFS/BGefg0cvwk=
X-Google-Smtp-Source: AGRyM1sHYj272DJZDqR+/VB0RgZIX/8moaVQPYZZf836p/96v4eCGhQHTL8dA/m/Ps/q7gBqPtXw0A==
X-Received: by 2002:a05:6402:5255:b0:435:bec2:9e33 with SMTP id t21-20020a056402525500b00435bec29e33mr4739267edd.398.1655963565560;
        Wed, 22 Jun 2022 22:52:45 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id t11-20020a17090605cb00b0070d742804a5sm1243688ejt.150.2022.06.22.22.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 22:52:45 -0700 (PDT)
Message-ID: <378d9e97-e248-dbfa-94f6-216e2e8cc609@gmail.com>
Date:   Thu, 23 Jun 2022 07:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] staging: r8188eu: Make rtw_signal_stat_timer_hdl a
 static function
Content-Language: en-US
To:     Chang Yu <marcus.yu.56@gmail.com>, Larry.Finger@lwfinger.net
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20220623043855.407208-1-marcus.yu.56@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220623043855.407208-1-marcus.yu.56@gmail.com>
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

On 6/23/22 06:38, Chang Yu wrote:
> Make rtw_signal_stat_timer_hdl a static function instead of a global
> function.
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
> Changes in v2:
> Added static for the definition as well
> 
>   drivers/staging/r8188eu/core/rtw_recv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index cc91638a085d..6564e82ddd66 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -24,7 +24,7 @@ static u8 rtw_rfc1042_header[] = {
>   	0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
>   };
>   
> -void rtw_signal_stat_timer_hdl(struct timer_list *t);
> +static void rtw_signal_stat_timer_hdl(struct timer_list *t);
>   
>   void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
>   {
> @@ -1794,7 +1794,7 @@ s32 rtw_recv_entry(struct recv_frame *precvframe)
>   	return ret;
>   }
>   
> -void rtw_signal_stat_timer_hdl(struct timer_list *t)
> +static void rtw_signal_stat_timer_hdl(struct timer_list *t)
>   {
>   	struct adapter *adapter = from_timer(adapter, t, recvpriv.signal_stat_timer);
>   	struct recv_priv *recvpriv = &adapter->recvpriv;

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

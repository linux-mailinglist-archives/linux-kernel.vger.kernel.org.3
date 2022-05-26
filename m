Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77301534BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbiEZIV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244940AbiEZIVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:21:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AE71ADAB;
        Thu, 26 May 2022 01:21:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e4so963623ljb.13;
        Thu, 26 May 2022 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1LFjb+AEMb7z82D6ENilph3SWwRvfmyKBpvYsDU8o1E=;
        b=L+4Ap8XN1HHlwZsMeelkJ+GCXPaL2OG9wfryU9zYd1a9r3hK6NFOFJi3FgTntbzEqk
         //INeR3wAUN6jxsfnITyvcsA9YtNuMCSpENBvwvrO69+BQN/moKg+8Op5MOLL3cBkCv/
         gbLy4eoIDTjiJ6uMeTHoTenBCabQNIbzvY5/skEb0/EV89SqBZ5gkTg5NF5lMFu/nEpg
         O5Nt3ojLu77EB8UWdbioXzLZY3Je3TOK71YeVb67KEH2alLBkTSFCD0PCqF84RbDHoVU
         ifoqWjaFF2oJOYFY16wJ/AbxDgEBZ73SlHdEwccujvPMLRkDJN3uuJOI3ZJs6sgLMLYn
         7MDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1LFjb+AEMb7z82D6ENilph3SWwRvfmyKBpvYsDU8o1E=;
        b=bTyYmQemfrLhNhvbWoCJsuGhNCubRRezahSVbGo2bmc9A7jeeCiNE60b8X8PkkMFcT
         L2MpuwOzhtP412vNP2h7M0gOZxZAuSdMEzEFgxOg90vJb8KtaDqvfFImnOsygnDZcO9R
         VQ8nuINit6B9NIo1aBYnDIhzqWLlGn8Nd8jP/ynk1ZhWzjensWJ5ayrCIIAn1vDoaT1u
         eVPonP2Y2g12jcO3GFjfo2z4b/nxDuPiIoXrh1LmBkSs/UrdGxfTiRHwiopTUCKvlLza
         4hKiVkEIo0TNuAY0XVvtmNBq8r2EOusPWhWoHN7+J95YowC8rQBGASvkPVHI7l2q5GfC
         FBdw==
X-Gm-Message-State: AOAM531S9BS/vtVFvViqt9CWPM1swCfin8YigPiyA+XQUhNa+HSsD9F8
        Qjp+7Q/AYgCIeB9Ulr0og7R5KN2b5T0=
X-Google-Smtp-Source: ABdhPJyzvINvKfeNR9ga9kpdjXm6FvmwSTjTIASvaKlRKHPS6yUP0cXyoMr5Ce/DLZl4/MbyGqAsLw==
X-Received: by 2002:a05:651c:994:b0:253:c449:12f with SMTP id b20-20020a05651c099400b00253c449012fmr21320097ljq.413.1653553301939;
        Thu, 26 May 2022 01:21:41 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.78.197])
        by smtp.gmail.com with ESMTPSA id h1-20020a056512220100b0047255d211b2sm212464lfu.225.2022.05.26.01.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 01:21:41 -0700 (PDT)
Subject: Re: [PATCH 1/4] sh: Kconfig: Fix indentation
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220525124007.45328-1-juerg.haefliger@canonical.com>
 <20220525124007.45328-2-juerg.haefliger@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <0f0c5ce5-3845-c4b4-180e-380dec53b525@gmail.com>
Date:   Thu, 26 May 2022 11:21:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220525124007.45328-2-juerg.haefliger@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 3:40 PM, Juerg Haefliger wrote:

> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> While at it, remove stray spaces from seemingly empty lines.

   You're also fixing some trailing spaces... that all counts up
to fixing trailing whitespace.

> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  arch/sh/Kconfig | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 5f220e903e5a..fc15fd6b719e 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
[...]
> @@ -644,7 +644,7 @@ config GUSA
>  	  This is the default implementation for both UP and non-ll/sc
>  	  CPUs, and is used by the libc, amongst others.
>  
> -	  For additional information, design information can be found 
> +	  For additional information, design information can be found
>  	  in <http://lc.linux.or.jp/lc2002/papers/niibe0919p.pdf>.
>  
>  	  This should only be disabled for special cases where alternate
[...]

MBR, Sergey

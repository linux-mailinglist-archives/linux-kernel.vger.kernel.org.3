Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EA04E3BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiCVJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiCVJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:21:30 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1815C847;
        Tue, 22 Mar 2022 02:20:02 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id i186so590197wma.3;
        Tue, 22 Mar 2022 02:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dOhc948YByb3X4njXePU+uM0J2dUUfssn4Dzwq4pjgs=;
        b=WNNFcHaYWa2cL5HJbbSPwE9d58YSsw4NJVJiV5+moo37We116eMJiaVd65myWQCaCH
         kItkdg5ny5udVY+ennFhybadikB3MJ/byK1hWqwp9ncP098YDDJ0Ptf3dutQw2zzEjF+
         Y1O0v2rjtGF3lhPW1jQVxiGRLHd4tlsrB/Qgp5MKgxH87x7229sUkVD3IJA7xLCQtNsH
         3UCqcNFJG18C2erJmI9pIVZa8dOfEKbdASnNDp6rJJGFPhMPqeS9SPXKm/Cm1WEIiLRu
         aSAQTSgwT4SgT2XndLvZgDfvCkbBetOGIlHOdDBhUusANsO8F1EE8UaQJmNKmO0RDmd/
         WuJw==
X-Gm-Message-State: AOAM533YdD7+WE9wo0IMXGhYYsK7INKiTKmA3TND91pFIGF1WNjE1zZT
        t6ybLckRlTtQ3FVROi17OhE=
X-Google-Smtp-Source: ABdhPJyT5mw6+28NcJn9iGRWPEBClXbyxwOahskWUbT9xdMMdntanGruWXf6u0KwMNLIORVlsqZ8UA==
X-Received: by 2002:a05:600c:1c8e:b0:38c:a386:26aa with SMTP id k14-20020a05600c1c8e00b0038ca38626aamr2776405wms.204.1647940801298;
        Tue, 22 Mar 2022 02:20:01 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm59059wmq.41.2022.03.22.02.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 02:20:00 -0700 (PDT)
Message-ID: <28696c20-21ad-b0ac-8093-4ce07225fcd8@kernel.org>
Date:   Tue, 22 Mar 2022 10:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: hppa vDSO and compiler (non-)support
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
 <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
 <dd4e55aa-0b3e-6e18-7ec2-3bec02cafde0@kernel.org> <YjjJNb0D/b+ZXBVZ@ls3530>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YjjJNb0D/b+ZXBVZ@ls3530>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 21. 03. 22, 19:51, Helge Deller wrote:
> * Jiri Slaby <jirislaby@kernel.org>:
>> On 09. 03. 22, 6:48, Jiri Slaby wrote:
>>> On 08. 03. 22, 15:51, Helge Deller wrote:
>>>> On 3/8/22 12:06, Jiri Slaby wrote:
>>>>> since the "parisc: Add vDSO support" commit, I can no longer
>>>>> cross-build a hppa kernel. I see two issues:
>>>>>
>>>>> 1) CROSS32_COMPILE detection doesn't work here, as openSUSE
>>>>> provides hppa-suse-linux-* binaries. It's easy to overcome by
>>>>> "CROSS32_COMPILE=hppa-suse-linux-"
>>>>
>>> ...
>>>> Would it make sense to add the detection for SUSE too?
>>
>> So, could 1) be fixed on the Kconfig side? Or should I (people running SUSE)
>> use "CROSS32_COMPILE=hppa-suse-linux-"?
> 
> Could you please try if this patch fixes it for you?

Works like a charm:
$ make V=1 O=../a/arch/parisc/ ARCH=parisc -j6 drivers/tty/serial/mux.o
...
 >  hppa-suse-linux-gcc <flags deleted> -o drivers/tty/serial/mux.o 
/home/latest/linux/drivers/tty/serial/mux.c
 >  if hppa-suse-linux-objdump -h drivers/tty/serial/mux.o | ...; fi

Thanks.

> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index 2a9387a93592..7583fc39ab2d 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -42,7 +42,7 @@ export LD_BFD
> 
>   # Set default 32 bits cross compilers for vdso
>   CC_ARCHES_32 = hppa hppa2.0 hppa1.1
> -CC_SUFFIXES  = linux linux-gnu unknown-linux-gnu
> +CC_SUFFIXES  = linux linux-gnu unknown-linux-gnu suse-linux
>   CROSS32_COMPILE := $(call cc-cross-prefix, \
>   	$(foreach a,$(CC_ARCHES_32), \
>   	$(foreach s,$(CC_SUFFIXES),$(a)-$(s)-)))
> @@ -52,7 +52,7 @@ export CROSS32CC
>   # Set default cross compiler for kernel build
>   ifdef cross_compiling
>   	ifeq ($(CROSS_COMPILE),)
> -		CC_SUFFIXES = linux linux-gnu unknown-linux-gnu
> +		CC_SUFFIXES = linux linux-gnu unknown-linux-gnu suse-linux
>   		CROSS_COMPILE := $(call cc-cross-prefix, \
>   			$(foreach a,$(CC_ARCHES), \
>   			$(foreach s,$(CC_SUFFIXES),$(a)-$(s)-)))

-- 
-- 
js
suse labs

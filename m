Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F715A513C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiH2QPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH2QP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:15:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1432BB7;
        Mon, 29 Aug 2022 09:15:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v5so2255154plo.9;
        Mon, 29 Aug 2022 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=uy4pLblRdQQDS3wAjiWuybD807qoihM26VKA21jhnKA=;
        b=H51WnfbYaarSmSDLLj1PUjpfIeWe+w2tPOvhrFUCIE+V+UVeCg2GufAJXaawSpYToL
         ZOt0hOj0TDFOfHSqAht22+Fbiqg5MnNU7sRFi/UKM9Gxbtwbd6ZdH4WIFl9kYPN6mmsh
         u2tRU9Co/14A21yCrkXOSMwkJJq8xlJSX8Qv+BdAuOj1Un7+ki/2wrMsrSz2IcuTdSIR
         rlH7cMJPSh7J684JC20xqPe6w7PwGb2wpnrl+zspViqcrvPiXc8srE5S2iwcAIFJHdIA
         fTZI0ukk8ebA6PT4E85CtE8As2KF41PwwDV/fFRhvFgmmDtRrpxQh02Jnn570cDHEDDy
         451g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=uy4pLblRdQQDS3wAjiWuybD807qoihM26VKA21jhnKA=;
        b=7kN6eDneaTqgZd5LUZJDntS0lBWgOH/xVLLKPJ/wL+2r0+i+/0F+ZyIdrEJvVED6Uf
         Qp22CuxQ63QSGybmpx58aB2Ac1HfZbbxdNai5b8bPkynJltbI4CNKS+bAf/zdIJV5ZD2
         YWWyqof/jThmuJ7ju+aA5Yndl1vaHTkligI0V3juyHpvYzgglfJtpVARnf5gauzJ45h2
         NNwgi/oNJT4TTIe4O4rtFnfT8Fo4YN1xJrWDOYuiwM1U8yJNfZ8p3Apcb9LhLTsVt9JK
         t/SaLezPa/pVUSSRG+jNF+5T3wU03hEpHjrsznrQ5czPz8b03XpM4tCMki853S+SAvO6
         IgwA==
X-Gm-Message-State: ACgBeo0csBXdfI6xPF+E1/mudR/PNqiziGLz9mG07Gi2NdOVsfXRf4Jd
        LeFa0ixc0S5cjWVvdVDROmw=
X-Google-Smtp-Source: AA6agR59toqoIdzgGXXc4iiWobVsn1cLhEY8TedcT7inFuxzm1KVsfl2LUZKWdi0N3FM8oMrC75jkA==
X-Received: by 2002:a17:90b:388f:b0:1f5:7748:9667 with SMTP id mu15-20020a17090b388f00b001f577489667mr19514821pjb.158.1661789726312;
        Mon, 29 Aug 2022 09:15:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mh3-20020a17090b4ac300b001fdb6ef8e2esm3076064pjb.10.2022.08.29.09.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:15:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <41c4e85d-2468-e23b-4270-0cc39c3c75d5@roeck-us.net>
Date:   Mon, 29 Aug 2022 09:15:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] watchdog/hpwdt: Include nmi.h only if
 CONFIG_HPWDT_NMI_DECODING
Content-Language: en-US
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220820202821.1263837-1-jerry.hoemann@hpe.com>
 <20220820202821.1263837-2-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220820202821.1263837-2-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/22 13:28, Jerry Hoemann wrote:
> Fixes: d48b0e173715 ("x86, nmi, drivers: Fix nmi splitup build bug")
> 
> Arm64 does not support NMI and has no <asm/nmi.h>.
> 
> Include <asm/nmi.h> only if CONFIG_HPWDT_NMI_DECODING is defined to
> avoid build failure on non-existent header file on Arm64.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index a5006a58e0db..f79f932bca14 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -20,7 +20,9 @@
>   #include <linux/pci_ids.h>
>   #include <linux/types.h>
>   #include <linux/watchdog.h>
> +#ifdef CONFIG_HPWDT_NMI_DECODING
>   #include <asm/nmi.h>
> +#endif
>   #include <linux/crash_dump.h>
>   
>   #define HPWDT_VERSION			"2.0.4"


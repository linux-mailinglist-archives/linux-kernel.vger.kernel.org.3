Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0E49C828
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiAZK65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbiAZK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:58:56 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93620C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:58:55 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id b14so14069147ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1LeqebZU7zO4zLSZoctAnk7wyNMl3wrQ0G0u2lAdEIE=;
        b=QAnj/Dypm31c4y4zxJDpUoK5Lj4T7DxxJu1M8ciX88f4ABcyGjADkFyDfSltgU20r6
         jyy2p8yHku3UkdssU1ixjb9Y+kBwnFJXum325aigZSo2FwysrAmQsXJssYOJN3Kz9jBN
         Xbif0kHCxBirvHwGAa9rSBxJAJgNq2GAnIOzYyFQKoH4aPRDtGWZlst2eUeQ0EfpRO1g
         eUDq5Xbp7J+ZPryFS+WzdZChj5sE/DcQQl2sWxMFoLUaDoISM55hC1J3Od/kImOomb0D
         jv8xiTd4Gmyd3HdMobPCcvkmsJYp4iGigZVJ6mQlb+Cn3nydXAu6hzBax8wxqtWHSewy
         +uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1LeqebZU7zO4zLSZoctAnk7wyNMl3wrQ0G0u2lAdEIE=;
        b=k25USTunFW2bF4MULXtdlaB96Y+EEndsRHIwXJ4EvOsISJZdO8Px36atj1JMKHnWg7
         YWEnfp/cnxZYibPkAmmYfSUI4KsU/Gzfwc6z20o3UUbpUjfYrihy/+A4S6kU8nVE8cbH
         hVzNdDIbHGuQCNl4eNOj4TR7fYweLBYH5x1Rdmj3NToC82y9UDGHg7CiAWSqX26uJcdY
         +wXO04BMT13BgmWtY1KuSL7inFw6kLDI5XwZGsvbfv+L/awvzFej1ia21zeh5G60Sbuu
         WQVRHqU4HvGCeguh3FbGyzcffA/PcnHqXae2vbXJPbrl3q36b/JICQVzTzYJaVipTZbo
         A8Bw==
X-Gm-Message-State: AOAM531r/TpNkuciiJ7WvGgX6/dwKXDwbPzr40qpLRFcKalEijoprZOa
        /0fyDxNTQTequ6vxDemjFeAE0eo2mv0=
X-Google-Smtp-Source: ABdhPJyMTAs8GAKP5D3ETY+f1IKIgihQgJmZLxSKX9MnjRVH5IrXBGMXeaRTzei+yLv662cHawRIcg==
X-Received: by 2002:a2e:9e87:: with SMTP id f7mr18184273ljk.353.1643194733881;
        Wed, 26 Jan 2022 02:58:53 -0800 (PST)
Received: from [192.168.1.11] ([94.103.227.208])
        by smtp.gmail.com with ESMTPSA id y23sm1421921lfb.2.2022.01.26.02.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 02:58:53 -0800 (PST)
Message-ID: <b6da2cde-b489-0b9d-819f-c36cd64f9531@gmail.com>
Date:   Wed, 26 Jan 2022 13:58:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 06/10] staging: r8188eu: remove DBG_88E calls from
 os_dep/ioctl_linux.c
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Phillip Potter <phil@philpotter.co.uk>, dan.carpenter@oracle.com,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-7-phil@philpotter.co.uk>
 <a681a562-eb41-9dc8-703a-5b235c15a3a1@gmail.com> <YfCgQbFxfVZXw9Fg@equinox>
 <b5bbe488-ac43-fd89-7c65-36bfa9c903a6@gmail.com> <YfEm4t+fhO4I2uDW@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YfEm4t+fhO4I2uDW@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 1/26/22 13:48, Greg KH wrote:
>> IMHO the best thing you can do is to leave these reads and leave a comment
>> like "hey, please remove me and test". One day useless reads should be
>> anyway removed, since ideally rtw_read family must get __must_check
>> annotation + normal error handling.
> 
> No, if these were never getting called in normal operation, there's no
> need to add them back.
> 

I guess, I was not clear, sorry. I mean leave reads that were called 
during normal operations, but used only for printing debug info. (As 
Phillip has already done in v1)

Reads inside R88_DBG() and other debug macros of course should be 
removed, but other places seems dangerous without good testing. There is 
al least one place with following comment:

> 			/* Although lenc is only used in a debug statement,
> 			 * do not remove it as the rtw_read16() call consumes
> 			 * 2 bytes from the EEPROM source.
> 			 */
> 			u16 lenc = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);

There is a chance that other places have same problem, but don't have a 
comment above it. That's why I suggested to leave all these "debug" 
reads and leave a comment for further work. It will help to easily spot 
them in future and remove or leave them with explanations why.




With regards,
Pavel Skripkin

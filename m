Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB204656F6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352874AbhLAUUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348939AbhLAUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:18:59 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CC2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:15:35 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id i63so50476579lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7HZ7zAJPGoiKZJ+pW6ZHJ810CsUooxXY5UzUNBlsa4E=;
        b=XZUCS93n/jhVSXEfcb3l6csTpMfcdszQX7QiMrTMKASPY2j2LuynVYVqR2A//wA+ha
         w4nXWrAXuds4ihUMB8CPCEZPlPAxyXijG7xOmOUkVnuENpkNMLhFs/JSna6EHgHpEQWf
         lIY9adlmmyRYy5GCUP/zs5m0DWfGkw0/ixILNmUty0k1UCsb62SFHhKzUZF5C/d+8Q/k
         BhzFHUeHK0I4DR04MiM114mV/Kw0ViVQNsk4kxbSlW6UKcKBGtgQ9ZNSzcoJFM/Naj/T
         3TX1155Mbg1yQVHNlwTfBIFwJQvXdPNC3lWJUDEaHquZumnxhgV8BOQ/wIZu2l3rs0H3
         79oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7HZ7zAJPGoiKZJ+pW6ZHJ810CsUooxXY5UzUNBlsa4E=;
        b=3Akz4yFzRfR2oTrtB7qGcd2Yk4S9m2m1t0Dx8mJS0KOABw9cWCMTatu90fq6aromGb
         KlwFEb8d8j1OYYHJS82GwOGUFOqCdp411OugbDq63Ij8HoBkLcuCzOnOnnWcU80HlCjd
         fZLnGIRdoXAW15qYmcVw+TsK6hrC/vs0cvJZiL2p37lBIiBSOh5+QAhFY12LzDsKZCaX
         JC60wqyg0PaWMIa7u7b94J5e7vt+aBNBBwISAzsIHVxMRqbFble309OjndSwBUum/bqy
         C6E4D6NOfJomjhq588i3DLMUWvfqLwzbTcxXd4ju9+3bml06Yl3SLeSIkoLWgFm5Hwya
         AyFg==
X-Gm-Message-State: AOAM531YlI05XRVZ+tscoCzkyURqGeGVswpDmxGggI5Lcf+Ww68GHG8R
        4GxkKl7OpR6pNStTIATrM6xA3aP+yqpHlg==
X-Google-Smtp-Source: ABdhPJwLPZSUuY0LnnHMiQZ9NbtLx2r0aUATIKhEn6zS+9nwEmXSZFKUspQePBGaAbAU6uetfvqVEQ==
X-Received: by 2002:a2e:2410:: with SMTP id k16mr7781914ljk.441.1638389733896;
        Wed, 01 Dec 2021 12:15:33 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.236])
        by smtp.gmail.com with ESMTPSA id w10sm84454lfn.308.2021.12.01.12.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 12:15:33 -0800 (PST)
Message-ID: <c4855ae4-fb42-ae84-d4b9-3890ae03ef83@gmail.com>
Date:   Wed, 1 Dec 2021 23:15:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH -next 0/3] some fix and cleanup for rtl8192e
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
References: <20211201095036.1763163-1-yangyingliang@huawei.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211201095036.1763163-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 12:50, Yang Yingliang wrote:
> patch #1, #2:
>    fix error handle case in alloc_rtllib()
> 
> patch #3:
>    remove unnecessary assignment
> 
> Yang Yingliang (3):
>    staging: rtl8192e: return error code from rtllib_softmac_init()
>    staging: rtl8192e: rtllib_module: fix error handle case in
>      alloc_rtllib()
>    staging: rtl8192e: rtllib_module: remove unnecessary assignment
> 
>   drivers/staging/rtl8192e/rtllib.h         |  2 +-
>   drivers/staging/rtl8192e/rtllib_module.c  | 17 ++++++++++++-----
>   drivers/staging/rtl8192e/rtllib_softmac.c |  6 ++++--
>   3 files changed, 17 insertions(+), 8 deletions(-)
> 

Agree with Dan, almost perfect one. Since you are going to send v4, 
please add following tag to 1/3 and 2/3 patches because they should be 
backported to stable kernels

Fixes: 94a799425eee ("From: wlanfae <wlanfae@realtek.com>")

( Im not kidding, it's real subject line of the patch :) )





With regards,
Pavel Skripkin

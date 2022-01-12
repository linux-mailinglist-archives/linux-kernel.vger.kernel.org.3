Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D948CCB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357119AbiALUBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357168AbiALUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:00:35 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A2EC034003
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:00:35 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id j1so5332230iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cl1FUyfdprGONZXPglxSDKBSmEWDkw6VkfF16x5mxXo=;
        b=QVJEehF7WPyvGeEiM5KzQqPIBMMXGEV3R+wLe8PkJGDeACISPmV4QHm+bqRf3ctMii
         e9A7XOez7BgUJWpIS85K3eqDw9O/LP5gRWCD7MDNpgnuqpnoM7y4SqV96P1MzAz4QbkZ
         6dTMEEMsxLx1RvNmJhKDjS7fzc3PdRvc8pQIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cl1FUyfdprGONZXPglxSDKBSmEWDkw6VkfF16x5mxXo=;
        b=Uqn0eig2rGvEPJ3jmporPYB6dPQs9Spvjq4t6pXvHboxkAD6QbALuIJVVJ1or1CnRS
         qewV6tloOjXVk4LwZdT2zqbr0Q35Dc2zSIwkNmx4TDIzLu8+bEkUAgr48jH3xgE82JpE
         1PhPQ+YEXU9zI0AQ6d9lWhvJAZHh/Zfgr6h4H5KZguw0ShaXbHzP6mf0ZAxw0LkQyIdx
         FDzdDkBrnPF2FDpAfmG98+ETrL3IheBjpNilmriIQtoVN/s3VqEQREpXh3RBC4sqMTAu
         hQCPQWZx8NH9qDlBD1m/JzA4Ad8/+rltcyo5c9LlbfMeXu96WbrLRpRKDV5dMrOD58nh
         Hvkw==
X-Gm-Message-State: AOAM533xVdSyhu1nd28Ttj+8tOkvBxoH69HMuYFS3MNEfxqy7B96tiph
        fRh/SYoEycjKGfhMHP3y3QaXeQ==
X-Google-Smtp-Source: ABdhPJyqfTMBuJuxUvt68Bs1IVabNVrDXN9rilZ2BQG+2TZJXMJyou7YfZBE20+jh9R7SNMFYnATlw==
X-Received: by 2002:a5d:8a0a:: with SMTP id w10mr692518iod.90.1642017634562;
        Wed, 12 Jan 2022 12:00:34 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h4sm412552ilh.1.2022.01.12.12.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 12:00:34 -0800 (PST)
Subject: Re: [PATCH v3] tools/power/cpupower/{ToDo => TODO}: Rename the todo
 file
To:     Onur Ozkan <onurozkan.dev@gmail.com>, trenn@suse.com
Cc:     shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Onur Ozkan <work@onurozkan.dev>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211224104343.33331-1-work@onurozkan.dev>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9fdc2f8e-8c76-ad3b-1ca5-39fae07d37de@linuxfoundation.org>
Date:   Wed, 12 Jan 2022 13:00:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211224104343.33331-1-work@onurozkan.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/21 3:43 AM, Onur Ozkan wrote:
> Renamed the to-do file to 'TODO' instead of 'ToDo' to
> comply with the naming standard.
> 

I get it now. I didn't pick up on the "ToDo" vs. "TODO"
difference. No need to add the list.

> Signed-off-by: Onur Ozkan <work@onurozkan.dev>

Your from doesn't match the Signed-off-by - please match them
and send v4 - no need to add the TODO file list this time.

> ---
>   tools/power/cpupower/{ToDo => TODO} | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename tools/power/cpupower/{ToDo => TODO} (100%)
> 
> diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/TODO
> similarity index 100%
> rename from tools/power/cpupower/ToDo
> rename to tools/power/cpupower/TODO
> 

thanks,
-- Shuah

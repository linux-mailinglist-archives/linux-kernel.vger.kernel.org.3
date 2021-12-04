Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C846847B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384684AbhLDLdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbhLDLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:33:05 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B484C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 03:29:39 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id k23so11349357lje.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 03:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lXCjgDqxO2g5OSHyeldrqqbpR4oerLqwrkcB+ct4YlI=;
        b=aDslnebTX9uAhOxIQg1fT+KgOaPiyH9l62P5GNXf3JNN+QI0/pjDsMD19gZ7ymbdLw
         CwF3HnGAOxcBfg/7KWoc3Rs/9Wwrk7fqDAHSCDlgO/ci3oC79mJA2j54f04K/jZgnN1y
         xEARMQCbHDeq6GTCLaJ12brHf/Cm8Iw7SeOa+nk/IV34OltrRzu7wrirLh/4Y7szu3H6
         V5I96yjn8+RKIeZTx3Yk+ZJtWOmevgehSYc8ibXOeB9OqUAhGrfV5Q/XposwpTZDd0qv
         TAHwuSNGDo1BHz7ZzB63UcK/G5nIkNb1TEc1OsbGx0ZGY07E/XWzhIYkLMffcRoDNGyv
         1V+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lXCjgDqxO2g5OSHyeldrqqbpR4oerLqwrkcB+ct4YlI=;
        b=qGfBf3zy05YRwVjU5w8jpzLg5vKQmRhQYb07cznHHcKYWbfpJ7epiTI9Tsv6rLVKfO
         9nc7x7xVGNo3G0B7sAKumD/Orj2hHEXWugSkODL+aiZVdPlZCPl49GUjoCrWEDikHYl7
         Li72Cc8Gc3vV1tqXAwRNcnwTcNTsnlXsgEveMCete3sdcMfQnzSo4P7nJikTAED395l6
         RZr8jjeWjNBhOS9wKGuTOf0DwPIsZr48HLo0MS6i3CwpfHiolOhOzU77PQ2DeMXkaAoM
         +KSYRG4gZdzd/r4R3niCgSroKXA2jh5l2DynhRAYdPnMUCd15UkcBQMtvOQ5a6be50Pk
         gj9g==
X-Gm-Message-State: AOAM5321ng+wQszDsWRqoYxXLGfoh/SYLtyNape2OGBTcsK067TQvFjM
        YrFa29ysYQxGHyU0ERbN09Y=
X-Google-Smtp-Source: ABdhPJyuJP+Olz1wrmPJMDGdDS3oe4Shxt5hPDFK9dKRl612inDiorE9nTFYUneeEDb/u0brjxzNkA==
X-Received: by 2002:a2e:700d:: with SMTP id l13mr24198891ljc.219.1638617377723;
        Sat, 04 Dec 2021 03:29:37 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.236])
        by smtp.gmail.com with ESMTPSA id b6sm762407ljr.103.2021.12.04.03.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 03:29:37 -0800 (PST)
Message-ID: <e64fe951-8e57-4c28-5451-71872247c57a@gmail.com>
Date:   Sat, 4 Dec 2021 14:29:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] staging: vt6655: remove unused variable byMinChannel
Content-Language: en-US
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?B?QWxkYXMgVGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211204103053.3934783-1-alb3rt0.m3rciai@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211204103053.3934783-1-alb3rt0.m3rciai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/21 13:30, Alberto Merciai wrote:
> Remove set but not used variable byMinChannel.
> 
> ---

Signed-off-by: is missing :)



With regards,
Pavel Skripkin

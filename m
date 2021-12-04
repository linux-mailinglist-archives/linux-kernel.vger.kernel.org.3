Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871EB46838E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384441AbhLDJ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhLDJ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:26:31 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F2C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 01:23:05 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id d11so10860905ljg.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 01:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/vA1+3g8Svc4sefTqC+kMMaFu0/gR+beNxXDUxYQ/HY=;
        b=pznYLXifFUPpwNbW6Ga0WJ/nvNzklczY//vyoZNdu0N2YAvn9TUIz8KHSQu0njGAAL
         RDEBiaCaUZE8bkJaLQF8MW/l6lGHVLcP8fDNWhGZHLkUfQVvOufVjvgFau4CCOs0GpMX
         fzj6yt8hVhVnO5UlyQM974Yg57CA0LyJoEGr+6bMxcgo4IfGJK94XFTp3t2XWo32IrVh
         ZS/diQrDyWCHmWcmHzyGskkOLcaYznlbqnM/Hvt0w9ziVuqHjylHZn55suWSuEbtnYOe
         kEEHOi55tBJ+nZfG+Z5liDMs+dKX9wUMtbpzf0qDylgkdyBGFHmoI+hYZR4OIffEMNb9
         ndrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/vA1+3g8Svc4sefTqC+kMMaFu0/gR+beNxXDUxYQ/HY=;
        b=jguehcy8z2+9+fIn18AC460AlAM+xmRGO3qXKKv09EFg9BPfpycMP5t61Sj2haJYbk
         62hnytCccT1NANjQeXtITu+wUv534tKj7epTYyR7gayBsZ0OrjGdYctrFsEXvpSMQXFE
         QGO1OcqSD/FumKwLqZWe4dW5s6f6LkM6v5QZRHQWc6+cpxnqyEFf4IoLFrL4w0K2n4JX
         rvBAS7q7uKcj0XZKFqlA0Pdea5F2Gh5w3n6HCma1HPdBYVwPwOd7UdIMvWxYUq/DVlxX
         zo0oTYtTptH1/PID0VnAc5y0EVoX8pw/sHgiZpGeDnBT7ZaOld46ieZp3eGSMbpJ1CxM
         ht4Q==
X-Gm-Message-State: AOAM532s31gnvTPDhL5V+2L3Rx0XHP1YafKK0CFPveuj3W1F01do2oxr
        v+PPrbUBcrVwthQVWr9usKk=
X-Google-Smtp-Source: ABdhPJx75qgk/RIsFe2xWeB1XcY2udJoO3qcN/ImOu87iJqn9ZlZcFhA8yGmJvmnhpMsZ2rhe/C5JQ==
X-Received: by 2002:a2e:9c81:: with SMTP id x1mr24548937lji.326.1638609783836;
        Sat, 04 Dec 2021 01:23:03 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.236])
        by smtp.gmail.com with ESMTPSA id f9sm697989lfv.44.2021.12.04.01.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 01:23:03 -0800 (PST)
Message-ID: <a10f1013-069e-7f56-8a5b-80621af8a158@gmail.com>
Date:   Sat, 4 Dec 2021 12:22:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] staging: vt6655: refactor byMinChannel to min_channel
Content-Language: en-US
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        =?UTF-8?B?QWxkYXMgVGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211204004041.3825744-1-alb3rt0.m3rciai@gmail.com>
 <e0fea904-1861-0003-1b04-6d2e966657da@gmail.com>
 <20211204090941.GA3805206@bulldog>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211204090941.GA3805206@bulldog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/21 12:09, Alberto Merciai wrote:
> On Sat, Dec 04, 2021 at 11:27:43AM +0300, Pavel Skripkin wrote:
>> Looks like this variable is set, but never used. Shouldn't it be just
>> removed?
>> 
>> Same for max_channel (or byMaxChannel).
> 
> To be honest, I would prefer leave them where they are. I'm only
> refactoring the code considering less the logic aspect.
> 
> I don't know if these variables will become usefull in a second
> moment.
> 
> Anyway, If you consider that this could be a good moment to remove
> them we can proceed.
> 
> What do you think about that?
> 

I think, it should be up to maintainers to decide, but them can be 
removed now and if somebody will need them later, he can bring them back 
without any pain. For now it's just useless memory usage.


I skimmed through priv fields usage and looks like many of them are just 
set, but never used. I guess, some kind of evolution removed all uses of 
them...




With regards,
Pavel Skripkin

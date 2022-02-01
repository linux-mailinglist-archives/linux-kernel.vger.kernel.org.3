Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA464A665E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiBAUvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiBAUvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:51:47 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AE6C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:51:47 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z199so22807717iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 12:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W3kshkXSjFyAo5fKHkF6jY1Kyw1sUOZVskQ3JpC65vs=;
        b=V5iYbe2qJpMtymUf/ZHlGT2NO/BkndvVXw2rPPzAhIqrQm74FRQ+j9knJyRJn3kE/a
         miQmToRT3phiAF9vGiOy7QlQBccxtdXhCWe8UnqfQVZXZcUilfkgEaqvokBuH6UyMDri
         HUwZzzzdBMfy2w5KvqH3hTajihoJm+cDcp4Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W3kshkXSjFyAo5fKHkF6jY1Kyw1sUOZVskQ3JpC65vs=;
        b=nAw+D71x1OpGYyaUj+fkExMBmmFYswyBQfLQ9PXZ5f+7EBKICZUC9I5CijCrghsWc+
         a605U/yqTvuUogFh3xzejm2VdLSkK3fgh0whwIyux4Vm9obD7I4qnXf2set0gvDujEsy
         v0uk3N6vE5IvwxtGsCRvkt2PKcpYNn9WVbh/lm3M4fvEmwdwT/UzjiaJL7fx2wSaRL4v
         Q9E2HTZRK0TASgW7pevyokDwSI7dsdZ1U5jLvHurwon2e1ZzePzdlgrUicEnWFU9pIpX
         NNrFSL1Pq4xTOru4A/bR5ZIBQx11n1XE+OihfOXTn4Twq0UgEU2nCaCQUPDZ6ZZvV9za
         rK5g==
X-Gm-Message-State: AOAM533EH4EBajgys6TJa8zFVKklaCnXRDsnwzPR+YWKRktTd4G/bAZX
        Uc0STg1tsIpYuEGc4LHVTHdjGA==
X-Google-Smtp-Source: ABdhPJxu1I3Vyj/HdszpsA6P4xRqhZNdX1lbLFND5kN/jA7H1BBqOQTN8XFouRW/a99/KgMLGNlaWQ==
X-Received: by 2002:a05:6602:2b89:: with SMTP id r9mr15003576iov.167.1643748705439;
        Tue, 01 Feb 2022 12:51:45 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a7sm1397941ilq.88.2022.02.01.12.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 12:51:45 -0800 (PST)
Subject: Re: [PATCH 4.4 00/25] 4.4.302-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220201180822.148370751@linuxfoundation.org>
 <8ef32c1a-2123-522a-bb65-9e421fe07a7e@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <829a4846-1e65-ffa7-2543-95a9177002b3@linuxfoundation.org>
Date:   Tue, 1 Feb 2022 13:51:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8ef32c1a-2123-522a-bb65-9e421fe07a7e@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 12:46 PM, Shuah Khan wrote:
> On 2/1/22 11:16 AM, Greg Kroah-Hartman wrote:
>> NOTE!  This is the proposed LAST 4.4.y kernel release to happen under
>> the rules of the normal stable kernel releases.  After this one, it will
>> be marked End-Of-Life as it has been 6 years and you really should know
>> better by now and have moved to a newer kernel tree.  After this one, no
>> more security fixes will be backported and you will end up with an
>> insecure system over time.
>>
>> --------------------------
>>
>> This is the start of the stable review cycle for the 4.4.302 release.
>> There are 25 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 03 Feb 2022 18:08:10 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.302-rc1.gz
> 
> Couldn't find the patch. Didn't get pushed perhaps.
> 

Found it. All set.

thanks,
-- Shuah

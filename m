Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB1E4AA12B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiBDUb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiBDUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:31:57 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F897C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:31:56 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id d188so8826502iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 12:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j/ZieDjJVDjS65pV7NQLd1h81ioo0WtSoLsoUkvGdY0=;
        b=IGVTI+6D73EnLthw8y7RolJqH8GW+CVYtcuAkWKxakKVQ3KiW0KMKeXoz9kkdPv7CY
         nIf1SvgBHHE4CM3SEmkMo4I87t/Sgs7XeNj6mIUswa6Oua7FLZ7T6pmY+sAcVr4q+kko
         5tDM8Y3CSIkZXQQKbklgItFSp2UN8iNKBaQOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j/ZieDjJVDjS65pV7NQLd1h81ioo0WtSoLsoUkvGdY0=;
        b=j/3PHsmR8/YUKTKFZNxrmWYPR7IPSda9FKUaTwWdkctKJP/ezoQUyIYMUsN9I1MSym
         yGF/YVmRXKkHjKc0bu/9HbaIdPEUyAcgFIkUVBY5wf4tZUM94ht0xImG2rZjUDeP7crh
         u1bGWsL2ASJyi16sIhTIFfbQ/3NusD0XinaikH44qVvuGNa0RRrTmZ1vNUn1KRL0icI5
         kIynbSb2xwwGJDom8fe0WFj3ZBneAg0hzUCColK6mvQHL4MnzqDgoh/uiWn3vSTQrYBc
         7V2xfU4OYKU8+9xzrDn48pQWwwZpbaRdSEOfgr8x0igxQ3cSAABC3dwMiilbXHB1wyDL
         ddow==
X-Gm-Message-State: AOAM530A59I5mRwRqJaJVjXS13+UXIeKpLPuTxO8a0gRMZkilHtwoU7o
        jYWR8Ewj3FRrsKmgqSrZU0vVFw==
X-Google-Smtp-Source: ABdhPJwbxmSx9lbU0uF7egzn3z2FU577sszNKsng0JEuSTd/j81+K7ePBfLZHLhcJZK5NlUSDbXXZQ==
X-Received: by 2002:a02:77d3:: with SMTP id g202mr447391jac.268.1644006715609;
        Fri, 04 Feb 2022 12:31:55 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l2sm1412414ilk.61.2022.02.04.12.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 12:31:55 -0800 (PST)
Subject: Re: [PATCH 5.15 00/32] 5.15.20-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220204091915.247906930@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f9d4824c-478a-507f-7695-59e696d04cb0@linuxfoundation.org>
Date:   Fri, 4 Feb 2022 13:31:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220204091915.247906930@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 2:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.20 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 06 Feb 2022 09:19:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.20-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



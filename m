Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22AC5060B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbiDSALt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiDSALs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:11:48 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7364C3A7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:09:07 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id t4so9510570ilo.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xBYRxu3ooTGcBwD+jjIlBhk9FkRMvsQZ36qo9XY7+PY=;
        b=JRv98ccg6BqRGuqyNqN9MjbZcx3Mqb2iCSRZ3WKYMYFnW89ABytpdfc5jsYua4K7Jn
         b1mFdHRJxxuSwdQAyRagKcerHTyDFKoH/yBPeBdg/j8atAEJV3wENOkysxfUavM3o5hP
         hoJQb4kHY8pL6X8JgP6czlduJ3avq4NiBKYSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xBYRxu3ooTGcBwD+jjIlBhk9FkRMvsQZ36qo9XY7+PY=;
        b=fvMXR21M8Tucx1R7Qce8E1l+mdxy4wX7TALwFfQ+KgUDcFwL0A0UsQPC2aH3K3Iuza
         VD+Uz7BS97JD7Gtf2PYaoQUQoXqv20IqGNSZVOjW9rnn9zClD2PqFxk0c7G2VJ9ffDxp
         zWNBWr6GdP7lmeeAu+BbeVju0jShqkQ8SR1B5xywTWgSeXPmMb9ORr0pN39I5Cc6R2hg
         sbMTOg4nqjxKRTTd/fZbxnXoPJvZekghEoDRs9APMo2pY0pspIro9r5FyeSoX9mgLSOd
         mlT6xDHltpdB9r6VTwtqkx2R9zuI5KH91GGL699Mu51lP90iesbSdO40h3kz9bf+5Yw+
         H3FA==
X-Gm-Message-State: AOAM530TOC2B0s88I+RagR1H3wIfzuXC+BJovB8F03e/ypKt0OIV7F0r
        n4AHaLo5d5XsLzQ4kV4YAwwRpQ==
X-Google-Smtp-Source: ABdhPJwUctKmVR4TQKXoWDJXP4KY1ydRv1tjZWk+KAvzbnN0iI8E1+TiYFgSM46HZ0RznJe5J9fTrg==
X-Received: by 2002:a05:6e02:17c8:b0:2cb:d6f2:74d9 with SMTP id z8-20020a056e0217c800b002cbd6f274d9mr5486419ilu.3.1650326946856;
        Mon, 18 Apr 2022 17:09:06 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id k6-20020a6b4006000000b00649d7111ebasm8706347ioa.0.2022.04.18.17.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:09:06 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/63] 5.4.190-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220418121134.149115109@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <05d6d15f-b4b4-32f3-b431-c9970a945856@linuxfoundation.org>
Date:   Mon, 18 Apr 2022 18:09:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220418121134.149115109@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 6:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.190 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Apr 2022 12:11:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.190-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


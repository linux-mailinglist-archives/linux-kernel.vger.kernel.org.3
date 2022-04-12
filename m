Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5E4FEAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiDLXgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiDLXct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:32:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA60C55A5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:20:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z6so7507iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ei1gVgQBv2oQKXabzX3arZm7KP5DgYy8QJMEBK56S0o=;
        b=gq+RVcMyf7xmbMVUuc3z+0xyGcrZV5fjFSvRj/W1eu5/AKaUiqnW3GfWNiGEeMOliH
         /brdpKDy4RBxGQieVtp2NCeJfLLQ1YYjVSG675bpjiM3zBN2KJr6EsvowqkgxqptP1IS
         8m/C7CzjAiZc8cul9/VljrUWIUS/Up9DSVZKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ei1gVgQBv2oQKXabzX3arZm7KP5DgYy8QJMEBK56S0o=;
        b=30wRty36Is026Bcs5/nXgYih3s2+f14u37VWQv2jzLeO/aKlq/CEzZdGl+C8ob+EuU
         /W+t2jxwrA+OpRxV07pd+uObtrPPA7TWGPwFxTEtYi08AIak/RiUTq4mbItXQKUOjE9c
         sXxRsZ7LYJA+HAbrtId2OmJqCgmmAiqzOe3/XIfBkjUSqU1S5uUcLTv1LXPGdZ+VpPWw
         BBJdymzUebqLSbYD8Viw8Il/YINvRYOIOvYxj8yW0sFtGpDjp0DSjawrhvoqrHKJ5i19
         nrZ6tPm+qSLgyGd44l2NsZe72hq0mqyN0zN+fjR8bZR1e0gUQ8TDOSkV7wIWXTLe1OKh
         Lk3Q==
X-Gm-Message-State: AOAM533PnzZVTTA5KVeFbvf7zCaP7qGzofh18+LO1b74FSI/8g+vZ9LE
        sVBT2JTafoJAYFSISBqJDg4wiQ==
X-Google-Smtp-Source: ABdhPJyBi87D4IRd1a7TaYiAIFkwOd4bWPMUjP+HNJbU0NVgFcBxQGVGZBqz0Np4itssdQ3Dl3WZMA==
X-Received: by 2002:a02:a186:0:b0:324:2cc3:ce4d with SMTP id n6-20020a02a186000000b003242cc3ce4dmr11636773jah.213.1649802022857;
        Tue, 12 Apr 2022 15:20:22 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y74-20020a6bc84d000000b00645dfdd8a4csm23952702iof.38.2022.04.12.15.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 15:20:22 -0700 (PDT)
Subject: Re: [PATCH 5.16 000/285] 5.16.20-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220412062943.670770901@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5b0b7aee-2ab0-1469-5bdf-525d5a205a9e@linuxfoundation.org>
Date:   Tue, 12 Apr 2022 16:20:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220412062943.670770901@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 12:27 AM, Greg Kroah-Hartman wrote:
> ----------------------
> Note, this will be the LAST 5.16.y kernel to be released.  Please move
> to the 5.17.y tree at this time.
> ----------------------
> 
> This is the start of the stable review cycle for the 5.16.20 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Apr 2022 06:28:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.20-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
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

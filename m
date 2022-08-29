Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333FC5A56F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiH2WQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiH2WQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:16:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB2A59B9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:16:27 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a9so2438350ilh.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6dInvOteQ3lzdPJd76FsV5wAJ82OObCz5h6Ys2Bn19U=;
        b=GoYgJcz7jUmqyCmWWVm2K5cnjbC2/z9tujERp9lU0GcVxM6Lz/5oRF5hWI3tXT87uR
         hBoC5qzNdRdf3fkEAtRft4gfO/PsG8ximqAzmfNti5Xkcm2xXnyms3RhJz7sLwU5gLQ0
         L8dJXrZbT83nPW2Rfxdj5c1VnpQctY7ASWjZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6dInvOteQ3lzdPJd76FsV5wAJ82OObCz5h6Ys2Bn19U=;
        b=qqlQBVF9OY07bIJxInDNNA7r7RlbKfHBCCP+wdBH8HElZxKJ/G1VT6z8pdPcTG/LK9
         qIT3T63N+L1vtHz8QKgLfjYJEldz3Neakr6iw+G0wmeL9bunRdLeFjOLtfRjNv/mOaCB
         /bxUa2n5vGA8E21Uvd9lnTsykmAaMkvBOrlh6e6nD+ScC8EBZKb6c/dP1Nnr3iHHG3sF
         OPErYxFGlX6YM0LaUTfgun7U512dndioIk1S25QA8qKl2p4wCObfTaTWMEx72aKP5RGA
         W/mPdfXzVcLnBdqYFjVrGALji/k+NcvPBB9M9jXvlL/bElrDBcfpPFKQhx08+9vItgGy
         dACg==
X-Gm-Message-State: ACgBeo1ymYY+hQA5qc1RBouGuJqTF69RXi8M9YDb/3GdFOcfz8Q4XNJy
        5IvpN7LD2/LsZ0j/X5nDGuGyBw==
X-Google-Smtp-Source: AA6agR4i8Ju+JPr4JAnoEBquWHORCnVqiWl+dpl1U5V96v9EnI75bhwMCF8fwkaTDzD29IiBs4gfkg==
X-Received: by 2002:a05:6e02:1be9:b0:2eb:5480:dd40 with SMTP id y9-20020a056e021be900b002eb5480dd40mr452770ilv.117.1661811386519;
        Mon, 29 Aug 2022 15:16:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 14-20020a056e020cae00b002e97becb248sm4903257ilg.29.2022.08.29.15.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 15:16:26 -0700 (PDT)
Message-ID: <367c4a1c-b5dd-ace9-2327-4f2b65c8d15a@linuxfoundation.org>
Date:   Mon, 29 Aug 2022 16:16:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5.15 000/136] 5.15.64-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220829105804.609007228@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220829105804.609007228@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 04:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.64 release.
> There are 136 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Aug 2022 10:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.64-rc1.gz
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

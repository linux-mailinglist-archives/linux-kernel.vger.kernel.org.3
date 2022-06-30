Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC90656266A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiF3XGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiF3XGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:06:18 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D81157239
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:06:14 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u199so1372736oie.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EeE3T/+WMpbYkuvDBoN/Y9Wk5cBdnroFOJvCX7KVoXc=;
        b=TpY8zvzTLAkwFsMjYa84Hb+WZRm8l5C1zGrt5s3AyMTs2WdkLR+X3NcymPtWNIAGEV
         fLVARO6pjEmLX8xrRnFF2JQlq8QE2cVg5cjyt16TByR5olZUZbM+Mm25ihnsx3qdYdVF
         itfuUSZKduh8Gm4r8znbinikCshX30xiXZuXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EeE3T/+WMpbYkuvDBoN/Y9Wk5cBdnroFOJvCX7KVoXc=;
        b=tNJGofltq5yOp02Rh7MCs/nrJ6PabKZC501QTlkNPCg7eGQdiWI50vD/M+Q3KkY9ok
         mQAbb1jTlk2cbQq4I4kc5UXSGoBY5zNEfVs6EAB+/nz6gioz40f+FRWHZ03Lt8np76Lk
         bMqPHJ7SXedGX0H8qYpN497GmWp4H3jrb7vXHjH8utQRJq2mjIRl8qTXM4bgBCq+Ymi3
         LM0zGCh6uqsodTfU1FVTsTAVoLMf0RW7feu8blEpN9PeIATw3EpJ6SQd8IXMwAPJ8AOO
         Vv4uqTiU3Nr6qMAG73g8E4skgik9h/SB5+FUjSmibVxHKT6fpbp/S8ACNBstxtxzxQmW
         u5iA==
X-Gm-Message-State: AJIora8PavUCLzb9r+4dZ2jD3wrXC6mCiewSvP63gc7l2vkyarrFlbTL
        a6dbN/EbNdTq0CBbGMY4/qcTfA==
X-Google-Smtp-Source: AGRyM1uGBw0gXzMu1IllUrMlxPLvfGvghZni54LjSt4SyDPLRvLBLQewdUi2QUDbhSsJ8AFwYY1qmQ==
X-Received: by 2002:a05:6808:f94:b0:32f:6378:d8b5 with SMTP id o20-20020a0568080f9400b0032f6378d8b5mr6981034oiw.171.1656630373399;
        Thu, 30 Jun 2022 16:06:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o13-20020a9d718d000000b00616afb1f1e2sm10711505otj.19.2022.06.30.16.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 16:06:12 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/29] 4.9.321-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220630133231.200642128@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2644c273-1f43-71cb-811e-1c6efa1d8790@linuxfoundation.org>
Date:   Thu, 30 Jun 2022 17:06:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220630133231.200642128@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 7:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.321 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Jul 2022 13:32:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.321-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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

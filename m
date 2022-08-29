Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52E5A56FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiH2WTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH2WTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:19:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9737AC32
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:19:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e195so1865901iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=z16LTytwree0PKSjWnzmVijEsQZawIjTScg5cLJbx4c=;
        b=DAE/19mVHjTvFqLQc+TeszZ2qDTXRKh5npmLwg8DNKTiocc51bxxarD5Yk+8EZZ7m2
         DhMYxP+pXYTrKEPkwNQ24xYWITPAwbHW/XrrL8uP0dhvx1UnJh9EDi8E2wY4OKmtBd/c
         szJZ5Js98RStfj+ESiqFrIHLx3eFHP3K5+5hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=z16LTytwree0PKSjWnzmVijEsQZawIjTScg5cLJbx4c=;
        b=g5PKuYfvjI8qEUUVKxlIkiLx2//aIq9c0f0BZQcqT345yrgG6/z6TpRzPdz/0BsP9Z
         SQhmiFs0pO9zBBF7OtKB20qh2ex/T3KqIKwLhajQ3vxdIfFVbquJpKqLg73sAw7SRBFk
         NvA40GkAa6dikVkLm/n26ssoyyCCcNaxNhrjtxOZ+2ucQ2nHNL/XhnOnMsii5CqmsVVE
         7HtV1CsZAjkIagPEuYOrgZA7HPa6NqB/1z7/eCnkNscH7Z9IyoqJVb7AGlKDCwDB9FVy
         JHOtQdz0CVrdmGoWmfrO2MIijkH1anGAmNuVQTNqPXu3KMMsOPZgPztJ0tLEAiOsb3FE
         eJbA==
X-Gm-Message-State: ACgBeo0hmlT5y5nATKG/eEixmOAnGVytEbgM2bsxwcXcnaWFGnCk7FwO
        9c9fHVzrLGhRdUr2sDUY+MTDfQ==
X-Google-Smtp-Source: AA6agR5dRxu3/NWPGWPcf3nUkCF9fPzF4dQYdscjh+c/ZVPiRjnANruqP0m1k2RrYxBL/WrSucWDfw==
X-Received: by 2002:a05:6638:1c17:b0:349:b6d3:c4bb with SMTP id ca23-20020a0566381c1700b00349b6d3c4bbmr10304187jab.222.1661811576137;
        Mon, 29 Aug 2022 15:19:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id ca12-20020a0566381c0c00b0034a11fe7513sm4773814jab.125.2022.08.29.15.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 15:19:35 -0700 (PDT)
Message-ID: <41b97b77-1433-6cc6-90ed-c5227740f471@linuxfoundation.org>
Date:   Mon, 29 Aug 2022 16:19:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5.10 00/86] 5.10.140-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220829105756.500128871@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220829105756.500128871@linuxfoundation.org>
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

On 8/29/22 04:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.140 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Aug 2022 10:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.140-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0098154A76D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354677AbiFNDJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354279AbiFNDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:09:20 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205AF2AE33
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:09:19 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id a15so5658190ilq.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+u7tit5dePdeszJPzkquI25j79UMUL4eAqYRMdwtm/w=;
        b=iew+ylXoZaNuQ03Yo9D3Y4ZJEYt5IK+hyeSA2sGBuHLt6ZFMpUQ1tSBDCemwcZLKnh
         lHDNqASha9GhazSl14oqrQmFwan1ZBiPqatvErQEmhytQF/4c0q9jESGbyh8ugFrGUAE
         9I7ymPk4ZoUXLtOEmGoJjq8yEJoQcTFDus+BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+u7tit5dePdeszJPzkquI25j79UMUL4eAqYRMdwtm/w=;
        b=HE3IC8cdFRJfGiuu4GE7ropTZwsUnSOFXJh/l1XugrSPEO6JHq4+TJzPk/Y6+oTn6j
         qms7jjL9JeS3xEspsbuJurUgJMT0sAj4746vnNlRMH3tch8rJOTsoTCFWEkMVyOWVoGu
         G64tcNKfDnOmnxqSY2Q4QQw8GSJAoJ8G1CmTmZoB6akZzsOkiBsIYsVK3NL2VBvNYIdl
         wjxPiihc1U1+qpC1tG3UMv33qe5J0U75eHN7B1MoDWIowG3jMwEb+z4t/N3bunDFNiWm
         +w0xiauJg2F4tnzDWgL2VMa4e/n2rbGhhqSBcnAo/pwZUm5D0kCbCKCwjUdOeXmNRFxN
         1PjA==
X-Gm-Message-State: AJIora9dfc/jVOqrC/PsC7s7m3Daf3TUxBrid1M8qQZHjCAZsBmnuPE0
        aj9DLW191PB4YVHG4fThLIFjwf7lvOwtww==
X-Google-Smtp-Source: AGRyM1tLHonWKVKVXSQRiyduuEprErsDZUIKBJTsc/UeWqdrsoxZVYGhcuuuFJFJ0svn/lnohFP8tQ==
X-Received: by 2002:a05:6e02:1b8f:b0:2d1:b707:3022 with SMTP id h15-20020a056e021b8f00b002d1b7073022mr1753978ili.71.1655176158496;
        Mon, 13 Jun 2022 20:09:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a92d6cd000000b002d7903d71ebsm4748355ilp.78.2022.06.13.20.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 20:09:18 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/167] 4.9.318-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220613094840.720778945@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <22e01c53-ef18-9bd7-1a9f-30ab710c7025@linuxfoundation.org>
Date:   Mon, 13 Jun 2022 21:09:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220613094840.720778945@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 4:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.318 release.
> There are 167 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Jun 2022 09:47:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.318-rc1.gz
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

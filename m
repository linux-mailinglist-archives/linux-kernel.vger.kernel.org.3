Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14BE526BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384381AbiEMUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384318AbiEMUjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:39:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94119CB7B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:39:17 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e15so9971742iob.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c93QaGdZ2wpFZYm7PoQV5zQZNGSuznpgKK0E+QTy+3c=;
        b=fX11sZdEusPdHbVrr+/51bJ5hwd34Uw+ad+zFbsSL4vjgppFroDjbOYu1pNtcy0eFt
         ViH6UDhIN0RH+2AEjaf5iU4b2I9JwgjUigz5r6JPWr1QZhaln4PW0HuiWb3yMhRM1Exk
         K7iIzXMURoF2YXUKcn9gNvpHExpkRNvqFjJHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c93QaGdZ2wpFZYm7PoQV5zQZNGSuznpgKK0E+QTy+3c=;
        b=0H+qDTYI294ZpZ9Tjp2BWC/Y/q5sx6Bi39ZolxA7QBcoq720/6kFHGIggvBOOODzF9
         YLzFuTSo+5U0yxSQtTYEmUQKTw/UhPmUw/koFRrq2JZaA8Lh6K8qhDz+4Yp94wT41f/p
         YKcsimREoSf3882ypqKfPrJRO18T8izAmwIcFLUyLDWNtCuYIhpTq3A/eQZ1bSMbJ4hM
         /FnovXpeiAfr/BGVMKjow2+AymWcBPsovvQJWbGbCXMSaW7Il8dOWPOvjG0N4gZoCMeh
         E8w42jmDwU/pAMjU6bGtI767+ghul3Z00CLTfhgRGe/FqexM/VWd7IefJXeQxf3dOGN/
         u2TA==
X-Gm-Message-State: AOAM533GN4DqT5XXAt/OSKNTjUz3Pt2TW1QCRyrWcSWjjPMvX1MdY5NB
        WpwiBB+oTrm8YEDOt9xci/oEyQ==
X-Google-Smtp-Source: ABdhPJwT9F2ouWF1DhNA8gs1IKZ4h1wHkn4xqWa43O+gdJ6u9mfAyoAM3b17BIfRtiHy2v5D0RD1iQ==
X-Received: by 2002:a02:7a06:0:b0:32b:1b83:649a with SMTP id a6-20020a027a06000000b0032b1b83649amr3490603jac.29.1652474356755;
        Fri, 13 May 2022 13:39:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v190-20020a6bacc7000000b0065a47e16f61sm890915ioe.51.2022.05.13.13.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 13:39:16 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/18] 5.4.194-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220513142229.153291230@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <01dcd57f-093a-731c-a1a7-c2d6b1e7a20d@linuxfoundation.org>
Date:   Fri, 13 May 2022 14:39:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220513142229.153291230@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 8:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.194 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 May 2022 14:22:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.194-rc1.gz
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

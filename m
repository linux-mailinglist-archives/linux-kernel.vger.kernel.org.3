Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5373E4CC8C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiCCWWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiCCWWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:22:44 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DFD17E1B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:21:58 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id c23so7564265ioi.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h75dXlU2U9GD438gggrDtSACtFpdKAcs8BfCPVpoYlg=;
        b=X/w+yubbX1fu5lb9hw99ZBR4IirBiXxQndYogS29ZqMd5m54+U46IL7l9stzEtXTxV
         /DBdCEsln+KRQKFgSkNlZxORisGui3zNrfpLFrZKoCx/eKKaDxcymCKG4kCBShwYmJ2R
         k182URkX8zha6jYXhn+F7JTzLfh/KUWtjJUdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h75dXlU2U9GD438gggrDtSACtFpdKAcs8BfCPVpoYlg=;
        b=zHj3bxvT0IlBawyIbyEWV1Pb+xIp6uOoSvEAil5kima2HGdSwqPGJis4x7U6s1Ba7E
         nG+6L0oQEmQLIyr9dqw3DYQZ2tyqM6iWCTGvm3dA3omb1uCYaIpgjnT6fBw//WIkRmzd
         BKraTOB9s+rY5IaMZiJQ5V98c2teUCAS/hTojfz8zmq7u15Q35db5pjmnmJM+5VvZZRq
         DkgNd2x05HOHsEz8ZpwowlriF+x4QaxImGoaqL7El8OB2KHTGMsVrYT/ILBbs3+wZv11
         7LHJOGo5LgGwV4hW/spXzZjVmD4PxxqgZC1expY6kW7hhAezRWSRjAcuueEmxgPj90XM
         dRxA==
X-Gm-Message-State: AOAM530zF7ykmbPXU8nrv4tJ1fZboMf51pYjS0fJo4XENKWl+cN90EJr
        UwAus60Eyt3sGjqFJ49jlwERxw==
X-Google-Smtp-Source: ABdhPJwVTB9bEOHKqgR8hY17iqs1ZieWMpIrz8IALt8YiS/sjqMZCM5Q+ziGAieK911yV9EOFheaqw==
X-Received: by 2002:a05:6638:381a:b0:314:e62:27dc with SMTP id i26-20020a056638381a00b003140e6227dcmr30831638jav.59.1646346117518;
        Thu, 03 Mar 2022 14:21:57 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id q190-20020a6b8ec7000000b00638d75f5cd0sm3076799iod.47.2022.03.03.14.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 14:21:57 -0800 (PST)
Subject: Re: [PATCH V2 1/3] selftests: add kselftest_install to .gitignore
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220302180121.1717581-1-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fca1c16c-1515-aabf-6377-ce952ee28492@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 15:21:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220302180121.1717581-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 11:01 AM, Muhammad Usama Anjum wrote:
> Add kselftest_install directory to the .gitignore which is created while
> creation of tar ball of objects:
> make -C tools/testing/selftests gen_tar
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in V2:
> Break up the patch in individual test patches
> Remove changes related to net selftest
> ---
>   tools/testing/selftests/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
> index 055a5019b13c..cb24124ac5b9 100644
> --- a/tools/testing/selftests/.gitignore
> +++ b/tools/testing/selftests/.gitignore
> @@ -3,6 +3,7 @@ gpiogpio-event-mon
>   gpiogpio-hammer
>   gpioinclude/
>   gpiolsgpio
> +kselftest_install/
>   tpm2/SpaceTest.log
>   
>   # Python bytecode and cache
> 

Applied to linux-kselftest next for Linux 5.18-rc1

thanks,
-- Shuah

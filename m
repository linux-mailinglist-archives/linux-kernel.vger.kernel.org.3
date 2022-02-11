Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEB14B1A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346384AbiBKAeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:34:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346352AbiBKAeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:34:23 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31BB5F7C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:34:22 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id i62so9595515ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0B0HAkZcpI/s7VWBoglKXXLpyOgKkv9v/vmy+ecRN2c=;
        b=YBFn8vHLtalzAuPUIkC8ZRtcGrbAZ6xVdORgh64HH7qdo5w8AwPW4zzB2QVhqAaw0p
         sqsJOybZdeXuJEC0zh5ShXnUMTddnvMYWVCQzsItaAeMJm5+wdihCjUSoPBlXFRJlAqw
         zsfUPhL58MBf9iJS6VzFibDJnfNNkCmeQT9sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0B0HAkZcpI/s7VWBoglKXXLpyOgKkv9v/vmy+ecRN2c=;
        b=YeGWgdf0JP3Kgzia8lTtCqo/Q2KKPzJfIzN6FL3L0RSB6FAe62dS91KgEuWoPQiw+A
         JNmQbyPD1gps2cMTwLgBfQMtSVpv37BcittCJfmEcs0sJZmo0zH3G7ShXjyFtc7iboN3
         brK7l1QEUST3BpNjHVXuL3dny5uRC2EusGg5e+HBu6Mb/Dc/m0ju/aZv34HwuQWf6N88
         Rf+rg1o9asWWuFYaEAfRSG57zhQaJ65BtjijQld3POMMnPtYyGEXE1+xtFBvGSWsju3R
         qkirZ7rxBeek4OsP+2XKTYwLAEXdumhgHiHwBs/CIqqbZu8KSgE52dTv7ZgmaLqER31f
         TDAg==
X-Gm-Message-State: AOAM530IYcZkNKQIJRepVOzE18TpxZJZvM6aitJNuNeERGM+ouYcjjWR
        gOntERaNByBQTMp3Adago/IezA==
X-Google-Smtp-Source: ABdhPJzHuToV0Q1odU9rDTAN7VCzDbuxMxH0XgDEurznyKV9NzWsA3E+IwHXFpemFoFHBEjUzmREIA==
X-Received: by 2002:a05:6602:26c7:: with SMTP id g7mr5219039ioo.56.1644539662196;
        Thu, 10 Feb 2022 16:34:22 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b12sm8381564ilv.68.2022.02.10.16.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 16:34:21 -0800 (PST)
Subject: Re: [PATCH V2] selftests/exec: Rename file binfmt_script to
 binfmt_script.py
To:     Kees Cook <keescook@chromium.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220210222319.1864680-1-usama.anjum@collabora.com>
 <202202101555.EE737A35@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <18cf9c45-b270-2c44-9eb8-d6f3e947ae49@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 17:34:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202202101555.EE737A35@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

On 2/10/22 4:55 PM, Kees Cook wrote:
> On Fri, Feb 11, 2022 at 03:23:19AM +0500, Muhammad Usama Anjum wrote:
>> Rename file for readability purpose. Update its usage and references.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> This path was suggested while review of the following patch. Please
>> apply it after applying that one first:
>> 	selftests/exec: Add non-regular to TEST_GEN_PROGS
>> Changes in V2:
>> 	Remove changes from binfmt_script.py, they were wrong
> 
> Thanks! :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thank you both. I will queue this up for Linux 5.18-rc1

thanks,
-- Shuah

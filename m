Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F31542374
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiFHEym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiFHEyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:54:00 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC9A2AD5ED
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:26:57 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h18so15546931ilj.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 18:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=49YVrS45Vywbvku0fH/A6/4OrA3D+q3WmkxQvwKqyKI=;
        b=YOmdyo/XCMqNO17UML3ZdHuN9Y+eK2A0qal8mBEknGZF+cBgCJlturlYbL9ZdEHoPG
         WTrIDMx4PJIPlFLyfEAbp7JT4C67ABiKveBRMPEQCJAP81hQ/Qsh2ojr0+lAAD4Uba13
         DCjYEly/xMq0/QUKUGBt6F15z0Zlm8HzUoRBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=49YVrS45Vywbvku0fH/A6/4OrA3D+q3WmkxQvwKqyKI=;
        b=I0LC75bueNXv+ShKevW9yvPPZhfwmToNDPo/2ZTmCn3oa8oPynnKu9ISCD5GdIZMVb
         NYrTFrUM4tWUu93/NoaxoLGHQHEmeqUpAOdN0kBaGMSEheZpVfp+ia7KS28chR0XWE0q
         P6kgjip6kFUYA/cf5azcvRwJ59dc+Qz/4Q1+DlEw6qNLePok+8MKH92jLl2b0Gfu26PU
         enMNe2JxBuZeLOsUn2yfxOLF7sTsFtnH22ArxCZokDNSLBvhR1MUmyg8e+QuyBwMUcmq
         Bdw8kF83QnkNUkAWS67u0sZpKH+bf/PdOn/TzRpNt8gnz0b9VBgbcup5zhTwGdNGeKAc
         TfaA==
X-Gm-Message-State: AOAM531YY4VL6UEtDWIITdEPYdswksjj/eFanqKuwISYnbR86L7oV1Tj
        F6hax1UbNA4DITHYLMIqLdO+dQ==
X-Google-Smtp-Source: ABdhPJyPH9BMUHvqhr8nqs8aepqKipDR8WqhJGWgP4nJ0OJAnHfPKOMomxYffvNdfNYQpWvx1dEQCQ==
X-Received: by 2002:a92:3609:0:b0:2c6:3595:2a25 with SMTP id d9-20020a923609000000b002c635952a25mr18461417ila.233.1654651616661;
        Tue, 07 Jun 2022 18:26:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l24-20020a026a18000000b00331a82096c2sm3087401jac.98.2022.06.07.18.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 18:26:56 -0700 (PDT)
Subject: Re: [PATCH 5.18 000/879] 5.18.3-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cb81fd66-1455-fdf6-85a1-1215c46f0c2a@linuxfoundation.org>
Date:   Tue, 7 Jun 2022 19:26:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 10:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.3 release.
> There are 879 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jun 2022 16:48:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.18.y
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


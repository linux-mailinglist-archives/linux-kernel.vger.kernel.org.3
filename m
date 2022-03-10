Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAB44D5206
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbiCJTdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiCJTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:33:23 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C813C9F7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:32:21 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id r2so7663721iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3k39or/q4g9IgtfecKdGNHs+YvqeoDMJlc9H6A0RBWA=;
        b=BVime9WyNxNSHNgpGfRKG1f5H3kVxma67aZ+YjekVMgHvjX1bS7yIhGhyMcVaWB7KF
         +GqHQlb42ooV+mVqMEqFlDQCQ4KJ0G+FxltU9m/uA45m5KSjWY3xIdWnkgpnzZC0rD5D
         Ut9d6ttsJhD0w32EsxmLsnCm4wWgyvciHPEAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3k39or/q4g9IgtfecKdGNHs+YvqeoDMJlc9H6A0RBWA=;
        b=N1nExojnXqYS8yl0AubVV+HKu8Hy60o9AEBBveXk0hFAZS+uRQ30mtmmfQkymWdkCN
         QfBWtYJzVo09vXuxAda33zbbBtt9yebQVP36AXLc3MO70iBhi8WFe9OFaXLCSLh9Ps2P
         jJYo21SE4ayGkRD0PYPLbdni903aaxov+sGmCU4Ma99s9SlqhjKGY1/v9U2Posc69E4/
         hhHdyDjTUMhAmc1KJ5FZkLmXkHHgNj+SABU3gLgwh9dGwJ9QvVS9RrTX63EgsQ41BZqt
         ueC8P7suum3osGo5rywNkD5A2wUcq6DhsElWUhlrKqUhore3bhR9fqxhgrC6Mcll/vsI
         Ot7Q==
X-Gm-Message-State: AOAM533QIBBa3nj5Syk5k7M8HBDUUUzEAyEgNu7h4s/W05ElYlV+DyVE
        mdJI9J4sgLO7wraPYclyskICdw==
X-Google-Smtp-Source: ABdhPJxfWpv54+6CpbllNO6plXmA4CuMgHeWxvQJtMn3DRfIq/154JhHrAZz+BX5lH+8jumvWCbP4g==
X-Received: by 2002:a02:3f13:0:b0:314:4a83:ac2c with SMTP id d19-20020a023f13000000b003144a83ac2cmr5394326jaa.3.1646940740711;
        Thu, 10 Mar 2022 11:32:20 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id f1-20020a056e020b4100b002c68e176293sm1598173ilu.87.2022.03.10.11.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:32:20 -0800 (PST)
Subject: Re: [PATCH 5.16 00/53] 5.16.14-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220310140811.832630727@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a6148582-6bc8-ca7c-e11f-c1da36ccb760@linuxfoundation.org>
Date:   Thu, 10 Mar 2022 12:32:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220310140811.832630727@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 7:09 AM, Greg Kroah-Hartman wrote:
> Note, I'm sending all the patches again for all of the -rc2 releases as
> there has been a lot of churn from what was in -rc1 to -rc2.
> 
> This is the start of the stable review cycle for the 5.16.14 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 12 Mar 2022 14:07:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.14-rc2.gz
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

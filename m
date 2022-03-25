Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0124E7C24
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiCYXYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiCYXYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:24:36 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4606B275CB0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:22:59 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k25so10634268iok.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vsKeb0c5akOHN1Gne2WlcBts4X5tlsLPQ0J060kwNJM=;
        b=XnElgVt38SYEmGaxWaHeWglxKZ7zv5x8jZxnJmm3kidaJ0IMd3PAL3UlFzBOzyCuRW
         J0/W3WsppEwWNKa+XxujVd3kZgNAtr1KN4dJv57etm3voI4tg4zC6R8HRzDKDWzogbPn
         kU2y7Syz1psrcixz6+jALWg5k4mXP2GrVlgSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vsKeb0c5akOHN1Gne2WlcBts4X5tlsLPQ0J060kwNJM=;
        b=m3OVDaBTqCms861ff8P+6tZy2pXdSJnWaamw6xEL6bw8ffCqV/VkNKK2xAtw03vMS3
         LppUabT/Kqm37ywUQXd+z05ibVvSsIAHxtC/Y5FpsRMEQtkb5/uc8iVcVJXpuuU8LYdQ
         3InQpa6jfdX3EDvXtViXYHXRM0JRiCFzKCa6MqM/lKHceC/uBK8d2HCCXWgxaLGLpNj0
         lZfzGkHo9Dao9C/69khD81RzXOhXyvovemxpp4EA9v1IW/aO4dBzhQ6PoZo5drFzhxFG
         lf8EMFuzUW/IvpMqG7ZjBFR18n4UKuEEsJUkBU7ntqrNiPtlMdAO4zXPuV7oquSUy9Jb
         qMlw==
X-Gm-Message-State: AOAM530VhbjuMSYoCcojBUZisvGFPBB8FtkUQ+OUqQJinJuErU9t6NmB
        70tWxT7BQvyKPk7ogLg/ey9ODQ==
X-Google-Smtp-Source: ABdhPJyn4SRPqHmBCOUAg2h3rjeBdimg0pL337YLfLwiSeb/NB1uoLsAw67KLTvfMSKxvE74MOTI7g==
X-Received: by 2002:a5d:898b:0:b0:649:5bbb:7d95 with SMTP id m11-20020a5d898b000000b006495bbb7d95mr694308iol.107.1648250578618;
        Fri, 25 Mar 2022 16:22:58 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b1-20020a92a041000000b002c8214b2f65sm3691408ilm.61.2022.03.25.16.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 16:22:58 -0700 (PDT)
Subject: Re: [PATCH 5.17 00/39] 5.17.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220325150420.245733653@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3555346a-9f2d-761d-88e9-ed2677a04a0d@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 17:22:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220325150420.245733653@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 9:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.1 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 27 Mar 2022 15:04:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
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

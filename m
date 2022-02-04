Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8704AA12D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiBDUci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiBDUch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:32:37 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256BBC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:32:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n17so8838416iod.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 12:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7FQ8RAJtS2IXkE2nku0Q/J4KXLIy7y7Nmy0mg4WfpqI=;
        b=a0t1yAPonrS2fXvdWFvRflccHI8L+xY/LYETP44jV+MGMf6bPjX3hAI7OHeVOFPqw8
         MWC633/k/b4qYVqzx4/iXkqr5zc6PizXZgQUPWNvFyhUxmlqfiZyX8v1rQkGq9t06jFK
         NdIV2YzjbrEGeL7NRb5vsFRsUu6eagXLwMXFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7FQ8RAJtS2IXkE2nku0Q/J4KXLIy7y7Nmy0mg4WfpqI=;
        b=tadE4aqEc8AiAlnSF20t25AzfutZUidTnzo66P9P1oTC6G+Rl9Yr6ovlHPBFTy701l
         TvOgdHUWfI2MYszzsgru8sEzhbcFcpvUFvGzrFsJO8KVdptDlg/6gihrH1IIUkYoSJYF
         d37diXbHvAKp7MQVnWHHkQD0kNVOoQiPX3E9AdZsJprLQPO3Z1utOWAczPQq4LpASvaW
         OXHjzARl2PazWNsADlzBBSGqCd65JjwnSw4B1PFAf/M9m5EhqqUm1saq9T85OxNcLdWS
         jj/gS0o3lbPF3brUCdhStTd9nnuffMh3OlV/3HfLFaEp/ssSYudwnNltANMZ9CEw/0cW
         GUNQ==
X-Gm-Message-State: AOAM530TMDaGA1vWhN3Du2RJukUS7FdlLi8/wgojvKPIujzcMalrWEY/
        XKuIS2k7BbW/4q55pYcG3OUT8w==
X-Google-Smtp-Source: ABdhPJwQruLCJgiUHu28Vbv7KaxBy8hI2r6iZuMagTcm4h2XdYAVm1OUES3zRhZgFRzjT5NIM4SV5w==
X-Received: by 2002:a05:6638:1348:: with SMTP id u8mr453928jad.4.1644006756576;
        Fri, 04 Feb 2022 12:32:36 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y22sm1429064iow.2.2022.02.04.12.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 12:32:36 -0800 (PST)
Subject: Re: [PATCH 5.10 00/25] 5.10.97-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220204091914.280602669@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e4a0b744-e5fa-2ead-20b3-007cb795a4a6@linuxfoundation.org>
Date:   Fri, 4 Feb 2022 13:32:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220204091914.280602669@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 2:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.97 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 06 Feb 2022 09:19:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.97-rc1.gz
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

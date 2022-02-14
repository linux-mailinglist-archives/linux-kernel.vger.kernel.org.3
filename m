Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A9C4B5DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiBNWcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:32:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiBNWcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:32:53 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F57613C26C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:32:45 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id n5so13477219ilk.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bf3Bc9D0jq7FIQN8gAz+SqtonqNFQ5fVJWGQu1QWYfY=;
        b=VfdBSkpHshMp5wBY5CwOnjlb5zUmG+oIpXuTRFgzc47kldK0W9AwzZJxd5XsTdul6l
         uxIgUsbnceGZaazbjfzdmNCcJxdeQhupIeig1cUYRR2j8HD+ZRu4aF8NaOoAwIA8P7Z7
         4uQ4CoSwDy/vRcbhM3FptNb1F0GvhcnzRBl0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bf3Bc9D0jq7FIQN8gAz+SqtonqNFQ5fVJWGQu1QWYfY=;
        b=YGkVe1X8WR4rcXEUyO5XigTxtJ0cJH4ATvwyXBPTrpmnX7fqfTSMIIpdV11ab5Q2lZ
         JSYKRXKhXvDSYXuPQI4+l1rDQ0gb0NZG1EIjgSw09ANCqz4L7bBD1TyvnMAXVhbm/TT9
         HzcjZ4IC9wNmfVilSU2zOHSr89evuYPDgbmCJd/gYgnhKg3GRwL4iR5UGu1aZzg+q17P
         FeCY53XzcMVCP5/zCMXYnkf95JeeNq3YAdSq/09W8d+YslmeEyHly2Bet9BNoX5XQEDm
         XxnAz7LLoXP14nczH8cc1w+NYYNvzjfpZb9AlKsOdBbMn9op6nH+LdDYRxXK7EranOfF
         Wfbg==
X-Gm-Message-State: AOAM533y4YC+Behz6tTWP/zQRC755+8+6RgHWXbN+JsdWlK7VNkLtZ4V
        b5AB+UlHUhJn9/iGB9EphnWqCA5/48JGGw==
X-Google-Smtp-Source: ABdhPJxo1HOhkhI5r7CSbOsckdFZTyzCWIiFOOl2YmJ2qTKrqbkUSaH13SB07sOPD1onMQZSFPIRag==
X-Received: by 2002:a92:c5b1:: with SMTP id r17mr617226ilt.320.1644877964635;
        Mon, 14 Feb 2022 14:32:44 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id x14sm5865419ill.88.2022.02.14.14.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 14:32:44 -0800 (PST)
Subject: Re: [PATCH 4.19 00/49] 4.19.230-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220214092448.285381753@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f9998c23-3ebd-d9d0-60cc-14a375772846@linuxfoundation.org>
Date:   Mon, 14 Feb 2022 15:32:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220214092448.285381753@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 2:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.230 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Feb 2022 09:24:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.230-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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


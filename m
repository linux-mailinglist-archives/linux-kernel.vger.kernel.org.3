Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B3B47E760
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349676AbhLWSCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244522AbhLWSCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:02:16 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1F1C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:02:15 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e8so4816736ilm.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=crcalCbsdsuGUt7vADUyZgFYhL5+xBKGp5LdAom+KUc=;
        b=VJoR1oMjuYKabXAOvgTkMPuLCPzALe+MaI4KQ9kRyhExxQsViEwxzTgHgUP7GqUnpD
         TyTlkB68AAujP9TtFt2qJoBcJ5tri7ynvcjNkSmAUf+SEsXAYt5mjB/OVWFS3PA/MpQA
         hYYOzUW0weEqMTHebFGMgITqzvsfsmsRMTcmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=crcalCbsdsuGUt7vADUyZgFYhL5+xBKGp5LdAom+KUc=;
        b=O9gUyWYZhSndMakp34yhZDsPJcZOKp41Beh5lBlr6yUK0zv32l7zWG1oamGaoy6yIB
         moYugQsFLGsZjzv14UKz8SU5nrBe4hFWPSRsccGi0W/TtAhGB/GkwAEX575hsumwi+dd
         ZDGlW/GGCMQ5qTDAgDWJ6yWyerlTggL+FBCnDTu8RTfd2ccE8TBYQrCrLjPR+TEme+6Y
         5Xdcqvcjl5V6h3qM2coH71BTwcId6F4Y+0PmLMWXSw+im2HnzpEW+Y6Es6ugMRVvx51f
         VHBeXcZLm2f0JBVa4FPiuxqzaBOlQtnj2FF1v5HFppJu0gSINPq/eiWMBMmqGbPvJ6su
         AfRg==
X-Gm-Message-State: AOAM5335yrMTYY6eiY8PMem/Pgc+7YL0Gqu2E1DiyquKwu45De/XEvPz
        700FR2wjpz6qJtZPfGhQJbgzG4EavTpSoQ==
X-Google-Smtp-Source: ABdhPJySs6IxOqMyO+caDCjivQrp/33rxoe2g7fjdQFztJUypZEhZJcO1t5hrQ1IPVmJpDxLB2l6Hg==
X-Received: by 2002:a05:6e02:152a:: with SMTP id i10mr1674953ilu.145.1640282535026;
        Thu, 23 Dec 2021 10:02:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j5sm3066703ilo.77.2021.12.23.10.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 10:02:14 -0800 (PST)
Subject: Re: [PATCH] tools/power/cpupower/{ToDo => TODO}: Rename the todo file
To:     Onur Ozkan <onurozkan.dev@gmail.com>, trenn@suse.com
Cc:     shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Onur Ozkan <work@onurozkan.dev>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211204134439.79754-1-work@onurozkan.dev>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f0c8e0ac-b182-848e-6e60-38c1904ff9e1@linuxfoundation.org>
Date:   Thu, 23 Dec 2021 11:02:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211204134439.79754-1-work@onurozkan.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/21 6:44 AM, Onur Ozkan wrote:
> Renamed the to-do file to 'TODO' instead of 'ToDo' to
> comply with the naming standard.
> 
> Signed-off-by: Onur Ozkan <work@onurozkan.dev>
> ---
>   tools/power/cpupower/{ToDo => TODO} | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename tools/power/cpupower/{ToDo => TODO} (100%)
> 
> diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/TODO
> similarity index 100%
> rename from tools/power/cpupower/ToDo
> rename to tools/power/cpupower/TODO
> 

Please add reference to the new naming standard to the change log
and send me v2.

thanks,
-- Shuah

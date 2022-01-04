Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB1483B42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 05:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiADEWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 23:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiADEWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 23:22:00 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B28C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 20:22:00 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e8so27367722ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 20:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/ImgiPdbq2N+p166JQs3lDpTsm/xUH4BmSoapqHyKc=;
        b=7ea+MipDKFNp8pexK4CQZQW07zkOWvhZT1++wlHsyUpyxqX5Qhm2vwbAXN+YCVBQew
         opi95LEJXR4UOJM0skMcJA1295ySJmN7L/VQslmllJ3XpdRkfHn72uDTR/VeR6vkjAoK
         ZduVZzn9gC4ua4v1kOIBsIqMJ1qWoI6/78Lu59LVoWDjvt3GnrpXr/jplZgkszM6/pS8
         IP8eLmdfA+F3lWYIsyXWcP5JnIorQ2MrQ20zWKKM3wLfnGS7LWmqscyVfnz1VGmezXq3
         Yvw0jL21PrFTAAXlYMbPtpDBKQ+QQRZXyrbai/SM6GeB4uIT78HlI1Tj8Lhv5g7PwFI8
         4x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/ImgiPdbq2N+p166JQs3lDpTsm/xUH4BmSoapqHyKc=;
        b=LKhPxLn3DN9w7AmZnOTCcGuKiCSlE03xbSD+fCUEEkv5u7/FQLEopMozEqrRA5QMgI
         hVRgSmnQmbXKow5pfHnhmdH6PnDvu14AQ9ryQKMOTp6c0BPKXRk87Ffa9Q4IabdVtB/W
         G2G0Gb9QxSeHr9IuCLpjBGcAPV+Z62dYFjeZPbz4b55TGO3H8Ci2UsLoN8Ecwg90DxzN
         EHMcw6MeXmDmYLe26xKxwIt+8pHqehiLcon3TsAGSp+PvyfRPs4AdZRMGlJjin/yE/15
         FB1TbLmtww1YsBTPhWvKYzFeijBaP0T4c7oKOYi7qarGB3daOApB9zfvuViFnxNQfdfG
         LLHQ==
X-Gm-Message-State: AOAM531Sw3ildEwkf/u6Zhj21w0CVJODjo9ou5MMmZu3SEL5h4eZEGMO
        oT0623oyz9eoxC6NzudrRDqnKtj5GAlN4Q==
X-Google-Smtp-Source: ABdhPJz0IkAokrq+laDzYrRe1EY6L7kFS2boZTpCjSOeMA/D10L9yQHi4GGVHJfWynOufboNa0dJEQ==
X-Received: by 2002:a05:6e02:1a2c:: with SMTP id g12mr21401051ile.192.1641270119662;
        Mon, 03 Jan 2022 20:21:59 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g11sm22499972ild.52.2022.01.03.20.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 20:21:59 -0800 (PST)
Subject: Re: [GIT PULL] md-fixes 20220103
To:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Norbert Warmuth <nwarmuth@t-online.de>,
        Guoqing Jiang <jgq516@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <C0F28A74-39F7-4B12-BC8F-96E2FEBE0AD0@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <499b185d-ff9a-934e-7768-ec796244fa1a@kernel.dk>
Date:   Mon, 3 Jan 2022 21:21:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <C0F28A74-39F7-4B12-BC8F-96E2FEBE0AD0@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/22 2:28 PM, Song Liu wrote:
> Hi Jens, 
> 
> Please consider pulling the following fix on top of your block-5.16 branch. 
> It fixes a raid1 regression with missing bitmap updates.

Pulled, thanks.

-- 
Jens Axboe


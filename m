Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18CA50EC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiDYXDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiDYXDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:03:39 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD7F3D1F7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:00:33 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id d3so10326196ilr.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ia87REFG0AYraSTeAkYZRVYwp6MdRMp9URsVCkFU7RU=;
        b=X62cc21UcM8gAmCg5EiadF8tgHOLnAI+GvexRgJCkpAo88iCOInrAGuRMuA+Dao8WB
         Wr3NafYftBnEyB/9ia3alKH9XUay7vI4Z2GzlFd6CbufbFamGwKSIhIa7765i+Q1Iv8L
         raCl2rtZjdtQs/UncUjVlRE/9M82O55aBIbc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ia87REFG0AYraSTeAkYZRVYwp6MdRMp9URsVCkFU7RU=;
        b=12CxxEPCJbiaxZNlE9EdVwbFf/V0/lRtoQkScwFCRDoFC/etrpaGtekb7cwbBF/beX
         6qLCAyxeFmoLrzM86WG+Vb6RQdW2z/nALSgpsoCSlCkR7d1sO0+ydCr3ZTXdTWuDeIQg
         kg56iGhDqUq7eZS+ifcCtW6EFJPetneIT5NXxUdTmZeCo4/329dvRlR5R0PlEc7Mw2b/
         Fzvpn2Swe55sJIPVEol3JyKU3CEWAZuy8b+xDXkgYTmvjHN6XeRTZ9tUvLw0YawNVWNY
         0Jq5+qkhhm9Dz7e7MYpPEuzkv2wJj5ylW56O43ph9to4g7mHn4P4u+egucLgSOwMqB9c
         QbOw==
X-Gm-Message-State: AOAM532h3/juEvrdwT48ZCOkgj7QNQzdnx+he4Pjdfodimi3eOgoulmB
        AYIGHcWOn70v/I1DeRzLeqWw/g==
X-Google-Smtp-Source: ABdhPJyH5ffWuC4e3FNfgLxcYhuhqH84NGmqCX23Plb6skBV6q3k5vdx9m+QEzaOQeKJl79MymaLYA==
X-Received: by 2002:a05:6e02:1e08:b0:2cc:4b66:1984 with SMTP id g8-20020a056e021e0800b002cc4b661984mr7907887ila.266.1650927633083;
        Mon, 25 Apr 2022 16:00:33 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p184-20020a6b8dc1000000b00650b95043e8sm8351137iod.33.2022.04.25.16.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 16:00:32 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] selftests/resctrl: Print a message if the result
 of MBM&CMT tests is failed on Intel CPU
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
 <1920a6b6-bc1b-31db-4c1b-efccc189daa5@linuxfoundation.org>
 <9a1d0420-d99a-e4a8-c6de-729b56e9c1f0@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <488995ee-2a00-321c-126f-8ed7f8b82635@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 17:00:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9a1d0420-d99a-e4a8-c6de-729b56e9c1f0@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 3:19 PM, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 3/29/2022 8:37 AM, Shuah Khan wrote:
>> On 3/23/22 2:09 AM, Shaopeng Tan wrote:
>>> Hello,
>>>
>>> The aim of this series is to print a message to let users know a possible
>>> cause of failure, if the result of MBM&CMT tests is failed on Intel CPU.
>>> In order to detect Intel vendor, I extended AMD vendor detect function.
>>>
>>> Difference from v4:
>>> - Fixed the typos.
>>> - Changed "get_vendor() != ARCH_AMD" to "get_vendor() == ARCH_INTEL".
>>> - Reorder the declarations based on line length from longest to shortest.
>>> https://lore.kernel.org/lkml/20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com/ [PATCH v4]
>>>
>>> This patch series is based on v5.17.
>>>
>>> Shaopeng Tan (2):
>>>     selftests/resctrl: Extend CPU vendor detection
>>>     selftests/resctrl: Print a message if the result of MBM&CMT tests is
>>>       failed on Intel CPU
>>>
>>>    tools/testing/selftests/resctrl/cat_test.c    |  2 +-
>>>    tools/testing/selftests/resctrl/resctrl.h     |  5 ++-
>>>    .../testing/selftests/resctrl/resctrl_tests.c | 45 +++++++++++++------
>>>    tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
>>>    4 files changed, 37 insertions(+), 17 deletions(-)
>>>
>>
>> I can queue this up for Linux 5.18-rc2. Thanks for fixing the error
>> path with clear messages for failures.
> 
> Is this perhaps still in your queue for consideration? I peeked at the
> branches within the kselftest repo but could not find it merged yet.
> If things are tightened for fixes it would be welcome as v5.19 material
> also.
> 
> Thank you very much
> 

Thanks for the ping. The changes are a bit more extensive for a fix based
on my review comments. I queued these two in linux-kselftest next branch
for 5.19-rc1.

thanks,
-- Shuah

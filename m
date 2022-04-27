Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC751276E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiD0XTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiD0XTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:19:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697D564F8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:16:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b12so2847457plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tkonzaZX90dzwA5vktnXuUW5em2UCjcqgQZC/ODzsbM=;
        b=Z9octsvan+ibqadfTqwi4F/eau5upv7E3zD6XCpYF8zww8TD3iSWsF/4498LinOCQi
         t1zA6uY8/TuCiAFZ+yCxi91CDbxdDD22U7xfPSPMoq1hhDRUJJ6BzeQ9f4eiHqmJloXL
         LYF2GWN1+MVfa9MVrREt3paM9ZkcyG1/acHfy2piPo0qlWWHV+AXFcU0Lcc18LU8ntP1
         ftlGQb8OOU6Qj+Lv+c7pJZJSZ7mk0CGNRXxlIjjmnk/AJeIIT51TTjx8YngHXJHz0umv
         kMJObyBxprSTmIHMHBbtR1tBj3ajevlzOGsqQzKyrgbPybzV62R5I5PClTw/UUfJOoZN
         keLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tkonzaZX90dzwA5vktnXuUW5em2UCjcqgQZC/ODzsbM=;
        b=t7evNLGtuJaWLRMGr+RqLeZHgB9L3bMYKxForbQeFF3o3s5BTB5LYRMKNusQhRkY3i
         yE5ibJ9venSwdv5E3zbjCHZ82ShZ6wg+ppiQiNtuvHIFY0ggJ56Dg+6p8xAA+oiA7nI8
         aFtqu8tyAlkaoyniEq0SLgacHXxNCIk9sEv88GXcqALhzvsIj8i4qDIyfM5HC7wv1Y0e
         aFs23fX3o1WQ7oITq4SKXfAGtQ1SiIQJVHvhptPZfgwhCsWwELCmN5KqCfwzcEdqF4XM
         BWZ74tsFR1dlHvg8DiRwcqFAvyBfAlU9p8c4Q1GbLQdQG5dhyp0qRTA1Ct9L2cfuRn9Y
         aOaw==
X-Gm-Message-State: AOAM533bm8KzKg+yshULldojETYfQtwVaoJC2vvWQp2fsbGBK21I0PpI
        fkYHUgPidWTv93daW2gj9zWU52XDb0I=
X-Google-Smtp-Source: ABdhPJxBU7LIMxrtWMsM3GaOMHaDXLMY9ygziSJYz9UyFv9WeualAg/4O896hTuAofDoWifWfZjU2g==
X-Received: by 2002:a17:90b:368e:b0:1d8:fcd2:c6ca with SMTP id mj14-20020a17090b368e00b001d8fcd2c6camr30222109pjb.44.1651101366811;
        Wed, 27 Apr 2022 16:16:06 -0700 (PDT)
Received: from [172.30.1.16] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x126-20020a628684000000b0050d3f600ed0sm11775525pfd.40.2022.04.27.16.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 16:16:06 -0700 (PDT)
Message-ID: <67b840a9-c656-c871-afc1-84d2ec2c0fc3@gmail.com>
Date:   Thu, 28 Apr 2022 08:16:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V1] extcon: modify extcon device to be created after
 driver data is set
Content-Language: en-US
To:     bumwoo lee <bw365.lee@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
References: <CGME20220427030050epcas1p377eb744ed82b0e4a80747da6229fedca@epcas1p3.samsung.com>
 <20220427030005.706-1-bw365.lee@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220427030005.706-1-bw365.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi bumwoo,

On 22. 4. 27. 12:00, bumwoo lee wrote:
> Currently, someone can invoke the sysfs such as state_show()
> intermittently before dev_set_drvdata() is done.
> And it can be a cause of kernel Oops because of edev is Null at that time.
> So modified the driver registration to after setting drviver data.
> 
> - Oops's backtrace.
> 
> Backtrace:
> [<c067865c>] (state_show) from [<c05222e8>] (dev_attr_show)
> [<c05222c0>] (dev_attr_show) from [<c02c66e0>] (sysfs_kf_seq_show)
> [<c02c6648>] (sysfs_kf_seq_show) from [<c02c496c>] (kernfs_seq_show)
> [<c02c4938>] (kernfs_seq_show) from [<c025e2a0>] (seq_read)
> [<c025e11c>] (seq_read) from [<c02c50a0>] (kernfs_fop_read)
> [<c02c5064>] (kernfs_fop_read) from [<c0231cac>] (__vfs_read)
> [<c0231c5c>] (__vfs_read) from [<c0231ee0>] (vfs_read)
> [<c0231e34>] (vfs_read) from [<c0232464>] (ksys_read)
> [<c02323f0>] (ksys_read) from [<c02324fc>] (sys_read)
> [<c02324e4>] (sys_read) from [<c00091d0>] (__sys_trace_return)
> 
> Signed-off-by: bumwoo lee <bw365.lee@samsung.com>
> ---
>   drivers/extcon/extcon.c | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
(snip)

Applied it on extcon-fixes. Thanks for your work.
I change the first letter to capital letter as  following:
- extcon: Modify extcon device to be created after driver data is set


And better to use the correct version on patch title on next
and then add the changes according to version as following:
If you describe changes under '---', it is no problem
when git apply with git am command.

For example.
[PATCH v2] extcon: Modify extcon device to be created after driver data
...

Signed-off-by: bumwoo lee <bw365.lee@samsung.com>
---

Changes from v1:
- explain what are changes


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

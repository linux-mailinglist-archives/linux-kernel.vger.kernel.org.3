Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3EC5AD024
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiIEKa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbiIEKay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:30:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A50D2E695
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:30:51 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h188so7734823pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=gtvu1sOWJAtKexo39ijvJL1dgptfKWjzICln4Ve7K/4=;
        b=a0S+cI5o4IcMxp8BPR8AUgnrlaVxXq0POxlWQ7zqp6D+VsbpNz9X/FqxXJq1bb3htf
         AI2Fb/m2tjO32ImNzN/g9EZ4QJ9uLhJrjyLjP2hyytCMZPkc8ZmSI62u8tKtDVp4r3Q2
         GB2+9fMem/RLmVYcmRp+VWgr9ZDHiUxkQWmiqNGZJ3o9e07vD2epHCS3LTnx1fojPMmC
         eU5/E6EcLmpxcqm6BYvWwNyiXy58q/gXG90uLX2JeH9QidVC5y3jLGZ9mVJ8PzCvFKEm
         1lBq2dvG9QwsH1mvnoxB/sf1hWsIAXXWBmBPgQfe0aaIZ6BYnWlIlh6MLeKtRWLObzI2
         BQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=gtvu1sOWJAtKexo39ijvJL1dgptfKWjzICln4Ve7K/4=;
        b=mDblvuxxTLRbcZVG+HfKQ19B596bMaTHRY5ars+x1vYNVUE2IN1/0VKxEC1Y9FLdkp
         yTvLm5pQ9vg9e7p+RV9Rl7Ax5k8h71A/6uRQmJgawUCP8DZu5fhvK9IXLtD5CGn2+huS
         oWjpC1CcGektMwBro87DNyvaULw813/ZUiMDQuJTZg6Lw4vcRpfjz1wt+bTVM+KsroBT
         o1BucZikPAT8gVL4oNTwA3xa8MaKgUeVEPA+bey+clb+2tEvOR41VkgGzOuQTSVUaoaW
         PkXekLioU5vxxbVu9nTVKAP8Ew3XOAu8r5aVBuEQ8b8n8BYVyhR5CkrJwY4s8YUpLZKD
         Yk9g==
X-Gm-Message-State: ACgBeo3hcH/5x0oGERm5TWO8eulKs3wbE1Samrv8wtkZtAX5pLVhqF0p
        yludOQLgb1IWTlZbam8VuhP5uldbisFGDg==
X-Google-Smtp-Source: AA6agR6D0zR7wUWzfMTak/FDwLHjkBdxm+fKf7GHHreRhXXZpVCI0ODqPOg74oFtwVf6bbM2Y6t8QA==
X-Received: by 2002:a63:2bd5:0:b0:41d:9a9f:2e6d with SMTP id r204-20020a632bd5000000b0041d9a9f2e6dmr42579301pgr.53.1662373850885;
        Mon, 05 Sep 2022 03:30:50 -0700 (PDT)
Received: from [10.4.229.138] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id z188-20020a6233c5000000b00536aa488062sm7334490pfz.163.2022.09.05.03.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:30:50 -0700 (PDT)
Message-ID: <c05bdeac-b354-0ac7-3233-27f8e5cbb38a@bytedance.com>
Date:   Mon, 5 Sep 2022 18:30:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [Phishing Risk] [External] Re: [PATCH] cgroup/cpuset: Add a new
 isolated mems.policy type.
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220902063303.1057-1-hezhongkun.hzk@bytedance.com>
 <YxT/liaotbiOod51@slm.duckdns.org>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <YxT/liaotbiOod51@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun, thanks for your reply.

We usually use numactl to set the memory policy, but it cannot be 
changed dynamically. In addition, the mempolicy of cpuset can provide a 
more convenient interface for management and control panel.

Sorry,I don't quite understand the meaning of "don't enforce anything 
resource related". Does it mean mempolicy, such as "prefer:2" must 
specify node? Or "cpuset.mems.policy" need to specify a default value?
(cpuset.mems.policy does not require a default value.)

Thanks.


> Hello,
> 
> On Fri, Sep 02, 2022 at 02:33:03PM +0800, hezhongkun wrote:
>> From: Zhongkun He <hezhongkun.hzk@bytedance.com>
>>
>> Mempolicy is difficult to use because it is set in-process
>> via a system call. We want to make it easier to use mempolicy
>> in cpuset, and  we can control low-priority cgroups to
>> allocate memory in specified nodes. So this patch want to
>> adds the mempolicy interface in cpuset.
>>
>> The mempolicy priority of cpuset is lower than the task.
>> The order of getting the policy is:
>> 	1) vma mempolicy
>> 	2) task->mempolicy
>> 	3) cpuset->mempolicy
>> 	4) default policy.
>>
>> cpuset's policy is owned by itself, but descendants will
>> get the default mempolicy from parent.
>>
>> How to use the mempolicy interface:
>> 	echo prefer:2 > /sys/fs/cgroup/zz/cpuset.mems.policy
>> 	echo bind:1-3 > /sys/fs/cgroup/zz/cpuset.mems.policy
>>          echo interleave:0,1,2,3 >/sys/fs/cgroup/zz/cpuset.mems.policy
>> Show the policy:
>> 	cat /sys/fs/cgroup/zz/cpuset.mems.policy
>> 		prefer:2
>> 	cat /sys/fs/cgroup/zz/cpuset.mems.policy
>> 		bind:1-3
>> 	cat /sys/fs/cgroup/zz/cpuset.mems.policy
>> 		interleave:0-3
>> Clear the policy:
>> 	echo default > /sys/fs/cgroup/zz/cpuset.mems.policy
> 
> So, I'm a fan of adding cgroup functionalities which don't enforce anything
> resource related. What you're proposing can easily be achieved with userland
> tooling, right?
> 
> Thanks.
> 

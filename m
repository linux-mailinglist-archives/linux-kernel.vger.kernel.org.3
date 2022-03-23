Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35764E55B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245269AbiCWP4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCWP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:56:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A9BCB8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:54:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mz9-20020a17090b378900b001c657559290so6806490pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Hh1ug1d4hVAiXZL5NFxeqG5pcbYIEm9L1GDr+RPQQh8=;
        b=cvtyFj7GfLKZ4+6tSF+EYvKlMULHKWOCA2NU6ZLx/gvUnnBCOID9TuSaes4gNpvBV+
         24lJninHJw+1ZCTbSD0Of/4fIq/+ODphC7SoKRy+9B1v+YTNtr/Qlj0EXhI0glGLAM9R
         rKBQoOQM4y1pVohtA+UVRVJmxwT+OmtFdArkAO0o9TW2YuPEhBygaBR9bIpL6PLIHOvu
         36TM4ruSYp72/PXRF/MdhuUKMCqisg4SAKvzziz0moMpIjNkH8TT8nDP2b8ihFmi4EFO
         4uyUI+qd8rirVM7fvnfUY3RFSbZf95tFcmc+WNhDK2ipFZY/bHrHFa0Ndn9yhs1Z63u/
         5ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hh1ug1d4hVAiXZL5NFxeqG5pcbYIEm9L1GDr+RPQQh8=;
        b=gJHOlvNUDwo77XkSebI0Ybr9rSQnaetAnYgLTj2FZyFd1RiDHOUzu4f1V9qQHOiOru
         Usp76YLDI2lE/Z2CicKL7dnpv+7FkstNnol2ptwiHpKhYKc5mnsCxCT0YH3pgSO/dJ0A
         XjxpNoCfq6dUCySRnq6LddjGuERLTPhfu8eoe49kWpuFIQTWO99Dq+sjAaJxxgU1jSk8
         HhqWk2uVLJySGEUlfNWXFoB4RlKecbxe7TFoWfNONTlfewia9saGT+ZZW1i3CTCnEUt2
         3FkUS7B4gRTsbAtC/jfOXfPYIHCf0CrnqsUVnoiW/ye9leh4MFwlGIX5wqYkgi7zkGP/
         LFDA==
X-Gm-Message-State: AOAM532QfZ2pTCwiXGZAaFccLFrl3OSaOmhS3BXccQ0VrsIrXRvtE6Gd
        Nw0qmk008NDFA8Gisi4InPEeMQ==
X-Google-Smtp-Source: ABdhPJzsR+gLcGMdmgrX5xZxhLRKiJ3BNB1i1XmuixS0ic++diitT9WZiml9wJs2jPY9+euweP6lEg==
X-Received: by 2002:a17:902:6a89:b0:153:7213:3841 with SMTP id n9-20020a1709026a8900b0015372133841mr556626plk.74.1648050898577;
        Wed, 23 Mar 2022 08:54:58 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:257e:c5d2:cab0:ca98? ([2409:8a28:e62:3990:257e:c5d2:cab0:ca98])
        by smtp.gmail.com with ESMTPSA id o17-20020a639a11000000b0038160e4a2f7sm250359pge.48.2022.03.23.08.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 08:54:57 -0700 (PDT)
Message-ID: <b435553f-930e-52fa-86fb-0d1619bb69b3@bytedance.com>
Date:   Wed, 23 Mar 2022 23:54:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v2] psi: report zeroes for CPU full at the
 system level
Content-Language: en-US
To:     peterz@infradead.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>, corbet@lwn.net,
        mingo@redhat.com, surenb@google.com, ebiggers@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Martin Steigerwald <Martin.Steigerwald@proact.de>
References: <20220309111445.86484-1-zhouchengming@bytedance.com>
 <Yij8m9qHtvNKyGMK@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Yij8m9qHtvNKyGMK@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/10 3:14 上午, Johannes Weiner wrote:
> On Wed, Mar 09, 2022 at 07:14:45PM +0800, Chengming Zhou wrote:
>> Martin find it confusing when look at the /proc/pressure/cpu output,
>> and found no hint about that CPU "full" line in psi Documentation.
>>
>> % cat /proc/pressure/cpu
>> some avg10=0.92 avg60=0.91 avg300=0.73 total=933490489
>> full avg10=0.22 avg60=0.23 avg300=0.16 total=358783277
>>
>> The PSI_CPU_FULL state is introduced by commit e7fcd7622823
>> ("psi: Add PSI_CPU_FULL state"), which mainly for cgroup level,
>> but also counted at the system level as a side effect.
>>
>> Naturally, the FULL state doesn't exist for the CPU resource at
>> the system level. These "full" numbers can come from CPU idle
>> schedule latency. For example, t1 is the time when task wakeup
>> on an idle CPU, t2 is the time when CPU pick and switch to it.
>> The delta of (t2 - t1) will be in CPU_FULL state.
>>
>> Another case all processes can be stalled is when all cgroups
>> have been throttled at the same time, which unlikely to happen.
>>
>> Anyway, CPU_FULL metric is meaningless and confusing at the
>> system level. So this patch will report zeroes for CPU full
>> at the system level, and update psi Documentation accordingly.
>>
>> Fixes: e7fcd7622823 ("psi: Add PSI_CPU_FULL state")
>> Reported-by: Martin Steigerwald <Martin.Steigerwald@proact.de>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Peter, would you mind picking this up for 5.18?

Hi Peter, ping...

Maybe the subject should start with "sched/psi", to be easier to notice ;-)

Thanks.

> 
> Thanks!

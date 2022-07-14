Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D8C574F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbiGNNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiGNNYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:24:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10565D5A1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:24:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso3065746pjk.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u1UtaEoyhNdBLBYULOpsQvM7CRbo7Xt6w7P3JBVMdkQ=;
        b=COaionMtMh0iGHZ+PJq2ZgF+nW7L7uM7JgphYDshLy18RupWnw2LKJyhYzHdEJq9jZ
         cd5fpWmmFMAPKZZl608gPt7ZcYFWFiFRXRfLnrUbTLgKrygVPdPH4sz0FfmnkyUGCDI7
         ORs5z35ZSwCuBh6xmgtad1osC/wiHPdUyUhpNEqvO9ykyp5DHbJ+xgc2Lu90bxKl1veU
         Axr77M/YsklVv5DJh3kkgdI5fORhdTbqpscwJEdOllnwibdOZxT1LODsWz6ZKmT++mHu
         CTYfNaaiIdPkQ04NnJ4De9ZcH7i5X29X3mNBApA/wQWAw2/cRWM4q6unXWlkYl42puBJ
         GKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u1UtaEoyhNdBLBYULOpsQvM7CRbo7Xt6w7P3JBVMdkQ=;
        b=kqPR8XU/zAZQ6XLiyJDfj7EgwPtYiNT+S43FR1pXWi7LYBGCZXJkLWp0M90+tAYuys
         z7HiFW/wX/GLrw2yZVtddfrETNlsuQBlQHVC1M5MNJ6roHZUFGd4lMBd5nBqlsq9jN6T
         odd9YzHU/z//R1/4B0OYip8tOtTD0Jvg8s+M+4YdTLLUsWkl8D9aBOgAIS1GPYEPoBad
         LyAGlBLBE8RaG2z6lnBCLBTKDEfTuTEOxv20PSYbTXRFHDJyH+8tsO/D9ggFF/CtXGwi
         FkqxDs5Banih3YbybuPrmE+X4oWl7e28YME8vGt1qmNuDXjXA+ejlvTSpmQ6rXQI8QK+
         Ul/Q==
X-Gm-Message-State: AJIora929OP3SP5wENpXRtxwexAmsHHY5T5LdCBR3CdI9amrJV5Thn6N
        DwCAYvC7mRR03uNdER//poreDQ==
X-Google-Smtp-Source: AGRyM1tSmp4zJiFMK3AZH8bw6gCccvCCiyKX2GPzZltv94o6dCEN1lKSSI8272wM6NBi7CF8STxwHA==
X-Received: by 2002:a17:902:aa0b:b0:16b:c4a6:1dc9 with SMTP id be11-20020a170902aa0b00b0016bc4a61dc9mr8375051plb.83.1657805070345;
        Thu, 14 Jul 2022 06:24:30 -0700 (PDT)
Received: from [10.255.242.206] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id l1-20020a63f301000000b00415320bc31dsm1325925pgh.32.2022.07.14.06.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:24:29 -0700 (PDT)
Message-ID: <7b611f83-87ab-30aa-beb1-94f2f3110f47@bytedance.com>
Date:   Thu, 14 Jul 2022 21:24:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH v2 06/10] sched/fair: delete superfluous
 SKIP_AGE_LOAD
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-7-zhouchengming@bytedance.com>
 <71c7d48c-8ce8-9d43-d578-2a3c15dbd64b@arm.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <71c7d48c-8ce8-9d43-d578-2a3c15dbd64b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/14 20:33, Dietmar Eggemann wrote:
> On 13/07/2022 06:04, Chengming Zhou wrote:
>> There are three types of attach_entity_cfs_rq():
>>
>> 1. task migrate to CPU
>> 2. task move to cgroup
>> 3. task switched to fair from !fair
>>
>> The case1 and case2 already have sched_avg last_update_time
>> reset to 0 when attach_entity_cfs_rq().
>>
>> We will make case3 also have last_update_time reset to 0 when
>> attach_entity_cfs_rq() in the following patches.
>>
>> So it makes no difference whether SKIP_AGE_LOAD is set or not.
> 
> Wouldn't this patch make more sense after 09/10?
> 

Yes, this patch was put at last in the v1.

In this v2, the following patch 07/10 make attach_entity_cfs_rq() to use
update_load_avg(DO_ATTACH) to do conditional attach.

So I want to get rid of "sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD"
earlier in this patch, or have to write like this:


  int flags = UPDATE_TG | DO_ATTACH;

  update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? flags : SKIP_AGE_LOAD | flags);


Thanks.

> [...]

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F051A52FED0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 20:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbiEUScR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 14:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiEUScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 14:32:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A906666A9
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 11:32:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h8so12841272ljb.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LQdic5D2mWyJy+0s57aqv9AapzRzXHTJwfJI8BE4AEc=;
        b=dtMTibjG/ktDXCJMVAEnJNykhvUx5B/p4FDm+DFx085Tn5NCToh6aVKUHumRUF//Ff
         tv3jvIqQmEUOha8bhOTjTHjWVtjTNH8f8Qxu6dBUkKMjPmtLnXD2+kY7dJ+AhZLNe16E
         +KJZwnO0TRjsdt/Ko9CYbxWT/7pCRhDl5IeHh2WxeJ5JB68QrBEFFAnUfl8F9f6T6dJk
         6gUAwEWAJa7oXIByFX/y8bsiSxiQN6bX01Wm1+R/d5+yCRZ4QGrsqrjWzT6p7YxR1k1I
         c1aPtBu0InXsS2YaRxkJtlHo96fZbv9cC3+hXxbBeSj2QxivJNupczKbCKiP+lLtyS1A
         eL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LQdic5D2mWyJy+0s57aqv9AapzRzXHTJwfJI8BE4AEc=;
        b=uCiUR3l0NKAzC0MjB3BPBWF01anopFDEdHL9B1jE6cL5Tv+6FMXi330+IiDoBWyVLQ
         p3Xjk/pBWrKlZJOAThxmjkg4AZre+Ub5UqhgaC9o/tUq6Vn1jWZ6C5rZGcMlXh8T3bdI
         wCIk9n8kSvsOqwR78YgiTf8NSkWxD7ci67XQQfNhgY1auyYDl3lBfM6Ffo/ddGUL/21p
         5oPJ383Nxi3vTwVPJ8oPqIrzzAAyquL8wFNfSGQINsukbAEPUHvLRU15q8Jcn4sBSw7A
         JFZHJ/AjkDpw7s2h5gLUeIkg5qqVQ6aZbcWb2z7ZZTG5gozc5OhJQVDpOYTqs1+Ocsr7
         dN+g==
X-Gm-Message-State: AOAM531bW9HDWCN8MAs9klAAlQAeGc+B+/iCVlHOz/P88Dbvus5Jq4os
        l1JYZ3iEqlOE/ntqjoTjAFn4Pw==
X-Google-Smtp-Source: ABdhPJwDNu0Ao/DIM+X+2YYMISKkfLIKDeA74Gcnphj12xwHRi4nvTgpC4/vj6NVqWUdlz4OOxKy9A==
X-Received: by 2002:a2e:8907:0:b0:253:c8e5:1fac with SMTP id d7-20020a2e8907000000b00253c8e51facmr8806691lji.338.1653157932817;
        Sat, 21 May 2022 11:32:12 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id r19-20020ac252b3000000b00477c05f9ffbsm1149830lfm.9.2022.05.21.11.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 11:32:12 -0700 (PDT)
Message-ID: <0c73ce5c-3625-6187-820e-1277e168b3bc@openvz.org>
Date:   Sat, 21 May 2022 21:32:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] tracing: add 'accounted' entry into output of
 allocation tracepoints
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     YoPOhRctb8wwbmY5@carbon, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
References: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
 <20220518160447.20a7b96f@gandalf.local.home>
 <b728f944-e3ae-cdb6-5f02-2fb21466b2fb@openvz.org>
 <20220519100348.101d027d@gandalf.local.home>
 <e018be81-f4f2-a26f-7c5a-7adddd9c56c4@openvz.org>
 <20220519123255.543b8db6@gandalf.local.home>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220519123255.543b8db6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 19:32, Steven Rostedt wrote:
> On Thu, 19 May 2022 19:29:36 +0300
> Vasily Averin <vvs@openvz.org> wrote:
> 
>> Frankly speaking I vote for performance with both hands.
>> However I'm still would like to avoid new sparse warnings.
>> Christoph Hellwig just recently taught me, "never add '__force' before
>> thinking hard about them", but in this case I would need to use it three times.
>>
>> I found that bitwise typecasts can be avoided by using translation unions. 
>>
>> What do you think about following trick?
> 
> It's really up to you memory management folks. Although I may need to
> update libtraceevent to handle the union case. That may be a bit tricky.

In this case, I would like to keep sub-optimal v3 patch version.
If necessary, we can improve the performance later, and right now
I will send v4 with minor patch description changes and ask
Andrew Morton to include it in the mm tree.

Thank you,
	Vasily Averin


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3537157E49B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiGVQmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiGVQmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:42:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362C45FACB;
        Fri, 22 Jul 2022 09:42:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p10so976143lfd.9;
        Fri, 22 Jul 2022 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xaaf0HNzWmhDoOucX+0h5VHGXwYwMIslA/bCLi1nrKE=;
        b=Tsv4sFokS0GU1gqG5yQV9meI5UgcZgAA02hdyFj6DPzNfI/Jhiaimb1AH7mMmLmFom
         ZQTnIIviPL6htMofuiWUC2iF3QJS6zylSGB44BwZ7SEhgdRv1MWwIHwWZdcVG9OKiB3A
         OHjgHABF2qu7kb9qHNZLDvpoJVOiI7kUKC43DILGvSjjpCh+39RVQlMTCC396DRQjGCb
         zSfrevchflsmFmr/2OhN5dwIdMqyh78n5YYfPNIWGO/pzudXsfKo/oSLkNL7PeXkJNlp
         TshNwCOVcomL98xN3etQSU8zZCPeA/cO+HLwjW0O/Lig7v8tVRpWkSLnqbt4N2n1H/eb
         G0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xaaf0HNzWmhDoOucX+0h5VHGXwYwMIslA/bCLi1nrKE=;
        b=hlRZE6Lm6v0ZzYmqpboRa8/FfYevverxNsWVW1jeUtL7Mf4nu0MEcHSfuXk2T4JZjd
         HHm//sgNHFeOpLnIPWmGB7kcEvQWwvgXTsfZBGGTqUTrWqQsr24fgaWq/Wf1VNfcbdg3
         hVcfXJ3AfqPTnS5svMY7Ws7Zp6A6FG6D/YPiPVGJuxYE15F0502RJFS62pqNJ7P23UyA
         Id+4kTVtJFZq5lA9hDsBPuexvqtoNHhVo0qvvx7+U75Syg2GjhcGQU/ax9+t5Ck3pHON
         rTxmlrCJqzU9AvGn7bMDgE0V/Yi1+I/H/9Ye893p7FhEqeiOfkjQhABiJO7N4SJxj+i1
         nkFg==
X-Gm-Message-State: AJIora+e/yJd3egAYFhKfPc3l5WMPODPG+AeYnrzVt6HHuLbMIpuvWe6
        1Zdx34tKvWJ0V7yMswTUu8tDael0atxOkA==
X-Google-Smtp-Source: AGRyM1sTHqgBReLbiOi3fH7YqUujhX7RaKusK8BFbdtr+bXhcXex5n7DvpxnnZENJkIIUIAK9M/fJw==
X-Received: by 2002:a05:6512:b27:b0:489:e045:394e with SMTP id w39-20020a0565120b2700b00489e045394emr332687lfu.202.1658508160232;
        Fri, 22 Jul 2022 09:42:40 -0700 (PDT)
Received: from [192.168.1.4] (broadband-188-32-106-30.ip.moscow.rt.ru. [188.32.106.30])
        by smtp.gmail.com with ESMTPSA id p15-20020a19f00f000000b0047255d2110asm1140388lfc.57.2022.07.22.09.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 09:42:39 -0700 (PDT)
Message-ID: <3995754e-064b-6091-ccb0-224c3e698af2@gmail.com>
Date:   Fri, 22 Jul 2022 19:42:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] futex2: add NUMA awareness
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
Cc:     linux-api@vger.kernel.org, fweimer@redhat.com,
        linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        libc-alpha@sourceware.org, Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <36a8f60a-69b2-4586-434e-29820a64cd88@igalia.com>
 <74ba5239-27b0-299e-717c-595680cd52f9@gmail.com>
 <8bfd13a7-ed02-00dd-63a1-7144f2e55ef0@igalia.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
In-Reply-To: <8bfd13a7-ed02-00dd-63a1-7144f2e55ef0@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 18:00, André Almeida wrote:
> Hi Andrey,
> 
> Thanks for the feedback.
> 
> Às 08:01 de 14/07/22, Andrey Semashev escreveu:
>> On 7/14/22 06:18, André Almeida wrote:
> [...]
>>>
>>> Feedback? Who else should I CC?
>>
>> Just a few questions:
>>
>> Do I understand correctly that notifiers won't be able to wake up
>> waiters unless they know on which node they are waiting?
>>
> 
> If userspace is using NUMA_FLAG, yes. Otherwise all futexes would be
> located in the default node, and userspace doesn't need to know which
> one is the default.
> 
>> Is it possible to wait on a futex on different nodes?
> 
> Yes, given that you specify `.hint = id` with the proper node id.

So any given futex_wake(FUTEX_NUMA) operates only within its node, right?

>> Is it possible to wake waiters on a futex on all nodes? When a single
>> (or N, where N is not "all") waiter is woken, which node is selected? Is
>> there a rotation of nodes, so that nodes are not skewed in terms of
>> notified waiters?
> 
> Regardless of which node the waiter process is running, what matter is
> in which node the futex hash table is. So for instance if we have:
> 
> 	struct futex32_numa f = {.value = 0, hint = 2};
> 
> And now we add some waiters for this futex:
> 
> Thread 1, running on node 3:
> 
> 	futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);
> 
> Thread 2, running on node 0:
> 
> 	futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);
> 
> Thread 3, running on node 2:
> 
> 	futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);
> 
> And then, Thread 4, running on node 3:
> 
> 	futex_wake(&f, 2, FUTEX_NUMA | FUTEX_32);
> 
> Now, two waiter would wake up (e.g. T1 and T3, node 3 and 2) and they
> are from different nodes. futex_wake() doesn't provide guarantees of
> which waiter will be selected, so I can't say which node would be
> selected.

In this example, T1, T2 and T3 are all blocking on node 2 (since all of
them presumably specify hint == 2), right? In this sense, it doesn't
matter which node they are running on, what matters is what node they
block on.

What I'm asking is can I wake all threads blocked on all nodes on the
same futex? That is, is the following possible?

  // I'm using hint == -1 to indicate the current node
  // of the calling thread for waiters and all nodes for notifiers
  struct futex32_numa f = {.value = 0, .hint = -1};

  Thread 1, running on node 3, blocks on node 3:

  futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);

  Thread 2, running on node 0, blocks on node 0:

  futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);

  Thread 3, running on node 2, blocks on node 2:

  futex_wait(&f, 0, FUTEX_NUMA | FUTEX_32, NULL);

  And then, Thread 4, running on whatever node:

  futex_wake(&f, -1, FUTEX_NUMA | FUTEX_32);

Here, futex_wake would wake T1, T2 and T3. Or:

  futex_wake(&f, 1, FUTEX_NUMA | FUTEX_32);

Here, futex_wake would wake any one of T1, T2 or T3.

> There's no policy for fairness/starvation for futex_wake(). Do
> you think this would be important for the NUMA case?

I'm not sure yet. If there isn't a cross-node behavior like in my
example above then, I suppose, it falls to the userspace to ensure fair
rotation of the wakeups on different nodes. If there is functionality
like this, I imagine, some sort of fairness would be desired.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0633C46AFC6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhLGBdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:33:22 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:32862 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232745AbhLGBdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:33:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uzi0nBx_1638840568;
Received: from 30.240.96.231(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uzi0nBx_1638840568)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Dec 2021 09:29:29 +0800
Message-ID: <4172710c-58ad-a674-b892-868a13c4a149@linux.alibaba.com>
Date:   Tue, 7 Dec 2021 09:29:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v6 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211202021606.48812-1-yinan@linux.alibaba.com>
 <20211202021606.48812-2-yinan@linux.alibaba.com>
 <20211202125800.7b346733@gandalf.local.home>
 <20211206151858.4d21a24d@gandalf.local.home>
From:   Yinan Liu <yinan@linux.alibaba.com>
In-Reply-To: <20211206151858.4d21a24d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> After applying this, I get a failure on the kprobe self tests at boot up:
>>
>>   Testing ftrace filter: OK
>>   trace_kprobe: Testing kprobe tracing:
>>   trace_kprobe: Could not probe notrace function kprobe_trace_selftest_target
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 2 PID: 1 at kernel/trace/trace_kprobe.c:1973 kprobe_trace_self_tests_init+0x5c/0x497
>>   Modules linked in:
> 
> And I added the below patch, and it shows that the section is not properly
> sorted. Something went wrong with your sorting.
> 
> I plan on keeping this check, at least as a compile option, to make sure
> that the output is sorted, otherwise things will silently fail if they are
> not.
> 
> This patch produced:
> 
> [    1.315419] ftrace: allocating 43510 entries in 170 pages
> [    1.320638] ------------[ cut here ]------------
> [    1.325227] [3] x86_pnpbios_disabled+0x0/0x1c at 8a51c707 is not sorted with __traceiter_initcall_level+0x0/0x60 at 87000660
> 
> I'm dropping the patches until this is "sorted out" :-)
> 
> -- Steve
>
Hi, steven

Sorry, I just saw the email yesterday. Recently my computer is not 
around. I'm not sure what went wrong at the moment. I will fix it.



Best regards!
-- Yinan Liu


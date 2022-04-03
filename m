Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4509E4F07B6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiDCFPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDCFP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:15:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7633419289;
        Sat,  2 Apr 2022 22:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=PEgc8Ga0cnyRYRy3sepXDsniqZif9JIr9jjDkoUEBdQ=; b=arcia5dACXcwl6PBm4kdLKQ00e
        o+b4po6tKbqKMZVRftRs0MOz/ARBR1SL4zRpNCD088wyaw+l/rX4n8jLRgiv+JD5oX5Jp2DVRCVtM
        TEpqzQHaa93aHawO0Ees1yGVSLxDdD/+P/isouLSUUjwEjSPtVzDSBZNImmvM9XKRBRLWhziBXNr5
        mP98OBnzolebyVuK2ufK30MfdrfD8oSeVDJRvV2q09RFzGveyNPj/XeszSH8AyXfNUgDm9VmOqO1L
        /WcMrQk0UamQ52KlJnfk8mJt52OK8dtFYjxSXMVgqC1T0gyqF4+h20AbE6NaGk4uQaUx+54DaPUed
        vK3iw9mA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nasYK-004fIF-Ft; Sun, 03 Apr 2022 05:13:28 +0000
Message-ID: <53133d81-e52c-8887-c879-615b585e3351@infradead.org>
Date:   Sat, 2 Apr 2022 22:13:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3 v2] Docs: admin/kernel-parameters: edit a few boot
 options
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-ia64@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220401030927.12023-1-rdunlap@infradead.org>
 <20220401030927.12023-2-rdunlap@infradead.org>
 <20220401120305.00076d14@gandalf.local.home>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220401120305.00076d14@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/22 09:03, Steven Rostedt wrote:
> On Thu, 31 Mar 2022 20:09:25 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> @@ -5908,6 +5910,8 @@
>>  	trace_buf_size=nn[KMG]
>>  			[FTRACE] will set tracing buffer size on each cpu.
>>  
>> +	trace_clock=	[FTRACE] See Documentation/trace/ftrace.rst
> 
> 	trace_clock=	[FTRACE] Set the clock used for tracing events
> 			at boot up.
> 			local - Use the per CPU time stamp counter
> 				(converted into nanoseconds). Fast, but
> 				depending on the architecture, may not be
> 				in sync between CPUs.
> 			global - Event time stamps are synchronize across
> 				CPUs. May be slower than the local clock,
> 				but better for some race conditions.
> 			counter - Simple counting of events (1, 2, ..)
> 				note, some counts may be skipped due to the
> 				infrastructure grabbing the clock more than
> 				once per event.
> 			uptime - Use jiffies as the time stamp.
> 			perf - Use the same clock that perf uses.
> 			mono - Use ktime_get_mono_fast_ns() for time stamps.
> 			mono_raw - Use ktime_get_raw_fast_ns() for time
> 				stamps.
> 			boot - Use ktime_get_boot_fast_ns() for time stamps.
> 			Architectures may add more clocks. See
> 			Documentation/trace/ftrace.rst for more details.
> 

Will do. Thanks.

> 
> 
>> +
>>  	trace_event=[event-list]
>>  			[FTRACE] Set and start specified trace events in order
>>  			to facilitate early boot debugging. The event-list is a

-- 
~Randy

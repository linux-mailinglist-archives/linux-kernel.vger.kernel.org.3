Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC294BA80F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbiBQSVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:21:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiBQSV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:21:29 -0500
X-Greylist: delayed 1463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 10:21:15 PST
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFAB1712AC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:21:15 -0800 (PST)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 7B20A9D0E80
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:56:52 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id Kl1QnOOMnHnotKl1QnIGXq; Thu, 17 Feb 2022 11:56:52 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:34154 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nKl1O-001Zrd-AE; Thu, 17 Feb 2022 11:56:50 -0600
Message-ID: <ca674409-34bb-69b2-0df5-e01b6facee88@kernel.org>
Date:   Thu, 17 Feb 2022 18:56:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC V2 17/21] watchdog/dev: Add tracepoints
Content-Language: en-US
To:     Gabriele Paoloni <gpaoloni@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Peter.Enderborg@sony.com" <Peter.Enderborg@sony.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1644830251.git.bristot@kernel.org>
 <e67874c8b676ea8dfe38679efa25363889bb1e76.1644830251.git.bristot@kernel.org>
 <96f418b4-0ba8-01fe-ead0-2028bfc42560@sony.com>
 <ba924008-c0ab-4800-aac4-d9d9ae930c32@kernel.org>
 <ef1b1d99-6172-2b4d-9612-7ecbe8fc6c8b@roeck-us.net>
 <6c6fc4fa-6464-2dbf-40da-e3c61f322d95@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <6c6fc4fa-6464-2dbf-40da-e3c61f322d95@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.232.30.176
X-Source-L: No
X-Exim-ID: 1nKl1O-001Zrd-AE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:34154
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 18:49, Gabriele Paoloni wrote:
> 
> On 17/02/2022 18:27, Guenter Roeck wrote:
>> On 2/17/22 08:27, Daniel Bristot de Oliveira wrote:
>>> Hi Peter
>>>
>>> On 2/16/22 17:01, Peter.Enderborg@sony.com wrote:
>>>> On 2/14/22 11:45, Daniel Bristot de Oliveira wrote:
>>>>> Add a set of tracepoints, enabling the observability of the watchdog
>>>>> device interactions with user-space.
>>>>>
>>>>> The events are:
>>>>>     watchdog:watchdog_open
>>>>>     watchdog:watchdog_close
>>>>>     watchdog:watchdog_start
>>>>>     watchdog:watchdog_stop
>>>>>     watchdog:watchdog_set_timeout
>>>>>     watchdog:watchdog_ping
>>>>>     watchdog:watchdog_nowayout
>>>>>     watchdog:watchdog_set_keep_alive
>>>>>     watchdog:watchdog_keep_alive
>>>> Some watchdogs have a bark functionality, I think it should be event
>>>> for that too.
>>>>
>>> I understand. The problems is that I do not see the bark abstraction
>>> in the
>>> watchdog_dev layer.
>>>
>> I don't even know what "bark functionality" means. A new term for
>> pretimeout ?
>> Something else ?
> From my understanding the bark timeout is actually the pretimeout
> whereas the bite timeout is the actual timeout.

So, what Peter wants is tracepoints for the pretimeout actions?

-- Daniel

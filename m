Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C4E4BA5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbiBQQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:27:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiBQQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:34 -0500
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.143.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036809AD9B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:27:19 -0800 (PST)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id BDEBA5351F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:27:18 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id KjckndtUx9AGSKjcknQY06; Thu, 17 Feb 2022 10:27:18 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:34148 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nKjcj-003u9J-0E; Thu, 17 Feb 2022 10:27:17 -0600
Message-ID: <ba924008-c0ab-4800-aac4-d9d9ae930c32@kernel.org>
Date:   Thu, 17 Feb 2022 17:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC V2 17/21] watchdog/dev: Add tracepoints
Content-Language: en-US
To:     "Peter.Enderborg@sony.com" <Peter.Enderborg@sony.com>,
        Guenter Roeck <linux@roeck-us.net>,
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
        Gabriele Paoloni <gpaoloni@redhat.com>,
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
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <96f418b4-0ba8-01fe-ead0-2028bfc42560@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.232.30.176
X-Source-L: No
X-Exim-ID: 1nKjcj-003u9J-0E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:34148
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

On 2/16/22 17:01, Peter.Enderborg@sony.com wrote:
> On 2/14/22 11:45, Daniel Bristot de Oliveira wrote:
>> Add a set of tracepoints, enabling the observability of the watchdog
>> device interactions with user-space.
>>
>> The events are:
>> 	watchdog:watchdog_open
>> 	watchdog:watchdog_close
>> 	watchdog:watchdog_start
>> 	watchdog:watchdog_stop
>> 	watchdog:watchdog_set_timeout
>> 	watchdog:watchdog_ping
>> 	watchdog:watchdog_nowayout
>> 	watchdog:watchdog_set_keep_alive
>> 	watchdog:watchdog_keep_alive
> 
> Some watchdogs have a bark functionality, I think it should be event for that too.
> 

I understand. The problems is that I do not see the bark abstraction in the
watchdog_dev layer.

In the case I am investigating (the safety_monitor/safety_app) the bark is
outside of the "OS" view, it is an hardware action - like. shutdown.

Am I missing something? Thoughts?

-- Daniel

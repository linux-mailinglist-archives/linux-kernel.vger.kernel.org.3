Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A24B7752
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbiBORq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:46:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbiBORq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:46:28 -0500
X-Greylist: delayed 1383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 09:46:18 PST
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0D9E6C32
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:46:18 -0800 (PST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 01C771219C9E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:23:15 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id K1VpnmLeT22u3K1Vqn6oIm; Tue, 15 Feb 2022 11:21:14 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:59436 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nK1Vo-002nDW-7t; Tue, 15 Feb 2022 11:21:12 -0600
Message-ID: <65172f14-bad6-37b1-d243-e91ca472d22e@kernel.org>
Date:   Tue, 15 Feb 2022 18:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC V2 12/21] rv/reactor: Add the printk reactor
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1644830251.git.bristot@kernel.org>
 <fad2d358d57dfffc084d482684ecc1d13b62b262.1644830251.git.bristot@kernel.org>
 <10cf6003-6d2b-056b-11bb-3ae9c342a369@linuxfoundation.org>
 <c1657d1c-0d2b-4aa3-c1ed-2ae6fdfcda86@kernel.org>
 <87v8xg30qc.fsf@jogness.linutronix.de>
 <45179cdb-2391-207a-2f7b-2dea828d1606@kernel.org>
 <87r1842r1m.fsf@jogness.linutronix.de>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <87r1842r1m.fsf@jogness.linutronix.de>
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
X-Exim-ID: 1nK1Vo-002nDW-7t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:59436
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 14:33, John Ogness wrote:
> On 2022-02-15, Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
>>> I suggest using printk_deferred() for this reactor for now. With
>>> printk_deferred() the message and timestamp are immediately and
>>> locklessly stored in the buffer, and the printing is performed in a
>>> separate context. printk_deferred() is safe for all contexts.
>> Question: Does it always postpone or only postpone when in a
>> particular contexts, like, with irqs disabled?
> printk_deferred() always postpones printing.

That is why printk() seems to be the better option, though I can use the
deferred option too.

Noting that, I am aware of printk_deferred(), and every once and while I am
Cc'ed on patches suggesting changing printk() to printk_deferred(), but they are
not, let's say, welcome [1]... that is why I am not using it.

>> Note: do not use this reactor with rq_lock taken, it will lock the
>> system until printk can handle that.
> Perhaps you could explain thi comment in your commit message?  printk()
> should never lock the system.

I saw deadlocks in the past, and while testing the WIP monitor some time ago, it
seems it depends on the console type. If such restriction does not exist
anymore, I can remove that comment, it would be even better!

[1]
https://lore.kernel.org/lkml/e68888438cec9a1da53aaa1647720ade638d6ad4.1600705105.git.bristot@redhat.com/

-- Daniel

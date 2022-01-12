Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C468A48C948
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355551AbiALRYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:24:23 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.253]:27111 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355577AbiALRYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:24:02 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 0393A3B8B3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:24:00 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 7hJvn5W2PRnrr7hJvnsSRj; Wed, 12 Jan 2022 11:21:59 -0600
X-Authority-Reason: nr=8
Received: from host-79-47-126-144.retail.telecomitalia.it ([79.47.126.144]:48572 helo=[10.0.0.88])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1n7hJu-004Oi8-Ht; Wed, 12 Jan 2022 11:21:58 -0600
Message-ID: <76028ce8-b46b-b164-60b2-4a40f3872775@kernel.org>
Date:   Wed, 12 Jan 2022 18:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [for-next][PATCH 16/31] rtla: Real-Time Linux Analysis tool
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tao Zhou <tao.zhou@linux.dev>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220111173030.999527342@goodmis.org>
 <20220111173116.190327559@goodmis.org>
 <5f04540c-273a-c4f2-692d-9de2f1495ba9@kernel.org>
 <20220112112159.742d258c@rorschach.local.home>
 <20220112113054.1be08f6c@rorschach.local.home>
 <20220112121426.2dde33c2@rorschach.local.home>
 <20220112121623.5b989f83@rorschach.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220112121623.5b989f83@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.47.126.144
X-Source-L: No
X-Exim-ID: 1n7hJu-004Oi8-Ht
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-47-126-144.retail.telecomitalia.it ([10.0.0.88]) [79.47.126.144]:48572
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 18:16, Steven Rostedt wrote:
> On Wed, 12 Jan 2022 12:14:26 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> And by making this mistake, I noticed something in doing the diff. You
>> put rtla into Documentation/tools. It should be in tools/ itself, not
>> the Documentation directory.
> At least it use to be in tools/tracing/rtla, but this series has code
> in Documentation/tools/rtla, was it not fully moved over?

The code is in tools/tracing/rtla/. The documentation is in
Documentation/tools/rtla. It  was requested by Corbet in the v3 [1].

Am I missing something?

[1] https://lore.kernel.org/lkml/87tuhcsu0h.fsf@meer.lwn.net/

-- Daniel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C998F48C348
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352917AbiALLiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:38:09 -0500
Received: from gateway20.websitewelcome.com ([192.185.59.4]:31406 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352904AbiALLiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:38:07 -0500
X-Greylist: delayed 1241 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 06:38:06 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id E90FD4018ED72
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:17:21 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 7bb6nll43INxB7bb6nJrDx; Wed, 12 Jan 2022 05:15:20 -0600
X-Authority-Reason: nr=8
Received: from host-79-47-126-144.retail.telecomitalia.it ([79.47.126.144]:48568 helo=[10.0.0.88])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1n7bb4-001QEl-Su; Wed, 12 Jan 2022 05:15:19 -0600
Message-ID: <5f04540c-273a-c4f2-692d-9de2f1495ba9@kernel.org>
Date:   Wed, 12 Jan 2022 12:15:13 +0100
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
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220111173116.190327559@goodmis.org>
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
X-Exim-ID: 1n7bb4-001QEl-Su
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-47-126-144.retail.telecomitalia.it ([10.0.0.88]) [79.47.126.144]:48568
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven!

On 1/11/22 18:30, Steven Rostedt wrote:
> From: Daniel Bristot de Oliveira <bristot@kernel.org>
> 
> The rtla is a meta-tool that includes a set of commands that aims
> to analyze the real-time properties of Linux. But instead of testing
> Linux as a black box, rtla leverages kernel tracing capabilities to
> provide precise information about the properties and root causes of
> unexpected results.
> 
> rtla --help works and provide information about the available options.
> 
> This is just the "main" and the Makefile, no function yet.
> 
> Link: https://lkml.kernel.org/r/f59acda8bc513c4a6c279a9bc3ad112a20690e68.1638182284.git.bristot@kernel.org

Thanks for picking RTLA!

Just one problem, you are picking the V8, but we actually had a V9:
  https://lore.kernel.org/lkml/cover.1639158831.git.bristot@kernel.org/

-- Daniel

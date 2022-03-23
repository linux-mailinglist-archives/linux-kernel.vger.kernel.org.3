Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5864E59B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbiCWURv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiCWURt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:17:49 -0400
X-Greylist: delayed 1423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 13:16:19 PDT
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDEE89CEE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:16:19 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id E46C478F39
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:52:35 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id X723nmdIGRnrrX723n6m9I; Wed, 23 Mar 2022 14:52:35 -0500
X-Authority-Reason: nr=8
Received: from host-79-43-204-123.retail.telecomitalia.it ([79.43.204.123]:49864 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nX723-0030od-2h; Wed, 23 Mar 2022 14:52:35 -0500
Message-ID: <42ced9a2-f5ee-4793-683b-41c946835336@kernel.org>
Date:   Wed, 23 Mar 2022 20:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] tracing/rtla: Updates to the RTLA tool
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220321103035.564a1df5@gandalf.local.home>
 <CAHk-=whxmA86E=csNv76DuxX_wYsg8mW15oUs3XTabu2Yc80yw@mail.gmail.com>
 <20220323154300.0be32927@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220323154300.0be32927@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.43.204.123
X-Source-L: No
X-Exim-ID: 1nX723-0030od-2h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-43-204-123.retail.telecomitalia.it ([10.0.0.45]) [79.43.204.123]:49864
X-Source-Auth: kernel@bristot.me
X-Email-Count: 8
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

On 3/23/22 20:43, Steven Rostedt wrote:
>> That said, mentioning the perf tools, I wish the tracing tools would
>> do a bit more package checking and helpful error messages too, rather
>> than just fail with
>>
>>     fatal error: tracefs.h: No such file or directory
>>
>> when (presumably) libtracefs and friends are needed.
> Yes exactly.
> 
> Daniel, care to update the Makefile to check for libtracefs and friends and
> give a more informative message when it fails?
> 
> You can look at the trace-cmd Makefile that does so.

Working on that!

-- Daniel

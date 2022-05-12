Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889BA5255F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358171AbiELTpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358086AbiELTpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:45:34 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7990A2469C3;
        Thu, 12 May 2022 12:45:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 89ADE3DFA1D;
        Thu, 12 May 2022 15:45:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sVTNgZs3ae88; Thu, 12 May 2022 15:45:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2AE383DF7BE;
        Thu, 12 May 2022 15:45:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2AE383DF7BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1652384731;
        bh=pQy1aWAQMG7y5qg/kTHDnVubaGptoLGg9ixBjeC+QKU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Z7MbVmWoy9Cjnmg8wdKZbjqRMIqi/6KTxgSjA9JAgkSUYPssHpFrbZmw3WGumgW6q
         ETM85DrBqgVgheYEx28rS/IzsEN0/2xmyRzsvNxRITNhLx0kDYGb8qBrm0GMXfoAHG
         1lZSCWbVdTdIQWmDYknQFfTf6fqEfNU0AsQTL94s2f6II2CuXLNkk85PDyA9IbX3GW
         QbHX6WKRT838v1dHqHdSNldosCg0LnYcv37pDmGY+xD/1xXzD0CgLdCCfrsW2nUMwC
         4Nc5Bsjh7Gq0JPe4wFrVREOuZQHsRidHcwGbaFpKXJeR62fcmQHGq8Sa72bAWfTzDN
         g7wuUJScQVWGg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HYdtroEhjJjF; Thu, 12 May 2022 15:45:31 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1FEB63DF9A0;
        Thu, 12 May 2022 15:45:31 -0400 (EDT)
Date:   Thu, 12 May 2022 15:45:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Primiano Tucci <primiano@google.com>
Message-ID: <680139213.54888.1652384731022.JavaMail.zimbra@efficios.com>
In-Reply-To: <1651771383.54437.1652370439159.JavaMail.zimbra@efficios.com>
References: <1651771383.54437.1652370439159.JavaMail.zimbra@efficios.com>
Subject: Re: Feedback on user-events UAPI
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4257)
Thread-Topic: Feedback on user-events UAPI
Thread-Index: o6f5mOT0knDiVDPdCZsAQKF6xvC6vRQON1is
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 12, 2022, at 11:47 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi Beau,
> 
> I have queued a few questions I would like to discuss with respect to the
> proposed
> user events UAPI. I originally planned to expand further on them, but I now
> think it's
> best if I ask away right now and we clarify things through discussion:
> 
> First, I find it odd that the event enable bitmask and the event ID and payload
> type registration must be combined. I can think of various use-cases where other
> tracers would be interested to use the event-enable bitmask facility without
> polluting the event ID/payload registration data structures with useless data.
> Can those be split into two distinct independent ABIs ?
> 
> I can't help but notice that this new user-space instrumentation
> infrastructure/ABI
> can only be used for tracing user-space through kernel tracers. Considering that
> ABIs dictated by the kernel usually end up being de facto standards, I am
> concerned
> that if it is unable to allow purely user-space tracers to use it, then all
> applications
> will end up being statically instrumented in ways that prevent user-space
> tracers from
> hooking efficiently on the static instrumentation. As I have replied in an
> earlier
> thread, purely user-space tracers are not just marginally faster than kernel
> tracers
> for tracing user-space. They are an order of magnitude faster as soon as all the
> proper
> configuration steps are taken to ensure there are no system calls on the tracer
> fast path. Therefore, it would be sad to effectively dismiss efficient tracer
> implementations for the sake of easiness of implementation of today's user-event
> ABI. This will cause a precedent we will be stuck with later.
> 
> Linux kernel developers involved in implementation of instrumentation within
> Linux
> have spent a lot of effort to make sure the instrumentation is orthogonal to the
> tracing technology (tracepoints, kprobe, kretprobe...). I understand that making
> sure the user-space instrumentation ABI keeps this orthogonal is a lot more
> work,
> but nobody said that exposing ABIs to user-space was easy. ;-)
> 
> The other point I would like to raise is container awareness. I can't help but
> notice that the user events ABI is exposed to trace all containers, with the
> intent
> to be used (consumed) from some privileged namespace (e.g. root pid namespace).
> This works in use-cases where the user of the tracing data controls the entire
> machine (all containers), but not so much if the user is a single tenant within
> a multi-tenants systems. I would expect that a proper namespace-aware facility
> would take care of making sure that a trace consumer could observe what is
> instrumented within its own container, and within nested containers as well.
> The fact that all container questions are entirely dismissed, thus keeping a
> event-enable bitmask registry and event ID/type registry global to the entire
> system, is not compatible with consuming traces from a non-privileged container,
> and I suspect this may also be used as a side-channel to learn information about
> what other containers are doing in a multi-tenant system.

One more thought: I may have simply missed it, but is there any user events code 
which dynamically validates that the input from user-space writev() indeed match the
event description layout ? I'm thinking about wrong size, too short strings, too long
strings, missing null terminator and so on. Any user input that could make the trace
unreadable should never reach the tracing buffers.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

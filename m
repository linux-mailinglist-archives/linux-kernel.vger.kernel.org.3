Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD84E7CF2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiCYTke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiCYTiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:10 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F692706F5;
        Fri, 25 Mar 2022 12:21:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 02BF73F93FE;
        Fri, 25 Mar 2022 15:21:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Di5e2I5kUZyI; Fri, 25 Mar 2022 15:21:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6E1EF3F92E5;
        Fri, 25 Mar 2022 15:21:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6E1EF3F92E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1648236060;
        bh=WR3Gmf/g+LB/7o/or7cSc4Y88IAWlkjH9PpLE8VVLaQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WQ/bewDeVF0QbGYWBAcb47YoEj34JqimRhogL3W5LhkDNBi4q2vuU/6JG8RSKwBKU
         Pj5jQ3Yz06F+XfXlDaR+Dpfwvn+m+WIkea3ma5GAj3bGbTvCPZSEje2pllv+K3okLf
         BqEX9zQcU5wgxehR7SanQ+9qSlWS/L2yV85pBXukEr+UEI8t+qlRw7rl/Ca6wikFhy
         jyQDHeidd9UZM3zX4MAuNZ6kpbr50xViOv4nT/YmSpoI/OZwyw0CLYnBQyMvMaDptT
         U1gzOQSSM7mhK9iPY3bURdO/v/dVscm6j7xECJiuPmCW67wVgN2bbBSMGwNxFJTbkv
         pudVSMJ5BAkqQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SN81cawGgHhn; Fri, 25 Mar 2022 15:21:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 49FFA3F962D;
        Fri, 25 Mar 2022 15:21:00 -0400 (EDT)
Date:   Fri, 25 Mar 2022 15:21:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     lwn <lwn@lwn.net>
Message-ID: <298059821.194836.1648236060140.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-UST 2.13.2 and 2.12.4 (Linux user-space tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Index: /XuRM8m30UNxv1/uEfXFqpcCoOViXw==
Thread-Topic: LTTng-UST 2.13.2 and 2.12.4 (Linux user-space tracer)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a stable release announcement for the LTTng-UST project. LTTng-UST
is a tracer for Linux user-space applications. The respective versions are
2.13.2 and 2.12.4.

The most important change introduced in these releases is the implementation
of a LTTng-UST Log4j 2.x log appender. Note that in the context of
CVE-2021-45046 [2], LTTng-UST per-se is not affected because it does not
use Log4j for its own logging, but rather implements a log appender (a log
"sink").

Here are the noteworthy changes:

In both 2.13.2 and 2.12.4:

* Add a Log4j 2.x Java agent

    Before those releases, LTTng-UST only implemented a Log4j 1.x appender.
    Considering that Log4j 1.x has been unmaintained since 2015 [1], and that
    a range of Log4j 2.x versions are affected by the critical vulnerability
    CVE-2021-45046, allowing Log4j users which use LTTng-UST as a log appender
    to upgrade from Log4j 1.x to an up-to-date 2.x is very much relevant,
    thus explaining why this new feature is introduced in LTTng-UST stable
    releases.

    This adds a new agent to the LTTng-UST Java agents suite supporting the
    Log4j 2.x logging backend.

    This backport differs from the master branch for the
    '--enable-java-agent-all' option won't select this new agent since we
    wanted to avoid introducing a new dependency in existing configurations.

    The name of the new agent jar file is "lttng-ust-agent-log4j2.jar".
    It will be installed in the arch-agnostic "$prefix/share/java" path
    e.g: "/usr/share/java".
    
    It uses the same jni library "liblttng-ust-log4j-jni.so" as the Log4j 1.x agent.
    
    The agent was designed as a mostly drop-in replacement for applications
    upgrading from Log4j 1.x to 2.x. It requires no modification to the
    tracing configuration as it uses the same domain "-l / LOG4J" and the
    loglevels integer representations are converted to the Log4j 1.x values
    (excluding custom loglevels).

* Fix: concurrent exec(2) file descriptor leak

    If exec(2) is executed by the application concurrently with LTTng-UST
    listener threads between the creation of a file descriptor with
    socket(2), recvmsg(2), or pipe(2) and call to fcntl(3) FD_CLOEXEC, those
    file descriptors will stay open after the exec, which is not intended.
    
    As a consequence, shared memory files for ring buffers can stay present
    on the file system for long-running traced processes.

    Rather than fcntl(2) FD_CLOEXEC to make sure the file descriptors are
    closed on exec immediately upon their creation.

Noteworthy specifically in 2.13.2:

* Fix: sample discarded events count before reserve

    Sampling the discarded events count in the buffer_end callback is done
    out of order, and may therefore include increments performed by following
    events (in following packets) if the thread doing the end-of-packet
    event write is preempted for a long time.
    
    Sampling the event discarded counts before reserving space for the last
    event in a packet, and keeping this as part of the private ring buffer
    context, should fix this race.

    This fix is only part of the 2.13 stable branch and not backported to
    2.12 because the lib ring buffer code used to implement this fix did not
    exist in 2.12. Given that the impact of this bug is only imprecision of
    discarded event reporting in corner-case scenarios (small impact, rare
    occurrence), the complexity of implementing this fix in 2.12 is not justified.
    The effect of this issue is that the lttng-tools
    tests/regression/tools/streaming/test_high_throughput_limits test is flaky.

Feedback is welcome!

Thanks,

Mathieu

[1] https://blogs.apache.org/foundation/entry/apache_logging_services_project_announces
[2] https://www.cve.org/CVERecord?id=CVE-2021-45046

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

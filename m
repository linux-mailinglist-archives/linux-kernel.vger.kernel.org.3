Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EACD59A71A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351278AbiHSUjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349461AbiHSUiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:38:55 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B786F69F40;
        Fri, 19 Aug 2022 13:38:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9845D3C0A55;
        Fri, 19 Aug 2022 16:38:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EQnzhJTjtQtC; Fri, 19 Aug 2022 16:38:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E96DD3C0A54;
        Fri, 19 Aug 2022 16:38:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E96DD3C0A54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1660941530;
        bh=zHYXDU3OBJlo2f7kOevIZTmU79fOSY6P6oEc16MdY2E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IQETqVpUlJXgSSXmO9FwnBtLCC+J0RyU0Nb88mRnH70F6jS+Lauin+XOT7mw3tk6T
         NCKkMjN2lA0aH6QPg8NbKQ8NPmah5CIRFO3uihoFQKQlCxMHPBxz25htK/vYsgtDTg
         AKSO6lT8PZRzNp11km8kSmFHRttQUocQoVuZ1cN2ltedJwSjToBLr4OtDIvYIDSWko
         OL8OAX8uWSYfU6J+rfE+jWdhV3EqobiO6GggpdbLbASi62TmrEm4coNjjqHnL6G8Yy
         uTcWU6DjJFC2EEBw1EkGS//Um3Ke5T4ks2iN+bu/ZBk6zbk9n4KMGV7g013U1aKoTJ
         jrio6rQlDyb1Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s-DeMP4_bKJx; Fri, 19 Aug 2022 16:38:50 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DB6DE3C0A53;
        Fri, 19 Aug 2022 16:38:50 -0400 (EDT)
Date:   Fri, 19 Aug 2022 16:38:50 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev <lttng-dev@lists.lttng.org>,
        Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lwn <lwn@lwn.net>
Message-ID: <1557496534.17909.1660941530779.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-ust 2.12.6 and 2.13.4 (Linux user-space tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103 (Linux)/8.8.15_GA_4372)
Thread-Index: BBsWiGWbzxfD3y6w1mw3EXGTI3mZlw==
Thread-Topic: LTTng-ust 2.12.6 and 2.13.4 (Linux user-space tracer)
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

This is a release announcement for the currently maintained stable
branches of the LTTng-UST project. Versions 2.12.6 and 2.13.4 are
now available.

* New in these releases:

In 2.13.4, a compile-time check that disallows using types other
than integer or pointer for tracepoint array and sequence fields
has been removed in C. This is because the check relies on pointer
arithmetic, which does not support opaque pointer types, which was
therefore a regression.

In both 2.12.6 and 2.13.4, the mechanism to get the maximum cpu
number value has been changed to not rely on sysconf(3)
_SC_NPROCESSORS_CONF, but rather use /sys/devices/system/cpu/possible
on Linux. This fixes an issue observed with recent lxc, which
caused scenarios where holes in the configured CPU list causes
the returned value to be lower than the maximum cpu number + 1.

In both 2.12.6 and 2.13.4, the function lttng_ust_ctl_duplicate_ust_object_data
now returns a negative error value, fixing a segmentation fault on error
in lttng-tools.

In both 2.12.6 and 2.13.4, spurious futex wakeups are now handled
correctly. Failure to do so did not cause any user-observable issues
other than using slightly more CPU time than strictly needed, because
this spurious wakeup would only cause an additional connection attempt
to the session daemon to fail.

Feedback is welcome,

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

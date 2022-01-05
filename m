Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5BD485A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbiAEUjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:39:42 -0500
Received: from mail.efficios.com ([167.114.26.124]:33246 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbiAEUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:39:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 83B673C9809;
        Wed,  5 Jan 2022 15:39:38 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FbqI1sBWzjtz; Wed,  5 Jan 2022 15:39:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CFFA13C95C0;
        Wed,  5 Jan 2022 15:39:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CFFA13C95C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641415177;
        bh=utAt7L+QSW4ZeE1CsZsobUlkZJDy5lBZN/Y6L3fUl9k=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NfwlNLhGUzsEsZ/Te9HaSZuVfLina0WqSK+ZyjcRSIeF7ybDFlImwtNJyPvh2YVnF
         W4GSmRcMSfUzzhRHJfTfxDnD6PzVEUUBxoVXPHbFsvKqLxF1G+3akBWBXwUrTzjmEl
         awkAvXhdwy7FdlZk2lvrp1lJRlkv9EWL7Z7SmCAqsvRomngd1oXGbVgbfBvIaokD8y
         KYY0/cihQKt2FnLBX/6hWd/dB2sKi24GWnOsntx/pwfgfQ9XCX3Bbjf8G/R7A+vba2
         B5qX6pvpEoB9IRAiXixJcY1IgS1IpFrpxplx3I5ODps/8MuumkZkyo9/VtpdeI8u/C
         Md5kRE7GUVNMw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mt3U6jItNVuz; Wed,  5 Jan 2022 15:39:37 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BFE7F3C9374;
        Wed,  5 Jan 2022 15:39:37 -0500 (EST)
Date:   Wed, 5 Jan 2022 15:39:37 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        lttng-dev <lttng-dev@lists.lttng.org>, rp <rp@svcs.cs.pdx.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <1604976069.5148.1641415177661.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] Userspace RCU 0.11.4, 0.12.3 and 0.13.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF95 (Linux)/8.8.15_GA_4177)
Thread-Index: hFOmTmvfinaOxKagaO3L6KLVzo7LIA==
Thread-Topic: Userspace RCU 0.11.4, 0.12.3 and 0.13.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a release announcement for the currently maintained stable
branches of the Userspace RCU library. Please note that 0.11.4 is
the last release of the 0.11 stable branch, which is reaching end
of life. Users facing issues with the 0.11 stable branch are expected
to upgrade to 0.12.3 or 0.13.1.

The content of those bug fix releases is fairly straightforward,
and the change log small enough to be shown in this release
announcement (see below).

Feedback is as always welcome!

Thanks,

Mathieu

Project website: https://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

Changelog:

2022-01-05 Userspace RCU 0.13.1
        * fix: properly detect 'cmpxchg' on x86-32
        * fix: use urcu-tls compat with c++ compiler
        * fix: remove autoconf features default value in help message
        * fix: add missing pkgconfig file for memb flavour lib
        * Make temporary variable in _rcu_dereference non-const
        * Fix: x86 and s390: uatomic __hp() macro C++ support
        * Fix: x86 and s390: uatomic __hp() macro clang support
        * Fix: x86 and s390 uatomic: __hp() macro warning with gcc 11
        * Fix: changelog: v0.13.0 was released in 2021

2022-01-05 Userspace RCU 0.12.3
        * fix: use urcu-tls compat with c++ compiler
        * fix: add missing pkgconfig file for memb flavour lib
        * Make temporary variable in _rcu_dereference non-const
        * Fix: x86 and s390: uatomic __hp() macro C++ support
        * Fix: x86 and s390: uatomic __hp() macro clang support
        * Fix: x86 and s390 uatomic: __hp() macro warning with gcc 11
        * Document known ABI issue in README.md
        * fix: clock_gettime on macOs
        * Fix: rculist header: use parenthesis around macro parameters
        * Fix: rcuhlist header: use parenthesis around macro parameters
        * Fix: hlist header: use parenthesis around macro parameters
        * Fix: list.h: use parenthesis around macro parameters, caa_container_of()
        * Fix: hlist iteration relies on undefined behavior
        * Fix: use __atomic_load() rather than atomic load explicit
        * Fix: use atomic load memory_order_consume for rcu_dereference on C11/C++11
        * fix: warnings on non-Linux platforms
        * fix: HAVE_SCHED_SETAFFINITY is not defined
        * Add git review config to stable branch
        * fix: include 'sys/endian.h' on FreeBSD
        * cleanup: explicitly mark unused parameters (-Wunused-parameter)
        * fix: shadowed local variable (-Wshadow)
        * cleanup: all functions have declarations (-Wmissing-prototypes)
        * Import libtap from babeltrace

2022-01-05 Userspace RCU 0.11.4
        * fix: add missing pkgconfig file for memb flavour lib
        * Make temporary variable in _rcu_dereference non-const
        * Fix: x86 and s390: uatomic __hp() macro C++ support
        * Fix: x86 and s390: uatomic __hp() macro clang support
        * Fix: x86 and s390 uatomic: __hp() macro warning with gcc 11
        * Document known ABI issue in README.md
        * fix: clock_gettime on macOs
        * Fix: rculist header: use parenthesis around macro parameters
        * Fix: rcuhlist header: use parenthesis around macro parameters
        * Fix: hlist header: use parenthesis around macro parameters
        * Fix: list.h: use parenthesis around macro parameters, caa_container_of()
        * Fix: hlist iteration relies on undefined behavior
        * Fix: use __atomic_load() rather than atomic load explicit
        * Fix: use atomic load memory_order_consume for rcu_dereference on C11/C++11
        * Fix: gitreview defaultbranch should be stable-0.11
        * fix: warnings on non-Linux platforms
        * fix: HAVE_SCHED_SETAFFINITY is not defined
        * Add git review config to stable branch
        * fix: include 'sys/endian.h' on FreeBSD
        * cleanup: explicitly mark unused parameters (-Wunused-parameter)
        * fix: shadowed local variable (-Wshadow)
        * cleanup: all functions have declarations (-Wmissing-prototypes)
        * Import libtap from babeltrace

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

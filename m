Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196624858F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbiAETMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:12:20 -0500
Received: from mail.efficios.com ([167.114.26.124]:60148 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbiAETL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:11:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8DDE33C8B56;
        Wed,  5 Jan 2022 14:11:57 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9oNEJfGvcF-Y; Wed,  5 Jan 2022 14:11:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 13C5E3C887C;
        Wed,  5 Jan 2022 14:11:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 13C5E3C887C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641409917;
        bh=lxXU7MkbOVO9jDbLz5VrWqQwIoBMKaSskabZ9LfVyz4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HGx2mZL0xmxdCpgOi2I84umS01L70+DBdRfti++nlE15nF9XlrLbtiYWhq5sjeSi5
         fgoFgngGAB6ZtMRDaxA6iDgiDGHCSHv7zH3hrUpx0Hjc5TvkMyU45v40SU1Hu22oFS
         JcGxGYqNA9ea1yzFiEmhczB2riRIRQAgVohjCfE0MM3mtIn99XAip5NYE5f82IRbAt
         X1p2vJK68mgBrV+CdIhUL/5yWRlPjrlNvAB510ysU9gNXqoKJkqxKI+KuIeFOQXYtQ
         6FJlNHh8KxSE4XSTlJf6MQf7s6/a7DwGs08o3bakh5OtfKxrVPPYJpDww/myimHvhA
         qh8ecxATGAr+w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 93rxNQm326DQ; Wed,  5 Jan 2022 14:11:57 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 08E483C8AE4;
        Wed,  5 Jan 2022 14:11:57 -0500 (EST)
Date:   Wed, 5 Jan 2022 14:11:56 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1275248080.2857.1641409916909.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.12.7 and 2.13.1 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF95 (Linux)/8.8.15_GA_4177)
Thread-Index: 7cLqhylIvorgVNK6xQZrdmHTvto22w==
Thread-Topic: LTTng-modules 2.12.7 and 2.13.1 (Linux kernel tracer)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a release announcement for the LTTng Linux kernel tracer 2.12.7 and
2.13.1 releases. Both are bug fix releases in the lttng-modules stable branches.
They also enable support for the most recent Linux kernel releases.

LTTng-modules 2.12.7 contains instrumentation fixes for the 5.14, 5.15 and
5.16-rc Linux kernels. Kernel version ranges were adjusted for instrumentation
of the RHEL 8.4 kernel.

LTTng-modules 2.13.1 fixes scenarios where trigger actions are missing:

    There is an issue when associating multiple actions to a single system
    call, where the first action is effectively added, but the following
    actions are silently ignored.

The affected on-event trigger is a feature newly introduced in 2.13.

This 2.13.1 release also contains instrumentation fixes for the 5.15 and 5.16-rc
Linux kernels. It now emits a warning in the kernel console whenever registration
of events internally fails within LTTng-modules, for example in case of
out-of-memory error.

As always, feedback is welcome!

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

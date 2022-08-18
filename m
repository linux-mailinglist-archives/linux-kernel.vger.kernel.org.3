Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D189598D82
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbiHRUM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345902AbiHRUME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:12:04 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E818AD2EB7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:07:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C994A397075;
        Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gsVIAdTyPiF4; Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3C466397074;
        Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3C466397074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1660853254;
        bh=SkZgC0RsN7P2tBsmQlIQmAIwtS4a7HORxyttVgTFO/A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nxwd5oaSIs2ve2F2VZlRFptFl+Z7R/VEpslfn5tF1WUT0HNYsRhh6d/dW+guBhE7D
         O+FXv68je/ptwbOWJ1Fgh4oIjzUjwXSC92b+h9OVszY0hdM72/sWJr9KYvkwfPmHNl
         dU5/7nIPkzJd2U1dcHEzVR6czu2C8HSsAsjw1RL2lZwEtdtDgSvpXQg9RWyOssCArn
         Ik/Tza17hDfylF8t8y6XDNu7ntDtw0HQRaMUh0QEa/BpP0TKfYW5s/JNu6WmrxGfoZ
         F7XuyuD7EsOeqBcSzWqyDcYw8KKMoRSohqwIkrWa0E0H07Sm1AWz8UnBEriM+3PnH9
         GtwTzX6OQdtTQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fyzT_UDvwwWd; Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2EEC3397694;
        Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
Date:   Thu, 18 Aug 2022 16:07:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        lttng-dev <lttng-dev@lists.lttng.org>, rp <rp@svcs.cs.pdx.edu>
Cc:     paulmck <paulmck@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>, lwn <lwn@lwn.net>
Message-ID: <1089391319.15796.1660853254177.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] Userspace RCU 0.12.4 and 0.13.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103 (Linux)/8.8.15_GA_4372)
Thread-Index: bwIKiKBCPmydWVq5CpBZdRA1UQ0RxA==
Thread-Topic: Userspace RCU 0.12.4 and 0.13.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ re-sending without html headers. My email client managed to add those without me realizing it. ]

Hi,

This is stable release announcement for the Userspace RCU project.
It covers the two currently maintained stable branches: 0.12 and 0.13,
respectively with releases v0.12.4 and v0.13.2.

Especially for the spurious futex wakeup fix, users of the 0.12 and 0.13 (or older)
liburcu branches are recommended to upgrade.

* Noteworthy in these releases:

- Handle spurious futex wakeups in urcu-qsbr, urcu, urcu-wait, defer_rcu, call_rcu,
  and workqueue code. This has been known to cause issues where the workqueue
  worker thread spuriously takes nearly 100% of CPU time.

- Change method used by _rcu_dereference ot strip type constness.
  Rather than using pointer arithmetic (which does not work with opaque types),
  rely on a statement expression trick.

- Fix support for Linux systems where sysconf(_SC_NPROCESSORS_CONF) can
  return a value less than max cpu id.

Project website: https://liburcu.org

Feedback is welcome!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

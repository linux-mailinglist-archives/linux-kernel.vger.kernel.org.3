Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6BE53D25F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349309AbiFCTaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbiFCTan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:30:43 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F78159BBA;
        Fri,  3 Jun 2022 12:30:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D56CA3FD55B;
        Fri,  3 Jun 2022 15:30:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PoAEU5B-W_Nf; Fri,  3 Jun 2022 15:30:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 56F813FD2E8;
        Fri,  3 Jun 2022 15:30:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 56F813FD2E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1654284635;
        bh=f56zKEv6Nh3cphP2EsdkVgMEWZOWaZE4zDAQFr2H9Qs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=vFAGmtmgVTf/yuynbZKkUFMRNW/uJyOVJqkg/bEX1v+fmPO6c6nz+RnRjbiMG0MRG
         lMI5cWVsQNHKa3fYuL4g8R/CL1gtDnTYDUpBSZl+W/hsBAJMHlKsWcPbnEbe6vgEYK
         Vc0s6yDzyVVtgVrNktJ4ql4mhJFhj/DQj7xGa4P6TQjj9jZt5odsVmDXaaLRV65aSx
         aX7U+/zQkF3nqalzvrP6bikr+pp+EW6Y7pWS73MvpP4uRkvyB8U8ekug85E8/OVu6V
         LI1S7BVCWktSJFgm9HCvsU0h2YxAFl4dhnX5w8XOeESs/MqSXOyWO4kEmNeMlhOM+z
         +iixtNM3AUV5g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y1CIPhIGFxiu; Fri,  3 Jun 2022 15:30:35 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4BE963FD619;
        Fri,  3 Jun 2022 15:30:35 -0400 (EDT)
Date:   Fri, 3 Jun 2022 15:30:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev <lttng-dev@lists.lttng.org>,
        Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <846400291.20840.1654284635213.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.13.4 and 2.12.9 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4257)
Thread-Index: DHrGG1JJg8YJlaBmRz8CT/+mTxeC+w==
Thread-Topic: LTTng-modules 2.13.4 and 2.12.9 (Linux kernel tracer)
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

The 2.13.4 and 2.12.9 releases are bug fix releases for the currently
maintained LTTng-modules stable branches.

Noteworthy in the 2.12.9 release:

The README.md file now document that the stable-2.12 branch of
LTTng-modules supports Linux kernels between 3.0 and 5.17 (inclusive).
Support for the 5.18 kernel is provided starting from the stable-2.13
branch of LTTng-modules. Also, tracepoint instrumentation was adapted
to follow changes to upstream kernels: the "random" tracepoint
subsystem was removed from 5.18, and this removal was backported to
stable kernels as well. Finally, a compaction subsystem instrumentation
name-spacing fix is included.

Noteworthy in the 2.13.4 release: 

The same instrumentation fixes as 2.12.4 were integrated, affecting the
compaction and random subsystems. Changes to tracepoint instrumentation
were done to support the 5.18 Linux kernel, affecting the block, compaction,
sched, scsi, and kvm subsystems. The kprobes instrumentation was adapted
to use the rethooks if possible (needed for 5.18).

Now that the kvm subsystem unexports the kvm_x86_ops symbols in 5.18,
lttng-modules relies on kallsyms to use this symbol.

Finally, two changes are really more in the "bug fix" category rather than
adapting to newer kernels: the bytecode interpreter in lttng-modules left the
context fields byte order uninitialized, thus leading to bogus context field
values in the event notification capture feature. Fix this by initializing
the byte order. A hard-to-trigger race is also fixed in the event notifier
use of the ring buffer.

Changelog:

2022-06-03 (National Repeat Day) (National Repeat Day) LTTng modules 2.13.4
        * Fix: event notifier: racy use of last subbuffer record
        * Fix: bytecode interpreter context_get_index() leaves byte order uninitialized
        * fix: 'random' tracepoints removed in stable kernels
        * fix: random: remove unused tracepoints (v5.10, v5.15)
        * fix: sched/tracing: Append prev_state to tp args instead (v5.18)
        * fix: mm: compaction: cleanup the compaction trace events (v5.18)
        * fix: scsi: core: Remove <scsi/scsi_request.h> (v5.18)
        * fix: kprobes: Use rethook for kretprobe if possible (v5.18)
        * fix: random: remove unused tracepoints (v5.18)
        * fix: scsi: block: Remove REQ_OP_WRITE_SAME support (v5.18)
        * fix: block: remove genhd.h (v5.18)
        * fix: sched/tracing: Don't re-read p->state when emitting sched_switch event (v5.18)
        * fix: KVM: x86: Unexport kvm_x86_ops (v5.18)
        * Fix: do not warn on unknown counter ioctl
        * Fix: tracepoint event: allow same provider and event name
        * Fix: compaction migratepages event name

2022-06-03 (National Repeat Day) (National Repeat Day) LTTng modules 2.12.9
        * fix: 'random' tracepoints removed in stable kernels
        * fix: random: remove unused tracepoints (v5.10, v5.15)
        * fix: random: remove unused tracepoints (v5.18)
        * Document supported kernel versions for stable-2.12 branch
        * Fix: include erroneously removed by backport
        * Fix: tracepoint event: allow same provider and event name
        * Fix: compaction migratepages event name

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

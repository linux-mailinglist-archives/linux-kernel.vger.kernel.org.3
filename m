Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6754B77B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbiFNRSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbiFNRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:18:52 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647172AC66
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:18:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 76508400C1F;
        Tue, 14 Jun 2022 13:18:50 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AJVlPABmggB2; Tue, 14 Jun 2022 13:18:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BEC7F4005FA;
        Tue, 14 Jun 2022 13:18:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BEC7F4005FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1655227129;
        bh=TwOb5ojeSJ+VgbFyhjgDgfy81dWqmovTQ/a0GTTMmX8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=SYd0NkktM4WFSD/HKIZFJzuQqPgyp6swn41U8ZmuAdkAi3HkKXZUGFwXzoJlTDIm3
         Q3YsYfBfODusX/qdDNYDaojQ0ZcbqX2Iur6r8wS7fqWarbFTnYfeMQv+3Rrzr8rOjW
         7e3tIsw68aRkzWemjzO+Fh5v+lx0jg5D2SLWni+TamrtSnjTDPdGt7+YH0THFq80qU
         29gyOih1C1ohZk5x0YuYz0++9y4G0kZKlYx79N/6IHWdWTR4BRwfRVpumvy1fS2z3A
         7HQrSYAW4rXRhng/dhFR1uUnaKwZ1GjQ7JwbmV+v2uvOzxya6Zxl3FZ/bz9QzZeeWs
         XDXtSBDZ6ntQQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k2zvfGIivrK1; Tue, 14 Jun 2022 13:18:49 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B0DAB40077A;
        Tue, 14 Jun 2022 13:18:49 -0400 (EDT)
Date:   Tue, 14 Jun 2022 13:18:49 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Michael Jeanson <mjeanson@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Message-ID: <581392317.60476.1655227129623.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220614154830.1367382-1-mjeanson@efficios.com>
References: <20220614154830.1367382-1-mjeanson@efficios.com>
Subject: Re: [PATCH 0/3] selftests/rseq: fixes for RISC-V and Glibc 2.35
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4257)
Thread-Topic: selftests/rseq: fixes for RISC-V and Glibc 2.35
Thread-Index: tWfOWsblzTKx9asw8dZkMp8iDEA/BQ==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 14, 2022, at 11:48 AM, Michael Jeanson mjeanson@efficios.com wrote:

> The patch series allows running the rseq selftests on a Glibc 2.35
> system which has rseq support but no RSEQ_SIG defined for the RISC-V
> architecture.
> 
> The patches were tested on both Glibc 2.33 and 2.35.

For the whole series:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Peter, can you pick them up through your tree ?

Thanks,

Mathieu

> 
> Michael Jeanson (3):
>  selftests/rseq: riscv: use rseq_get_abi() helper
>  selftests/rseq: riscv: fix 'literal-suffix' warning
>  selftests/rseq: check if libc rseq support is registered
> 
> tools/testing/selftests/rseq/rseq-riscv.h | 50 +++++++++++------------
> tools/testing/selftests/rseq/rseq.c       |  3 +-
> 2 files changed, 27 insertions(+), 26 deletions(-)
> 
> --
> 2.34.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

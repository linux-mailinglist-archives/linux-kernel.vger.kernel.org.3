Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C44A5AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiBALIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiBALIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:08:44 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A586C061714;
        Tue,  1 Feb 2022 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YCTgMx/TPthTFsdnu0CFJGBXo2QGXtQUU49o6KmcOuA=; b=BxSsmVmilzxI3s3ZiFlye0yLbS
        5e+AX/exrACsktV3l10fpBEW+GN4ql9mWtTkmLx6RfCS6bt6zgfQ0ZZGxWmDYDZ4wPaqndT4hjEd0
        mEkFGeDKEaR1ocA48gjLfldqlV/gu0/SVHSwjXSLARrK0wUwK78lVUDgcoM3CklSrYxb4LoNC9d6t
        UlvSPXicSenDsdUeUXUblwnY695mcxBDaBSbPM0meJeMCGuiqVppac1T8YJiFoTOJ4ObAjQa1Ry1f
        xjbc0Dbd8d9Ut1HUxhzz8IRxo1KW0ib0e3kqHnpXI4/gP69qfgtUfKUMSnJJpLrqK7/TmRPhyr09X
        YozHqIyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEr1K-005poe-Dg; Tue, 01 Feb 2022 11:08:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3319098623E; Tue,  1 Feb 2022 12:08:21 +0100 (CET)
Date:   Tue, 1 Feb 2022 12:08:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>
Subject: Re: [RFC PATCH 1/2] rseq: extend struct rseq with numa node id
Message-ID: <20220201110821.GV20638@worktop.programming.kicks-ass.net>
References: <20220131205531.17873-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131205531.17873-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 03:55:30PM -0500, Mathieu Desnoyers wrote:

> It is also useful for implementing NUMA-aware user-space mutexes.

That really wants a futex extention..

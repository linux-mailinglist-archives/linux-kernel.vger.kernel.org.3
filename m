Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1487B4A5AE7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiBALJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiBALJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:09:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A79C061714;
        Tue,  1 Feb 2022 03:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uWNduFOJS9OuZWczQEXrGKDHDs4uBUffkCKAXba6Lec=; b=HpiUGtdb3gl9D6C/Xq6aStoCko
        EBNZjmFnDre9pAVhPz4/wL3ZDOzKVZcFuK6VA/Kgj79U8ib0yecC/JQfJ/cEJzQ3IghyA8efrQ6rt
        03ken04y+f7PljPrSkLifkKP5GUSGkp7QqfPg6e/DU+LNwpWwh/KkXebvHyabDFzv3xnJR8C8O6Wb
        81KIkrSHHyW40SSzKhAM6hra5pGQKdNEPaOztvRic/XwqLS0dYHIfVhYxFGn2OR6jTTUWthpYzmdX
        VcUGkTSkFerIPNkfS0mNwffPeTyn9nrkTQFQYxcwUXnK1CH5I+LC3MZtfzd+D3mK8v833OPzXKwgo
        R184w5yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEr1p-005ppW-CK; Tue, 01 Feb 2022 11:08:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECBB498623E; Tue,  1 Feb 2022 12:08:52 +0100 (CET)
Date:   Tue, 1 Feb 2022 12:08:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [RFC PATCH 1/2] rseq: extend struct rseq with numa node id
Message-ID: <20220201110852.GW20638@worktop.programming.kicks-ass.net>
References: <20220131205531.17873-1-mathieu.desnoyers@efficios.com>
 <8735l3k3hu.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735l3k3hu.fsf@mid.deneb.enyo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:19:09PM +0100, Florian Weimer wrote:
> It can be used to implement getcpu purely in userspace, too.  I had
> plan to hack this together with a node ID cache in TLS, which should
> offer pretty much the same functionality (except for weird CPU
> topology changes which alter the node ID of a previously used CPU).

PowerPC does that quite a lot..

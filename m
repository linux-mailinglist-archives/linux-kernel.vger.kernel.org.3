Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793EB497A09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiAXINA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiAXIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:12:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C73C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sKMCQ5uWLExiHu2Qqs6Y0bEwq688b7sYBxzar7EPcKA=; b=rBN/ylsX065uvYUd/ybDMismM6
        w9RLUxodQVBLiM4QKUrb1ekdabWMiXXtuDyuw4UrNH/R6FwBEouGlEr5TTZkQkKuUw9gAWCQqsdaC
        0I5Ljb1va4Yqz+Cr0aSbsnCLJhWZNzxnkbSRGGSXh9+ScPPr+TumQkuGEZ/VL7W84+X+EiR7yRnZD
        jj1IHpfyxK7bkaEwo+ZZebSzmGq3m8V7UbN5Qh5WtMz1UPnUAYlHH612ghx1rtf51SRxgxNI9aXwZ
        yh6m327PG9YThDTV79d0J0o2svV+QdToG1M3HJAKJ84PK3/R33BMfqIOIVHHX1pPPNLtEczieBAoG
        8sgXrRpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBuSs-00379n-Qi; Mon, 24 Jan 2022 08:12:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A00B98624A; Mon, 24 Jan 2022 09:12:38 +0100 (CET)
Date:   Mon, 24 Jan 2022 09:12:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chun-Hung Tseng <henrybear327@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian@brauner.io,
        linux-kernel@vger.kernel.org,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [PATCH] sched: Simplify __sched_init runtime checks
Message-ID: <20220124081238.GL20638@worktop.programming.kicks-ass.net>
References: <20220122162618.25432-1-henrybear327@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122162618.25432-1-henrybear327@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 05:26:18PM +0100, Chun-Hung Tseng wrote:
> Improve runtime checks in __sched_init(void) by replacing if conditional
> checks with preprocessor directives.
> 
> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
> Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>

This is not a valid SoB chain.

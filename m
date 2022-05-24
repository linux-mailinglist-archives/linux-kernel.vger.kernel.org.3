Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CA53287C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiEXLE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiEXLEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:04:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAF490CD4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y1TaiNqe+4oUo0hKcDCeioatpdaui+xyqgx5U5jgeMM=; b=UUhcPlM9X8LaJJQawZ8QATtHPP
        sKmKYGtTaEDLG9C6BXdXkzwOwEDtwzaJ7k1XjqeBPGjo/cuwJj9MtzxyXMeCce/BReaxy4t1EARnE
        dyE17dEVQdqAaus/hBv2a6skb2cza368zOxDoxko4/ux7bY+AMUTTMWUSBvqsicJWoq+q39V6ihp7
        MC5miQGdgo/sGE2OU0G/npntpuUACCUrEacD/NQ9AlXQVOX1iz3qnxvamfqB6lyBEYI89/2YM23L2
        3xkIICaaGfFyJr+l/IFtr6/uDbzmhaC1PU59aG9xkoixJRt6O4VU00ROZxmhbZNdq58+1RnRcoeD+
        8F0XY5iA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntSKY-001Ji0-PC; Tue, 24 May 2022 11:04:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EF7730003C;
        Tue, 24 May 2022 13:04:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2DDE203DC9F0; Tue, 24 May 2022 13:04:01 +0200 (CEST)
Date:   Tue, 24 May 2022 13:04:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, shan.gavin@gmail.com,
        zhenyzha@redhat.com
Subject: Re: [PATCH] sched/topology: Fix typo in build_sched_domain()
Message-ID: <Yoy7oUJeeNnMaxfO@hirez.programming.kicks-ass.net>
References: <20220524080733.1362818-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524080733.1362818-1-gshan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 04:07:33PM +0800, Gavin Shan wrote:
> In build_sched_domain(), it seems that "borken" is misspelled. To
> correct it with "broken".

I hereby award you the 'I cannot google' award.

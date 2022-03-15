Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A843C4D995E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347559AbiCOKud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348707AbiCOKtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:49:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF6275DC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bzjITRLip76YCCbU9LHjuc8S4NeB67qbdOXzTfdXcto=; b=Cxx6XNEYTxhqe4+MqJsYyCeMk0
        FroCDWr4W7byDJSLf+2svEmBPf/wTYIWBX+aOQgdiY4dOm0Kbe/Yjn54vj3/3wpA1KoECbZB7sUkl
        RVSlVrSaH/FdDQ5ZRcGlXuxTuCnC1IZ6qQyofWa3q6rkHMXiryqzJGer8W9Zwl+GZYGmHdpc+2fDT
        PSZJMFvHeDBWshJ3kcb3CK1nqetYp+2bCyPhKGsgqXdQBKR3JiytaRppRSYdzhzdij/v5h3HXlTzd
        74uDZaER6Wlymb3bgZ/X/VRtF3rfT8ixfIu83jzrjy1UsFhjStz/bEWmZ5BuSd+wznOL1uCsuypTQ
        EOGc0WvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU4ix-004x0x-Q0; Tue, 15 Mar 2022 10:48:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C38C298620D; Tue, 15 Mar 2022 11:48:17 +0100 (CET)
Date:   Tue, 15 Mar 2022 11:48:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/3] preempt/dynamic: Introduce preempt mode accessors
Message-ID: <20220315104817.GE8939@worktop.programming.kicks-ass.net>
References: <20220314133738.269522-1-frederic@kernel.org>
 <20220314133738.269522-3-frederic@kernel.org>
 <CANpmjNPqY65ZYLFukgp779pHbiRH05yns+G7Z36QdWwrQp1WOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPqY65ZYLFukgp779pHbiRH05yns+G7Z36QdWwrQp1WOQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 03:44:39PM +0100, Marco Elver wrote:
> https://lore.kernel.org/lkml/20211112185203.280040-3-valentin.schneider@arm.com/
> 
> Is it also possible to take all the rest of that series (all 4
> patches) from Valentin?

I'll go stick the remaining 3 patches from Valentin in sched/core, they
seem to still apply without issue.

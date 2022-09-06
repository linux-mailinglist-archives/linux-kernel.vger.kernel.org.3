Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE95AE40B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbiIFJWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiIFJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:22:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7A76525F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sno9aA/zPoVA7LeyDSwFFvhyaBShZyj6BYGGwsUCYEc=; b=La+9j0zpOe6qKGU5pJGLwN85Ka
        558S74deuVPU2FByhxqJCtvdcrXWFZPf6VdAWpEdrCGYHgUKT71zFx2Qd4aVoKJWk4a4dHnLzH2i5
        1ZxPzC8e91N7TeARBp3tSF/rWxYoj5DbNQlTUe7khklk4PAljt7G9o6gDac7XoacnAV7JjWUtl6DC
        5au7T4WScHW6Z948s7Sf7CokFECVYppdatdpR0TvkRz8PL7D36T5/gLIA0OeVaD3rXUG8fvtFsQEj
        1tUFU+cLaQeQxn6c15AVGcXKlADsdnVmEHKa11LF00dkNktr4gBd0LNnMb0+/qYgabBHZR7lN843J
        uYS6YV2Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVUmv-00AGV6-J2; Tue, 06 Sep 2022 09:22:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73DEE300023;
        Tue,  6 Sep 2022 11:22:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D0C9209D3CB0; Tue,  6 Sep 2022 11:22:31 +0200 (CEST)
Date:   Tue, 6 Sep 2022 11:22:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     lizhe <sensor1010@163.com>
Cc:     tglx@linutronix.de, tony.lock@intel.com, hdegoede@redhat.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kernel/stop_matche.c : remove redundant global variable
 initialization
Message-ID: <YxcRVyAq1p/SqypZ@hirez.programming.kicks-ass.net>
References: <25ea6dc9.5fc6.18312145202.Coremail.sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ea6dc9.5fc6.18312145202.Coremail.sensor1010@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 05:14:25PM +0800, lizhe wrote:
> HI : 
>    I failed to submit using git, so I sent it directly by email

I think you need to read the documentation on how to use a MUA again.

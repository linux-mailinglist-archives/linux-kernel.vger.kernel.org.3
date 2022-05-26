Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE9534EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbiEZLzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiEZLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:54:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758CED02A2;
        Thu, 26 May 2022 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/KKs81xaGG0Zeb96rlyhXltBDwH/3Jx5aR0YVFFHJhc=; b=OjBu8kO/+Ur9j0C3iPCwNEkmOR
        xWvrRIRZmqg5F1WmoJ0fCUbDgX0KRpp9dn/pr+HIZbqAJZzopTY6mYKUHN+xM5rsfx36/C7FQKG6W
        p2U7WMUHXWBBzkOeSVBEHucsAC4XjFVggV7qEiYiT+WCluEaATDzcKLErgeWS6B+/HogHYIjwCdrX
        C1OwZd2ZBoAeB9O2ixKrg3xIncMiY4IA4ADqXeGrkIBKLg3pyUczl1/O1RGXltmWCjon0DEQZdOlH
        NaSLqT83+G1Wdt0AJTOt6F0S4r4j26WgVWygV6fZznEozhW1C0RPoFuWvv0vkpgigQGbPHkuJ/vj9
        r1Jk8Nog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuC4m-001DZc-Kt; Thu, 26 May 2022 11:54:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64411981124; Thu, 26 May 2022 13:54:46 +0200 (CEST)
Date:   Thu, 26 May 2022 13:54:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Jan Hubicka <jh@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: objtool warning, branch, patch, and .config (GCC bug)
Message-ID: <20220526115446.GR2578@worktop.programming.kicks-ass.net>
References: <20220525173332.GA4008581@paulmck-ThinkPad-P17-Gen-1>
 <20220525173444.GA4010526@paulmck-ThinkPad-P17-Gen-1>
 <20220526080313.GM2578@worktop.programming.kicks-ass.net>
 <20220526080849.GF6479@worktop.programming.kicks-ass.net>
 <Yo9CCoEF7nOd6lQI@tucnak>
 <20220526094124.GN2578@worktop.programming.kicks-ass.net>
 <Yo9lQxpj9U+fQTKH@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo9lQxpj9U+fQTKH@tucnak>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 01:32:19PM +0200, Jakub Jelinek wrote:

> Filed https://gcc.gnu.org/PR105739 for this, the replacement
> happens during inlining, so I've CCed Honza Hubicka who knows
> that code best.

Thanks!

> It is unlikely anything can be done about this for GCC 9,
> because the final GCC 9.5 release is to be released tomorrow,
> there is no chance of getting it fixed by then, especially
> when it doesn't look like a recent regression.

Yeah, that's unfortunate timing, nothing to be done about that though.

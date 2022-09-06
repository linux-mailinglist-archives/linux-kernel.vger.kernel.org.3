Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2340C5AF59C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiIFUQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiIFUPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:15:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E7BD174;
        Tue,  6 Sep 2022 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8YFmxfjt7ME/Y6ky/Dfq1n4MGr8bFmKz3xmylsBVObM=; b=thFW1nRsJ8JcarMlnwnqTbcZWJ
        9tvBnOOPi23154IXiKf9qrKsx2kVo7T1BOtdeWnWpkvWgh+Qe/OVJrqwnNeTnTz5pgzKbPXGH5DDz
        fpvZs2OPwnuLMjUcOvjCvcjEXscBQ9eCe8DSErVypqUOz01SQwHoA4FOYMCtsw+mKPilr397Kn5cj
        rIwwCk4766uP6puII+VmkwNL8iSAI5BJYJTISm4JzmiPYl9+KTICRFTdXTHeAWBBAFRwEVthKMSOs
        LOW+J4oatCPRW2VHacVOttfOKu08ZnHlepMv9LmNw+Oa8BeDQPQ2q+H2YsQ892AmrGDQcl7lGfxNy
        DdD+AYVw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVeuj-00Aj5k-9G; Tue, 06 Sep 2022 20:11:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 818283006A4;
        Tue,  6 Sep 2022 22:11:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69A2D2B6563B9; Tue,  6 Sep 2022 22:11:14 +0200 (CEST)
Date:   Tue, 6 Sep 2022 22:11:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: use objtool-args-y to clean up objtool arguments
Message-ID: <YxepYgOsLXYNgNW2@hirez.programming.kicks-ass.net>
References: <20220902130846.654526-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902130846.654526-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:08:45PM +0900, Masahiro Yamada wrote:
> Based on Linus' patch.
> 
> Link: https://lore.kernel.org/lkml/CAHk-=wgjTMQgiKzBZTmb=uWGDEQxDdyF1+qxBkODYciuNsmwnw@mail.gmail.com/
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Ack on the version that works ;-)

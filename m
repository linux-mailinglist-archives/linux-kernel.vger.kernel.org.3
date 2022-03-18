Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5B4DD8B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiCRLI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiCRLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:08:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FAF3A56
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BHBH8G96Ps/oE0eH+Ie+X9ErNpzL4QXTbqriBTJrVKk=; b=njRAng050Xf1a5ONze/STK/SHg
        sBeENvKFl8UJ1F41CkMLNVd/9Ulf8dx5qDHhrjm83cADTQOzfF4tXgy0tIlM1aTvL3jBKOpPGGdVw
        wlV+lOvT8b0XQQ1nySM+Id7xg04PqdrUkUNhh1Bg2X6nzGPZvx7g64pn15JIExYdCqx4N+VynX4/X
        r+mrOMSZSeGOIsMNoWs6mpR0e/btLuTJgEclO82x8MfXIRIJHSii6S9iJJLUKgexQnaO7gAVXnO8h
        sritbc4HJxox1TQNApPytg/TT83xu7iAtqyrVEDaoXhv6NZsU8TgpdCASvnLWcdSXAuNvm9XUkbIN
        D7pmmKMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVARY-002Btl-Dr; Fri, 18 Mar 2022 11:06:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 109453001EA;
        Fri, 18 Mar 2022 12:06:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6A602D35E98E; Fri, 18 Mar 2022 12:06:51 +0100 (CET)
Date:   Fri, 18 Mar 2022 12:06:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] perf/x86: Add Intel Raptor Lake support
Message-ID: <YjRny2qPtal2Y/Hj@hirez.programming.kicks-ass.net>
References: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:45:57AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> From PMU's perspective, Raptor Lake is the same as the Alder Lake. The
> only difference is the event list, which will be supported in the perf
> tool later.

Thanks!

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E373952FA8E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 12:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348279AbiEUKDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 06:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiEUKC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 06:02:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37555B884
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LfyHbALNTPecA2HX176Hbr8CB/YSXoZN5WLuIRvvUns=; b=KJrPx6vSz3NPryjADqppadBwTA
        mSvmLa4/k7ZxTcLMwmZArlrhTFcxnr1s9Dh03Ohx6vZcVQpCm7B11BgUkZ/9wyu5Jk/3qYyZ5m6zM
        /4qCgbT9Oa/9vvhSNTRwUWFDXsPOHQ1aqOnkLenIvi/K6sS3kn6DoZGNyijF4qbMmWbcMpe04zmfF
        f/wvInPZ7UmV2ERXcUtqa9L79NyM5OEfZCmmlJFRc5JWtuJNiXwGwxn/8UN6sPEcTHFFAz0+yZIQG
        SS2Wd5RYvsOJl+Bg7pNXIR6BiQ1G2DCnj43apbGVFk6wWPzWb+awCJKZmMyb+XpKuFYtBbcnCM6RU
        /87HB9Uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsLwH-000CKT-HV; Sat, 21 May 2022 10:02:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF36D980E99; Sat, 21 May 2022 12:02:24 +0200 (CEST)
Date:   Sat, 21 May 2022 12:02:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: Fix return value in frequency invariance setup
 for XEON_PHI_KNL/KNM
Message-ID: <20220521100224.GB2578@worktop.programming.kicks-ass.net>
References: <20220520161022.5972-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520161022.5972-1-ggherdovich@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 06:10:21PM +0200, Giovanni Gherdovich wrote:
> knl_set_max_freq_ratio() should return true on success and false
> otherwise. If the last line of the function body is reached, it means no
> appropriate value for turbo_freq was found: the setup is unsuccessful and
> it should return false.
> 
> Fixes: 8bea0dfb4a82 ("x86, sched: Add support for frequency invariance on XEON_PHI_KNL/KNM")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
>  arch/x86/kernel/smpboot.c | 2 +-

You seems to have missed all that code moved in tip. This no longer
applies.

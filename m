Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409EB4DC58E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiCQMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiCQMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:10:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322511965C2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:09:08 -0700 (PDT)
Date:   Thu, 17 Mar 2022 13:09:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647518946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DL4OEL8S9516AQ2+IPZ385CGAWJ8cpPdE5cJtlTl3AA=;
        b=rxDQHkqjtPzP/0pQ/Iu0B/XafP6JndHDlGBu0K32RmSbDtRR+3qElvIP0FfyyvJvbe5dLT
        RaUNIDb/EzJitXNud819seUghFAA/iftS/ItfbhnQDV//XIa4tif0DLJUb6Exm837WaQPj
        DRvh9T2aGM27ZCqkfk2E4is2Kz6JdiWVPw2bZW3/3x76qCoABp8HmgakJq1kBxAOlkRw36
        +BNl3w4HXlGgKFhyUGy3LMdzSHIe0cedEOYUKlY5p4n8w+N2KME3gjP3r6Siz074z8RfnD
        oAEYGVCNO+AYTeDcshHko7l4uyLzNVDt7CDllxCFPsOtLUBhRqm1tSZcNmeKbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647518946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DL4OEL8S9516AQ2+IPZ385CGAWJ8cpPdE5cJtlTl3AA=;
        b=yRar9PFGVEZxjrl2M67rvXqpaHivnwaBM+5LTqFKQYphb4JdIs7/YEngvFSwfSB0ph5IVA
        BuMt1f+ZDhA7pWDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <YjMk4b3vbR4vJqfO@linutronix.de>
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
 <YjIKQBIbJR/kRR+N@linutronix.de>
 <YjIN4C8EFIOOR+o4@linutronix.de>
 <20220316203524.GK8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220316203524.GK8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-16 21:35:24 [+0100], Peter Zijlstra wrote:
> 
> The previous thing in wrong because it tries to solve the wrong thing,
> the above makes sense, except I would write it like so:

Perfect. You want me to dress it as a patch or have you already done so?

Sebastian

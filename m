Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17358022D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiGYPrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiGYPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:47:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B51EDF4C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:47:01 -0700 (PDT)
Date:   Mon, 25 Jul 2022 17:46:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658764019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eUlkA2t1MtUb2rLp8O9d3LCKI3kOKYWqIJYKHRIVqbM=;
        b=ST0dTB3vgE0ehJkQ0EuSN19MOO7D3AMRotQoZgnpVpZIObYs1fXMm6oOGYM0Si4CNV2iMT
        PAJnt/V2kqP1tIAdlmAo29p4j/acGy0S0eHEmiSKwW49Nqk+H5u3G8XW22NnKPFzulkt3g
        IhxXgPinkTlzC77qIlb/BVOLljVDREQrDKeEhJWe0AXQxoHujmLGD1cQaQEntzwiFF6nxk
        tf3OwOXKRjVNjTpNSrFJ+sZCpJRcChhpKZyZOsuqQJEL287hmWSrffaFaDDpS3MZmxJcSV
        8OIO0IEfWleAFE0ka9BfJnx9Q8HdUdEbSNJbOjS10HV3SwEF+Rt3hHJlL1vMiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658764019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eUlkA2t1MtUb2rLp8O9d3LCKI3kOKYWqIJYKHRIVqbM=;
        b=wFI50G4ZpgU8FqY7aToEPCHL3oeaknykoBxRNvhuXU17Pd/NaiRn1oHC0EyDLk09lA/cIg
        zfEJGZx29n9C+7Bw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/2] signal: Last two bits for PREEMPT_RT
Message-ID: <Yt668pH5WpWkiPyG@linutronix.de>
References: <20220720154435.232749-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220720154435.232749-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-20 17:44:33 [+0200], To linux-kernel@vger.kernel.org wrote:
> This are the last two signal/ptrace related bits to get PREEMPT_RT
> working.

a polite ping for the series. This is one of two road blocks to get RT
enabled in v5.20. I don't want to add any pressure just point out that I
can't sit still for days since the end is near ;)

Sebastian

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604254E2F13
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbiCURcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242642AbiCURcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D08A66C1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E006C61476
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC7AC340E8;
        Mon, 21 Mar 2022 17:30:38 +0000 (UTC)
Date:   Mon, 21 Mar 2022 13:30:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <20220321133037.7d0d0c7f@gandalf.local.home>
In-Reply-To: <20220316210341.GD14330@worktop.programming.kicks-ass.net>
References: <20220308161455.036e9933@gandalf.local.home>
        <20220315174606.02959816@gandalf.local.home>
        <20220316202734.GJ8939@worktop.programming.kicks-ass.net>
        <20220316210341.GD14330@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 22:03:41 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Does something like the below (untested in the extreme) help?

Hi Peter,

This has been tested extensively by the ChromeOS team and said that it does
appear to fix the problem.

Could you get this into mainline, and tag it for stable so that it can be
backported to the appropriate stable releases?

Thanks for the fix!

-- Steve

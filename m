Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3FD4FC735
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiDKWCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiDKWCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD019C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E7BF616E4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA80C385A3;
        Mon, 11 Apr 2022 22:00:00 +0000 (UTC)
Date:   Mon, 11 Apr 2022 17:59:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] tracing/timer: Add missing argument documentation of
 trace points
Message-ID: <20220411175958.3fd73378@rorschach.local.home>
In-Reply-To: <20220411140115.24185-1-anna-maria@linutronix.de>
References: <20220411140115.24185-1-anna-maria@linutronix.de>
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

On Mon, 11 Apr 2022 16:01:15 +0200
Anna-Maria Behnsen <anna-maria@linutronix.de> wrote:

> Documentation of trace points timer_start, timer_expire_entry and
> hrtimer_start lack always the last argument. Add it to keep implementation
> and documentation in sync.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Looks fine to me. I expect this to go through the timer tree?

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

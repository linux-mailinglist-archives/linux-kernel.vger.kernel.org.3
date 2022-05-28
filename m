Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6FC536D3B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 15:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiE1N63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiE1N61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 09:58:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4745413D3E
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 06:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9BF4B82744
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CA4C34100;
        Sat, 28 May 2022 13:58:22 +0000 (UTC)
Date:   Sat, 28 May 2022 09:58:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Junwen Wu <wudaemon@163.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tannerlove@google.com, tglx@linutronix.de
Subject: Re: [PATCH v1] softirq: Add tracepoint for tasklet_entry/exit
Message-ID: <20220528095821.6e70fff9@gandalf.local.home>
In-Reply-To: <20220524210709.3f0ddc3a@gandalf.local.home>
References: <20220524210709.3f0ddc3a@gandalf.local.home>
        <20220524210709.3f0ddc3a@gandalf.local.home>
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

On Sat, 28 May 2022 13:54:11 +0000
Junwen Wu <wudaemon@163.com> wrote:

> >From 68d2298372018ec90c8587d5421a0e1a3c9f879f Mon Sep 17 00:00:00 2001  
> From: Junwen Wu <wudaemon@163.com>
> Date: Sun, 8 May 2022 15:29:56 +0000
> Subject: [PATCH v2] softirq: Add tracepoint for tasklet_entry/exit

You should always send a v2 as a separate email starting a new thread.

> 
> Usually softirq handler is pre-defined,only tasklet can be register by
> driver.We expand tracepoint for tasklet_entry/exit to trace
> tasklet handler.
> 
> Signed-off-by: Junwen Wu <wudaemon@163.com>
> ---

And reference v1 here, by something like:

Changes since v1: https://lore.kernel.org/all/20220508160624.48643-1-wudaemon@163.com/

 - Used DECLARE_EVENT_CLASS (Steven Rostedt)


>  include/trace/events/irq.h | 41 ++++++++++++++++++++++++++++++++++++++
>  kernel/softirq.c           |  4 ++++
>  2 files changed, 45 insertions(+)


-- Steve

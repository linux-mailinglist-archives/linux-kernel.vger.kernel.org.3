Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B42F593784
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbiHOSvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244090AbiHOSqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:46:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1A1402F7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EA2960EEB
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3F4C433C1;
        Mon, 15 Aug 2022 18:28:04 +0000 (UTC)
Date:   Mon, 15 Aug 2022 14:28:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 07/11] tracing: trace_events_synth: Convert to printbuf
Message-ID: <20220815142810.3f4e03a6@gandalf.local.home>
In-Reply-To: <20220815175830.pndfli32u5lfa4ww@moria.home.lan>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
        <20220815172613.621627-8-kent.overstreet@linux.dev>
        <20220815134314.32f3d3fc@gandalf.local.home>
        <20220815175830.pndfli32u5lfa4ww@moria.home.lan>
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

On Mon, 15 Aug 2022 13:58:30 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> You specified the other tracing patch, you did not specify this one.

I said: "As I said. Feel free to move seq_buf.c back into the tracing directory (but
         still need to keep seq_buf.h in include/linux), and feel free to convert
         all the other users besides tracing, to printbuf."

This is one of the tracing patches.

> 
> Andrew, I just reran the tracing tests with this patch dropped - you can just
> drop it, no other fixups are required.

Thanks,

-- Steve

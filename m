Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2C34E594E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbiCWTog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240384AbiCWToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:44:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294FA6582
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C29D2615BB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EED2C340E8;
        Wed, 23 Mar 2022 19:43:01 +0000 (UTC)
Date:   Wed, 23 Mar 2022 15:43:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [GIT PULL] tracing/rtla: Updates to the RTLA tool
Message-ID: <20220323154300.0be32927@gandalf.local.home>
In-Reply-To: <CAHk-=whxmA86E=csNv76DuxX_wYsg8mW15oUs3XTabu2Yc80yw@mail.gmail.com>
References: <20220321103035.564a1df5@gandalf.local.home>
        <CAHk-=whxmA86E=csNv76DuxX_wYsg8mW15oUs3XTabu2Yc80yw@mail.gmail.com>
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

On Wed, 23 Mar 2022 11:15:30 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> That said, mentioning the perf tools, I wish the tracing tools would
> do a bit more package checking and helpful error messages too, rather
> than just fail with
> 
>     fatal error: tracefs.h: No such file or directory
> 
> when (presumably) libtracefs and friends are needed.

Yes exactly.

Daniel, care to update the Makefile to check for libtracefs and friends and
give a more informative message when it fails?

You can look at the trace-cmd Makefile that does so.

-- Steve

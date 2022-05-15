Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B592527A88
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 00:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiEOWK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 18:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiEOWK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 18:10:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FAE6164
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 15:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B5CF611A5
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA9CC385B8;
        Sun, 15 May 2022 22:10:52 +0000 (UTC)
Date:   Sun, 15 May 2022 18:10:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm] tracing: incorrect isolate_mote_t cast in
 mm_vmscan_lru_isolate
Message-ID: <20220515181051.20155172@gandalf.local.home>
In-Reply-To: <e85d7ff2-fd10-53f8-c24e-ba0458439c1b@openvz.org>
References: <e85d7ff2-fd10-53f8-c24e-ba0458439c1b@openvz.org>
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

On Wed, 11 May 2022 12:46:53 +0300
Vasily Averin <vvs@openvz.org> wrote:

> Fixes following sparse warnings:
> 
>   CHECK   mm/vmscan.c
> mm/vmscan.c: note: in included file (through
> include/trace/trace_events.h, include/trace/define_trace.h,
> include/trace/events/vmscan.h):
> ./include/trace/events/vmscan.h:281:1: sparse: warning:
>  cast to restricted isolate_mode_t
> ./include/trace/events/vmscan.h:281:1: sparse: warning:
>  restricted isolate_mode_t degrades to integer
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

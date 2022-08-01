Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922725872A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiHAU6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiHAU5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4045F42
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC3561225
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39ACC433D6;
        Mon,  1 Aug 2022 20:57:12 +0000 (UTC)
Date:   Mon, 1 Aug 2022 16:57:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] tracing/eprobe: Add eprobe filter support
Message-ID: <20220801165711.3b7523e7@gandalf.local.home>
In-Reply-To: <165932114513.2850673.2592206685744598080.stgit@devnote2>
References: <165932112555.2850673.7704483936633223533.stgit@devnote2>
        <165932114513.2850673.2592206685744598080.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Aug 2022 11:32:25 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add the filter option to the event probe. This is useful if user wants
> to derive a new event based on the condition of the original event.
> 
> E.g.
>  echo 'e:egroup/stat_runtime_4core sched/sched_stat_runtime \
>         runtime=$runtime:u32 if cpu < 4' >> ../dynamic_events
> 
> Then it can filter the events only on first 4 cores.
> Note that the fields used for 'if' must be the fields in the original
> events, not eprobe events.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Hi Masami,

Thanks! But I'm not going to be able to add this for this merge window (too
late, it just opened up), because it's a new feature.

I'll take patch 1 though, as that's just a clean up, and then keep the
other two for the next merge window.

-- Steve

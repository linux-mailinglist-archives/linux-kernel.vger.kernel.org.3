Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF759708F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbiHQOCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbiHQOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7889E7332D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:01:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4515461471
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED81C433B5;
        Wed, 17 Aug 2022 14:01:13 +0000 (UTC)
Date:   Wed, 17 Aug 2022 10:01:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Reaver <me@davidreaver.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>
Subject: Re: [PATCH] tracing/perf: Fix double put of trace event when init
 fails
Message-ID: <20220817100122.127f0a44@gandalf.local.home>
In-Reply-To: <Yvyx0ouTDvsWTox6@krava>
References: <20220816192817.43d5e17f@gandalf.local.home>
        <Yvyx0ouTDvsWTox6@krava>
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

On Wed, 17 Aug 2022 11:16:02 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> LGTM
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks Jiri!

-- Steve

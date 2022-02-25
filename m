Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD234C46A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbiBYNhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241499AbiBYNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:37:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43730A0BC3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:36:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E983AB830B9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7DEC340E7;
        Fri, 25 Feb 2022 13:36:48 +0000 (UTC)
Date:   Fri, 25 Feb 2022 08:36:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-ID: <20220225083647.12ceb54b@gandalf.local.home>
In-Reply-To: <20220225192008.d7a4f2b5558fe43c95909777@kernel.org>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.714815604@infradead.org>
        <20220225005520.c69be2fbdbd28028361792d9@kernel.org>
        <20220224105847.5c899324@gandalf.local.home>
        <20220225103449.6084e5314273556f35107cd9@kernel.org>
        <20220224211919.0612a3f6@rorschach.local.home>
        <20220225192008.d7a4f2b5558fe43c95909777@kernel.org>
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

On Fri, 25 Feb 2022 19:20:08 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > No. It only acts like ftrace_location_range(sym, sym_end) if the passed
> > in argument is the ip of the function (kallsyms returns offset = 0)  
> 
> Got it. So now ftrace_location() will return the ftrace address
> when the ip == func or ip == mcount-call.

Exactly! :-)

Are you OK with that?

-- Steve

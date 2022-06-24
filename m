Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3C6558C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiFXAB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiFXAB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:01:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBEC52E4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09446B825E9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9571C3411D;
        Fri, 24 Jun 2022 00:01:22 +0000 (UTC)
Date:   Thu, 23 Jun 2022 20:01:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Message-ID: <20220623200120.02e8ef43@rorschach.local.home>
In-Reply-To: <YrR26pFadVbt5RSh@FVFF77S0Q05N.cambridge.arm.com>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
        <YqxoEJG6jGDWitg3@FVFF77S0Q05N>
        <20220622105436.775ccf7f@rorschach.local.home>
        <YrR26pFadVbt5RSh@FVFF77S0Q05N.cambridge.arm.com>
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

On Thu, 23 Jun 2022 15:21:30 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> I don't think that helps? I'm on about the size of the kernel "Image" file, not
> the runtime memory footprint.
> 
> ... unless you mean doing that at compiler time?

Oh, when Peter said: "This saves, on an x86_64-defconfig + FTRACE,
23975*4 ~= 94K of permanent storage." I was thinking of "storage in
memory". I wasn't thinking of disk space on the host machine.

But sure, this is fine with me. I'll have to take a deeper look at the
patch though.

-- Steve

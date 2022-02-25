Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182D44C4C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbiBYRdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiBYRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:33:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11B03BFA1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:32:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 690DD61CB9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27703C340E7;
        Fri, 25 Feb 2022 17:32:40 +0000 (UTC)
Date:   Fri, 25 Feb 2022 12:32:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 00/39] x86: Kernel IBT
Message-ID: <20220225123238.5ceeaae1@gandalf.local.home>
In-Reply-To: <20220225172644.76fyxjximjrcdbzt@treble>
References: <20220224145138.952963315@infradead.org>
        <20220224202602.3gvz5tnxvwb4maod@treble>
        <Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net>
        <Yhj5GKLfyxbNCGua@hirez.programming.kicks-ass.net>
        <20220225172644.76fyxjximjrcdbzt@treble>
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

On Fri, 25 Feb 2022 09:26:44 -0800
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > Damn, I just realized this makes KERNEL_IBT hard depend on KALLSYMS :-(  
> 
> Why should the jump label patching code even care whether there's an
> ENDBR at the jump target?  It should never jump to the beginning of a
> function anyway, right?  And objtool presumably doesn't patch out ENDBRs
> in the middle of a function.

Perhaps Peter confused jump labels with static calls?

-- Steve

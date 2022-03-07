Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC434CFE5A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbiCGM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiCGM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:26:16 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB967DA9D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:25:21 -0800 (PST)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 0EBAF100008;
        Mon,  7 Mar 2022 12:25:16 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 07 Mar 2022 04:25:16 -0800
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 04/39] x86/ibt: Base IBT bits
In-Reply-To: <YiXpv0q88paPHPqF@hirez.programming.kicks-ass.net>
References: <20220303112321.422525803@infradead.org>
 <20220303112825.190662703@infradead.org>
 <YiXpv0q88paPHPqF@hirez.programming.kicks-ass.net>
Message-ID: <9a58477564a1d86e17bdd2ef959e7f3e@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Joao will be submitting GCC and Clang bugreports on this shortly.
> 
Reported both on GCC and Clang:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104816
https://github.com/llvm/llvm-project/issues/54247

I'm not sure if something should be reported to ClangBuiltLinux, since 
the kernel will be built with -fno-jump-tables anyways.

Tks,
Joao

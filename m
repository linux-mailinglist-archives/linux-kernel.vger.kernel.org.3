Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AEB4C55BC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 12:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiBZL4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 06:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiBZL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 06:56:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21F22971CF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=luXQngK7Qu8op7UUBbfQNkcn6jXe6LiNgInSTg8CiUo=; b=TFGxSDMFnaYZomsbuc21/YLscn
        hCuh7OmXIoNoKNUbXCX5PwNieuUFhmqdCeQgBkS+1oYrK+JJ21fgTSce58jZB/tTgfCCUJl0lUwyH
        PZB2EmX3E5gr4YOwiv6wORD2lvrBqBYeJ5VW4ikQg1N0YQXy4Td/J/UZeJz++VuiUFN2tWhWn0yrL
        Fu+ll4QnW/HQWxBxn0bHNibsO9eGlQPGnaiehw5nbqT1QH1jvkfYqbDDkJEBUw5lcEolg+nVHi3XD
        Zjs2yy4Wipr3mpwkgw7ACnPQB0XZsmoStBmTqeiO8I447sw8EStKlkpgnRJQfkeK6U/MifC/TzdRo
        OcUQMi4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNvfJ-00DCww-0a; Sat, 26 Feb 2022 11:55:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E96D2986AEC; Sat, 26 Feb 2022 12:55:07 +0100 (CET)
Date:   Sat, 26 Feb 2022 12:55:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220226115507.GC11184@worktop.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
 <20220224235516.qdikcfdl7jo35iu6@treble>
 <Yhi0lY8w3E5VKquU@hirez.programming.kicks-ass.net>
 <20220225235122.lhhsfzamd5pfm7ue@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225235122.lhhsfzamd5pfm7ue@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 03:51:22PM -0800, Josh Poimboeuf wrote:
> Ah, I see what you mean now.  Still, it can just reference the code
> label itself without having to allocate storage:

Ooh, cute. Yes ofcourse... duh.

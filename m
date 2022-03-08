Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66C14D1C61
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348038AbiCHP4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiCHP4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B04F467
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XWrF28aaFKCDnGiE12KhdjNWuydBXYTc5nR0UxD7m88=; b=n1YdvNtiJInXy4TFjDesaIWtUo
        1jiWmXWSSwb265QBu+FrDeFhMS6wJmpInEJHEv4EdTNjz2Q/rAhS4Bv9n41upKfjfaISX68oVrPzS
        YxePyBV9+cKj3CzxvWZj7ght69Y2x7GZqdCqrSE0Nv25/cDlWf1CRDSWzqNT942f5tdK9stlOOpEn
        zYVsxhLbGuRfLXWDok3zvy+5NXpu0SmBJ8pATWrW6ppX3U8a46eNgmCMTs22lkHnZkVSIHPESkGHn
        VR61IW3F9l72clVzPU3eT2QIL0VArgwHfRleGbXpAivuiL7B58i1tJ2Rk8FTETLRg+kHNEFMhPl2P
        ILxtFb+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAb-00GIuo-G0; Tue, 08 Mar 2022 15:54:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9E8230074A;
        Tue,  8 Mar 2022 16:54:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B419A2B55FFAC; Tue,  8 Mar 2022 16:54:38 +0100 (CET)
Message-ID: <20220308153011.021123062@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 00/45] x86: Kernel IBT
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully last posting...

Since last time:

 - updated the ftrace_location() patch (naveen, rostedt)
 - added a few comments and clarifications (bpetkov)
 - disable jump-tables (joao)
 - verified clang-14-rc2 works
 - fixed a whole bunch of objtool unreachable insn issue
 - picked up a few more tags

Patches go on top of tip/master + arm64/for-next/linkage. Also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt

Enjoy!



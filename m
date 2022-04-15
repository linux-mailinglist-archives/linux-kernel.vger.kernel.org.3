Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC4550264E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351165AbiDOHnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbiDOHni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:43:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BECC205D7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=22/MeM8DHvIlm1VjYFivjPtNxFqsJDkoFPpSUaTCabw=; b=n7HlJ0LVCgs7INX4luwsXHE/N9
        J+ouMADVcoFqy0MluSInQNX2dz8+EPmKs6jKSmQ9atGr4CDsIHa0hrje/Lwla+CKPPB4a3CdT8pMh
        ED0H/CUoZeLvzlI0v5DAaudte8zghtVrvOwDg8lKTeNjBITMbWFxm/F8HqGjebxB+CdULoPUOe8aF
        Qy34eIDQedoFtFSTeW0Ccu4Lofzb+he+3kE7h9f0YxCUMS6d1gbu1lrbO1b3OxwScilh1kvBoMJgY
        eMtoo7opVaKeiN2CHd18xY04U4SGhUfvzhYAVygsBfukGjhh7phv2kRktkBpXeOa5x0+eCT5e9ZIc
        Mi0Ij3bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfGZX-00FwGG-Gu; Fri, 15 Apr 2022 07:40:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94F2F3001AE;
        Fri, 15 Apr 2022 09:40:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44E6E2025D913; Fri, 15 Apr 2022 09:40:49 +0200 (CEST)
Date:   Fri, 15 Apr 2022 09:40:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: plumbers talk on kCFI, BTI, & IBT?
Message-ID: <Ylkhgeyeolh1AO1y@hirez.programming.kicks-ass.net>
References: <CAKwvOdkyMyE0ZRUU9Rh4qTxpOseD=fydo-FB9kdd7zRo7nVreg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkyMyE0ZRUU9Rh4qTxpOseD=fydo-FB9kdd7zRo7nVreg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 02:28:08PM -0700, Nick Desaulniers wrote:
> Hi Sami, Peter, Joao, and Mark,
> Jose and I are currently in the planning process to put together a
> Kernel+Toolchain microconference track at Linux Plumbers Conference
> this year (Sept 12-14) in Dublin, Ireland.  Would you all be
> interested in a session on Control Flow Integrity in the kernel?
> Mitigations in hardware, software, or both might be of interest to
> discuss more in person?

Yeah, I think a session on CFI in general would be good to have.

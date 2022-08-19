Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE759967D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347295AbiHSHup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347246AbiHSHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:50:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA71D9E96
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cTRVX8Pd/QkIMgNoEEIaYCDvLIjoXFSl5I7fHaAjeJQ=; b=m3ppzq09RDvO533j7tkDCONQKL
        53E2eC43uquw3tcBbZ9G1cofjLQqdRlaZ7Kt1+p/fLPnuxtgmT3qhC5FOLaTOqy49rE/FvlquNjqU
        b8b3hqKsgDQebXBET46Ej32VS0HFmC6UpIKjrW4Tau7YieYpXvAY/KuZsxJfqWvIgjTa4wCO7A75G
        k1Njl4UbTONw2UtamDrFDKIikoxf6QfVArOentc47RmjZ9bWF06a3KLks0nY77jayazHqPEC0DFeS
        KyryeyvQXeFEoPAxJ+hn+fSN0UbHyp6RQBoaFGpC31F2YgQx3hfchyyozQDlcVekAuAUTzqL+QEZR
        7PSkzLow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOwlf-00Aspa-Jf; Fri, 19 Aug 2022 07:50:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 384C5980120; Fri, 19 Aug 2022 09:50:08 +0200 (CEST)
Date:   Fri, 19 Aug 2022 09:50:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>
Subject: Re: [PATCH 0/3] x86/kvm, objtool: Fix KVM "missing ENDBR" bug
Message-ID: <Yv9AsJoDRep8h0vZ@worktop.programming.kicks-ass.net>
References: <cover.1660837839.git.jpoimboe@kernel.org>
 <64365019-57dc-b449-8178-30428e09adf8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64365019-57dc-b449-8178-30428e09adf8@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 07:25:57PM +0200, Paolo Bonzini wrote:
> On 8/18/22 17:53, Josh Poimboeuf wrote:
> > Fix the "missing ENDBR" KVM bug, along with a couple of preparatory
> > patches.
> > 
> > Josh Poimboeuf (3):
> >    x86/ibt, objtool: Add IBT_NOSEAL()
> >    x86/kvm: Simplify FOP_SETCC()
> >    x86/kvm: Fix "missing ENDBR" BUG for fastop functions
> > 
> >   arch/x86/include/asm/ibt.h | 10 ++++++++++
> >   arch/x86/kvm/emulate.c     | 26 ++++++--------------------
> >   tools/objtool/check.c      |  3 ++-
> >   3 files changed, 18 insertions(+), 21 deletions(-)
> > 
> 
> Queued, thanks!

OK, let me drop them from the queue then ;-)

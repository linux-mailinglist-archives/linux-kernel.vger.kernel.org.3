Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D195A441C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiH2HrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2HrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:47:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C54E84B;
        Mon, 29 Aug 2022 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=icmA1xkGpp5ORC8y3pAN+UrwFjhTZyJG6EnseJL/u4k=; b=O9fs2pJDR/sM57y7pdwxppt3S7
        yZV7bW0YuAHQK3L9rf0gr5sBSQzxAZmjn4p/4Dogt4KABbM+h2QeIQqKT/5M4zeiij4kH1CKhLaKQ
        DHPCrGgZ3gh9GAL4STrsLaXB4GBfmhQR+Op8clUV3vlKKLcUoHdeLZ0oVU1qOez32hterxpggtLdN
        9wEr1/71Br6M0N7cEXsAmEQAumx3p18mREclKXYPiWgwkArK0Ow0a3kfLCoFYm1wrwn6UuEU8G1Kc
        aaslc49rOz2QUnC1yt0c/yML4fq4vOnKYExUkfPMytvrQjkUH+HiYRhEvpiQz0YTeyiDxEMth6p7Q
        rm0dn6uA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSZTo-007REY-QN; Mon, 29 Aug 2022 07:46:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D67E23002C7;
        Mon, 29 Aug 2022 09:46:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8BC5207F7FB4; Mon, 29 Aug 2022 09:46:43 +0200 (CEST)
Date:   Mon, 29 Aug 2022 09:46:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <Ywxu4+/eChqka4nv@hirez.programming.kicks-ass.net>
References: <20220829085730.142da032@canb.auug.org.au>
 <f6919bbc-e332-8d93-dffa-0cbe70463542@arm.com>
 <YwxqyZ5vyLX1mxZT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwxqyZ5vyLX1mxZT@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 09:29:13AM +0200, Peter Zijlstra wrote:
> On Mon, Aug 29, 2022 at 08:24:15AM +0530, Anshuman Khandual wrote:
> > Hi Stephen,
> > 
> > The original posted patch had author's 'Signed-off-by'. Seems like the tip
> > extraction have cut out portions of the commit message as well, apart from
> > just dropping the "Signed-off-by" :) We should keep the commit message in
> > the original form. Could you please fix that ?
> > 
> > Original patch: https://lore.kernel.org/lkml/20220824044822.70230-2-anshuman.khandual@arm.com/
> > Tip extraction: https://lore.kernel.org/lkml/166155215090.401.870330359879147742.tip-bot2@tip-bot2/
> > 
> 
> Urgn, that's my script triggering on your ------ lines. Let me see if I
> can rebase that.

Force pushed tip/perf/core, should be fixed now.

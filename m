Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECA552110D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbiEJJkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbiEJJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:40:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C9AF20;
        Tue, 10 May 2022 02:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HCWdULSg6wBdYOmLMa1csH7qtuWWJk+eVbCutcmw1tk=; b=wTVjkmSCm1u9pVSJKCZVENA2M0
        wt4n85U/hUoPnikwIsVA/m8RtU7bcjUX+rJ3f3sGFwxE9v22OPSxnv2bTMKBgVZdjyC66sNfMrvIb
        BOV4PIdZ5NI9mcuiwxTftOY06MHbgRGuihby+gdOhEm6/wtWiWaYMIaupVKSPKfiHDUoLPLNJybJG
        k9ky33GFU89c6nAg90QkLdpuaCeGKRDX1u8ysaumCB0gwjafe91Zn6OAa/CN2srGjTMxIfZjusEPN
        sVlVrVS26bo0QWQJVZss1xfbfFxj3MVFZqQFjpfqVzgI1LGhBO4jM0J4pvkPAcKqLQ4WS+cqzP7GR
        cUWDWA5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noMHb-004I52-Dy; Tue, 10 May 2022 09:35:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DC5C981011; Tue, 10 May 2022 11:35:53 +0200 (CEST)
Date:   Tue, 10 May 2022 11:35:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-tip-commits@vger.kernel.org,
        Vasant Hegde <vasant.hegde@amd.com>, pbonzini@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: perf/core] kvm: x86/cpuid: Fix CPUID leaf 0xA
Message-ID: <20220510093553.GM76023@worktop.programming.kicks-ass.net>
References: <165126412838.4207.9648561218200979307.tip-bot2@tip-bot2>
 <YnlOMDv5lMw2kGVb@zn.tnic>
 <246a7466-dc61-0186-2ff2-77fe37e73c06@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <246a7466-dc61-0186-2ff2-77fe37e73c06@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:29:34AM +0530, Sandipan Das wrote:
> > So which is it? Should we zap this version in tip instead?

I made it go away.

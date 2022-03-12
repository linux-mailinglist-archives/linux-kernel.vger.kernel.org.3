Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74F24D6FC1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiCLPdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiCLPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:33:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB34F192580
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zLkTAwyDVD9LSFsK+1dSCDDfPpQMrdtPI8MjxNSKzSU=; b=k6ETk9TvLDn0yESmpoVClkqUxM
        sFFQ9V2LjgoR0IipB/oVnKuUqHBNipd0yOwlwRmVLw3Bly3WQ12C4/b3MGzM/piMCxZU6BJudekTx
        nHDaG0Rstru0Oek8DkH4fsFGeoGfvOB94AONx4+VlaeCmmPzQEkyHuxj/L4kHLrh0D86IQOkP7hr7
        HVPQTUOiSv3aU5z/nMo9j1kW/zwZeTGJJpEkEWxsd0E80kMXrXr5/RuuYcQihb2XRf1vr3vI1jCEQ
        FCkJbLZ1HSJo3XnDm2ywZKf7PKdwXy+dmRZY/TrlYTSOoGpPni10wc+n3y2wqH3zo3thesaHIkbPX
        KeiA+79A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT3iR-000Cxp-Nt; Sat, 12 Mar 2022 15:31:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF7CF987D0D; Sat, 12 Mar 2022 16:31:33 +0100 (CET)
Date:   Sat, 12 Mar 2022 16:31:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86/alternative: make .altinstr_replacement section
 non-executable
Message-ID: <20220312153133.GE28057@worktop.programming.kicks-ass.net>
References: <20220311144312.88466-1-adobriyan@gmail.com>
 <20220311144312.88466-4-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311144312.88466-4-adobriyan@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 05:43:11PM +0300, Alexey Dobriyan wrote:
> Instructions in .altinstr_replacement section aren't meant to be
> executed by CPU directly, only after being copied to the real
> instruction stream in .text/.init_text.

But who cares; the entire section is deleted right along with
.init_text.

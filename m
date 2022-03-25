Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BC64E6F20
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354606AbiCYHp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbiCYHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:45:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C23CFCF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zzEhBDf3ESC9Hat3sODLbJ12fEhXcTDzRyTeQwdZ9hs=; b=MeQq4f8IE08Te9zlwEAxRYhnQU
        RzlgwdXLraH/T70A62x1738FgN+kxi69Lf+zEWlWOZswgGy+YEdl3aAr4GDxJ2j88/B+guOEbbtoi
        qANBb3ZWqkdA5Nx/J4RXz/EvsxTpgW1YGXB6MfonPdqWGsKsot9+IDK25TgqWt9UcY+itFgOqB0DS
        qLCBbLU6RPIXMzEHDbx5XgInIiTmcFPfuk539PX214y/mLboD+sUVqs80llVVde5By6yD7+FtxZlf
        ++A09l+I28lXW+L1MypdW6LlmA7h8I7lFU+KIK2Iq+N2bxrJgQiFJPXHsHl7aUGAQUJZOQxMIExHv
        Eh6lBQCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXecL-004JVs-8R; Fri, 25 Mar 2022 07:44:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D2069862A6; Fri, 25 Mar 2022 08:44:14 +0100 (CET)
Date:   Fri, 25 Mar 2022 08:44:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Some trivial noinstr fixes
Message-ID: <20220325074414.GK8939@worktop.programming.kicks-ass.net>
References: <20220324183607.31717-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324183607.31717-1-bp@alien8.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 07:36:04PM +0100, Borislav Petkov wrote:

> Borislav Petkov (3):
>   task_stack, x86/cea: Force-inline stack helpers
>   x86/kvm/svm: Force-inline GHCB accessors
>   x86/mm: Force-inline __phys_addr_nodebug()

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

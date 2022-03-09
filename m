Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F257A4D3C40
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiCIVlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiCIVlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:41:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EFA11D798
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:40:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E16561B0D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFEFC340E8;
        Wed,  9 Mar 2022 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646862047;
        bh=Wn6Pn2hqc9mv4qmzYe8C1j0oVQ6FqKJOJXV04OX5goA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hF7YR0HfRO7w6SSQHNDPnVtJo/5dCfKgisJ31jdpceHokiFp7tfXTKnQjsLF5k1fK
         WIZuJhybxSrnacr2+VZxl/2ZjPtmaFvfpqljhi7CBhkYxwAP50XIHXD2RU0xmIR8Nx
         r9f7STfRTO7qVEM3ThxbbIDngVbQsiaxnhTKytmY=
Date:   Wed, 9 Mar 2022 13:40:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH v3 0/5] mm/mprotect: avoid unnecessary TLB flushes
Message-Id: <20220309134046.31a0751523acb9babb55b9de@linux-foundation.org>
In-Reply-To: <20220309041043.302261-1-namit@vmware.com>
References: <20220309041043.302261-1-namit@vmware.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Mar 2022 20:10:38 -0800 Nadav Amit <nadav.amit@gmail.com> wrote:

> This patch-set is intended to remove unnecessary TLB flushes during
> mprotect() syscalls. Once this patch-set make it through, similar
> and further optimizations for MADV_COLD and userfaultfd would be
> possible.

Thanks.  I'll save this away for consideration after the -rc1 release. 
Which gives others plenty of time for review (hint) (request).


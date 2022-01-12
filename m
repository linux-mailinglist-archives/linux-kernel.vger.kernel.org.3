Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1073B48C081
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351829AbiALI5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351855AbiALI5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:57:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F6C06175E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ptT7Q+NrHVUneTPMfkYgw6UZZqAeVqwlWTC8DxFKkTk=; b=UZV2cTxtt3k7HAXRsH4bAADE3r
        gavBKX8EUJ30aNEf7rNkl61lfU+/OqkBLCHNvL7+nwb5BcBgAa+WmrmrbDYQnYwfYjwi//mEb3P6c
        KZqhqbWMKTjYNv4jsMZFLXNIxyUE4hpdwC7ryl7uxGPaweh6wDU23UeKfB+yB1oyemLoDd6S8kjhN
        CCdF76rla+xF0sa0GMCXv3JN4GueC+rRjVKHsMR92IPrsN3WVBWTUR99UHekeEr6WtdTJ2aHocgUL
        o2U5EjOO7TUhkE69bvDGlS3I+S3aQu5cMZqcC6ON9iOgMsT/Rii9eSrrYWMWIRLiHge9BMC7LNheq
        IiiPkA2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7ZQt-003xpt-Bc; Wed, 12 Jan 2022 08:56:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E466300237;
        Wed, 12 Jan 2022 09:56:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DC532B35079A; Wed, 12 Jan 2022 09:56:39 +0100 (CET)
Date:   Wed, 12 Jan 2022 09:56:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com, will@kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as reviewer for atomics
Message-ID: <Yd6Xx4lAak1qZFVB@hirez.programming.kicks-ass.net>
References: <20220104095018.1990058-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104095018.1990058-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 09:50:18AM +0000, Mark Rutland wrote:
> As I've fiddled about with the atomic infrastructure a fair bit now,
> Peter suggested I should add myself as a reviewer or maintainer to make
> sure I'm Cc'd on anything I might have an opinion on.
> 
> For now, add myself as a reviewer.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

Must definitely! Thanks!

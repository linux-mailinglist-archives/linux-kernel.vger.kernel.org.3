Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7E646E424
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhLII3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhLII3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:29:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E167C061B38
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 00:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=im9dRaYouYh+nZ7cGN0OZqrb4E9EISo03wtbdlMeE5M=; b=XElRRn94HjMcOv9r63U3cDM3IJ
        JA8VIanbeqHD+N2Z/lhMOLWrltHh8crI13AsiaXvtBYjSRgoklY0B0qJyTZY9wADgeLQUPQ6Rmt23
        PAhnEpDVnfMbqonH5lLHbvH/KBo9LbEpaz2Fpw9/ok5E0srUh4GE1Agx7itep9aINC5sUTltgpGn3
        fva68ieaH2Phc+yx+JaXTtEAFDAVEs5c+q2VxEqtkb1MoGwpEbVsGszsPoGF8qBpZuvg7I/IuLpgB
        ctgjl1PO/1T8ltYK9QKyF603RPC+XSsBcKtisinw+Sa8l8L2w5gc4YYhYkTHQ5uypFI2Isj4uXgeu
        aF3jYNAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvEkA-000KjS-48; Thu, 09 Dec 2021 08:25:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7C569817E0; Thu,  9 Dec 2021 09:25:33 +0100 (CET)
Date:   Thu, 9 Dec 2021 09:25:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        elver@google.com, keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [RFC][PATCH 0/5] refcount: Improve code-gen
Message-ID: <20211209082533.GE16608@worktop.programming.kicks-ass.net>
References: <20211208183655.251963904@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208183655.251963904@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 07:36:55PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> Improves the refcount_t code-gen; I've still got to go through the latest thing
> Linus suggested, but figured I should get these patches out to see if there's
> other concerns etc..
> 

Bah, I forgot to Cc Jens, let me bounce him the lot.

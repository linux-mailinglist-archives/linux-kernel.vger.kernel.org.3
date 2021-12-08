Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B8D46DB77
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhLHSsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLHSsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:48:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D3C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/XDiYJK8Hi157XsYbjLTQl9kMcgUCEWOxjk1u7xVJPM=; b=teSSbH24X6drUhkN6edevNoN6l
        UJqjpfWCNV9F4f/m52EPqJvHB9nu9h4qGCulXrlpdvJhJjqyiYmLKeQKyUvSgzk9w7EHyaABm3zGd
        WSEmtIpo7PNLUrUDLtomglBjxYlEOQ9WkCG0WAjoWZTqpcw1ooU5iltdputRhsz2JmyXTQKziI6Yb
        /riDMsXa3D9uMQV1jtgvC7AV2uexKLixHgfyfOb7Pt/n+YvwS+6uEkqhqP4AFMv8lWlKsMwuljOS/
        JnDM6slGmFs8sZA6kRdzYIFZC5KYyqB8cAo8pwNcCJ5IJo3c95lIrda6s71uFlMySg0lfzm7fEeBc
        +CEbh6Gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv1vw-008gPF-RH; Wed, 08 Dec 2021 18:44:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27BB69811F7; Wed,  8 Dec 2021 19:44:55 +0100 (CET)
Date:   Wed, 8 Dec 2021 19:44:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, boqun.feng@gmail.com,
        lkp@intel.com, will@kernel.org
Subject: Re: [PATCH] locking/atomic: atomic64: remove unusable atomics
Message-ID: <20211208184455.GZ16608@worktop.programming.kicks-ass.net>
References: <20211126115923.41489-1-mark.rutland@arm.com>
 <YbD3f3CnTUkInNoP@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbD3f3CnTUkInNoP@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 06:20:47PM +0000, Mark Rutland wrote:
> Peter, did you have any thoughts on this, or would you be happy to pick it as a
> cleanup?
> 
> If there's anything on your queue that I can help to get out of the way, please
> let me know!
> 

I think it's good, it just got lost in this trainwreck of an inbox. I'll
try not to loose it again :-)

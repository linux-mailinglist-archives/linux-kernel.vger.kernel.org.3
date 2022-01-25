Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944BE49B570
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbiAYN43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358916AbiAYNyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:54:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0AC06174E;
        Tue, 25 Jan 2022 05:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R97F4j2vJPpYP2hkOl7KqnbnzY+rMR+5Vc9jNgI1Gyc=; b=gYEvOrUjTJSh5whtbj2sO5ibO+
        mzZsse1aw+8QOEcsxOrS1e0h39BHF0RSokv9V7dg/Esy4R8yabHdPyCfdU0cgLsgmUli/ramkIQrY
        KoyXTRGtJ6eOXH1NPbEhAZdQnLixypIXtKCB+OWp11PcjynzEqRpviAQpjcPjYjVrV/F7/NK3/IOF
        eaxKPE0zkjKTQAblFvsUVUbYwTWaJNXuo23miDHs/q2xoBYrndC6PvkGKAFafC2lXdjkokx620xMM
        JEQqgzhOJQm5qALCRM1wSqlKr1r8KvIT5Z7O/JXlH+9nMcP/0MN9h/lLl/SqLCMkPG1kcaBlr1cTh
        M89L7Lng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCMGp-002tCJ-3M; Tue, 25 Jan 2022 13:54:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC1C63002C5;
        Tue, 25 Jan 2022 14:54:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 740C32B37A003; Tue, 25 Jan 2022 14:54:01 +0100 (CET)
Date:   Tue, 25 Jan 2022 14:54:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YfAA+age1zo3lxIB@hirez.programming.kicks-ass.net>
References: <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
 <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
 <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
 <Ye/w/lOf4f8+8fDt@hirez.programming.kicks-ass.net>
 <yt9dbl00rmgx.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dbl00rmgx.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:09:18PM +0100, Sven Schnelle wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > Now the documentation states we need this super speed A<->A cable, but
> > could you also update the documentation for usb-c ? There's a fair
> > number of usb-c only devices out there now.
> 
> Stupid beginners question: Would every USB3 A-A cable work, or are the
> debug cables special? I've read the RX/TX pairs have to be swapped, but
> to me it looks like that's always the case?

I'm using a random USB3 A-A cable (it came with an HDMI frame grabber of
of AliExpress). The official one has a wire missing I think, to avoid
ground loops or something like that.

The easiest thing to do is try the runtime DBC option:

  echo enable > /sys/bus/pci/devices/0000:00:14.0/dbc

If that works you can see what it takes to make the earlyprintk one
working. This thread seems to have much of that covered.

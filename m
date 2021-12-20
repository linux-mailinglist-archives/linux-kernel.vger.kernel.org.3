Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3DB47B1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhLTRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhLTRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:01:33 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84AC061574;
        Mon, 20 Dec 2021 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sQ7BWNClLWcRoTvAousi7pFg1UZuXIYnl6ojC+f5BuM=; b=ia85Cs9KAcSrA7nOeCBivJsLPf
        7CDjNGfcKHeuKShrmXHAY2J+S39PDEmQ/N7ExDmfCqjrIIYEb4SH6DgYXfMl48Rzr/o/Xu87GA7tm
        pbZNkrsfgu4MEz2DZ68Ezb3VYaUH/TS6mf/ptrRlLyEu4Z7o14zPNpJQ3Pm/zbK/HIwDj4HPSlv8K
        yrrneeznHRLxmxBGtQKG5fTJkt3+fecIBlk9Z1KLywowQF68XpDfV13Yq8rQhrIcLk1z6HhCWyKC5
        fcgaDRxXrzPRD8x6COeReStFHooE7Ai6+b2qld4/zsrlO0DPng7qVxQI6zMcrM/4dI4Q3yFHnKkcm
        x16IETmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzM2G-002XjH-Ql; Mon, 20 Dec 2021 17:01:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2737E300347;
        Mon, 20 Dec 2021 18:01:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2DEC3015F8F7; Mon, 20 Dec 2021 18:01:13 +0100 (CET)
Date:   Mon, 20 Dec 2021 18:01:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YcC22e6KLq/JiU+O@hirez.programming.kicks-ass.net>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YbyqeE39vqE9pEDD@kroah.com>
 <YcCV0TECWE31fYV7@hirez.programming.kicks-ass.net>
 <YcCcCjYcXw6T8LjG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcCcCjYcXw6T8LjG@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:06:50PM +0100, Greg KH wrote:
> Please see c4d936efa46d ("Revert "usb: early: convert to
> readl_poll_timeout_atomic()"") in Linus's tree.  I already added a
> comment much like yours.  If that's not sufficient, I'll be glad to
> re-word it.

Oh, no that's excellent, thanks!

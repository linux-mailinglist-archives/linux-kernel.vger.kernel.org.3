Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D45B49B52C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577373AbiAYNcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577184AbiAYN3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:29:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A5BC061779
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WJW6Lj/AQ2mLNX4DlwunesX+5YC4+prbjbipchmJRxA=; b=An8lzReU29Jk6j7duCNt1M5Qs+
        bAgwHNg4/IZcVH50tT/Q602zE8c9YJ1BhMIgBlKe7T+SoH9MKJaSZShy6h/PW3qe6Cj1hgi7eV8+K
        Jq0qu2oqzQkSMZPJfdJXGULyIHZaxHLS00F+WYCnz+zws1xnY4T2HEjx5SgWgrF04Ql7g392cmvgk
        pj+x8IxQGRdagwq4Gn6jhqFPfoF7byBai6UIBLo/O/Hl9R2vJgld5U6pWsvFSk6L1YykRs/NPo3r8
        /t97rGFiUjUguzY+yhnCfq7rhzfnT057ZaPxgq7ibCy+Nxg/cGNn2E13K2bzAEFMw9/opXQe3N3Mx
        3YfGCYsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCLsP-002qac-Km; Tue, 25 Jan 2022 13:28:49 +0000
Date:   Tue, 25 Jan 2022 13:28:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        naoya.horiguchi@linux.dev, rostedt@goodmis.org,
        Ingo Molnar <mingo@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] mm/migration: Add trace events for base page and
 HugeTLB migrations
Message-ID: <Ye/7EWJ576hdkWDg@casper.infradead.org>
References: <1643080105-11416-1-git-send-email-anshuman.khandual@arm.com>
 <1643080105-11416-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643080105-11416-3-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 08:38:25AM +0530, Anshuman Khandual wrote:
> +		TP_printk("addr=%lx, pte=%lx order=%d", __entry->addr, __entry->pte, __entry->order)

In these days of increasingly advanced Rowhammer attacks, is it wise
to let userspace know exactly which physical addresses are being
used for virtual addresses?

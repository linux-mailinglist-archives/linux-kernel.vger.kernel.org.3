Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A719C46567E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbhLATd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbhLATcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:32:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5C9C06175C;
        Wed,  1 Dec 2021 11:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hFS9voJP3sUV6hy8HBgiPVd7sEVsX477OnX7BuqZmYc=; b=i+gp1la+cT/rqwNBgnOYCV9XD1
        LNXGrVTIadb8pFDsaqJlBFNLQvygBa58Lw0IuUmVyCsVYXgC6eFVfn1RUfdaD2DMUZu3/HgcbLRDI
        WeqxweASUcwhFmXFf63uqxeVYLEuEOzdMK3JCYgNQKLD1icnT79R07PH5S4YKdfJe80B/l9Kxd9vg
        0SIhQfsfCz+6lVIGYAAqXPT1hCO0B/7a5XrpSgzcsq2W8cz99eqYeIZxRunrTp0uL+Vqnmeay2nyY
        mmM0Jt7hL19QoAJ0NmS8/PUWT+F+Q4whso9ARFgrS642ih39ixBx5YmlxalXULRLxnZcDl+/QC6O2
        gWzeGgsA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msVHL-009wyc-TC; Wed, 01 Dec 2021 19:28:31 +0000
Date:   Wed, 1 Dec 2021 11:28:31 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot failure after merge of the akpm tree
Message-ID: <YafM3/JAilu/ce9q@bombadil.infradead.org>
References: <20211130184622.71be17e0@canb.auug.org.au>
 <YaZPoEHL2svLLBwS@bombadil.infradead.org>
 <YafJY3rXDYnjK/gs@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YafJY3rXDYnjK/gs@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:13:39AM -0800, Luis Chamberlain wrote:
> On Tue, Nov 30, 2021 at 08:21:52AM -0800, Luis Chamberlain wrote:
> > On Tue, Nov 30, 2021 at 06:46:22PM +1100, Stephen Rothwell wrote:
> > > Bisected to commit
> > > 
> > >   f00ff38c1dfa ("sysctl: add and use base directory declarer and registration helper")
> > > 
> > > I have reverted that complete 6 patch series for today.
> > 
> > I'll be trying to reproduce and fix, thanks for the report!
> 
> OK please try this patch, I can boot with this just fine on ppc64le:

And to be clear I reproduced the issue and this patch fixes it for me
on ppc64le.

  Luis

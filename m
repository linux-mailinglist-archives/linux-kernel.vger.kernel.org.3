Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBBC47EC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351613AbhLXGyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245692AbhLXGyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:54:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E533C061401;
        Thu, 23 Dec 2021 22:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JtRr75bNYqycAEprguVijwvjoY3EweCPEp884i8dsfI=; b=mtfGEJZbI6p3QtIT0f5dQ11cC/
        zj7ItLwL8HKTNNgVEr9LJBqYCEO24evgXuuis7NmkQ7qfo+fKEZqKItWBYDgrEh6wxPExhK547zq9
        dCTwqqif+1jPBi1gXTxbULwDANwQZN/cfI/KjW1dSY1JaTC9XQoBIWvt5yCHRwKeyZNGQh+KReLa4
        t/tay14oYR6dK/6uxGmnPEY8uoXD4wr9jbERoV7f1K2E5O/kV+3kbgGYMk3wmTRmuJFFuPeli7M0H
        jshsJVovgoNco9lPV0h4hxic3JrVoxw8jYP/Jf0zVHEOUE7oSMwsu/0B6wLBHPPVduAVIx/eRhYAr
        nLrcQsTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0eTJ-00DorD-QV; Fri, 24 Dec 2021 06:54:33 +0000
Date:   Thu, 23 Dec 2021 22:54:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Wei Wu =?utf-8?B?KOWQtOS8nyk=?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 08/13] riscv: compat: Add COMPAT Kbuild skeletal support
Message-ID: <YcVuqfsiObz4XirW@infradead.org>
References: <20211221163532.2636028-1-guoren@kernel.org>
 <20211221163532.2636028-9-guoren@kernel.org>
 <CAK8P3a0-ZOwoC_Ft+TiKAXdETcqU5XPS+9DZGkA+bB73SNCCbQ@mail.gmail.com>
 <CAJF2gTQ=Yo98-S12D9CbVXPJsAKpLu1NhJAVB3yu+J9thz6CUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQ=Yo98-S12D9CbVXPJsAKpLu1NhJAVB3yu+J9thz6CUg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 08:06:55PM +0800, Guo Ren wrote:
> On Wed, Dec 22, 2021 at 2:23 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> > > +
> > > +config SYSVIPC_COMPAT
> > > +       def_bool y
> > > +       depends on COMPAT && SYSVIPC
> >
> > Can this be moved to init/Kconfig next to SYSVIPC?
> 
> I would try another patchset, to see other architecture guys' advice.

The existing per-arch definitions are pretty much historic cruft.

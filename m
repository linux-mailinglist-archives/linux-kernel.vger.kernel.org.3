Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AC4849A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiADVAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:00:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50207 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233740AbiADVAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:00:43 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 204L0UVV019108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jan 2022 16:00:30 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2D81115C00E1; Tue,  4 Jan 2022 16:00:30 -0500 (EST)
Date:   Tue, 4 Jan 2022 16:00:30 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kvartet <xyru1999@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        sunhao.th@gmail.com
Subject: Re: INFO: task hung in __filemap_get_folio
Message-ID: <YdS1bk5txXiJynXV@mit.edu>
References: <CAFkrUsjD2HSRHdZ9yKANa0pLe8rhwPXKbU+E-A7K+td3jS5ZVA@mail.gmail.com>
 <YdSPb5Q6HytIi6w9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdSPb5Q6HytIi6w9@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 06:18:23PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 04, 2022 at 07:44:10PM +0800, kvartet wrote:
> > Hello,
> > 
> > When using Syzkaller to fuzz the latest Linux kernel, the following
> > crash was triggered.
> 
> This isn't a crash, it's a notification of a hang.  More than likely
> syzbot is playing with RT scheduling again.
> 
> We do not need more people running syzbot.  We need more people tracking
> down and fixing the syzbot reports that already exist.

One of the syzbot spam reported by kvartet was a hang in the jbd2
layer, while it was waiting for processes to complete running handles,
and the oom killer lock was reported as being involved.  At which
point, I stopped reading or caring about *any* of the syzbot
complaints being reported by kvartet....

					- Ted

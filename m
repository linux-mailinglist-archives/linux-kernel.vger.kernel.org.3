Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03E473659
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbhLMVFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:05:41 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56436 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbhLMVFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:05:40 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 33057CE12BD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:05:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BAD360EFF;
        Mon, 13 Dec 2021 21:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1639429536;
        bh=biOxBHYttmfLcu5XjgSOMwkLkRSOPguut1k6wAtMXN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u1PQEIyQ9fEj+8m1vJaDpqw/RsoyQOUMXBQcRRSp9KJgbzaXKJ88IOpqo2doiJqhu
         KoXEzh+f1z2M4o3QsR15cEN9pmDNzVBrTUHzH0UZnB15n8tXGtgmlM9wQpoaBMbhkc
         X4AFHDwWEk8iFT8bbebxcTFroz8XJIi+PQP7BJhU=
Date:   Mon, 13 Dec 2021 13:05:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH v3 0/5] Avoid requesting page from DMA zone when no
 managed pages
Message-Id: <20211213130534.af47c7956c219797e6b56687@linux-foundation.org>
In-Reply-To: <20211213122712.23805-1-bhe@redhat.com>
References: <20211213122712.23805-1-bhe@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 20:27:07 +0800 Baoquan He <bhe@redhat.com> wrote:

> Background information can be checked in cover letter of v2 RESEND POST
> as below:
> https://lore.kernel.org/all/20211207030750.30824-1-bhe@redhat.com/T/#u

Please include all relevant info right here, in the [0/n].  For a
number of reasons, one of which is that the text is more likely to be
up to date as the patchset evolves.

It's unusual that this patchset has two non-urgent patches and the
final three patches are cc:stable.  It makes one worry that patches 3-5
might have dependencies on 1-2.  Also, I'd expect to merge the three
-stable patches during 5.16-rcX which means I have to reorder things,
redo changelogs, update links and blah blah.

So can I ask that you redo all of this as two patch series?  A 3-patch
series which is targeted at -stable, followed by a separate two-patch
series which is targeted at 5.17-rc1.  Each series with its own fully
prepared [0/n] cover.

Thanks.

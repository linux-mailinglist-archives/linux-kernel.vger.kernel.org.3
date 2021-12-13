Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9464721DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhLMHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:44:10 -0500
Received: from verein.lst.de ([213.95.11.211]:46455 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhLMHoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:44:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 99CDA68AA6; Mon, 13 Dec 2021 08:44:04 +0100 (CET)
Date:   Mon, 13 Dec 2021 08:44:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND v2 2/5] dma-pool: allow user to disable atomic
 pool
Message-ID: <20211213074404.GA20758@lst.de>
References: <20211207030750.30824-1-bhe@redhat.com> <20211207030750.30824-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207030750.30824-3-bhe@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:07:47AM +0800, Baoquan He wrote:
> In the current code, three atomic memory pools are always created,
> atomic_pool_kernel|dma|dma32, even though 'coherent_pool=0' is
> specified in kernel command line. In fact, atomic pool is only
> necessary when CONFIG_DMA_DIRECT_REMAP=y or mem_encrypt_active=y
> which are needed on few ARCHes.

And only these select the atomic pool, so it won't get created otherwise.
What problem are you trying to solve?

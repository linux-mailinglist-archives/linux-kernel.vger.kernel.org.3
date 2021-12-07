Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC64D46B34A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhLGG7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:59:32 -0500
Received: from verein.lst.de ([213.95.11.211]:54739 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230386AbhLGG7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:59:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D014368AFE; Tue,  7 Dec 2021 07:55:56 +0100 (CET)
Date:   Tue, 7 Dec 2021 07:55:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 nvdimm tree
Message-ID: <20211207065556.GA4786@lst.de>
References: <20211207173938.6d619ba6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207173938.6d619ba6@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:39:38PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm-current tree got a conflict in:
> 
>   mm/memremap.c
> 
> between commit:
> 
>   b80892ca022e ("memremap: remove support for external pgmap refcounts")
> 
> from the nvdimm tree and commit:
> 
>   30156644eb0d ("mm/memremap: add ZONE_DEVICE support for compound pages")
> 
> from the akpm-current tree.

The resolution looks good to me, thanks.

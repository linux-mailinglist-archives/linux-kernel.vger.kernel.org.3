Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE1D47BC31
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhLUIvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:51:05 -0500
Received: from verein.lst.de ([213.95.11.211]:45911 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233569AbhLUIvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:51:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A474368AFE; Tue, 21 Dec 2021 09:50:54 +0100 (CET)
Date:   Tue, 21 Dec 2021 09:50:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, corbet@lwn.net, hch@lst.de, cl@linux.com
Subject: Re: [PATCH 1/2] docs: kernel-parameters: Update to reflect the
 current default size of atomic pool
Message-ID: <20211221085051.GA7439@lst.de>
References: <20211217090827.101938-1-bhe@redhat.com> <20211217090827.101938-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217090827.101938-2-bhe@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 05:08:26PM +0800, Baoquan He wrote:
> Since commit 1d659236fb43("dma-pool: scale the default DMA coherent pool
> size with memory capacity"), the default size of atomic pool has been
> changed to take by scaling with system memory capacity. So update the
> document in kerenl-parameter.txt accordingly.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

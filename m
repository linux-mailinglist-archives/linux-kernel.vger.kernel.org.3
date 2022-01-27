Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC38D49DA64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiA0GBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:01:45 -0500
Received: from verein.lst.de ([213.95.11.211]:42573 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232585AbiA0GBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:01:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA89B68AFE; Thu, 27 Jan 2022 07:01:41 +0100 (CET)
Date:   Thu, 27 Jan 2022 07:01:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings in Linus' tree
Message-ID: <20220127060141.GA10653@lst.de>
References: <20220127153055.6dd9f73d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127153055.6dd9f73d@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 03:30:55PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Building Linus' tree, today's linux-next build (htmldocs) produced
> these warnings:
> 
> include/linux/blkdev.h:1533: warning: Function parameter or member 'start_time' not described in 'bio_end_io_acct'
> include/linux/blkdev.h:1533: warning: Excess function parameter 'start' description in 'bio_end_io_acct'
> 
> Introduced by commit
> 
>   956d510ee78c ("block: add disk/bio-based accounting helpers")

The warning looks correct, but that commit is rather old, so something
else must have caused it to be emitted now?

> 
> -- 
> Cheers,
> Stephen Rothwell


---end quoted text---

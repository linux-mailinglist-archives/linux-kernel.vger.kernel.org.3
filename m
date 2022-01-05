Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A90484EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiAEHUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:20:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57078 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiAEHUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:20:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D4D9B818F9;
        Wed,  5 Jan 2022 07:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D528CC36AE9;
        Wed,  5 Jan 2022 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641367198;
        bh=+5D2LgPMmG2tuY/rNi5bQY6f9qdsVjrr+jSwcS7aJAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCGZlrXMAlaoI6DT5P656pS324kcS3Akfoz/IgyqFPHewbKvpXsWT35pjTx5vrqrm
         16dtw2NbOw1/3A2acehF3kdBe3qENZEBAhL7X8wII/wP4XCC22daDB1gewAHXoM/i3
         CjEEDmT1KmcEjV6FLQmpzL2x/Q7vKctHsuJdfskTAkN9playa6LkK7H9HNxCJC3JQ/
         XGUMvxDTUlKSN8qknEa8C0pNkk84Cl5oN3IMNvy8+DY0oBDAFxiuYCP307LmFANzYE
         vEhB0O5j/sXTZQQhw1GRtQPJlWhXW9GSWi4Toq3/dWHXUa/JE6S3V7FkcP9CP+46Ve
         kfi7PQsoEfJbw==
Date:   Wed, 5 Jan 2022 12:49:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: manual merge of the dmaengine tree with the
 dmaengine-fixes tree
Message-ID: <YdVGmkzgUmvPDmlE@matsya>
References: <20211214172437.1552740-1-broonie@kernel.org>
 <CAMuHMdUQjKOp6B7_-pG8t8OzrH=H+dYjn65YMHHy7CLaw6OU1g@mail.gmail.com>
 <36975790-c9f8-a6f6-cbc2-493da4bdd8c1@intel.com>
 <20220105100407.69b16fe2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105100407.69b16fe2@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-01-22, 10:04, Stephen Rothwell wrote:
> Hi Dave,
> 
> On Tue, 4 Jan 2022 14:41:00 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
> >
> > >>   +       */
> > >>   +      list_for_each_entry_safe(d, t, &flist, list) {
> > >>   +              list_del_init(&d->list);
> > >> -               complete_desc(d, IDXD_COMPLETE_NORMAL);
> > >> ++              idxd_dma_complete_txd(d, IDXD_COMPLETE_NORMAL, false);  
> > > Is "false" correct here?  
> > 
> > Hi Geert, took a closer look today. I believe it should be 'true'
> > here since this is a normal completion that needs to release the
> > descriptors. Sorry about the previous incorrect response.
> 
> I have updated my resolution from today.  Thanks for the feedback.

I have merged fixes into next as well, so this should not be required
tomorrow.

Dave pls test..

-- 
~Vinod

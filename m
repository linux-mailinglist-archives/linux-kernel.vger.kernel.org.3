Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3653E269
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiFFHtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiFFHtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:49:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA55EA76D0;
        Mon,  6 Jun 2022 00:49:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3F49B68AA6; Mon,  6 Jun 2022 09:49:04 +0200 (CEST)
Date:   Mon, 6 Jun 2022 09:49:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Michael Schaller <misch@google.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New partition on loop device doesn't appear in /dev anymore
 with kernel 5.17.0 and newer (repro script included)
Message-ID: <20220606074904.GA3145@lst.de>
References: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com> <20220603124956.GA18365@lst.de> <CALt099JqRXwsGnq_DmHmnwPyB0K9Y+-BZUG_YoGxOg7G7ZZh9w@mail.gmail.com> <20220603132313.GA20886@lst.de> <Ypx+qusVyLJEEb/r@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ypx+qusVyLJEEb/r@eldamar.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 12:00:10PM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Fri, Jun 03, 2022 at 03:23:13PM +0200, Christoph Hellwig wrote:
> > On Fri, Jun 03, 2022 at 03:21:28PM +0200, Michael Schaller wrote:
> > > Thank you, Christoph! <3
> > > 
> > > Patch https://lore.kernel.org/all/20220527055806.1972352-1-hch@lst.de/
> > > does indeed fix the issue.
> > > 
> > > Could this patch also be backported to 5.17 and 5.18?
> > 
> > It should get picked up automatically based on the fixes tag as soon
> > as it hits mainline.
> 
> As it does not apply cleanly to older versions, this probably will
> need a sperate turnaround, but AFAICS it's just because of
> a0e286b6a5b6 ("loop: remove lo_refcount and avoid lo_mutex in ->open /
> ->release") changing context of the fourth hunk in
> drivers/block/loop.c .

Normally the stable process takes care of such trivial changes.  I'll
wait for the next batch and if not take care of it manually.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0FA528401
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiEPMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiEPMSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:18:01 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912362BB22
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:17:55 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hh4so11842596qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6WoWussqs/nE0WQFdCOfcolnwp+yEL3nnakgRyZRHVE=;
        b=dNPrnAOHFoYC1Szl537Ai+cBSuuvzo2sTNk+SMetEJzZpdGUqXGFGgUSqKF5vBUjYm
         gMwOGHC24+4HHAibvvjAofcotuJ36Rac28QKstG6THDLsWqpUIzPO7pFtceJPS2bueKl
         k6Q6FW3PpcgUCsCghBOONcWHLu0+iLgzdH68yD6hOCOCzmJoTVpUU82s70otH7dJRi70
         CvCx2eMkWmxccQUs7E0erTwIIsfKLvELEoEUxLBCQqyZrq9M9U/bAL/9H9t/px39opul
         Yvr+ep+zr9xXjHghZx2ZPyP+bdFM1UDY/fE14VXGXL6w8ZCVS+e68RZVteHzg1sPewih
         S/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6WoWussqs/nE0WQFdCOfcolnwp+yEL3nnakgRyZRHVE=;
        b=TLZnMt5+6w0Kr6gVCU5+TMdnA8WoNSNDYfi93IMVelUrA/as/MwQyAWqElx71fMYlm
         +EsT2/C+aP4LjC2+geniuOA6uwX3pYVntiJ5SehYND4Uw3Wdiw1N7pIRT3yqAAVRi2oU
         ZLYktvX8MCD/9da7/EoMf7V/lGX7yKa0QNwm1Z3sTcMEVm96/tbXZtJuebzeKRRCG+ul
         qzqopcfDO5xRoYpvRfYrLwJCw+fb78XoAlgzVz69fK5Flyos405PMssrxJhInMPwCwAs
         Dp0PGpx15OhVcoebtUFyzPwz9K8XsV8eSCnKCVBAT1yr4GXttIJYjTWjF/dZIRLJwLwx
         bPVw==
X-Gm-Message-State: AOAM530h0NNr6dUGOTKJn0avtZqIYKGFH+tMmByHc8tYPi8fjqwxI89n
        rcUzlifll8JgWzCA33xkoeWEgA==
X-Google-Smtp-Source: ABdhPJzqEm7QHW/ub0pHz6AYCmev82zktUJyJxo3YCahnMnuMg5LtLrY7OUuAcE3jTIC8fdqjXBpvg==
X-Received: by 2002:ac8:584a:0:b0:2f7:b19b:f9b6 with SMTP id h10-20020ac8584a000000b002f7b19bf9b6mr6722119qth.683.1652703474556;
        Mon, 16 May 2022 05:17:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a128-20020ae9e886000000b006a2e2dde144sm2751831qkg.88.2022.05.16.05.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:17:53 -0700 (PDT)
Date:   Mon, 16 May 2022 08:17:52 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Matthew Ruffell <matthew.ruffell@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] nbd requests become stuck when devices watched by
 inotify emit udev uevent changes
Message-ID: <YoJA8C2XtXY27qJ1@localhost.localdomain>
References: <20220422054224.19527-1-matthew.ruffell@canonical.com>
 <CAEzrpqe=LD3DQcEeLXmmFuq7cX_dAQ6DOCuJYWBoZWKKTmoTzA@mail.gmail.com>
 <CAKAwkKt3yMOOW3NXcE91WkGr+8xj050CYP2pLoQVHt_2wXq=-w@mail.gmail.com>
 <CAKAwkKvfFn18RjupuqGpx4QeAiMYKSq7QUTd3wEL=pkZ+BENpQ@mail.gmail.com>
 <Yn5Zf6lONff1AoOA@localhost.localdomain>
 <6efae367-12fa-1a58-7438-1b39dc0d6ef8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6efae367-12fa-1a58-7438-1b39dc0d6ef8@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 11:39:25AM +0800, yukuai (C) wrote:
> 在 2022/05/13 21:13, Josef Bacik 写道:
> > On Fri, May 13, 2022 at 02:56:18PM +1200, Matthew Ruffell wrote:
> > > Hi Josef,
> > > 
> > > Just a friendly ping, I am more than happy to test a patch, if you send it
> > > inline in the email, since the pastebin you used expired after 1 day, and I
> > > couldn't access it.
> > > 
> > > I came across and tested Yu Kuai's patches [1][2] which are for the same issue,
> > > and they indeed fix the hang. Thank you Yu.
> > > 
> > > [1] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
> > > https://lists.debian.org/nbd/2022/04/msg00212.html
> > > 
> > > [2] nbd: fix io hung while disconnecting device
> > > https://lists.debian.org/nbd/2022/04/msg00207.html
> > > 
> > > I am also happy to test any patches to fix the I/O errors.
> > > 
> > 
> > Sorry, you caught me on vacation before and I forgot to reply.  Here's part one
> > of the patch I wanted you to try which fixes the io hung part.  Thanks,
> > 
> > Josef
> > 
> > > From 0a6123520380cb84de8ccefcccc5f112bce5efb6 Mon Sep 17 00:00:00 2001
> > Message-Id: <0a6123520380cb84de8ccefcccc5f112bce5efb6.1652447517.git.josef@toxicpanda.com>
> > From: Josef Bacik <josef@toxicpanda.com>
> > Date: Sat, 23 Apr 2022 23:51:23 -0400
> > Subject: [PATCH] timeout thing
> > 
> > ---
> >   drivers/block/nbd.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 526389351784..ab365c0e9c04 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -1314,7 +1314,10 @@ static void nbd_config_put(struct nbd_device *nbd)
> >   		kfree(nbd->config);
> >   		nbd->config = NULL;
> > -		nbd->tag_set.timeout = 0;
> > +		/* Reset our timeout to something sane. */
> > +		nbd->tag_set.timeout = 30 * HZ;
> > +		blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
> > +
> >   		nbd->disk->queue->limits.discard_granularity = 0;
> >   		nbd->disk->queue->limits.discard_alignment = 0;
> >   		blk_queue_max_discard_sectors(nbd->disk->queue, 0);
> > 
> Hi, Josef
> 
> This seems to try to fix the same problem that I described here:
> 
> nbd: fix io hung while disconnecting device
> https://lists.debian.org/nbd/2022/04/msg00207.html
> 
> There are still some io that are stuck, which means the devcie is
> probably still opened. Thus nbd_config_put() can't reach here.
> I'm afraid this patch can't fix the io hung.
> 
> Matthew, can you try a test with this patch together with my patch below
> to comfirm my thought?
> 
> nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
> https://lists.debian.org/nbd/2022/04/msg00212.html.
> 

Re-submit this one, but fix it so we just test the bit to see if we need to skip
it, and change it so we only CLEAR when we're sure we're going to complete the
request.  Thanks,

Josef

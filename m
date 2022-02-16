Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6B14B8EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbiBPREo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:04:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiBPREn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:04:43 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FAA2A523F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:04:30 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id s1so511116ioe.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ebPURKf0/zwBkSiUOG+tDveD/Pc8B6gk0N6+zX/eOg=;
        b=caoErfXVMhneOKUMlH+nxW0INIgrQ6Nixn6Vi1TMYKcG/GLqZqDmKTDkIvgsRkeaD/
         D23NXdh9zJO3y9F+AUOh0pdkVYWp97CEqabIdSuNSwmPY2KhgQOKl9abEnjygdbzg99P
         E6SBxO32A89HTTbx9T25u753a5gO/G32bKzFmNSMSMmCaSiEcAZs5aFpsiN58JDbngj5
         vnsEUBUX5yYACAWkw/+xSiUT8cNiAtZLMaI7HBppC4OMvDGzV9d505sF/S4jqimQ5ifB
         /ow4wkKuqMsNRWj3gWER0cRP8hIeYPd5ohPLztTOaXC4IyOARvq/awhPGOlZRi72fLBz
         NwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ebPURKf0/zwBkSiUOG+tDveD/Pc8B6gk0N6+zX/eOg=;
        b=5a2kV0QX80rnYOia9rpbz4iDd8fDgS2TMMixU+nC8R1KXo7Nz1RVI9rRBQhZggyhKK
         OlP5N1d1n+4om2m3gD+Wrv0qnikVXjKUs1N2Ud5kJVTc02+F+f+4qyoVmPCwOsLb35yP
         vD2L2meL52oUwMyjfepqird6/FrPCM2+1MOAEHT/t+hswxVU3A5qwPPViMa2BCe1eaeG
         kRMe9lZRQtoy+NgCVumkf/dwLNlaEhtM/B5XTtf207Vi4HFrgQMc6WnD0enpxmnk3b2d
         y8LY47yKWS2rt+uAJMD6+Uo52aRXJsZ8ewhnaULrkUeLD0EbBHWwLIdldan8A7x+iCDy
         NNOg==
X-Gm-Message-State: AOAM531G1rIbbm8mWjCJT+gto/70NsVnV0TttLHhZNP9Qk5REqGBCrYH
        tJaHqHvv9AypbhpNmPWylReH36Tw3kHx0Cp0m3k=
X-Google-Smtp-Source: ABdhPJx1pOzGdJ0I5ZGWUdukwje0VchP9Q2Dpzte/hebLd/x02Xsa9rd474WbNtX+50nkoXg8naKRuuHmHa3wNyQnkM=
X-Received: by 2002:a5e:8c15:0:b0:634:478e:450e with SMTP id
 n21-20020a5e8c15000000b00634478e450emr2504490ioj.56.1645031070215; Wed, 16
 Feb 2022 09:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
 <20220111161937.56272-2-pankaj.gupta.linux@gmail.com> <CAPcyv4jrVJ_B0N_-vtqgXaOMovUgnSLCNj228nWMRhGAC5PDhA@mail.gmail.com>
 <CAM9Jb+i0B2jZ0uCEDyiz8ujuMkioFgOA0r7Lz9wDK026Vq1Hxg@mail.gmail.com> <CAPcyv4gJGB8+acXKXbpEpMck_y=XBMR0B0c255MaSyLsH4+eZA@mail.gmail.com>
In-Reply-To: <CAPcyv4gJGB8+acXKXbpEpMck_y=XBMR0B0c255MaSyLsH4+eZA@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 16 Feb 2022 18:04:19 +0100
Message-ID: <CAM9Jb+hbds3b+nY9APU40Fpd9pt4CyFuZ3SU4ZB05subnaJQvQ@mail.gmail.com>
Subject: Re: [RFC v3 1/2] virtio-pmem: Async virtio-pmem flush
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Pankaj Gupta <pankaj.gupta@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > > >
> > > > Enable asynchronous flush for virtio pmem using work queue. Also,
> > > > coalesce the flush requests when a flush is already in process.
> > > > This functionality is copied from md/RAID code.
> > > >
> > > > When a flush is already in process, new flush requests wait till
> > > > previous flush completes in another context (work queue). For all
> > > > the requests come between ongoing flush and new flush start time, only
> > > > single flush executes, thus adhers to flush coalscing logic. This is
> > >
> > > s/adhers/adheres/
> > >
> > > s/coalscing/coalescing/
> > >
> > > > important for maintaining the flush request order with request coalscing.
> > >
> > > s/coalscing/coalescing/
> >
> > o.k. Sorry for the spelling mistakes.
> >
> > >
> > > >
> > > > Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > > > ---
> > > >  drivers/nvdimm/nd_virtio.c   | 74 +++++++++++++++++++++++++++---------
> > > >  drivers/nvdimm/virtio_pmem.c | 10 +++++
> > > >  drivers/nvdimm/virtio_pmem.h | 16 ++++++++
> > > >  3 files changed, 83 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > > > index 10351d5b49fa..179ea7a73338 100644
> > > > --- a/drivers/nvdimm/nd_virtio.c
> > > > +++ b/drivers/nvdimm/nd_virtio.c
> > > > @@ -100,26 +100,66 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
> > > >  /* The asynchronous flush callback function */
> > > >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > > >  {
> > > > -       /*
> > > > -        * Create child bio for asynchronous flush and chain with
> > > > -        * parent bio. Otherwise directly call nd_region flush.
> > > > +       /* queue asynchronous flush and coalesce the flush requests */
> > > > +       struct virtio_device *vdev = nd_region->provider_data;
> > > > +       struct virtio_pmem *vpmem  = vdev->priv;
> > > > +       ktime_t req_start = ktime_get_boottime();
> > > > +       int ret = -EINPROGRESS;
> > > > +
> > > > +       spin_lock_irq(&vpmem->lock);
> > >
> > > Why a new lock and not continue to use ->pmem_lock?
> >
> > This spinlock is to protect entry in 'wait_event_lock_irq'
> > and the Other spinlock is to protect virtio queue data.
>
> Understood, but md shares the mddev->lock for both purposes, so I
> would ask that you either document what motivates the locking split,
> or just reuse the lock until a strong reason to split them arises.

O.k. Will check again if we could use same lock Or document it.

Thanks,
Pankaj

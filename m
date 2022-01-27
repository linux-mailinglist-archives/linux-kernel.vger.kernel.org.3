Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF2249EA42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiA0STM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiA0STL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:19:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0564FC061714;
        Thu, 27 Jan 2022 10:19:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p15so7660798ejc.7;
        Thu, 27 Jan 2022 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wglz3dr5ZpuUB19weHhKOPZc6B5K17v8WIbIql7h9W0=;
        b=p8cPHrBHfI2Xa/NYWfEX2poYrDPVPBpKYaj5k7mUk6l36aaSONsH/+xh+699rRMoWz
         QOed+qwuemq3N3FHfNwk/8vhbs++LUBRETC8U5DCGeG6hgAPrAAob0ewJsewKZBPT3+5
         MT7ncl6+bzdEONRzsghe9jweiU3zxRWt/iX+rAXjFzEKZkqNcPy5MwDZOwu88HtalcQD
         yqUYgZ3/cyYA/JAYeUKBU2kTBDd9CvbazPXR7pnkkrFGNqu3cTmPKS0RGrY4rkqLXA0a
         2crC9NVKguUuaG2UGq48VUTl5ukPKeUG4Dr7Wly7C7gRygYFMDtk1AvZuz/2Tb3LSgxN
         +z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wglz3dr5ZpuUB19weHhKOPZc6B5K17v8WIbIql7h9W0=;
        b=PBSY/MtGyQxJCV5IjZS0IWg2pCPN4X+/0z9VZsr5JRQ/2hCx9cCmZS5hzv3Ehmxda2
         okPiIRT2YaS/SP27pqm1P0cmM6C6zri+stffDvJPO2o7SHbEnqk49J3+xnzXDw9/qxpA
         ryWZoFHcWsXjW7xRaLBAugYxmMmfV+FDomeev0eSDF7Piij0HdTKb094b0DXDS8XMNAO
         jGT9vuFgihVOEQ+JVfkLcI+LZZAe7H/WDHuoq9h1mzhXFnj93NT7swVQ4uoCr96HZ94k
         OkgSzPUW5WlLMzOi1XCwvUsS04EEFxpRmlDWWvt2ctF5PArTvsaobqzePg+95ulbdmrl
         FENA==
X-Gm-Message-State: AOAM531UpwNBFWhNgJ0TZDQB8n2OH2EhzARnPIMuCv95WGB2St3n1iyf
        b6G6zfWViquPX0ccSQOiP+ULS4R953ETt8XyMuE=
X-Google-Smtp-Source: ABdhPJz/7zIlKJilq8uD9xEg1mcY1MjfoHMMFmP5AlF8DzelAIiS0RiwrGjf+i9foz4wPbqbRrv/pflJdjaXxW0np5A=
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr3920805ejc.637.1643307549496;
 Thu, 27 Jan 2022 10:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20220126185153.417948-1-shy828301@gmail.com> <8de293cb-168b-5a52-3791-dba36ef4217d@nvidia.com>
In-Reply-To: <8de293cb-168b-5a52-3791-dba36ef4217d@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 27 Jan 2022 10:18:57 -0800
Message-ID: <CAHbLzkpHg2uxYqWSqCsYJrFGdC+T6Vpnwkoe2bY1k8AkW6NiTA@mail.gmail.com>
Subject: Re: [v5 PATCH] block: introduce block_rq_error tracepoint
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:02 AM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 1/26/22 10:51 AM, Yang Shi wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Currently, rasdaemon uses the existing tracepoint block_rq_complete
> > and filters out non-error cases in order to capture block disk errors.
> >
> > But there are a few problems with this approach:
> >
> > 1. Even kernel trace filter could do the filtering work, there is
> >     still some overhead after we enable this tracepoint.
> >
> > 2. The filter is merely based on errno, which does not align with kernel
> >     logic to check the errors for print_req_error().
> >
> > 3. block_rq_complete only provides dev major and minor to identify
> >     the block device, it is not convenient to use in user-space.
> >
> > So introduce a new tracepoint block_rq_error just for the error case
> > and provides the device name for convenience too. With this patch,
> > rasdaemon could switch to block_rq_error.
> >
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> > The v3 patch was submitted in Feb 2020, and Steven reviewed the patch, but
> > it was not merged to upstream. See
> > https://lore.kernel.org/lkml/20200203053650.8923-1-xiyou.wangcong@gmail.com/.
> >
> > The problems fixed by that patch still exist and we do need it to make
> > disk error handling in rasdaemon easier. So this resurrected it and
> > continued the version number.
> >
> > v4 --> v5:
> >   * Report the actual block layer status code instead of the errno per
> >     Christoph Hellwig.
> > v3 --> v4:
> >   * Rebased to v5.17-rc1.
> >   * Collected reviewed-by tag from Steven.
> >
> >   block/blk-mq.c               |  4 +++-
> >   include/trace/events/block.h | 41 ++++++++++++++++++++++++++++++++++++
> >   2 files changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index f3bf3358a3bb..4ca72ea917d4 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -789,8 +789,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
> >   #endif
> >
> >          if (unlikely(error && !blk_rq_is_passthrough(req) &&
> > -                    !(req->rq_flags & RQF_QUIET)))
> > +                    !(req->rq_flags & RQF_QUIET))) {
> > +               trace_block_rq_error(req, error, nr_bytes);
> >                  blk_print_req_error(req, error);
> > +       }
> >
> >          blk_account_io_completion(req, nr_bytes);
> >
> > diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> > index 27170e40e8c9..918b190718d5 100644
> > --- a/include/trace/events/block.h
> > +++ b/include/trace/events/block.h
> > @@ -144,6 +144,47 @@ TRACE_EVENT(block_rq_complete,
> >                    __entry->nr_sector, __entry->error)
> >   );
> >
> > +/**
> > + * block_rq_error - block IO operation error reported by device driver
> > + * @rq: block operations request
> > + * @error: status code
> > + * @nr_bytes: number of completed bytes
> > + *
> > + * The block_rq_error tracepoint event indicates that some portion
> > + * of operation request has failed as reported by the device driver.
> > + */
> > +TRACE_EVENT(block_rq_error,
> > +
> > +       TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
> > +
> > +       TP_ARGS(rq, error, nr_bytes),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(  dev_t,        dev                     )
> > +               __string( name,         rq->q->disk ? rq->q->disk->disk_name : "?")
> > +               __field(  sector_t,     sector                  )
> > +               __field(  unsigned int, nr_sector               )
> > +               __field(  int,          error                   )
> > +               __array(  char,         rwbs,   RWBS_LEN        )
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->dev       = rq->q->disk ? disk_devt(rq->q->disk) : 0;
> > +               __assign_str(name,   rq->q->disk ? rq->q->disk->disk_name : "?");
>
> Did you verify that rq->q->disk NULL checks are must in this checkout
> for blk_update_request() ?
>
> > +               __entry->sector    = blk_rq_pos(rq);
> > +               __entry->nr_sector = nr_bytes >> 9;
> > +               __entry->error     = blk_status_to_errno(error);
> > +
> > +               blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
> > +       ),
> > +
> > +       TP_printk("%d,%d %s %s %llu + %u [%d]",
> > +                 MAJOR(__entry->dev), MINOR(__entry->dev),
> > +                 __get_str(name), __entry->rwbs,
>
> Since printing major number and minor number is sufficient to identify
> the block device. We don't have a notion of printing disk_name for the
> block tracepoints what makes this tracepoint special ?

Thanks for the comments, will remove it to follow the convention.

>
> > +                 (unsigned long long)__entry->sector,
> > +                 __entry->nr_sector, __entry->error)
> > +);
> > +
> >   DECLARE_EVENT_CLASS(block_rq,
> >
> >          TP_PROTO(struct request *rq),
> > --
> > 2.26.3
> >
>

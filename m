Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294CB54DBE6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359537AbiFPHgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFPHgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:36:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEA02604
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:36:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id f7so386045ilr.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E5BwCHaHvcf1wbBWUk6t9iPl0/Tr2CgxtxTHhrP5wxQ=;
        b=DEKhrcSsLol4yvUgMgL1+AIUj1xqMgZFtQYIKIF6JTm0+9ApXENQHioyBo1WqC4B/N
         5IhCOkMt+UwULcoJqUmtMKKtJjHx5jcwjJl3XuTYiUAMC4Om1acURjKnCx4Az5Jr3vyU
         O6xNDRlcBIBOnlIbWMriE0nBZ7LYiXocVk6MLVfo12qMrxw0qoQWRhJvob7p92fTT7xb
         rStQEssGvqQUBfKiTsP53IC1x4kdQblQTk06Apn+HqvhXFQ8owqzK+WvqPAgcxm3YhN+
         dMXXLjdfIfMz/qpbmCEyWGxOMZCv79SZ9nUyuIz0pQ9FfZ/fJxLHwqUhOKT7NKZQjmd/
         GJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E5BwCHaHvcf1wbBWUk6t9iPl0/Tr2CgxtxTHhrP5wxQ=;
        b=sPfYMw5pEp4qQ7US/+HKVqF8sHv+UFdMHmWDsqAnqcvtOzu6Hn6NKprkmOSZR3f2zr
         cjdHA8UNo3zbPbrgr+BopxvsWSzs4+dzBEhuGoqaWnMqiqSY8/0+hVeGYqUV9ch+cK/G
         4lxLXF6oMw5TFKcIBq/eC4ABdMPy7nmse+YRT6rOeWIpFDYS5KprDbeSqgv8+rXJjzAl
         rIHd/WrZJevYN9mVm0TbbTAd8U7KCZatDH3M4mLR3NCqEGJzeqCeVQ0HKkFCupDSphkX
         Zo3iFLqaYbjwIsYCqfMr8gbxdpvLYEhLZrMOw7B0uLCV/XA95NO5APfrd6w2iM2Pg07P
         d8OA==
X-Gm-Message-State: AJIora+KZstYljiRdV0jFxxgLkBpdXyia5YbCqPeZsAf02dU5S3WHLd5
        fBEmD9ywB85lloldmCW0O79JcTAoQfHR2JUAt6rNDztooJeA2kdz
X-Google-Smtp-Source: AGRyM1vT0jGbBtQQ+4XMSagb0UsV84407+jlDgqf6tDDFXf3CakodiJxOxK8QDUZbO6nMwP5zvGrkW4pJXB7VsqUbiI=
X-Received: by 2002:a05:6e02:148c:b0:2d1:8e79:17d0 with SMTP id
 n12-20020a056e02148c00b002d18e7917d0mr2000558ilk.314.1655365002440; Thu, 16
 Jun 2022 00:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEtz-1=3=+zUZvc+CX4LrufZZfZO=_zONo5GuAUX+BrpAQ@mail.gmail.com>
 <20220616051221.28506-1-huangjie.albert@bytedance.com> <20220616023904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220616023904-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Thu, 16 Jun 2022 15:36:31 +0800
Message-ID: <CABKxMyM-bOXZ8J=_JWS1_Lvx-Qj3gKH=mHjW1CKTc=k=2XYFMg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] virtio_ring : keep used_wrap_counter in vq->last_used_idx
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, yuanzhu@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin <mst@redhat.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B 14:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 16, 2022 at 01:12:21PM +0800, Albert Huang wrote:
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >
> > the used_wrap_counter and the vq->last_used_idx may get
> > out of sync if they are separate assignment=EF=BC=8Cand interrupt
> > might use an incorrect value to check for the used index.
> >
> > for example:OOB access
> > ksoftirqd may consume the packet and it will call:
> > virtnet_poll
> >       -->virtnet_receive
> >               -->virtqueue_get_buf_ctx
> >                       -->virtqueue_get_buf_ctx_packed
> > and in virtqueue_get_buf_ctx_packed:
> >
> > vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> > if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
> >          vq->last_used_idx -=3D vq->packed.vring.num;
> >          vq->packed.used_wrap_counter ^=3D 1;
> > }
> >
> > if at the same time, there comes a vring interrupt=EF=BC=8Cin vring_int=
errupt:
> > we will call:
> > vring_interrupt
> >       -->more_used
> >               -->more_used_packed
> >                       -->is_used_desc_packed
> > in is_used_desc_packed, the last_used_idx maybe >=3D vq->packed.vring.n=
um.
> > so this could case a memory out of bounds bug.
> >
> > this patch is to keep the used_wrap_counter in vq->last_used_idx
> > so we can get the correct value to check for used index in interrupt.
> >
> > v1->v2:
> > - reuse the VRING_PACKED_EVENT_F_WRAP_CTR
> > - Remove parameter judgment in is_used_desc_packed,
> > because it can't be illegal
> >
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 57 ++++++++++++++++++++----------------
> >  1 file changed, 31 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 13a7348cedff..b22d97c9a755 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -111,7 +111,12 @@ struct vring_virtqueue {
> >       /* Number we've added since last sync. */
> >       unsigned int num_added;
> >
> > -     /* Last used index we've seen. */
> > +     /* Last used index  we've seen.
> > +      * for split ring, it just contains last used index
> > +      * for packed ring, it not only contains last used index, but als=
o
> > +      * used_wrap_counter, the VRING_PACKED_EVENT_F_WRAP_CTR is
> > +      * the bit shift in last_used_idx
> > +      */
> >       u16 last_used_idx;
> >
> >       /* Hint for event idx: already triggered no need to disable. */
> > @@ -154,9 +159,6 @@ struct vring_virtqueue {
> >                       /* Driver ring wrap counter. */
> >                       bool avail_wrap_counter;
> >
> > -                     /* Device ring wrap counter. */
> > -                     bool used_wrap_counter;
> > -
> >                       /* Avail used flags. */
> >                       u16 avail_used_flags;
> >
> > @@ -1406,8 +1408,12 @@ static inline bool is_used_desc_packed(const str=
uct vring_virtqueue *vq,
> >
> >  static inline bool more_used_packed(const struct vring_virtqueue *vq)
> >  {
> > -     return is_used_desc_packed(vq, vq->last_used_idx,
> > -                     vq->packed.used_wrap_counter);
> > +     u16 last_used;
> > +     bool used_wrap_counter;
> > +
> > +     last_used =3D vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRA=
P_CTR);
> > +     used_wrap_counter =3D !!((vq->last_used_idx) >> VRING_PACKED_EVEN=
T_F_WRAP_CTR);
> > +     return is_used_desc_packed(vq, last_used, used_wrap_counter);
>
> Hmm.
>
> If vq->last_used_idx is read twice like this the values can be inconsiste=
nt,
> no idea what the result will be if so.
>
> I think we need to read vq->last_used_idx with READ_ONCE.
>
> And I guess write it with WRITE_ONCE for symmetry.
>

if we read vq->last_used_idx with READ_ONCE. for example:

1)last_used =3D READ_ONCE (vq->last_used_idx) & ~(1 <<
VRING_PACKED_EVENT_F_WRAP_CTR);
2)used_wrap_counter =3D !!((READ_ONCE (vq->last_used_idx)) >>
VRING_PACKED_EVENT_F_WRAP_CTR);

1 and 2 may get different values, so think this will be better:
last_used_idx =3D vq->last_used_idx;
last_used =3D last_used_idx& ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
used_wrap_counter =3D !!((last_used_idx) >> VRING_PACKED_EVENT_F_WRAP_CTR);

what do you think=EF=BC=9F

>
> >  }
> >
> >  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > @@ -1416,6 +1422,7 @@ static void *virtqueue_get_buf_ctx_packed(struct =
virtqueue *_vq,
> >  {
> >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> >       u16 last_used, id;
> > +     bool used_wrap_counter;
> >       void *ret;
> >
> >       START_USE(vq);
> > @@ -1434,7 +1441,8 @@ static void *virtqueue_get_buf_ctx_packed(struct =
virtqueue *_vq,
> >       /* Only get used elements after they have been exposed by host. *=
/
> >       virtio_rmb(vq->weak_barriers);
> >
> > -     last_used =3D vq->last_used_idx;
> > +     used_wrap_counter =3D !!((vq->last_used_idx >> VRING_PACKED_EVENT=
_F_WRAP_CTR));
> > +     last_used =3D (vq->last_used_idx) & (~(1 << VRING_PACKED_EVENT_F_=
WRAP_CTR));
> >       id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);
> >       *len =3D le32_to_cpu(vq->packed.vring.desc[last_used].len);
> >
> > @@ -1451,12 +1459,15 @@ static void *virtqueue_get_buf_ctx_packed(struc=
t virtqueue *_vq,
> >       ret =3D vq->packed.desc_state[id].data;
> >       detach_buf_packed(vq, id, ctx);
> >
> > -     vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> > -     if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
> > -             vq->last_used_idx -=3D vq->packed.vring.num;
> > -             vq->packed.used_wrap_counter ^=3D 1;
> > +     last_used +=3D vq->packed.desc_state[id].num;
> > +     if (unlikely(last_used >=3D vq->packed.vring.num)) {
> > +             last_used -=3D vq->packed.vring.num;
> > +             used_wrap_counter ^=3D 1;
> >       }
> >
> > +     last_used =3D (last_used | (used_wrap_counter << VRING_PACKED_EVE=
NT_F_WRAP_CTR));
> > +     vq->last_used_idx =3D last_used;
> > +
> >       /*
> >        * If we expect an interrupt for the next entry, tell host
> >        * by writing event index and flush out the write before
> > @@ -1465,9 +1476,7 @@ static void *virtqueue_get_buf_ctx_packed(struct =
virtqueue *_vq,
> >       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_=
DESC)
> >               virtio_store_mb(vq->weak_barriers,
> >                               &vq->packed.vring.driver->off_wrap,
> > -                             cpu_to_le16(vq->last_used_idx |
> > -                                     (vq->packed.used_wrap_counter <<
> > -                                      VRING_PACKED_EVENT_F_WRAP_CTR)))=
;
> > +                             cpu_to_le16(vq->last_used_idx));
> >
> >       LAST_ADD_TIME_INVALID(vq);
> >
> > @@ -1499,9 +1508,7 @@ static unsigned int virtqueue_enable_cb_prepare_p=
acked(struct virtqueue *_vq)
> >
> >       if (vq->event) {
> >               vq->packed.vring.driver->off_wrap =3D
> > -                     cpu_to_le16(vq->last_used_idx |
> > -                             (vq->packed.used_wrap_counter <<
> > -                              VRING_PACKED_EVENT_F_WRAP_CTR));
> > +                     cpu_to_le16(vq->last_used_idx);
> >               /*
> >                * We need to update event offset and event wrap
> >                * counter first before updating event flags.
> > @@ -1518,8 +1525,7 @@ static unsigned int virtqueue_enable_cb_prepare_p=
acked(struct virtqueue *_vq)
> >       }
> >
> >       END_USE(vq);
> > -     return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <<
> > -                     VRING_PACKED_EVENT_F_WRAP_CTR);
> > +     return vq->last_used_idx;
> >  }
> >
> >  static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> > @@ -1550,9 +1556,9 @@ static bool virtqueue_enable_cb_delayed_packed(st=
ruct virtqueue *_vq)
> >       if (vq->event) {
> >               /* TODO: tune this threshold */
> >               bufs =3D (vq->packed.vring.num - vq->vq.num_free) * 3 / 4=
;
> > -             wrap_counter =3D vq->packed.used_wrap_counter;
> > +             wrap_counter =3D !!(vq->last_used_idx >> VRING_PACKED_EVE=
NT_F_WRAP_CTR);
> >
> > -             used_idx =3D vq->last_used_idx + bufs;
> > +             used_idx =3D (vq->last_used_idx & ~(1 << VRING_PACKED_EVE=
NT_F_WRAP_CTR)) + bufs;
> >               if (used_idx >=3D vq->packed.vring.num) {
> >                       used_idx -=3D vq->packed.vring.num;
> >                       wrap_counter ^=3D 1;
> > @@ -1582,9 +1588,9 @@ static bool virtqueue_enable_cb_delayed_packed(st=
ruct virtqueue *_vq)
> >        */
> >       virtio_mb(vq->weak_barriers);
> >
> > -     if (is_used_desc_packed(vq,
> > -                             vq->last_used_idx,
> > -                             vq->packed.used_wrap_counter)) {
> > +     wrap_counter =3D !!(vq->last_used_idx >> VRING_PACKED_EVENT_F_WRA=
P_CTR);
> > +     used_idx =3D (vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRA=
P_CTR));
> > +     if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> >               END_USE(vq);
> >               return false;
> >       }
> > @@ -1689,7 +1695,7 @@ static struct virtqueue *vring_create_virtqueue_p=
acked(
> >       vq->notify =3D notify;
> >       vq->weak_barriers =3D weak_barriers;
> >       vq->broken =3D true;
> > -     vq->last_used_idx =3D 0;
> > +     vq->last_used_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
> >       vq->event_triggered =3D false;
> >       vq->num_added =3D 0;
> >       vq->packed_ring =3D true;
> > @@ -1720,7 +1726,6 @@ static struct virtqueue *vring_create_virtqueue_p=
acked(
> >
> >       vq->packed.next_avail_idx =3D 0;
> >       vq->packed.avail_wrap_counter =3D 1;
> > -     vq->packed.used_wrap_counter =3D 1;
> >       vq->packed.event_flags_shadow =3D 0;
> >       vq->packed.avail_used_flags =3D 1 << VRING_PACKED_DESC_F_AVAIL;
> >
> > --
> > 2.31.1
>

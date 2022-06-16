Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A854DBFD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359384AbiFPHkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359652AbiFPHjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:39:49 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930C65C370
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:39:39 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 19so663684iou.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2NZfzUnIe15BwHtBAtHoh9uWwKk1w8MTJsEiQyPaxBs=;
        b=tBAKsSvEfqgDarYzQTRCAEedLAuYfAyGBoL/2VuGwV+goK3InU2AUZfry4u1jZnVYL
         mf73/4tPVcWPg+50mLipV2tcJ1wZgRy4xHvYA31y6EBXiPR1HJ1uxMb59jz01Q8lCKNC
         yaXuxS4mcHaZLzpBw+7MmbeImPpclMeC/nuHa35wt9vsFIkrxQd2gdh51b2lH1P4M83i
         qbeH3avti0j/Mg8Ul1oeNRfuT34NtcIDybyUoFYgtvJufX9WDiazzDG8k2NRPZqK4SDw
         42mPng/84taeiUMKevGI/jK1VYV+okNaoUxwOG3w1Pb8o+eksr4wzEugc841pEF241Jz
         Uf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2NZfzUnIe15BwHtBAtHoh9uWwKk1w8MTJsEiQyPaxBs=;
        b=qmxTUi6BTZ5w1zgVLSYcIpGlPLlomK/BpeTzBg30PWQLNBXgmRdUIDVT0sUwguqot3
         LFENbsPPuXLWuy5eeesaFEfNSZ7+Gh4kqRPkxxBg0vOrTcR9vH5MPw+G4ltUrhuTKuvA
         95iFk3IfM1sNziX2uJrVptHQqYiNcTmRnwwz7S3CvwH2PQ0eDGZjg40RAWbZ56pL1Zta
         LDZUrZPf337+kRBZx/W8FHmgbe7EJp0jcpYmjhBK/DzgvOaObZeHeU79fhY6TloFOS+E
         X3PuizqNxiMh5bGXqmKW5JAAZS+dCb1uR5bRXdhOFlUXFNqfIyZ14FeNFrqBERLxw9EP
         eVDQ==
X-Gm-Message-State: AJIora+tw2DUFFYXN2L8g/oTaaP2i/FKY6iYMvl08kQXACOKj8tCfn4Y
        zhgLoVsMdxfqV6WmFMQc1nXAC801Fa1PWz8rpEOxWEuxX8IWcoGp
X-Google-Smtp-Source: AGRyM1t951G+xl/vdyFM3ALX07JLGqjnGB4fK8qm11VpocSYE7w+3oPKk3sh+jFbe3BazyA9BnOF0ujccmvFJEDkQhg=
X-Received: by 2002:a05:6638:1117:b0:331:4bc8:3856 with SMTP id
 n23-20020a056638111700b003314bc83856mr1834203jal.128.1655365178965; Thu, 16
 Jun 2022 00:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEtz-1=3=+zUZvc+CX4LrufZZfZO=_zONo5GuAUX+BrpAQ@mail.gmail.com>
 <20220616051221.28506-1-huangjie.albert@bytedance.com> <20220616015331-mutt-send-email-mst@kernel.org>
 <20220616024148-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220616024148-mutt-send-email-mst@kernel.org>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Thu, 16 Jun 2022 15:39:27 +0800
Message-ID: <CABKxMyM5+eWLUenLgR+PHYErXX_-h5MNSwxaZNeZVmDL4Hy0Wg@mail.gmail.com>
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
=97=A5=E5=91=A8=E5=9B=9B 14:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 16, 2022 at 02:07:19AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 16, 2022 at 01:12:21PM +0800, Albert Huang wrote:
> > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > >
> > > the used_wrap_counter and the vq->last_used_idx may get
> > > out of sync if they are separate assignment=EF=BC=8Cand interrupt
> > > might use an incorrect value to check for the used index.
> > >
> > > for example:OOB access
> > > ksoftirqd may consume the packet and it will call:
> > > virtnet_poll
> > >     -->virtnet_receive
> > >             -->virtqueue_get_buf_ctx
> > >                     -->virtqueue_get_buf_ctx_packed
> > > and in virtqueue_get_buf_ctx_packed:
> > >
> > > vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> > > if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
> > >          vq->last_used_idx -=3D vq->packed.vring.num;
> > >          vq->packed.used_wrap_counter ^=3D 1;
> > > }
> > >
> > > if at the same time, there comes a vring interrupt=EF=BC=8Cin vring_i=
nterrupt:
> > > we will call:
> > > vring_interrupt
> > >     -->more_used
> > >             -->more_used_packed
> > >                     -->is_used_desc_packed
> > > in is_used_desc_packed, the last_used_idx maybe >=3D vq->packed.vring=
.num.
> > > so this could case a memory out of bounds bug.
> > >
> > > this patch is to keep the used_wrap_counter in vq->last_used_idx
> > > so we can get the correct value to check for used index in interrupt.
> > >
> > > v1->v2:
> > > - reuse the VRING_PACKED_EVENT_F_WRAP_CTR
> > > - Remove parameter judgment in is_used_desc_packed,
> > > because it can't be illegal
> > >
> > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> >
> >
> > This looks good, just a small suggestion below:
> >
> > > ---
> > >  drivers/virtio/virtio_ring.c | 57 ++++++++++++++++++++--------------=
--
> > >  1 file changed, 31 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 13a7348cedff..b22d97c9a755 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -111,7 +111,12 @@ struct vring_virtqueue {
> > >     /* Number we've added since last sync. */
> > >     unsigned int num_added;
> > >
> > > -   /* Last used index we've seen. */
> > > +   /* Last used index  we've seen.
> > > +    * for split ring, it just contains last used index
> > > +    * for packed ring, it not only contains last used index, but als=
o
> > > +    * used_wrap_counter, the VRING_PACKED_EVENT_F_WRAP_CTR is
> > > +    * the bit shift in last_used_idx
> > > +    */
> > >     u16 last_used_idx;
> > >
> > >     /* Hint for event idx: already triggered no need to disable. */
> > > @@ -154,9 +159,6 @@ struct vring_virtqueue {
> > >                     /* Driver ring wrap counter. */
> > >                     bool avail_wrap_counter;
> > >
> > > -                   /* Device ring wrap counter. */
> > > -                   bool used_wrap_counter;
> > > -
> > >                     /* Avail used flags. */
> > >                     u16 avail_used_flags;
> > >
> > > @@ -1406,8 +1408,12 @@ static inline bool is_used_desc_packed(const s=
truct vring_virtqueue *vq,
> > >
> > >  static inline bool more_used_packed(const struct vring_virtqueue *vq=
)
> > >  {
> > > -   return is_used_desc_packed(vq, vq->last_used_idx,
> > > -                   vq->packed.used_wrap_counter);
> > > +   u16 last_used;
> > > +   bool used_wrap_counter;
> > > +
> > > +   last_used =3D vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRA=
P_CTR);
> >
> > This only works if last_used_idx is 16 bit and
> > VRING_PACKED_EVENT_F_WRAP_CTR is 15.
> >
> > I think you want
> > /* all bits below VRING_PACKED_EVENT_F_WRAP_CTR */
> > vq->last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> >
> >
> > > +   used_wrap_counter =3D !!((vq->last_used_idx) >> VRING_PACKED_EVEN=
T_F_WRAP_CTR);
> >
> >
> > A bit more efficient and clear:
> >
> > !!(q->last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR))
> >
> >
> >
> > Also this logic is repeated in multiple places. Let's add a couple of i=
nline
> > functions:
> >
> > static inline bool packed_used_wrap_counter(vq)
> >
> > static inline u16 packed_last_used(vq)
>
> Or better:
>
> packed_used_wrap_counter(u16 last_used_idx)
> packed_last_used(u16 last_used_idx)
>

This one does look better, Jason what is your take?

thanks.

> > then use these everywhere.
> >
> >
> > > +   return is_used_desc_packed(vq, last_used, used_wrap_counter);
> > >  }
> > >
> > >  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > @@ -1416,6 +1422,7 @@ static void *virtqueue_get_buf_ctx_packed(struc=
t virtqueue *_vq,
> > >  {
> > >     struct vring_virtqueue *vq =3D to_vvq(_vq);
> > >     u16 last_used, id;
> > > +   bool used_wrap_counter;
> > >     void *ret;
> > >
> > >     START_USE(vq);
> > > @@ -1434,7 +1441,8 @@ static void *virtqueue_get_buf_ctx_packed(struc=
t virtqueue *_vq,
> > >     /* Only get used elements after they have been exposed by host. *=
/
> > >     virtio_rmb(vq->weak_barriers);
> > >
> > > -   last_used =3D vq->last_used_idx;
> > > +   used_wrap_counter =3D !!((vq->last_used_idx >> VRING_PACKED_EVENT=
_F_WRAP_CTR));
> > > +   last_used =3D (vq->last_used_idx) & (~(1 << VRING_PACKED_EVENT_F_=
WRAP_CTR));
> > >     id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);
> > >     *len =3D le32_to_cpu(vq->packed.vring.desc[last_used].len);
> > >
> > > @@ -1451,12 +1459,15 @@ static void *virtqueue_get_buf_ctx_packed(str=
uct virtqueue *_vq,
> > >     ret =3D vq->packed.desc_state[id].data;
> > >     detach_buf_packed(vq, id, ctx);
> > >
> > > -   vq->last_used_idx +=3D vq->packed.desc_state[id].num;
> > > -   if (unlikely(vq->last_used_idx >=3D vq->packed.vring.num)) {
> > > -           vq->last_used_idx -=3D vq->packed.vring.num;
> > > -           vq->packed.used_wrap_counter ^=3D 1;
> > > +   last_used +=3D vq->packed.desc_state[id].num;
> > > +   if (unlikely(last_used >=3D vq->packed.vring.num)) {
> > > +           last_used -=3D vq->packed.vring.num;
> > > +           used_wrap_counter ^=3D 1;
> > >     }
> > >
> > > +   last_used =3D (last_used | (used_wrap_counter << VRING_PACKED_EVE=
NT_F_WRAP_CTR));
> > > +   vq->last_used_idx =3D last_used;
> > > +
> > >     /*
> > >      * If we expect an interrupt for the next entry, tell host
> > >      * by writing event index and flush out the write before
> > > @@ -1465,9 +1476,7 @@ static void *virtqueue_get_buf_ctx_packed(struc=
t virtqueue *_vq,
> > >     if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_=
DESC)
> > >             virtio_store_mb(vq->weak_barriers,
> > >                             &vq->packed.vring.driver->off_wrap,
> > > -                           cpu_to_le16(vq->last_used_idx |
> > > -                                   (vq->packed.used_wrap_counter <<
> > > -                                    VRING_PACKED_EVENT_F_WRAP_CTR)))=
;
> > > +                           cpu_to_le16(vq->last_used_idx));
> > >
> > >     LAST_ADD_TIME_INVALID(vq);
> > >
> > > @@ -1499,9 +1508,7 @@ static unsigned int virtqueue_enable_cb_prepare=
_packed(struct virtqueue *_vq)
> > >
> > >     if (vq->event) {
> > >             vq->packed.vring.driver->off_wrap =3D
> > > -                   cpu_to_le16(vq->last_used_idx |
> > > -                           (vq->packed.used_wrap_counter <<
> > > -                            VRING_PACKED_EVENT_F_WRAP_CTR));
> > > +                   cpu_to_le16(vq->last_used_idx);
> > >             /*
> > >              * We need to update event offset and event wrap
> > >              * counter first before updating event flags.
> > > @@ -1518,8 +1525,7 @@ static unsigned int virtqueue_enable_cb_prepare=
_packed(struct virtqueue *_vq)
> > >     }
> > >
> > >     END_USE(vq);
> > > -   return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <<
> > > -                   VRING_PACKED_EVENT_F_WRAP_CTR);
> > > +   return vq->last_used_idx;
> > >  }
> > >
> > >  static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wra=
p)
> > > @@ -1550,9 +1556,9 @@ static bool virtqueue_enable_cb_delayed_packed(=
struct virtqueue *_vq)
> > >     if (vq->event) {
> > >             /* TODO: tune this threshold */
> > >             bufs =3D (vq->packed.vring.num - vq->vq.num_free) * 3 / 4=
;
> > > -           wrap_counter =3D vq->packed.used_wrap_counter;
> > > +           wrap_counter =3D !!(vq->last_used_idx >> VRING_PACKED_EVE=
NT_F_WRAP_CTR);
> > >
> > > -           used_idx =3D vq->last_used_idx + bufs;
> > > +           used_idx =3D (vq->last_used_idx & ~(1 << VRING_PACKED_EVE=
NT_F_WRAP_CTR)) + bufs;
> > >             if (used_idx >=3D vq->packed.vring.num) {
> > >                     used_idx -=3D vq->packed.vring.num;
> > >                     wrap_counter ^=3D 1;
> > > @@ -1582,9 +1588,9 @@ static bool virtqueue_enable_cb_delayed_packed(=
struct virtqueue *_vq)
> > >      */
> > >     virtio_mb(vq->weak_barriers);
> > >
> > > -   if (is_used_desc_packed(vq,
> > > -                           vq->last_used_idx,
> > > -                           vq->packed.used_wrap_counter)) {
> > > +   wrap_counter =3D !!(vq->last_used_idx >> VRING_PACKED_EVENT_F_WRA=
P_CTR);
> > > +   used_idx =3D (vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRA=
P_CTR));
> > > +   if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> > >             END_USE(vq);
> > >             return false;
> > >     }
> > > @@ -1689,7 +1695,7 @@ static struct virtqueue *vring_create_virtqueue=
_packed(
> > >     vq->notify =3D notify;
> > >     vq->weak_barriers =3D weak_barriers;
> > >     vq->broken =3D true;
> > > -   vq->last_used_idx =3D 0;
> > > +   vq->last_used_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
> > >     vq->event_triggered =3D false;
> > >     vq->num_added =3D 0;
> > >     vq->packed_ring =3D true;
> > > @@ -1720,7 +1726,6 @@ static struct virtqueue *vring_create_virtqueue=
_packed(
> > >
> > >     vq->packed.next_avail_idx =3D 0;
> > >     vq->packed.avail_wrap_counter =3D 1;
> > > -   vq->packed.used_wrap_counter =3D 1;
> > >     vq->packed.event_flags_shadow =3D 0;
> > >     vq->packed.avail_used_flags =3D 1 << VRING_PACKED_DESC_F_AVAIL;
> > >
> > > --
> > > 2.31.1
>

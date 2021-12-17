Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26848478305
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 03:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhLQCPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 21:15:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230224AbhLQCPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639707329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fg69PIE3CJYhkZo2IZi4RRNkz+JVKK1hUXb+GLYsHW8=;
        b=QYSMVWMTrwT0ViqVC/hpusq4HJIqxgy29Jc3c0sW6J947OS7g3W2nPva7NpTGGFYZbIFXL
        k6VWGZMjhtBjnFA2qd6QRYjjI+RntGrgCB8WcpOReZ4+WeXW8JBrWCuZEjZf3b+avwmhcT
        stoESEr0mP2vPZ93a+5+Ndppc3QTY/4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-ZWakVdm5N0aTCOqa9OPKiw-1; Thu, 16 Dec 2021 21:15:28 -0500
X-MC-Unique: ZWakVdm5N0aTCOqa9OPKiw-1
Received: by mail-lj1-f200.google.com with SMTP id z18-20020a2e8e92000000b00218e583aff1so177305ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 18:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fg69PIE3CJYhkZo2IZi4RRNkz+JVKK1hUXb+GLYsHW8=;
        b=Il2WTYhPAvhHNyFNKll/pttYsm1yUdYsbS1hUi7NSt0SvWCIZSVMjUDsxh9bUsFh67
         klCy3opbcnsD2zeMRjrvCex8Xw6asFlNg03zsJUoEo6xU8KJ141lpBkY2f02KgL1AmvZ
         NpT6zZYH9maaCJRMkOHwAiButo/hwSj9rViI1QjoQAc3BAgVYLg54AvvkKhplL+F0aaq
         S8lQz6KP2E0dSFfcx5hwXFz/nZl45ggGOJ921O3AnoIUhQIUoxLK+nAI/IdVIZlE6We4
         dAfGqEXRlxu9Cu8LOEsZNwpyBxDck8fcOmaygZBJ36NVDNl+GAx7keyN/FZeQYJSq+en
         auQQ==
X-Gm-Message-State: AOAM532DCcWDMEIXOfpl8dSKu0MqAlxZ6HG51PYVZsIs3ePsnZGuXkVr
        jt3zStv0M3huaimHVHU3oWGDm/eCzCuiFKoTrxPb2K10qkZwtg+/B0DZvyesoxvML3Q8MrWKIMr
        etjF5EcOW6Nnaj6WIFv+7A1i9QSYbR022cHm9czG+
X-Received: by 2002:ac2:4e43:: with SMTP id f3mr922224lfr.348.1639707326731;
        Thu, 16 Dec 2021 18:15:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCye/2UBxDKKBLeReelEKKFsNVTLLZ1kq4+TCZ2lr2XK2ZOJiZBG4d9SwApLUFb8CSJq4aNmJu33bArEYF7pQ=
X-Received: by 2002:ac2:4e43:: with SMTP id f3mr922212lfr.348.1639707326500;
 Thu, 16 Dec 2021 18:15:26 -0800 (PST)
MIME-Version: 1.0
References: <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
 <20211214000245-mutt-send-email-mst@kernel.org> <4fc43d0f-da9e-ce16-1f26-9f0225239b75@oracle.com>
 <CACGkMEsttnFEKGK-aKdCZeXkUnZJg1uaqYzFqpv-g5TobHGSzQ@mail.gmail.com>
 <6eaf672c-cc86-b5bf-5b74-c837affeb6e1@oracle.com> <20211215162917-mutt-send-email-mst@kernel.org>
 <71d2a69c-94a7-76b5-2971-570026760bf0@oracle.com> <CACGkMEsoMpSLX=YZmsgRQVs7+9dwon7FCDK+VOL6Nx2FYK=_pA@mail.gmail.com>
 <a6ad8613-2d66-259e-55a3-42799c89dfe3@oracle.com> <CACGkMEudFhTU5=zh6Kjeru1_9P+jY41hJTwLDT9vBs6vwDaj5g@mail.gmail.com>
 <20211216205958-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211216205958-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 17 Dec 2021 10:15:14 +0800
Message-ID: <CACGkMEs8_oUk+5ywh08_RQb4A1qOg6N8hK=vZxQ5xOkvE_CPsg@mail.gmail.com>
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:01 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Dec 17, 2021 at 09:57:38AM +0800, Jason Wang wrote:
> > On Fri, Dec 17, 2021 at 6:32 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> > >
> > >
> > >
> > > On 12/15/2021 6:53 PM, Jason Wang wrote:
> > > > On Thu, Dec 16, 2021 at 10:02 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> > > >>
> > > >>
> > > >> On 12/15/2021 1:33 PM, Michael S. Tsirkin wrote:
> > > >>> On Wed, Dec 15, 2021 at 12:52:20PM -0800, Si-Wei Liu wrote:
> > > >>>> On 12/14/2021 6:06 PM, Jason Wang wrote:
> > > >>>>> On Wed, Dec 15, 2021 at 9:05 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> > > >>>>>> On 12/13/2021 9:06 PM, Michael S. Tsirkin wrote:
> > > >>>>>>> On Mon, Dec 13, 2021 at 05:59:45PM -0800, Si-Wei Liu wrote:
> > > >>>>>>>> On 12/12/2021 1:26 AM, Michael S. Tsirkin wrote:
> > > >>>>>>>>> On Fri, Dec 10, 2021 at 05:44:15PM -0800, Si-Wei Liu wrote:
> > > >>>>>>>>>> Sorry for reviving this ancient thread. I was kinda lost for the conclusion
> > > >>>>>>>>>> it ended up with. I have the following questions,
> > > >>>>>>>>>>
> > > >>>>>>>>>> 1. legacy guest support: from the past conversations it doesn't seem the
> > > >>>>>>>>>> support will be completely dropped from the table, is my understanding
> > > >>>>>>>>>> correct? Actually we're interested in supporting virtio v0.95 guest for x86,
> > > >>>>>>>>>> which is backed by the spec at
> > > >>>>>>>>>> https://urldefense.com/v3/__https://ozlabs.org/*rusty/virtio-spec/virtio-0.9.5.pdf__;fg!!ACWV5N9M2RV99hQ!dTKmzJwwRsFM7BtSuTDu1cNly5n4XCotH0WYmidzGqHSXt40i7ZU43UcNg7GYxZg$ . Though I'm not sure
> > > >>>>>>>>>> if there's request/need to support wilder legacy virtio versions earlier
> > > >>>>>>>>>> beyond.
> > > >>>>>>>>> I personally feel it's less work to add in kernel than try to
> > > >>>>>>>>> work around it in userspace. Jason feels differently.
> > > >>>>>>>>> Maybe post the patches and this will prove to Jason it's not
> > > >>>>>>>>> too terrible?
> > > >>>>>>>> I suppose if the vdpa vendor does support 0.95 in the datapath and ring
> > > >>>>>>>> layout level and is limited to x86 only, there should be easy way out.
> > > >>>>>>> Note a subtle difference: what matters is that guest, not host is x86.
> > > >>>>>>> Matters for emulators which might reorder memory accesses.
> > > >>>>>>> I guess this enforcement belongs in QEMU then?
> > > >>>>>> Right, I mean to get started, the initial guest driver support and the
> > > >>>>>> corresponding QEMU support for transitional vdpa backend can be limited
> > > >>>>>> to x86 guest/host only. Since the config space is emulated in QEMU, I
> > > >>>>>> suppose it's not hard to enforce in QEMU.
> > > >>>>> It's more than just config space, most devices have headers before the buffer.
> > > >>>> The ordering in datapath (data VQs) would have to rely on vendor's support.
> > > >>>> Since ORDER_PLATFORM is pretty new (v1.1), I guess vdpa h/w vendor nowadays
> > > >>>> can/should well support the case when ORDER_PLATFORM is not acked by the
> > > >>>> driver (actually this feature is filtered out by the QEMU vhost-vdpa driver
> > > >>>> today), even with v1.0 spec conforming and modern only vDPA device. The
> > > >>>> control VQ is implemented in software in the kernel, which can be easily
> > > >>>> accommodated/fixed when needed.
> > > >>>>
> > > >>>>>> QEMU can drive GET_LEGACY,
> > > >>>>>> GET_ENDIAN et al ioctls in advance to get the capability from the
> > > >>>>>> individual vendor driver. For that, we need another negotiation protocol
> > > >>>>>> similar to vhost_user's protocol_features between the vdpa kernel and
> > > >>>>>> QEMU, way before the guest driver is ever probed and its feature
> > > >>>>>> negotiation kicks in. Not sure we need a GET_MEMORY_ORDER ioctl call
> > > >>>>>> from the device, but we can assume weak ordering for legacy at this
> > > >>>>>> point (x86 only)?
> > > >>>>> I'm lost here, we have get_features() so:
> > > >>>> I assume here you refer to get_device_features() that Eli just changed the
> > > >>>> name.
> > > >>>>> 1) VERSION_1 means the device uses LE if provided, otherwise natvie
> > > >>>>> 2) ORDER_PLATFORM means device requires platform ordering
> > > >>>>>
> > > >>>>> Any reason for having a new API for this?
> > > >>>> Are you going to enforce all vDPA hardware vendors to support the
> > > >>>> transitional model for legacy guest?
> > > > Do we really have other choices?
> > > >
> > > > I suspect the legacy device is never implemented by any vendor:
> > > >
> > > > 1) no virtio way to detect host endian
> > > This is even true for transitional device that is conforming to the
> > > spec, right?
> >
> > For hardware, yes.
> >
> > > The transport specific way to detect host endian is still
> > > being discussed and the spec revision is not finalized yet so far as I
> > > see. Why this suddenly becomes a requirement/blocker for h/w vendors to
> > > implement the transitional model?
> >
> > It's not a sudden blocker, the problem has existed since day 0 if I
> > was not wrong. That's why the problem looks a little bit complicated
> > and why it would be much simpler if we stick to modern devices.
> >
> > > Even if the spec is out, this is
> > > pretty new and I suspect not all vendor would follow right away. I hope
> > > the software framework can be tolerant with h/w vendors not supporting
> > > host endianess (BE specifically) or not detecting it if they would like
> > > to support a transitional device for legacy.
> >
> > Well, if we know we don't want to support the BE host it would be fine.
>
> I think you guys mean guest not host here. Same for memory ordering etc.
> What matters is whether guest has barriers etc.
>

Yes.

Thanks


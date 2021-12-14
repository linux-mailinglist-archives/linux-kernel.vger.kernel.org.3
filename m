Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE56473B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhLNDCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:02:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232118AbhLNDCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639450932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bu9IQ6OFp8WKIafDhLgGALQ8s+ZyeyFhZV7jSjaz0VE=;
        b=PoiG4/ys3INlX0zqHw+TBlW9b9phTUckpqg67H2cwDlmLGaIYWlPLwmL836/3mxaFlsyXz
        mqzf6ZPhWIm1rbrVcgtl9j7GGOIGxPHHpnb25Y0YH0wRvVePjwMbeYb15TJLRVGckrpIY+
        WVaWt1TEDZ3C7y75K3FkhSC8TUJp4ho=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-XPhmb2_BNCWHp_UVL7CX7A-1; Mon, 13 Dec 2021 22:02:10 -0500
X-MC-Unique: XPhmb2_BNCWHp_UVL7CX7A-1
Received: by mail-lf1-f72.google.com with SMTP id f15-20020a056512228f00b004037c0ab223so8393811lfu.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bu9IQ6OFp8WKIafDhLgGALQ8s+ZyeyFhZV7jSjaz0VE=;
        b=hAUMEgPj5XRNdCIiZvpmUqOoQn8c+Ftw8KxyT60BxZk3CHaudD0eccgy+ndZILx3a0
         RlduIfBpcZWkUPrgj0OZoJKlVdNaopdPS/3rgG9ThwxE3WuXeCaT2e41K9gpHu7AXDUg
         vYlPxtqbBQfomd3glD0xzIqQoq2ndEvdCVtlQG4wZqNzyPLNSoD2XiF5iQwSEe7pU2n/
         R52nGj/H51SnzTDE8d28UeTEbtuYLTd6N3I2WsEDD8oYQC5QkVnHb7a8P+zHpBPYwLTR
         FCfyZPOZ7UBiPDCNb49upkky98V6Eq1z++bCaroGqDjL2a49ajUAzk6Ovjd7WBT0wHvp
         8obw==
X-Gm-Message-State: AOAM532Db9Wfr2/uBdiT9lCysxJae8RebYPteH4OItJGjw7i4fLV9WvT
        Go59TiQl+k/W4ae26DOJPNp5TLNFKHeBUBNJDVjX/qg0/oYJrcYFy1S1wQUPDuy6FH+M9GSI4+g
        R8w/p0J+JxfKWxEhmkFQ/Um4WFYjRIaE/z4WdLGk6
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr2289511lfv.481.1639450929018;
        Mon, 13 Dec 2021 19:02:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoBz5QZXCrzq6mFK2FP4oNu6GUwTHLciq3tJxPrbOySxsyH079jZwtqoTEnDqUSVqEBpDKzOE/W/UkNiJhASU=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr2289483lfv.481.1639450928676;
 Mon, 13 Dec 2021 19:02:08 -0800 (PST)
MIME-Version: 1.0
References: <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org> <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org> <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org> <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org> <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com> <20211212042311-mutt-send-email-mst@kernel.org>
 <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
In-Reply-To: <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 14 Dec 2021 11:01:57 +0800
Message-ID: <CACGkMEtS3nKAnda8G19hNf=WaeMAgjgeqj3-pi6CjaDsde9jXA@mail.gmail.com>
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:00 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 12/12/2021 1:26 AM, Michael S. Tsirkin wrote:
> > On Fri, Dec 10, 2021 at 05:44:15PM -0800, Si-Wei Liu wrote:
> >> Sorry for reviving this ancient thread. I was kinda lost for the concl=
usion
> >> it ended up with. I have the following questions,
> >>
> >> 1. legacy guest support: from the past conversations it doesn't seem t=
he
> >> support will be completely dropped from the table, is my understanding
> >> correct? Actually we're interested in supporting virtio v0.95 guest fo=
r x86,
> >> which is backed by the spec at
> >> https://urldefense.com/v3/__https://ozlabs.org/*rusty/virtio-spec/virt=
io-0.9.5.pdf__;fg!!ACWV5N9M2RV99hQ!dTKmzJwwRsFM7BtSuTDu1cNly5n4XCotH0WYmidz=
GqHSXt40i7ZU43UcNg7GYxZg$ . Though I'm not sure
> >> if there's request/need to support wilder legacy virtio versions earli=
er
> >> beyond.
> > I personally feel it's less work to add in kernel than try to
> > work around it in userspace. Jason feels differently.
> > Maybe post the patches and this will prove to Jason it's not
> > too terrible?
> I suppose if the vdpa vendor does support 0.95 in the datapath and ring
> layout level and is limited to x86 only, there should be easy way out.

Note that thought I try to mandate 1.0 device when writing the codes
but the core vdpa doesn't mandate it, and we've already had one parent
which is based on the 0.95 spec which is the eni_vdpa:

1) it depends on X86 (so no endian and ordering issues)
2) it has various subtle things like it can't work well without
mrg_rxbuf features negotiated since the device assumes a fixed vnet
header length.
3) it can only be used by legacy drivers in the guest (no VERSION_1
since the device mandates a 4096 alignment which doesn't comply with
1.0)

So it's a proof of 0.95 parent support in the vDPA core.

And we had a modern only parent, that is the vp_vdpa parent (though
it's not hard to add legacy support).

So for all the other vendors, assuming it has full support for
transitional devices for x86. As discussed, we need to handle:

1) config access before features
2) kick before driver_ok

Anything else? If not, it looks easier to do them in the userspace.
The only advantages for doing it in the kernel is to make it work for
virtio-vdpa. But virito-vdpa doesn't need transitional devices.

> I
> checked with Eli and other Mellanox/NVDIA folks for hardware/firmware
> level 0.95 support, it seems all the ingredient had been there already
> dated back to the DPDK days. The only major thing limiting is in the
> vDPA software that the current vdpa core has the assumption around
> VIRTIO_F_ACCESS_PLATFORM for a few DMA setup ops, which is virtio 1.0 onl=
y.

The code doesn't have such an assumption or anything I missed? Or you
meant the vhost-vdpa that tries to talk with the IOMMU layer directly,
it should be ok since host IOMMU is hidden from guest anyway.

>
> >
> >> 2. suppose some form of legacy guest support needs to be there, how do=
 we
> >> deal with the bogus assumption below in vdpa_get_config() in the short=
 term?
> >> It looks one of the intuitive fix is to move the vdpa_set_features cal=
l out
> >> of vdpa_get_config() to vdpa_set_config().
> >>
> >>          /*
> >>           * Config accesses aren't supposed to trigger before features=
 are
> >> set.
> >>           * If it does happen we assume a legacy guest.
> >>           */
> >>          if (!vdev->features_valid)
> >>                  vdpa_set_features(vdev, 0);
> >>          ops->get_config(vdev, offset, buf, len);
> >>
> >> I can post a patch to fix 2) if there's consensus already reached.
> >>
> >> Thanks,
> >> -Siwei
> > I'm not sure how important it is to change that.
> > In any case it only affects transitional devices, right?
> > Legacy only should not care ...
> Yes I'd like to distinguish legacy driver (suppose it is 0.95) against
> the modern one in a transitional device model rather than being legacy
> only. That way a v0.95 and v1.0 supporting vdpa parent can support both
> types of guests without having to reconfigure.

I think this is what a transitional device is expected to work.

Thanks

> Or are you suggesting
> limit to legacy only at the time of vdpa creation would simplify the
> implementation a lot?
>
> Thanks,
> -Siwei
>
> >
> >> On 3/2/2021 2:53 AM, Jason Wang wrote:
> >>> On 2021/3/2 5:47 =E4=B8=8B=E5=8D=88, Michael S. Tsirkin wrote:
> >>>> On Mon, Mar 01, 2021 at 11:56:50AM +0800, Jason Wang wrote:
> >>>>> On 2021/3/1 5:34 =E4=B8=8A=E5=8D=88, Michael S. Tsirkin wrote:
> >>>>>> On Wed, Feb 24, 2021 at 10:24:41AM -0800, Si-Wei Liu wrote:
> >>>>>>>> Detecting it isn't enough though, we will need a new ioctl to no=
tify
> >>>>>>>> the kernel that it's a legacy guest. Ugh :(
> >>>>>>> Well, although I think adding an ioctl is doable, may I
> >>>>>>> know what the use
> >>>>>>> case there will be for kernel to leverage such info
> >>>>>>> directly? Is there a
> >>>>>>> case QEMU can't do with dedicate ioctls later if there's indeed
> >>>>>>> differentiation (legacy v.s. modern) needed?
> >>>>>> BTW a good API could be
> >>>>>>
> >>>>>> #define VHOST_SET_ENDIAN _IOW(VHOST_VIRTIO, ?, int)
> >>>>>> #define VHOST_GET_ENDIAN _IOW(VHOST_VIRTIO, ?, int)
> >>>>>>
> >>>>>> we did it per vring but maybe that was a mistake ...
> >>>>> Actually, I wonder whether it's good time to just not support
> >>>>> legacy driver
> >>>>> for vDPA. Consider:
> >>>>>
> >>>>> 1) It's definition is no-normative
> >>>>> 2) A lot of budren of codes
> >>>>>
> >>>>> So qemu can still present the legacy device since the config
> >>>>> space or other
> >>>>> stuffs that is presented by vhost-vDPA is not expected to be
> >>>>> accessed by
> >>>>> guest directly. Qemu can do the endian conversion when necessary
> >>>>> in this
> >>>>> case?
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>> Overall I would be fine with this approach but we need to avoid brea=
king
> >>>> working userspace, qemu releases with vdpa support are out there and
> >>>> seem to work for people. Any changes need to take that into account
> >>>> and document compatibility concerns.
> >>>
> >>> Agree, let me check.
> >>>
> >>>
> >>>>    I note that any hardware
> >>>> implementation is already broken for legacy except on platforms with
> >>>> strong ordering which might be helpful in reducing the scope.
> >>>
> >>> Yes.
> >>>
> >>> Thanks
> >>>
> >>>
> >>>>
>


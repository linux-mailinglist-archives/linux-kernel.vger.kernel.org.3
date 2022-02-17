Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F44BA924
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbiBQTDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:03:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbiBQTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:02:50 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366A78021C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:02:36 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id x193so687143oix.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWO8Q+uI+0ihSwYJ6Zt8etN6DM2sOHrGeWR+2eej5uA=;
        b=WsgCMHBjoWD30X7I4vRhE0Pyb2PhqNzgiAyBJMP/BkiSybh3YyMwvipCuNYRTtqwMl
         9WHavxlvXgBg6u3N5aJqaqF7mjPYlDpQ47T61l4kvfnD630VJ5R4Wzm+fxn43l50xexx
         5gZukb7zGHSFQVH9ltIMqBXY7KspA1S18cKiCMd0zCkcIDISEp6fsq6PT8ESKSpkeUU+
         yzO4PrDjy9V5V2uF4g90P8Ykp+KU4AKTc/cgDIqJOPK7JzAYcZwCM8jr2Px04nduVVMo
         hPXert3+N1Hm8tAQa67uO/rASwLG+LWOY4kZZK8poD6ygC7vlhXP8Iqh+hcoysC+1CEQ
         k33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWO8Q+uI+0ihSwYJ6Zt8etN6DM2sOHrGeWR+2eej5uA=;
        b=ZdKQSJYQ16yGw4yUXKl72sJ4dA3rDH3hYHOPQBgphDs/3KR6Ikm0wkGzFaUaQag+Jc
         YzfAuFW2fmbhgszmLrwfuIvLSZA+AMPgBbLM1E+fE2NHlF5a4oG4ViJAVHUJSbXrlU+h
         GLUMbp3BUNslFZNNv3B09ttdbN8wEUhYaI/OGhh65lTl0aq1XlmbkVY8tYJy8Ymci21F
         LuKEP6c/izgVaBYpy9dTgH8qDa1PpMhytZpgq+rpfCwEWFlsKXN1z3emCvfo8brEmiv8
         r3IZcnDvGdFkGksB+cNei8ekvSfhtKyAWKLYzhAJkBhDq02AVSNwSVkR949bcS1yj7np
         0NRA==
X-Gm-Message-State: AOAM532zF+nlqvieP9dp05gnHQ7QWyKzDRSR5H7jl0JnwmLJgmMGHKIb
        V1dKwmsxFnvEyEnMz0Q+ACD3ceItmuSlm7TfdOXbRAYCzGqGjA==
X-Google-Smtp-Source: ABdhPJzl9kNKhILG8v7zritQHbJzshHEmz6JS+nWZBAN1tDVjRVOLX2ZZBrJPHsTSzu1JnaQAdFNGFv7ngSqEJdk99Y=
X-Received: by 2002:a05:6808:2096:b0:2ca:f505:6358 with SMTP id
 s22-20020a056808209600b002caf5056358mr3402657oiw.35.1645124555492; Thu, 17
 Feb 2022 11:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20220208181510.787069-1-andrew@daynix.com> <20220208181510.787069-3-andrew@daynix.com>
 <CA+FuTSfPq-052=D3GzibMjUNXEcHTz=p87vW_3qU0OH9dDHSPQ@mail.gmail.com>
 <CABcq3pFLXUMi3ctr6WyJMaXbPjKregTzQ2fG1fwDU7tvk2uRFg@mail.gmail.com> <CA+FuTSfJS6b3ba7eW_u4TAHCq=ctpHDJUrb-Yc3iDwpJHHuBMw@mail.gmail.com>
In-Reply-To: <CA+FuTSfJS6b3ba7eW_u4TAHCq=ctpHDJUrb-Yc3iDwpJHHuBMw@mail.gmail.com>
From:   Andrew Melnichenko <andrew@daynix.com>
Date:   Thu, 17 Feb 2022 21:02:24 +0200
Message-ID: <CABcq3pE9ewELP0xW-BxFCjTUPBf9LFzmde4tMf1Szivb8nMp7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drivers/net/virtio_net: Added basic RSS support.
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Yan Vugenfirer <yan@daynix.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Feb 14, 2022 at 12:09 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > > @@ -3113,13 +3270,14 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > >         u16 max_queue_pairs;
> > > >         int mtu;
> > > >
> > > > -       /* Find if host supports multiqueue virtio_net device */
> > > > -       err = virtio_cread_feature(vdev, VIRTIO_NET_F_MQ,
> > > > -                                  struct virtio_net_config,
> > > > -                                  max_virtqueue_pairs, &max_queue_pairs);
> > > > +       /* Find if host supports multiqueue/rss virtio_net device */
> > > > +       max_queue_pairs = 1;
> > > > +       if (virtio_has_feature(vdev, VIRTIO_NET_F_MQ) || virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> > > > +               max_queue_pairs =
> > > > +                    virtio_cread16(vdev, offsetof(struct virtio_net_config, max_virtqueue_pairs));
> > >
> > > Instead of testing either feature and treating them as somewhat equal,
> > > shouldn't RSS be dependent on MQ?
> >
> > No, RSS is dependent on CTRL_VQ. Technically RSS and MQ are similar features.
>
> RSS depends on having multiple queues.
>
> What would enabling VIRTIO_NET_F_RSS without VIRTIO_NET_F_MQ do?

RSS would work.

According to virtio spec article 5.1.6.5.5:
> A device MAY support one of these features or both. The driver MAY negotiate any set of these features
> that the device supports.

Also, in 5.1.3.1:
> VIRTIO_NET_F_RSS Requires VIRTIO_NET_F_CTRL_VQ.

>
> > >
> > > >
> > > >         /* We need at least 2 queue's */
> > > > -       if (err || max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> > > > +       if (max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> > > >             max_queue_pairs > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
> > > >             !virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
> > > >                 max_queue_pairs = 1;
> > > > @@ -3207,6 +3365,23 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > >         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> > > >                 vi->mergeable_rx_bufs = true;
> > > >
> > > > +       if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> > > > +               vi->has_rss = true;
> > > > +               vi->rss_indir_table_size =
> > > > +                       virtio_cread16(vdev, offsetof(struct virtio_net_config,
> > > > +                               rss_max_indirection_table_length));
> > > > +               vi->rss_key_size =
> > > > +                       virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> > > > +
> > > > +               vi->rss_hash_types_supported =
> > > > +                   virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> > > > +               vi->rss_hash_types_supported &=
> > > > +                               ~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> > > > +                                 VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> > > > +                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> > > > +
> > > > +               dev->hw_features |= NETIF_F_RXHASH;
> > >
> > > Only make the feature visible when the hash is actually reported in
> > > the skb, patch 3.
> >
> > VirtioNET has two features: RSS(steering only) and hash(hash report in
> > vnet header)
> > Both features may be enabled/disabled separately:
> > 1. rss on and hash off - packets steered to the corresponding vqs
> > 2. rss off and hash on - packets steered by tap(like mq) but headers
> > have properly calculated hash.
> > 3. rss on and hash on - packets steered to corresponding vqs and hash
> > is present in the header.
> >
> > RXHASH feature allows the user to enable/disable the rss/hash(any combination).
>
> I find that confusing, but.. I see that there is prior art where some
> drivers enable/disable entire RSS load balancing based on this flag.
> So ok.
>
> > I think it's a good idea to leave RXHASH in patch 2/4 to give the user
> > ability to manipulate the rss only feature.
> > But, if you think that it requires to move it to the 3/4, I'll do it.
> >
> > >
> > > Also, clearly separate the feature patches (2) rss, (3) rxhash, (4)
> > > rxhash config.
> >
> > Currently:
> > Patch 2/4 - adds VirtioNet rss feature.
> > Patch 3/4 - adds VirtioNet hash report feature.
> > Patch 4/4 - adds the ability to manipulate supported hash types.
> >
> > Can you provide more detailed suggestions on how to move hunks?
>
> I gave one in the follow-on patch, to which you responded. That's probably it.

I'll add zero size table check and move hunk for padded header length
from 3/4 to 1/4.

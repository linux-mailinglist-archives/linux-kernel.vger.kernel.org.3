Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA269476892
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhLPDRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:17:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230317AbhLPDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639624673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+B6iF5v2h52ZS6af9Ru3mvKMM/Y6Xv7ONEyz4ZfHeJc=;
        b=OL3lrGb/zd0+rF+/CqZgmf7wiigKVx+8eDe+Rn72syqAWP8/jLd/GFK4jAM0eSuc+qCy8U
        /HTFSmDp/HSQoG8x8/XMmatCpa2rpsmoCjJ7bnjTHaGJpV6pakjCQOaiTtqmzd3KFzxmLG
        e3DHbGZgTbPkdDEaQge7zj7j3TNb6WY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-uPPDjZtYM4WCVF7KEzDTpg-1; Wed, 15 Dec 2021 22:17:52 -0500
X-MC-Unique: uPPDjZtYM4WCVF7KEzDTpg-1
Received: by mail-lj1-f198.google.com with SMTP id u28-20020a2ea17c000000b0021126b5cca2so7894836ljl.19
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+B6iF5v2h52ZS6af9Ru3mvKMM/Y6Xv7ONEyz4ZfHeJc=;
        b=rDQ0w7xanr42LvmQPh+XdkLkVjh9Q9Ik9icwNVkdxuj+7hIHzypMm8TeUwEAH0UFuP
         j5iw1lvRsCr09RrDUtN6gtPJl3jvhsAJUHPxrTLHW3AtLmIWdXen3fdGXeU1ldbmjO2F
         ZX9pZJuCm1vXy7HSDMDTyd3UuLG+49J61l+RX3d/deKls8TY8qpALkbDFxc6FlHB/txC
         QgZ7SM8n4Uc2a+xnsBSpFD5rrCczy3xpqjJBZgjYQXxwetx9iToVHR+4cEvq4vCLn7wq
         6ZeGXkfTuEn7NOs0PlC+CDI/SchaDy7OW5MINzwYXuuNaoisoLDpXxPoY/TpTZ0w/CZt
         gCfA==
X-Gm-Message-State: AOAM533L2uaj4eH5i4SQOwKcpVDOePbKecTyg330M7jSbCXeWV2vRLn+
        ZGh++LfbUrbe0KVpttwdwUonytP9SkbEq7d1DdSj39Zk/xKWeiGxQUgXtKeSLkZD2qy1DdeOCAd
        +ZkpdTVng8uD2LnQgqjNPXBmhqDNEYmDE6F3syRLv
X-Received: by 2002:a2e:8507:: with SMTP id j7mr13138227lji.307.1639624670283;
        Wed, 15 Dec 2021 19:17:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzybEQzi7rWzYE9jmfV9nP+8CV6LzV7oVHuDufrPBpOHg5wimO1iedL9ILZ1jIXZssjM84pJjnht+DIQlb6M6g=
X-Received: by 2002:a2e:8507:: with SMTP id j7mr13138220lji.307.1639624670128;
 Wed, 15 Dec 2021 19:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20211216030836.81989-1-zhuran@mail.ustc.edu.cn>
In-Reply-To: <20211216030836.81989-1-zhuran@mail.ustc.edu.cn>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 16 Dec 2021 11:17:39 +0800
Message-ID: <CACGkMEv3unSNMvj78e_Cdynz6zaTz-BZ5e20wF3dMURODqe1Hg@mail.gmail.com>
Subject: Re: [PATCH] virtio: fix spelling error
To:     zhuxinran <zhuran@mail.ustc.edu.cn>
Cc:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:09 AM zhuxinran <zhuran@mail.ustc.edu.cn> wrote:
>
> start my first kernel patch commit
>

Patch looks good but this is not a good change log.

It should be something like "Fix typo in the comment for p9_virtio_create()"

Thanks

> Signed-off-by: zhuxinran <zhuran@mail.ustc.edu.cn>
> ---
>  net/9p/trans_virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index bd5a89c4960d..f7dc561ca516 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -648,7 +648,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>   * @args: args passed from sys_mount() for per-transport options (unused)
>   *
>   * This sets up a transport channel for 9p communication.  Right now
> - * we only match the first available channel, but eventually we couldlook up
> + * we only match the first available channel, but eventually we could look up
>   * alternate channels by matching devname versus a virtio_config entry.
>   * We use a simple reference count mechanism to ensure that only a single
>   * mount has a channel open at a time.
> --
> 2.33.1
>
>


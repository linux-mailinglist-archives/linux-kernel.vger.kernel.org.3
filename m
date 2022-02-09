Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3DC4AE8C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiBIFHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:07:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352211AbiBIEou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:44:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8690FC061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 20:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644381893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8gj37MRQ8xwMURk0vAQh2NMA0eBwSyEISE9txFEN/4=;
        b=OQD73OTcwzfE9aHAz6ocTDKhHyRmXun78GnNfF823oa/s2PjeuCkjcHyMIhIFuLmrQkPX8
        grzuyQnuUDlywShenl1s//tdlU0ft3ro7TZwqlafLtcBoICkF0eMlFQ77HD8ZdrNHOLtxK
        6fMXHd6906iVWLssctxmxvBfshEo+SQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-ynG28QrKNqK5oZOYxMRk1Q-1; Tue, 08 Feb 2022 23:44:52 -0500
X-MC-Unique: ynG28QrKNqK5oZOYxMRk1Q-1
Received: by mail-pj1-f70.google.com with SMTP id e1-20020a17090ada0100b001b83a55e809so927011pjv.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 20:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a8gj37MRQ8xwMURk0vAQh2NMA0eBwSyEISE9txFEN/4=;
        b=vQODyKhF+3BdTSjOcaNLaVlcFW8itU9Uqa5JTFU0796K/KHBErO3LnHEmKmoh3+mOY
         uEYjK+IlCKVUe6ldHCVSIyayXNghCyJwANkxno1r++opov7aSFmX3ZOrl0DFqEvBQrU+
         z0n4UQGCLnQohyL0FuNWkKM5ylSLA4keXnZSXcCY+SgQsEObigYHwdcZ36NeyUNOWSEI
         yD91vo6LNj8dIf+E4beAgQpaViV3y0X4dn/guf+oQ0g12nAm2kqltNX400WtOHo8JWXS
         hwWhohUownBSxSkbtkrH0gFbIA3YcZKgRj7s5vX7k4mckkAIRIizC/RFBPJ4Asy0vpmH
         G8XQ==
X-Gm-Message-State: AOAM530YpFrAdDTrdZTw4cTgpnR4WPywk7vcPm6Vwx2gyhWl37WzyQBi
        cEX/baNHXzKve95TjC1OGX8uu3CJzDYqY+3VUhzxLpFUSOUI2lyRqw0qw8VH5/KmB/7g1lRZeFQ
        ospZy3MUjGOqqwmU8EwoIQu2k
X-Received: by 2002:a17:90b:a06:: with SMTP id gg6mr1452900pjb.153.1644381891254;
        Tue, 08 Feb 2022 20:44:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwT+QxXjlJ0SaaM0kkOKxf0X5GYo0uqNI3uLhER1MI1QJk1PxbBUXYbpF29jjDOGwJPE6rDxg==
X-Received: by 2002:a17:90b:a06:: with SMTP id gg6mr1452886pjb.153.1644381890996;
        Tue, 08 Feb 2022 20:44:50 -0800 (PST)
Received: from [10.72.13.141] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v12sm12234256pgr.68.2022.02.08.20.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 20:44:50 -0800 (PST)
Message-ID: <6d74c8f6-ddf8-9258-cb99-80e0e8efbf38@redhat.com>
Date:   Wed, 9 Feb 2022 12:44:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 5/5] drivers/net/virtio_net.c: Added USO support.
Content-Language: en-US
To:     Andrew Melnychenko <andrew@daynix.com>, davem@davemloft.net,
        kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yuri.benditovich@daynix.com, yan@daynix.com
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-6-andrew@daynix.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220125084702.3636253-6-andrew@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/1/25 下午4:47, Andrew Melnychenko 写道:
> Now, it possible to enable GSO_UDP_L4("tx-udp-segmentation") for VirtioNet.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   drivers/net/virtio_net.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a801ea40908f..a45eee022be4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -60,13 +60,17 @@ static const unsigned long guest_offloads[] = {
>   	VIRTIO_NET_F_GUEST_TSO6,
>   	VIRTIO_NET_F_GUEST_ECN,
>   	VIRTIO_NET_F_GUEST_UFO,
> -	VIRTIO_NET_F_GUEST_CSUM
> +	VIRTIO_NET_F_GUEST_CSUM,
> +	VIRTIO_NET_F_GUEST_USO4,
> +	VIRTIO_NET_F_GUEST_USO6
>   };
>   
>   #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
>   				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
>   				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> -				(1ULL << VIRTIO_NET_F_GUEST_UFO))
> +				(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
> +				(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
> +				(1ULL << VIRTIO_NET_F_GUEST_USO6))
>   
>   struct virtnet_stat_desc {
>   	char desc[ETH_GSTRING_LEN];
> @@ -2530,7 +2534,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>   	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>   	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
>   		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
> -		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6))) {
>   		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
>   		return -EOPNOTSUPP;
>   	}
> @@ -3155,6 +3161,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>   			dev->hw_features |= NETIF_F_TSO6;
>   		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
>   			dev->hw_features |= NETIF_F_TSO_ECN;
> +		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
> +			dev->hw_features |= NETIF_F_GSO_UDP_L4;
>   
>   		dev->features |= NETIF_F_GSO_ROBUST;
>   
> @@ -3169,6 +3177,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>   		dev->features |= NETIF_F_GRO_HW;
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
>   		dev->hw_features |= NETIF_F_GRO_HW;
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO4) ||
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO6))
> +		dev->hw_features |= NETIF_F_LRO;


I think we need to use GRO_HW, see dbcf24d153884 ("virtio-net: use 
NETIF_F_GRO_HW instead of NETIF_F_LRO"

Thanks


>   
>   	dev->vlan_features = dev->features;
>   
> @@ -3200,7 +3211,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>   	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>   	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO) ||
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO4) ||
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO6))
>   		vi->big_packets = true;
>   
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> @@ -3400,6 +3413,7 @@ static struct virtio_device_id id_table[] = {
>   	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
>   	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
>   	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
> +	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
>   	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
>   	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
>   	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \


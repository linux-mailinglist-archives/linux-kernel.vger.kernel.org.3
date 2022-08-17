Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCAA596E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiHQMH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiHQMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6255586B61
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660738024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvED31tz28w3zR0MRsRpAF+4dRa0mrzWJzSKyavcZMM=;
        b=TpOUYd6Nk3jdrpmp41LJCoXXzz5JI0lPMuHGvbxQ6sTqByk9OJe4L9NOMMtf19Q0+199uS
        Ciig3F9XPyTqcSPzLmtZ7JWm2e9FZLzxXtb6M2x6Wh0/lBFL+9kJTe3rCoN6MHU/C35N6U
        RVj+J0HOI2K5sEg29SjG2/0UVRStpr0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-512-d0F_4Vc6NMushh-C6ow1ig-1; Wed, 17 Aug 2022 08:07:03 -0400
X-MC-Unique: d0F_4Vc6NMushh-C6ow1ig-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-31f3959ba41so150462837b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uvED31tz28w3zR0MRsRpAF+4dRa0mrzWJzSKyavcZMM=;
        b=Aw/Rde93vJpkFdOYl9yuNevOjeoKThcIpDT/L1x04Si1B1cVbe7ERZ2N+fPnUM7wDN
         ehICGwL/U+HD6XDFoMad7kJ+Ahi6+BRc1UddJxa3seXslMJhgT/GJiLq77WAwjJ+0QdK
         pWAtOQsmQZD49xv3qUCvK1jYwOq2RnqupZnI4Py4++j45oNUwZGE7+Rs4mz/Pi+rX10y
         BvJnbExErngxo2lmTYXMeAuECQ+p8x6NJIeJ8md1tGhlkS8oXutfcCDspdgg+xc1o4wA
         Umz0TE0zdyW6OJHnPyoCtcni6I6bCz3qzGPASQucWRfmVqzyQK4El7CoIuCDO/l6wdST
         7pZA==
X-Gm-Message-State: ACgBeo23+0u9SDOWqSUijrVKU0+Xx8WTK+co9kDPCLaL6CwwAReLi15Q
        jyrvoVPxAbWnfjsFEup8Q3wDF6olQam/GMQ+hVC5YGM47DTzT3HD5zOuWUdBFU5k3dhFmqXmvdL
        FTSRR5wpdEwtbbZfaFnCxXLL/ohjNPbsy4AnxrEbY
X-Received: by 2002:a25:e209:0:b0:67c:234a:f08c with SMTP id h9-20020a25e209000000b0067c234af08cmr19261953ybe.19.1660738022542;
        Wed, 17 Aug 2022 05:07:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR62CJmKIVjjGO862klgBFeJm3NBx72xx36Q9rR58vnUPEUrkGjik0Yn2s8sx5yftCEoPxhb1gkbhMxTvLwwrcg=
X-Received: by 2002:a25:e209:0:b0:67c:234a:f08c with SMTP id
 h9-20020a25e209000000b0067c234af08cmr19261926ybe.19.1660738022293; Wed, 17
 Aug 2022 05:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain> <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com> <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com> <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk> <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com> <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
In-Reply-To: <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Wed, 17 Aug 2022 20:06:51 +0800
Message-ID: <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

On Tue, Aug 16, 2022 at 11:35 PM Chris Murphy <lists@colorremedies.com> wrote:
>
>
>
...
>
> I already reported on that: always happens with bfq within an hour or less. Doesn't happen with mq-deadline for ~25+ hours. Does happen with bfq with the above patches removed. Does happen with cgroup.disabled=io set.
>
> Sounds to me like it's something bfq depends on and is somehow becoming perturbed in a way that mq-deadline does not, and has changed between 5.11 and 5.12. I have no idea what's under bfq that matches this description.
>

blk-mq debugfs log is usually helpful for io stall issue, care to post
the blk-mq debugfs log:

(cd /sys/kernel/debug/block/$disk && find . -type f -exec grep -aH . {} \;)

Thanks,
Ming


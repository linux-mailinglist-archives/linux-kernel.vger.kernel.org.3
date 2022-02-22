Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1DC4BF1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiBVF56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:57:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiBVF54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:57:56 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB0E7DE3D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:57:31 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qx21so39324397ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p/PmgnBMBE+a+LwnMw7RC+TxwSBL0sVYbhSV1c+Rplg=;
        b=HlroeRgk73cYJrya57IgoHaHYLeOQRZ8CFTKMyFrCQHZQft9rOKWBt3CMXGj8Hwp9y
         OGy7sNphB9Uqe6NWrSnzVQST3fDo8GycVwSxApBKE3AyeyubM14vpJoCdrwaTkK5kp7n
         cQyH7ksBDdcAQf+va82zEfbNiMIfQ7/cIXkVCcOwQbjxF1f5sLftHexJzTNZLmjXJvrQ
         WTVOPvI57wSmoZTTx1AVEgdWqYkpSr6ypiNnPHrvNh6daYJjvApt9/Ud15DRX8oTYctF
         MPEysQxdr7jBz9rTvY+DeVJw5EiPD0hc4QIeTMefTCLu+iCc3VWzd2Og153uAUiWlD09
         0APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p/PmgnBMBE+a+LwnMw7RC+TxwSBL0sVYbhSV1c+Rplg=;
        b=bGNauJaVY4/cnhmKLbrJSTK6GyycSFTcTx6YBwyzXjc00hfOTFdnN2ntP3E8wZR+8m
         bg3Z5XWku6uifjeElvXzjgg9GYpFMhTjTuUVDXFpzpCGgj0aTaAaftUBZ6GVIJtsKBSN
         cf6qA67tgUKbUJbt8nXinBGpEXFxzvrK2etVZ//iLWZGUCVQppi+O7bNf5NlUZNRMBEq
         8Eqjry3ZtwC9T3QKQy105AqGw7RJ4MO1c/33iVoCd66zT1tXAIP6+Ysq4u0yJ1FGMVyS
         GUCzyJQQN7UqhBrOdMbEW+W/KnI3ek67OV+gM31n1JIfExPFmjMbeE7snj2aAr5sDBXC
         C+/g==
X-Gm-Message-State: AOAM531SKcSgmS1Olsqhh7zeD/iUacQ+fYTBjF9paPBU2tUajwRB1azq
        Ig0DrXw+qaiuRXtpn/8hMFzvRsxs6XpQkWe9LvzWmEV6CV0=
X-Google-Smtp-Source: ABdhPJz8UvpHNGjwosxt0eNuD825WY1Yan8kUpAgvw5cnK0YhJVzisH6PHoeBKC7hmKBNTUEoKrxFSkN0+HDrNt/e8M=
X-Received: by 2002:a17:906:b201:b0:6b5:58c8:e43c with SMTP id
 p1-20020a170906b20100b006b558c8e43cmr17564278ejz.441.1645509450470; Mon, 21
 Feb 2022 21:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20220221215911.2948692-1-broonie@kernel.org>
In-Reply-To: <20220221215911.2948692-1-broonie@kernel.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 22 Feb 2022 06:57:19 +0100
Message-ID: <CAMGffEm_J9WcP2eoopwX8eEnRz9n4EycWxwgzP4c+NFr0eYXkw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the block tree
To:     broonie@kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Gioh Kim <gi-oh.kim@ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Md Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:59 PM <broonie@kernel.org> wrote:
>
> Hi all,
>
> Today's linux-next merge of the scsi-mkp tree got a conflict in:
>
>   drivers/block/rnbd/rnbd-clt.c
>
> between commit:
>
>   448025c103938 ("block/rnbd: client device does not care queue/rotationa=
l")
>
> from the block tree and commit:
>
>   e8e9884730b36 ("scsi: rnbd: Remove WRITE_SAME support")
>
> from the scsi-mkp tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
Hi Broonie,

Thanks for fixing it up, it looks good. We will pay attention on this next =
time!

Regards!
Jinpu Wang
>
> diff --cc drivers/block/rnbd/rnbd-clt.c
> index 1f63f308eb394,dc192d2738854..0000000000000
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@@ -1606,13 -1607,13 +1603,13 @@@ struct rnbd_clt_dev *rnbd_clt_map_devi=
c
>         }
>
>         rnbd_clt_info(dev,
> -                      "map_device: Device mapped as %s (nsectors: %zu, l=
ogical_block_size: %d, physical_block_size: %d, max_write_same_sectors: %d,=
 max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, s=
ecure_discard: %d, max_segments: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n=
",
>  -                     "map_device: Device mapped as %s (nsectors: %zu, l=
ogical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, di=
scard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segme=
nts: %d, max_hw_sectors: %d, rotational: %d, wc: %d, fua: %d)\n",
> ++                     "map_device: Device mapped as %s (nsectors: %zu, l=
ogical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, di=
scard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segme=
nts: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
>                        dev->gd->disk_name, dev->nsectors,
>                        dev->logical_block_size, dev->physical_block_size,
> -                      dev->max_write_same_sectors, dev->max_discard_sect=
ors,
> +                      dev->max_discard_sectors,
>                        dev->discard_granularity, dev->discard_alignment,
>                        dev->secure_discard, dev->max_segments,
>  -                     dev->max_hw_sectors, dev->rotational, dev->wc, dev=
->fua);
>  +                     dev->max_hw_sectors, dev->wc, dev->fua);
>
>         mutex_unlock(&dev->lock);
>         rnbd_clt_put_sess(sess);

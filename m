Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701F1520ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiEJHpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiEJHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:44:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA917AA4;
        Tue, 10 May 2022 00:35:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so1336604pjb.3;
        Tue, 10 May 2022 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jggdeZwx0ELWqoEo5YRQ8TKCNejGggZ8TRXkejgLZs4=;
        b=BF0+B4tvl9Sj3z4Ej45SIy9UpoJQ/cl8xGhd4tNlE7v7kOKipjjpgpwNt5IC3sFIBa
         OauOq/TYSy/uz+xU1rpBwhQdClqM9r7gqtQQ66kGsWL1PrkVqGUvnENwvcnGNIqZO/fg
         l+5rDftZQCL8alLFxoxEAdtPKdCmHgLSB9nbstxOwn+szjt+VQQpBw+6JqVuFHeLD6cO
         N6iBQO2301vP1sHGie0fxKI1Q1YHX8O0Yo3e0P8MPsccTk1Ie33lfLGPPxAZ7mlTvNcR
         6VQlvn+rHZ7saZQtQVAE4F+yNvxIPJT5UqPtCueUH5OYytXvwWkdWXJ0oBqecGDOmVWt
         E4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jggdeZwx0ELWqoEo5YRQ8TKCNejGggZ8TRXkejgLZs4=;
        b=2w1WPb2YxvNt2hz9GHs7SQJCFua12YuPaJxWl7rHxkfuv1NRBxjblELoqbhEJbEb7l
         bwv91rfgRpMKE+aKQmODfyXPB/M3EmBe4yE7toGOlE8HfEmskdvEmxFeKvEcK8iwhn8e
         JXjBYEIFw2K3SnVRq7n4DxqnA2avE7btdt/+5RE+vdai13de9jUKHGQEvu8SexHz1BzZ
         LmrjJS2YnWxhv5qt6w0WzcGhMAeacpsRhiiKKbhT1KJjUBfP9AB+Mky2VStSCCzFBLNd
         r5rP8dzlnh1ZlYyVY5Usfcus/fhsVjyEBi04n78OiiuksRZIT5wQAg0ezPu/0HU9p2NM
         3AGA==
X-Gm-Message-State: AOAM531YJUAaG4tG1TDoQN6sQS8WjMpvI7P4faQzcCQ8G95mAAcBrQNR
        16zKtTAfCaGWr9ZDGre/z/6EAYNUTUWvcGtRzII=
X-Google-Smtp-Source: ABdhPJzxrfCR7GjoMK2EJz7JCGaTcxPmCs3fGYZi7OwF+OwyYUNG+9KiCS/+lZThDa4KLVKu4ILylCCQh7274Nb+Z7c=
X-Received: by 2002:a17:902:eb8d:b0:15e:bf22:2791 with SMTP id
 q13-20020a170902eb8d00b0015ebf222791mr19834834plg.88.1652168142424; Tue, 10
 May 2022 00:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn> <20220509134629.440965-6-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220509134629.440965-6-Qing-wu.Li@leica-geosystems.com.cn>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 10 May 2022 10:35:31 +0300
Message-ID: <CA+U=DsoTgX5kjVshqKYa0rcL7MMWER9Q5njnVd7WRpkq+YCAHQ@mail.gmail.com>
Subject: Re: [PATCH V1 5/5] iio: accel: bmi088: modifed the device name.
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        mchehab+huawei@kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 4:46 PM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> It is possible to have multiple sensors connected on the same platform,
> The commit makes it possible to obtain the device name for
> the different chips according to the connected chip ID.
>
> To be compatible with previous versions, renambmi088a to bmi088-accel.
>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/bmi088-accel-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index 7c78cfb321ee..8f6920dc2ad9 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -461,7 +461,7 @@ static const struct iio_chan_spec bmi088_accel_channels[] = {
>
>  static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>         [0] = {
> -               .name = "bmi088a",
> +               .name = "bmi088-accel",
>                 .chip_id = 0x1E,
>                 .channels = bmi088_accel_channels,
>                 .num_channels = ARRAY_SIZE(bmi088_accel_channels),
> @@ -561,7 +561,7 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
>
>         indio_dev->channels = data->chip_info->channels;
>         indio_dev->num_channels = data->chip_info->num_channels;
> -       indio_dev->name = name ? name : data->chip_info->name;

This makes the 'name' parameter unused now.
Which begs the question if it should be removed.

One other detail is that the device-tree will need to set a compatible
string to 'bmi088-accel' and this will work (for SPI devices) for all
chip-types (including the new ones).

This raises the question of whether we should update the new chips in
the DT yaml doc here?

Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml

properties:
  compatible:
    enum:
      - bosch,bmi088-accel

If yes, then the 'drivers/iio/accel/bmi088-accel-spi.c' file also
requires an update with the new device-names.

> +       indio_dev->name = data->chip_info->name;
>         indio_dev->available_scan_masks = bmi088_accel_scan_masks;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &bmi088_accel_info;
> --
> 2.25.1
>

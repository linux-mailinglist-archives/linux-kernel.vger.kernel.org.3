Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1D65006CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbiDNHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbiDNHTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:19:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1614D369F1;
        Thu, 14 Apr 2022 00:17:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u15so8262741ejf.11;
        Thu, 14 Apr 2022 00:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lSMs6l95Aa4HubZ47TtOEpTFtR/B9ipIM8nu8U2XOBY=;
        b=HntGjBdcpUVX0rjAbjH4K3HcKAohdWFHDE0kyRAFF0Hrwon/zxMWFgB2iPRD4Fk9e7
         rKAOyO2L8ed3ClLi6GxPP5iG8QQ09aPaqRhijK+uwPATLLOYAlmt14LGcDG5JISwQWsw
         5Pr3YFFoEpxrZozh4mfMaul8xqcnYtdK1N3meDCKT9USNO8Aa8NDi4wWetqzGM2WoY0Z
         Y6PZeWTs/eQbaZz3enGu3x5BzYR3cP2wXspFhCFC0syyh9fN88vjmQckKsN47r2p2rN2
         CLTocRhuHWll51R2SElYOHPGqoU4QQx5cvtpdEkDKiKE4sVTKBTimI6+n5X8q3drDcTW
         M5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lSMs6l95Aa4HubZ47TtOEpTFtR/B9ipIM8nu8U2XOBY=;
        b=A2B4IXRjGpwPaD4YfzNTAXwVV9e5jCqV15j3ggpC9xRZE3DjbZBdTHKGpsF+c14uIX
         I1BLPf+iBvXFrYgaeudR/y8h4B8ta9mJIY+nbB5YVrsw03E7m0lKDRmopivgx4Tf9xPw
         I17yOoNXBrIGHWne+UT0gP2G89EilQP+tz4EEhEJKjCniFysno/1RTj4dJCQlJUhMNhl
         e8J+15+nsrqtmK2wMoTd8hnB9mbR7o2b62lil+Pk2N5mcjmc8e0FP/sx4sZ/nWufbK4f
         PQZkMCXhoFj8BfxG2n/vLkdCjBBYyz1YaCaY4oFSsOEUkvwXD6cpsXQlxlhshGAJt/+e
         zDFw==
X-Gm-Message-State: AOAM533QBIqbCdJci7H7wb33FMeMCv82UEWiXrVFgeHFc8DdmJlUHoT9
        CvPkXqNi9jwsY/uLz7YVCNA=
X-Google-Smtp-Source: ABdhPJw11IhiSGrmELHGd/U29IfBfy5bHbAMd57P4VEjerEPcJXfjsQO75ho/8DCQRSdSqWCdMTd5g==
X-Received: by 2002:a17:906:7056:b0:6d6:dd99:f2a4 with SMTP id r22-20020a170906705600b006d6dd99f2a4mr1144949ejj.43.1649920643487;
        Thu, 14 Apr 2022 00:17:23 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b2c:c401:dd5:7d95:7a65:6518? ([2001:a61:2b2c:c401:dd5:7d95:7a65:6518])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7de8a000000b004215209b077sm70538edv.37.2022.04.14.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 00:17:23 -0700 (PDT)
Message-ID: <fd9aa60147aba2d76e4b2d1b82011c610d3e52d6.camel@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: core: Convert to use firmware node handle
 instead of OF node
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Thu, 14 Apr 2022 09:17:22 +0200
In-Reply-To: <20220413180202.19220-1-andriy.shevchenko@linux.intel.com>
References: <20220413180202.19220-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-13 at 21:02 +0300, Andy Shevchenko wrote:
> Switch the IIO core to use firmware node handle instead of OF node.
> This will allow to get label from firmware on non-OF systems.
> 
> Note, this doesn't change of_iio_*() APIs for now.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/industrialio-core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c
> b/drivers/iio/industrialio-core.c
> index 2f48e9a97274..ffbe76806e07 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1893,20 +1893,22 @@ static const struct iio_buffer_setup_ops
> noop_ring_setup_ops;
>  int __iio_device_register(struct iio_dev *indio_dev, struct module
> *this_mod)
>  {
>         struct iio_dev_opaque *iio_dev_opaque =
> to_iio_dev_opaque(indio_dev);
> -       const char *label;
> +       struct fwnode_handle *fwnode;
>         int ret;
>  
>         if (!indio_dev->info)
>                 return -EINVAL;
>  
>         iio_dev_opaque->driver_module = this_mod;
> -       /* If the calling driver did not initialize of_node, do it
> here */
> -       if (!indio_dev->dev.of_node && indio_dev->dev.parent)
> -               indio_dev->dev.of_node = indio_dev->dev.parent-
> >of_node;
>  
> -       label = of_get_property(indio_dev->dev.of_node, "label",
> NULL);
> -       if (label)
> -               indio_dev->label = label;
> +       /* If the calling driver did not initialize firmware node, do
> it here */
> +       if (dev_fwnode(&indio_dev->dev))
> +               fwnode = dev_fwnode(&indio_dev->dev);
> +       else
> +               fwnode = dev_fwnode(indio_dev->dev.parent);
> +       device_set_node(&indio_dev->dev, fwnode);
> +
> +       fwnode_property_read_string(fwnode, "label", &indio_dev-
> >label);
>  
>         ret = iio_check_unique_scan_index(indio_dev);
>         if (ret < 0)

Hi Andy,

So I was actually planning to send the same patch today or in the next
few days. I do also have the conversion of inkern.c so I guess we can
move in 3 different ways:

1. If you are planning or already have some work with it, I'm more than
fine in just forgetting my patches and let you do it (you are cleaning
all the drivers already)

2. I can send the patch (without this one) already for reviewing... It
won't apply because I think there will be some conflicts with some of
the drivers you changed already. Fun fact, remove of.h from iio.h and
you see some drivers relying on it for property.h and mod_devicetable.h

3. Just wait for your latest patches to be merged and send mine next
week.

Up to you :)

- Nuno Sá



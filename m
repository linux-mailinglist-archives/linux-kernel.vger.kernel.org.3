Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9264D4CB21B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbiCBWRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCBWRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:17:34 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C910D199B;
        Wed,  2 Mar 2022 14:16:50 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id t28so3017651qtc.7;
        Wed, 02 Mar 2022 14:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qFb1AQXGto8rW2v4HENONQPyad9zpp2Lw3iyL5e2hcw=;
        b=TGLsEu6t++tXeHwptrWF0tmRCBkIkJHDm4VFCqheaPgdP8JHAuqJrpBzSg8NQ9fp8F
         XGDXGLQ9OJkcaVoPa7f/ow+MOL8mQC7QNnJ6ZoiOKaO0jqhk5+Mefa7o+fgkgIQA8GqA
         QF3kXKcFGBmGfZhGMttHslQaXysRkuvCylHUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qFb1AQXGto8rW2v4HENONQPyad9zpp2Lw3iyL5e2hcw=;
        b=VY4k00Fbot5FOmwUGDArwbYQHHqAfHWwquukL1ZFQlVcrvmeE7hNttzHZeo2Ecyhf6
         hl3aWYWkHIuASLY1vLzUWUaAvBKnrL67V2a4Abtv5glcyR4FHOlkf1z2Qp4+0VYc9KMA
         1RNgp0xGQivkUx8uMuVmvNJSxjWXHDWs56Nnjm4dL8Jcupevrk3cQpOIis5j3I0mVNQs
         xLAvqZKGne0qLlm87I0niiRNtHid94d9q5p4AXTTfpyjvFnNuepz2y43sJGxTqUraBkv
         L6UEaLa1DaeSGI7BggZ4YYRv68GKdqUcxuzC/lqvqUSWK6QR9c55suQA5osbNpDats3D
         O6KA==
X-Gm-Message-State: AOAM532QNKvUYC2IYOV/ZQi3fBlcB6mGRzKGzg07rxyc5hHFK/hqyUiu
        z0S+lnPvcP/tYM3Pi5cJYhx9JpnF7f5AOr2apFU=
X-Google-Smtp-Source: ABdhPJzkJ0p0YYS9ZflUh9jGYrmogt5rxOjUJMxJJf96LA6FonDZUDNtoD1pgTQcDhJlQxMnIZ36OkJc+TL5n2hUco4=
X-Received: by 2002:ac8:5b82:0:b0:2cf:232d:b1f8 with SMTP id
 a2-20020ac85b82000000b002cf232db1f8mr25724587qta.58.1646259409105; Wed, 02
 Mar 2022 14:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-2-clg@kaod.org>
In-Reply-To: <20220302173114.927476-2-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 22:16:35 +0000
Message-ID: <CACPK8XcQfC6qfMDLzzLeK5BKmBnrspruvruJ9xGdydZgWefVOw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mtd: spi-nor: aspeed: Rename Kconfig option
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 17:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> To prepare transition to the new Aspeed SMC SPI controller driver using
> the spi-mem interface, change the kernel CONFIG option of the current
> driver to reflect that the implementation uses the MTD SPI-NOR interface.
> Once the new driver is sufficiently exposed, we should remove the old one=
.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

As the maintianer of the aspeed systems and the openbmc kernel, I
think this makes the most sense.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/mtd/spi-nor/controllers/Kconfig  | 2 +-
>  drivers/mtd/spi-nor/controllers/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-no=
r/controllers/Kconfig
> index 5c0e0ec2e6d1..876a47042fec 100644
> --- a/drivers/mtd/spi-nor/controllers/Kconfig
> +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -config SPI_ASPEED_SMC
> +config SPI_ASPEED_SMC_MTD_SPI_NOR
>         tristate "Aspeed flash controllers in SPI mode"
>         depends on ARCH_ASPEED || COMPILE_TEST
>         depends on HAS_IOMEM && OF
> diff --git a/drivers/mtd/spi-nor/controllers/Makefile b/drivers/mtd/spi-n=
or/controllers/Makefile
> index e7abba491d98..1e28297fb1e8 100644
> --- a/drivers/mtd/spi-nor/controllers/Makefile
> +++ b/drivers/mtd/spi-nor/controllers/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_SPI_ASPEED_SMC)   +=3D aspeed-smc.o
> +obj-$(CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR)       +=3D aspeed-smc.o
>  obj-$(CONFIG_SPI_HISI_SFC)     +=3D hisi-sfc.o
>  obj-$(CONFIG_SPI_NXP_SPIFI)    +=3D nxp-spifi.o
>  obj-$(CONFIG_SPI_INTEL_SPI)    +=3D intel-spi.o
> --
> 2.34.1
>

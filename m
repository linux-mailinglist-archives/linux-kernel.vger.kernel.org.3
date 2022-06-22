Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4FE554610
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbiFVKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiFVKNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:13:04 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF02670
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:13:03 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v4so20551566oiv.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZV2ZlVJt7CeHj2xBD2KBNqt9YIgRKukSAc/1YjTAtQ=;
        b=n5/t5DQowlGHbbStJdwXCD4174eV+x4WAdb973TnbH7D7UekWKD/3AjKck5B+iwfyS
         cW91XtGyHnIS+GCb/kzcT1gvtXvnzoBLRItjXYiKCYC0ty1yMoFV/yTtgtJQWho4vG/L
         98bHbjtIuzBxKChynh3WF5ZrgeLImTpOiFXDZgsQDNvFg1HWEaafIm01Mr9qThBFxbwR
         Mj+ZzzbIwsp63FWgaF9ylIxsm67xo60GFlni0FvC5NKVNaje641dZjlEnxwwbvLBvcu7
         3UM63q2pZGd6vriehRE0+A34TnIC3vpp4ysD/E4eg5NF4PZKTxSNjGZE3m7atA4qzRIv
         LUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZV2ZlVJt7CeHj2xBD2KBNqt9YIgRKukSAc/1YjTAtQ=;
        b=V92cGZTAZu/1QCUE+DShFFczXf+PfgynSq8qoROrCidHFblXL00u68fEnsMOF/DVeG
         r8HM8ot0urfKADcIjsY2aCTs5LXoPNT6IHqTt8WygxyVXVn35x0ktx/c6c9lfv/7l+uy
         Si+xezixy9oYroBFF3J/D8/z6seTstjnQk9As3CZVNP3oCVp730UbMNEO1JRLivj+GMk
         FVZyJUrWKmU5wakE/9QpDaHXTrby9WCrZ9ezlYhqJRqlZIdGOko81jTNRQuvJxLl1OUz
         2pQUfWp0zDUob980WRhlF94WlNt8a8OoMa6zz13Zz5YabCU6XKZ81wGMPgSrmyHpgek/
         95zQ==
X-Gm-Message-State: AOAM531sL/Ny/u8Y34Kp+PUR8K2LMR9o21f9ijdTQmm2XAus1HcIaY57
        c10Msc4cwMXwybGKP9ZAEJvJxaYOzBV/wclRkSE=
X-Google-Smtp-Source: ABdhPJwRJ2IJLy7rIYmEXKNPWRcbCCSD+PzDdaZQzVkoYdJ9j1lgFXaz6YDYv+2RjYOpXXRSKRz/zWvaT77O5PiyjkA=
X-Received: by 2002:a05:6808:1926:b0:32e:b1dc:98f4 with SMTP id
 bf38-20020a056808192600b0032eb1dc98f4mr22242387oib.126.1655892780993; Wed, 22
 Jun 2022 03:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
 <20220620134758.1286480-2-aisheng.dong@nxp.com> <YrCM0reni+x/KWsG@sirena.org.uk>
 <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk> <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk> <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrHkXH1M4NydBfQT@sirena.org.uk> <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 22 Jun 2022 18:12:49 +0800
Message-ID: <CAA+hA=RQVRHzdy_ZpwcC-ZB8mwUYuMYu_iLNAfuPcMCS1G9WXA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark & Lucas,

[...]

> > > Furthermore, current imx blkctl is a common driver used by many devices
> > [1].
> > > Introducing volatile registers and cache may bloat the driver a lot
> > unnecessarily.
> >
> > You don't actually need to have a cache to use cache only mode, if there are
> > no cached registers then you'll just get -EBUSY on any access to the registers
> > but that's hopefully fine since at the minute things will just fall over anyway.
> > You shouldn't even need to flag registers as volatile if there's no cache since it's
> > not really relevant without a cache.
> >
>
> After a quick try initially, I found two issues:
> 1. There's a warning dump if using cache_only without cache
> void regcache_cache_only(struct regmap *map, bool enable)
> {
>         map->lock(map->lock_arg);
>         WARN_ON(map->cache_bypass && enable);
>         ...
> }
> 2. It seems _regmap_write() did not handle cache_only case well without cache.
> It may still writes HW even for cache_only mode?
>
> I guess we may need fix those two issues first before we can safely use it?
>

Below is a quick try fix which seems to work at my side by using cache_only
mode suggested by Mark. I set cache_only mode in the bus power notifier
rather than in blkctl power on/off callback in order to avoid possible cache
mode setting contention.

NOTE:  i didn't fix _regmap_write() as i.MX controls regmap write well in driver
with power enabled first, so don't have issues in reality.
It can be fixed in a separate patch later if needed.
You may check if it's as your expected solution.

For syscon, I still have no idea how to fix it if I can't disable it.

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 2eaffd3224c9..da1702fd57cc 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -495,7 +495,7 @@ EXPORT_SYMBOL_GPL(regcache_drop_region);
 void regcache_cache_only(struct regmap *map, bool enable)
 {
        map->lock(map->lock_arg);
-       WARN_ON(map->cache_bypass && enable);
+//     WARN_ON(map->cache_bypass && enable);
        map->cache_only = enable;
        trace_regmap_cache_only(map, enable);
        map->unlock(map->lock_arg);
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 7ebc28709e94..12f0f9a24fad 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -199,6 +199,8 @@ static int imx8m_blk_ctrl_probe(struct
platform_device *pdev)
                return dev_err_probe(dev, PTR_ERR(bc->regmap),
                                     "failed to init regmap\n");

+       regcache_cache_only(bc->regmap, true);
+
        bc->domains = devm_kcalloc(dev, bc_data->num_domains,
                                   sizeof(struct imx8m_blk_ctrl_domain),
                                   GFP_KERNEL);
@@ -408,6 +410,8 @@ static int imx8mm_vpu_power_notifier(struct
notifier_block *nb,
                 */
                udelay(5);

+               regcache_cache_only(bc->regmap, false);
+
                /* set "fuse" bits to enable the VPUs */
                regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
                regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
@@ -415,6 +419,9 @@ static int imx8mm_vpu_power_notifier(struct
notifier_block *nb,
                regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
        }

+       if (action == GENPD_NOTIFY_PRE_OFF)
+               regcache_cache_only(bc->regmap, true);
+
        return NOTIFY_OK;
 }

@@ -461,6 +468,9 @@ static int imx8mm_disp_power_notifier(struct
notifier_block *nb,
        if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
                return NOTIFY_OK;

+       if (action == GENPD_NOTIFY_ON)
+               regcache_cache_only(bc->regmap, false);
+
        /* Enable bus clock and deassert bus reset */
        regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(12));
        regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(6));
@@ -473,6 +483,8 @@ static int imx8mm_disp_power_notifier(struct
notifier_block *nb,
        if (action == GENPD_NOTIFY_ON)
                udelay(5);

+       if (action == GENPD_NOTIFY_PRE_OFF)
+               regcache_cache_only(bc->regmap, true);

        return NOTIFY_OK;
 }
@@ -531,6 +543,9 @@ static int imx8mn_disp_power_notifier(struct
notifier_block *nb,
        if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
                return NOTIFY_OK;

+       if (action == GENPD_NOTIFY_ON)
+               regcache_cache_only(bc->regmap, false);
+
        /* Enable bus clock and deassert bus reset */
        regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(8));
        regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(8));
@@ -543,6 +558,8 @@ static int imx8mn_disp_power_notifier(struct
notifier_block *nb,
        if (action == GENPD_NOTIFY_ON)
                udelay(5);

+       if (action == GENPD_NOTIFY_PRE_OFF)
+               regcache_cache_only(bc->regmap, true);

        return NOTIFY_OK;
 }
@@ -716,6 +733,9 @@ static int imx8mq_vpu_power_notifier(struct
notifier_block *nb,
        if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
                return NOTIFY_OK;

+       if (action == GENPD_NOTIFY_ON)
+               regcache_cache_only(bc->regmap, false);
+
        /*
         * The ADB in the VPUMIX domain has no separate reset and clock
         * enable bits, but is ungated and reset together with the VPUs. The
@@ -740,6 +760,9 @@ static int imx8mq_vpu_power_notifier(struct
notifier_block *nb,
                regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
        }

+       if (action == GENPD_NOTIFY_PRE_OFF)
+               regcache_cache_only(bc->regmap, true);
+
        return NOTIFY_OK;
 }

Regards
Aisheng

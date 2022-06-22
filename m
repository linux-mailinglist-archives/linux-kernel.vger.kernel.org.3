Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC065551D9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359330AbiFVRBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiFVRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:01:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF43ED02
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:01:24 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id h65so21489886oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVnoauuZr8uLItSbyMnPGz5PkUjcua4LTFQ0/ysUk8c=;
        b=WwHP6jCk3Nze/7kPccCRU1vx79tiz+LJO92F+hDHKdk5/KLSp1hXgzN/nHkDRTleu6
         9oK92Mtps6u0DLuiWlSV8dPlAFBvK8wcaNRyvqDjtKMmCyTA4R7YBAh3W1KMO0+Z0/8P
         TQIJqAOH1AC9I8oI8lxqNbb8kc2hdaMb4sFt5loOrifXmt6cIoVQq86ZtA5Fqa4KD2tX
         9yZEJ7WGj04uRGHDHVuEIZ9gxP+H7XD9B4h06Ts49NF/MM+sdG9321EwLHl21+zZoieb
         t6I8TGiVrGc9+bMf/ToYky2xwVxh74u0y/kWKyJJ3UgSB28QzkcA36jxllSf8UObPugm
         5DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVnoauuZr8uLItSbyMnPGz5PkUjcua4LTFQ0/ysUk8c=;
        b=RTHiuE1gYtrqjPMZhcF3NsUqFLzFW8YqPgb+BcVsv6dc6sgfAEowAZGsRpZj9J1s0T
         CNEVW+culvGjjAQKrS1vOdkYzXgyTs1TNWKIqFQfgQnMK1ibp5VMJ9DzSzoNQOLM90aN
         NBU4PC1ze5wIByFzU6bbJXNJjacY/nGvmPdOY0lh/BESVkTKzKCqa8HXhaK5nb+Wj7uK
         xNqvojN3tDGati8SBDSBuxQOwKMu4D77MiTYYZXQ0+ru+HToWNyUU6U4GSeDOBiLwpwo
         P/2WJk+NB1yfq8Mhm5HTuvW12C369BiOylpgtZ9aLtf5RALeL3U3h17hTx0NXOPJZf0I
         9G9A==
X-Gm-Message-State: AOAM531NjOUoXce5souyNiOUpy5X6T52ztMeb3o/kv/t5wJxry9G+Gm1
        mJ02BTzmdNQlXZekX+VacAWZx9/9VZG4tker8Nk=
X-Google-Smtp-Source: ABdhPJwImH2yDzuXrPiEnHG7SfrkT1f6uE+dBtq8OiwV07PfYI4O8rznqwzlPDC55jgRI327Cz8uNcrrshVs55Q4LdM=
X-Received: by 2002:a05:6808:1926:b0:32e:b1dc:98f4 with SMTP id
 bf38-20020a056808192600b0032eb1dc98f4mr23312009oib.126.1655917283877; Wed, 22
 Jun 2022 10:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk> <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrHkXH1M4NydBfQT@sirena.org.uk> <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <CAA+hA=RQVRHzdy_ZpwcC-ZB8mwUYuMYu_iLNAfuPcMCS1G9WXA@mail.gmail.com>
 <YrMMzizzE7rIji5x@sirena.org.uk> <CAA+hA=SA7BY8WxrbuRAOsuHyz+bx-EJq-UT_YLW5wYMS+io+pg@mail.gmail.com>
 <YrNC3eHx7ARQy/Vd@sirena.org.uk> <CAA+hA=SHgp1jZn1Qwrcu3fMnn22aaVimS4+Y2hPcWehS4zdRoA@mail.gmail.com>
 <YrNH8/eaYHYeAWNJ@sirena.org.uk>
In-Reply-To: <YrNH8/eaYHYeAWNJ@sirena.org.uk>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 23 Jun 2022 01:01:12 +0800
Message-ID: <CAA+hA=SsTeTF80dL6cT6Ef7Y9Q3Fhj4Jp0S-_nk=UK1HsZ4hYw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
To:     Mark Brown <broonie@kernel.org>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
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

On Thu, Jun 23, 2022 at 12:48 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jun 23, 2022 at 12:42:51AM +0800, Dong Aisheng wrote:
> > On Thu, Jun 23, 2022 at 12:27 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > cache_bypass is only going to be true if something enabled bypass, why
> > > would a device that doesn't use a cache enable bypass?  It does get
> > > turned on transiently by things like patching but those only make sense
> > > if the device can be accessed so caceh_only shouldn't be on then.
>
> > It was enabled by default according to the code:
> > __regmap_init -> regcache_init
>
> Ah, right.  That makes sense - we should relax the check to only apply
> if there is actually a cache.

If we don't remove the WARN_ON in regcache_cache_only(), how
would you suggest the fix?
Otherwise we can't call regcache_cache_only() for imx blkctl which does not
have a cache.

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

Regards
Aisheng

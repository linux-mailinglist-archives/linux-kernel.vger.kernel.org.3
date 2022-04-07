Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509034F7686
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbiDGGr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiDGGr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:47:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E08B207A34;
        Wed,  6 Apr 2022 23:45:26 -0700 (PDT)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MKbXu-1nHWBt0UBg-00KyG1; Thu, 07 Apr 2022 08:45:25 +0200
Received: by mail-wr1-f48.google.com with SMTP id u3so6355900wrg.3;
        Wed, 06 Apr 2022 23:45:24 -0700 (PDT)
X-Gm-Message-State: AOAM531W2o5KY3VJWh4KsSVH8HI8tkuFTDmT8uFeyfwUAKfejUnRDo91
        /D/PFMVgOcW+H7tHrofPPpTOEQbY33+eU5b8X7E=
X-Google-Smtp-Source: ABdhPJwsoybhLaXFjVbw9+Vc+qPMhYVfNmGEl4gaT+Zb4xyPM1SU8zwIvCuEH2wtfDORtGv8O2YNAP5pFGOwsiaZ1iY=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr9605655wrh.407.1649313924632; Wed, 06
 Apr 2022 23:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-10-brad@pensando.io>
In-Reply-To: <20220406233648.21644-10-brad@pensando.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Apr 2022 08:45:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1RdHTngDVqg4KnVA3N8EjDfbpQ=cEcz_CK8NmG2EgYLQ@mail.gmail.com>
Message-ID: <CAK8P3a1RdHTngDVqg4KnVA3N8EjDfbpQ=cEcz_CK8NmG2EgYLQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] mmc: sdhci-cadence: Add Pensando Elba SoC support
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>, dac2@pensando.io,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:16QUAd4m1hM+RCRM1ldXGIJ7ItAtpJGmDbRF74wz3JHNwuXUB22
 WMvO4cpdgDkTXruzTypokbYXHC4lCkDSYV8f9kF15CohYnWf9ZYIGKJTt+3MgiGeEKY4wpG
 5TbyUbEhnJaQdrIQ0d5kTCOGydOXeOkDpop4iOMyW7kG2XzBXfIJutCykU8czNNSDK0pHWB
 qGFPjjdLRY5lasyx40EWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IJJS/BzDVK0=:xk0Lcc4sVb2EaVlKnHWqH4
 tPb/S8lOBJ+fTK4GuZ9Yg+qIa0NzWC5AaeO3NuL1NLyqlpN0uIw6XbsRDWm4GPfQlPdJ/FZf2
 nvWa8weLhr363hyM7JNvdP+RbP8ZKfCZmtHJsAPxerbecIQSYlfFFeShtg43JAM21NtSuzXR2
 NVbZkiXRxjz8MC5Cb1GQ6tsxZqASeeqfdkxQaxYUUi67gOE1g8fdlB/ARWN87PR+oATALsmi7
 x2PQJ+VxyBjO6zziBZEKq9wz7vG3lAe51/DqeFuumIy/DTK1OIgtAwhImz7ykLAMtkIeLAFdv
 FTKzjawxf+v430v7soR00qQuEkK5BNAMR84HJpSUe94gzl+YgvSIciv38meIRqBZpvshnf7fs
 9rxnK6/HP9L0NRrKN+WNlgQ2Ji+WQg+fIvIAda4nOhNmnndhbYEvveylk7SrYqpvdbTNIZmIm
 A1If3U1mOxkOQ3uiEmQ7YI0sMOZSRJJrq/dkDz7Vw9a+/DKxGhRPWXwi9NwKPy7kd7FjcqW7Z
 TQe5aO2JZ7C3dtLksZPYnE4ubp153Zpv4lRSydE+n8d4MoI7CgZrZzMs/jn7ctc0zaXajpAWZ
 cSiCrFS2nEPZ7DLVtC8Fmnnqza+TQ3GNu+t9Z5BlUXmy5ZK67furvUfK30ncQMGvFMq+Y8kaQ
 XZiUF5QrqnBRgz1w6j+njsviKZ9Kg4KyoeNfD0VvSBD/EsHMrzZuYvKlkjPaPC4d3XiGFIYla
 6CNpKCdEpqk8hKT0j6i/ciLe6iC51v2YPR7SffrBzeu/Qx3JgFzfYFkkaE4V+PLYq4ojOlHJC
 wDS78SvKMB8tkE4dWgXvnb+cQEc5bp7m+cveWcMFh46O8eV/d4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 1:36 AM Brad Larson <brad@pensando.io> wrote:
> @@ -350,7 +461,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
> -       const struct sdhci_pltfm_data *data;
> +       const struct sdhci_cdns_drv_data *data;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_cdns_priv *priv;
>         struct clk *clk;
> @@ -369,10 +480,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>
>         data = of_device_get_match_data(dev);
>         if (!data)
> -               data = &sdhci_cdns_pltfm_data;
> +               data = &sdhci_cdns_drv_data;
>
>         nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> -       host = sdhci_pltfm_init(pdev, data,
> +       host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>                                 struct_size(priv, phy_params, nr_phy_params));
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
> @@ -389,6 +500,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         host->ioaddr += SDHCI_CDNS_SRS_BASE;
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                                 sdhci_cdns_hs400_enhanced_strobe;
> +       if (data->init) {
> +               ret = data->init(pdev);
> +               if (ret)
> +                       goto free;
> +       }
>         sdhci_enable_v4_mode(host);
>         __sdhci_read_caps(host, &version, NULL, NULL);

I'm not sure about the abstraction here. The approach of having a single
driver with some platform specific quirks like you do here works fine if the
differences between hardware implementations are fairly minor, but if there
are a larger number of variants, or the differences become too big, the
better approach is to have separate top-level driver instances that call
into a more generic driver, continuing the call chain

elba_drv_init()
 -> sdhci_cdns_probe()
     -> sdhci_pltfm_init()
         -> sdhci_add_host()
             -> mmc_add_host()

with each one being a more specific version of the one below it.
At the moment, it doesn't quite require having a custom driver,
but I fear that it it would get hard to rework if it continues to grow
other front-ends. It may be better to do the abstraction right away,
even if the elba driver becomes rather trivial.

Ulf, any preferences?

         Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469EA57656F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiGOQwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGOQwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:52:06 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958684AD40;
        Fri, 15 Jul 2022 09:52:04 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31c9b70c382so52578327b3.6;
        Fri, 15 Jul 2022 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3fEn7k6DEbC0BSZl5T1cKqr6t4t3jgvkJEo6o2VWJg=;
        b=MXGzp2L91pEJL+AcTAycFNXQ1RlDsP6v+gpGIgwODuesPa+p9Vkg4kB7S9nocynJGw
         Z6eSLqvXs18KQxUaf2JoIzf80wNgEBx5lb8hmQls/pYl5cmqKU6ZV2U293CPRD7pHPxN
         oVoCyNl0NZggmwruE29B+fIK5bXDrw9tjgIG3C8Nq+6m6OWBSRplWoiH96JI+OT2GKU0
         e+tCPQwL8IYMCW95SAqKMM4ZmBlz4myO2waTWwKa21CY9s4W7s12O0mKU6NbZpFIBwjv
         WQndJpk7ul+2kIlNcx4SEPMyoKdY46YyQ2MP3qjPVvRdKZ8R3yH3WQfj2xLINnsHUnDO
         ZohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3fEn7k6DEbC0BSZl5T1cKqr6t4t3jgvkJEo6o2VWJg=;
        b=S8bBgDCaTx7vYdVu0Yek0FMny4kKKl+WrwSl5TTRd2XKbCkeygR8pl/TDjO1YjF8AG
         4Z1aGufvqgTM35RWcjWnc5n5EY6OIe1Rnr0UzEbRL0JNpmX4jrDjHZLv0gK/H6d7GHXa
         Vy5Q69AfmUylfx/bILXyy4N6lU/zWToat/amV+aXqQRkHQjheDt747SAFibf1JmkBaf7
         /Btl3we1bhiVeeuzFtrD2Ix3i6YgWuQ0+W1T+ZRHn9u39P7fZBr7ReQP1SzfmSe5uM19
         3q56cYFxZBKDIQZSNQiXVKM/icdnVtgjRR4MkU37fRBFixED1tFTnfqIh4CQGlJDuRC+
         EB+g==
X-Gm-Message-State: AJIora/z0DRec7AclL7m7KjlxLTV9vQI201wOsVYKCzi8pBbzuaHubgN
        U7d39gjiA8yqx5HRvpiTr7KIvmn31RuS/QU+B1A=
X-Google-Smtp-Source: AGRyM1sCY24F2pEPhG1uDrQQmbeNKcxn2P0g2UtmOwj7faRUDuEi5O71VSZCHL0+DLUg4GOwi/Ey7mykcBwsz36AuRU=
X-Received: by 2002:a81:54c1:0:b0:31d:ec18:fd5d with SMTP id
 i184-20020a8154c1000000b0031dec18fd5dmr7130568ywb.277.1657903923745; Fri, 15
 Jul 2022 09:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220715112607.591-1-peterwu.pub@gmail.com> <20220715112607.591-11-peterwu.pub@gmail.com>
In-Reply-To: <20220715112607.591-11-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jul 2022 18:51:27 +0200
Message-ID: <CAHp75Ve_WRAUyy=h9_F-tC1dDkb_=-F1uf7_h7R0p7xZgBAd-w@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] power: supply: mt6370: Add MediaTek MT6370
 charger driver
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 1:29 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> driver, display bias voltage supply, one general purpose LDO, and the
> USB Type-C & PD controller complies with the latest USB Type-C and PD
> standards.
>
> This adds MediaTek MT6370 Charger driver support. The charger module
> of MT6370 supports High-Accuracy Voltage/Current Regulation,
> Average Input Current Regulation, Battery Temperature Sensing,
> Over-Temperature Protection, DPDM Detection for BC1.2.

...

> +static int mt6370_chg_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct mt6370_priv *priv;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = &pdev->dev;
> +
> +       priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!priv->regmap)
> +               return dev_err_probe(&pdev->dev, -ENODEV,
> +                                    "Failed to get regmap\n");
> +
> +       ret = mt6370_chg_init_rmap_fields(priv);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "Failed to init regmap fields\n");
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       priv->iio_adcs = devm_iio_channel_get_all(priv->dev);
> +       if (IS_ERR(priv->iio_adcs))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->iio_adcs),
> +                                    "Failed to get iio adc\n");
> +
> +       ret = mt6370_chg_init_otg_regulator(priv);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "Failed to init otg regulator\n");
> +
> +       ret = mt6370_chg_init_psy(priv);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "Failed to init psy\n");
> +
> +       mutex_init(&priv->attach_lock);
> +       priv->attach = MT6370_ATTACH_STAT_DETACH;
> +
> +       priv->wq = create_singlethread_workqueue(dev_name(priv->dev));
> +       if (IS_ERR(priv->wq))

> +               return dev_err_probe(priv->dev, PTR_ERR(priv->wq),
> +                                    "Failed to create workqueue\n");

You need either wrap mutex to be deallocated by devm or don't use
dev_err_probe() here.

> +       INIT_WORK(&priv->bc12_work, mt6370_chg_bc12_work_func);
> +       INIT_DELAYED_WORK(&priv->mivr_dwork, mt6370_chg_mivr_dwork_func);
> +
> +       ret = mt6370_chg_init_setting(priv);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to init mt6370 charger setting\n");
> +               goto probe_out;
> +       }
> +
> +       ret = mt6370_chg_init_irq(priv);
> +       if (ret)
> +               goto probe_out;
> +
> +       mt6370_chg_pwr_rdy_check(priv);
> +
> +       return 0;
> +
> +probe_out:
> +       cancel_delayed_work_sync(&priv->mivr_dwork);
> +       flush_workqueue(priv->wq);
> +       destroy_workqueue(priv->wq);
> +       mutex_destroy(&priv->attach_lock);
> +
> +       return ret;
> +}
> +
> +static int mt6370_chg_remove(struct platform_device *pdev)
> +{
> +       struct mt6370_priv *priv = platform_get_drvdata(pdev);
> +
> +       cancel_delayed_work_sync(&priv->mivr_dwork);
> +       flush_workqueue(priv->wq);
> +       destroy_workqueue(priv->wq);
> +       mutex_destroy(&priv->attach_lock);
> +
> +       return 0;
> +}


-- 
With Best Regards,
Andy Shevchenko

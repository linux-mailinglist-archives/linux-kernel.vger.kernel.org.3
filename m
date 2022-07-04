Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5681C565E61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiGDUUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiGDUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:20:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782A9D;
        Mon,  4 Jul 2022 13:20:33 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 64so9200588ybt.12;
        Mon, 04 Jul 2022 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/OYescpC12d20RwbBmj4WBQ3v7OC1u9RlDvkq13ckI=;
        b=cegCCcDkUoo9P6FNcssziPe3wSPrKUvAGCjIOIIy9fhcj35RkgxKJl+LbBpnuq3wjU
         JtZm3oS9OqN+sojHrPwB50NIagpcab7QJIX1ILsQ1nJ3StpvjNnYljM49uisc2SiVCWu
         j+rtopNKTrfSTkSrCEj5pkG8bfUOxmoh6VMMD0Z3C7+zk3OYZ7p4bcaWrLSOEPhtwFjV
         ukHS++YJVwKW7lmRgBitYGThBKP4TMSFRMAMUNaen1amEPS1C+rGOUMq/TS5XsdgdxNa
         DPHYNnx/8ldISZwxJH+AJ4LPwa6A5JV5wzs0BLypkdYT38ysetCoOfRolw7meRpF0evK
         WYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/OYescpC12d20RwbBmj4WBQ3v7OC1u9RlDvkq13ckI=;
        b=GMxQ+gS1KItIuX+haaKgZV3wAcCu2RwW4uEj/KHvkyPoT7cujbcMeuvr36SlIIEL5U
         fhEASkJrapNqMUQD6jKoNgBPuN2iNwMQOSe2wdkBXOOBL/LL2bsK1qn0okUkGZiPZOqO
         uGvZn92wxY5uE4k0OGvLh/tcdlBJ76ykeibAXBPcqFB3OA5xeJcEZD1ReXMuEkKRREPR
         EjkeR2wIMhO7sukrjKGbO3MMFf4UDIpCntm31ml3eLuGPymw0tVUWrQB6ffBJT44fzug
         KgUSicXPFAdqHYJWO/wUkEBPk+jDLeb1MfRIea3VKYTqMrjNN0RlfVLg0AJqi2BTz5dp
         KMpw==
X-Gm-Message-State: AJIora9AK+1lW50vxxWKVqqNmiUEHLKjg294YJjvo/Spe88rUo5ro4c6
        ModHzIas8XrzZjBNrPGNFOU0n8clVULvy3Av4G8=
X-Google-Smtp-Source: AGRyM1vGN87zp2vOQSkYPHdy4U3iFiPDyi3SOwkZWy9X2zeUnXbmXLO8oItZWKupT1Gp6nG69Gr+SrGEdJWU94cJNCE=
X-Received: by 2002:a5b:68a:0:b0:66e:472a:83f4 with SMTP id
 j10-20020a5b068a000000b0066e472a83f4mr8514627ybq.570.1656966032191; Mon, 04
 Jul 2022 13:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-9-peterwu.pub@gmail.com>
In-Reply-To: <20220704053901.728-9-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 22:19:55 +0200
Message-ID: <CAHp75VeNRVHr-LorfnWAkwfXzT+ix6S9sZ623OBA8+0Zi8Xucg@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] usb: typec: tcpci_mt6370: Add Mediatek MT6370
 tcpci driver
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 7:42 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> Add chip level mt6370 tcpci driver.

...

> +static const struct reg_sequence mt6370_reg_init[] = {
> +       REG_SEQ(0xA0, 0x1, 1000),
> +       REG_SEQ(0x81, 0x38, 0),
> +       REG_SEQ(0x82, 0x82, 0),
> +       REG_SEQ(0xBA, 0xFC, 0),
> +       REG_SEQ(0xBB, 0x50, 0),
> +       REG_SEQ(0x9E, 0x8F, 0),
> +       REG_SEQ(0xA1, 0x5, 0),
> +       REG_SEQ(0xA2, 0x4, 0),
> +       REG_SEQ(0xA3, 0x4A, 0),
> +       REG_SEQ(0xA4, 0x01, 0),
> +       REG_SEQ(0x95, 0x01, 0),
> +       REG_SEQ(0x80, 0x71, 0),
> +       REG_SEQ(0x9B, 0x3A, 1000)

Keep a comma here in case something would be added later on.

> +};

...

> +       if (ret && !source)
> +               return regulator_disable(priv->vbus);
> +       else if (!ret && source)
> +               return regulator_enable(priv->vbus);
> +       else
> +               return 0;

'else' is redundant in both cases.

...

> +static int mt6370_check_vendor_info(struct mt6370_priv *priv)
> +{
> +       struct regmap *regmap = priv->tcpci_data.regmap;
> +       u16 vid;
> +       int ret;
> +
> +       ret = regmap_raw_read(regmap, TCPC_VENDOR_ID, &vid, sizeof(u16));
> +       if (ret)
> +               return ret;
> +
> +       if (vid != MT6370_VENDOR_ID) {
> +               dev_err(priv->dev, "Vendor ID not correct 0x%02x\n", vid);
> +               return -ENODEV;

return dev_err_probe(...);

> +       }
> +
> +       return 0;
> +}
> +
> +static int mt6370_tcpc_probe(struct platform_device *pdev)
> +{
> +       struct mt6370_priv *priv;
> +       int ret;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = &pdev->dev;
> +       platform_set_drvdata(pdev, priv);
> +
> +       priv->tcpci_data.regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!priv->tcpci_data.regmap)

> +               return dev_err_probe(&pdev->dev, -ENODEV,
> +                                    "Failed to init regmap\n");

You may save some LoCs by introducing a temporary variable

  struct device *dev = &pdev->dev;

and here on a single line

  return dev_err_probe(dev, ...);

Ditto for the rest.

...

> +       ret = mt6370_check_vendor_info(priv);
> +       if (ret)

> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "Failed to check vendor info\n");

This duplicates (with less info given) the message from the callee.

...

> +       { .compatible = "mediatek,mt6370-tcpc", },

Inner comma is not needed.

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC93573788
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiGMNf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGMNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:35:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B882DBE;
        Wed, 13 Jul 2022 06:35:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t25so19107017lfg.7;
        Wed, 13 Jul 2022 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYKoXtQBi+UHHvlNJzsiB51zZLZoDshebAIvkG4Ze80=;
        b=h9bIngDNE7y+/fKX/oHw7+azOdfnTz2i7MgBHs5a3O0NBQRb9Jhkr8NN2D43RoxyaQ
         JfUUqNxRf2r2xyx2nr4o8UNpakeH0ch8O8dWrBQI6SYIqEOWBlqDbVQ3TBs4GPXW6srI
         p5ZXpOypyN4OimKhc5jlB186gygVDd4N0/Qii6mfN6TSSuKSh/11YEtz9bf/yameG/xy
         iC6f3xvZ8U3eAj68RJBuEiLDxNrnb0yGrSf/Qbvq9YIypvHGX/XJ+oApN9+olMdZ0pQA
         sSJA4NHPhXzcg87Q+SzqCMW0+e0mS4OdDvc7z5y6nJuyk6I2OyYTaAh7tLbCfJJadw7b
         srWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYKoXtQBi+UHHvlNJzsiB51zZLZoDshebAIvkG4Ze80=;
        b=sHpyXunXcCHoe1R6i9d135KDjTkN6nj9DVM1RPIQCc4RiMjHHXauHsxjqQ4n4hrYMT
         n9jhprhvrp2NyooBaTFeFVOEEH9nWgO1ztWPhmnJCmPIrWjLaCnvX3vyo8i42v5hxRi1
         Ctr/ef92iWADGCNvod0n1iqg4yrvtvdQRAk5GMrn5vnN8hZcn6/46/ft4OYiDIR00bke
         IN2Y1Y1HlYt4JMRzt1fzFxZXkK18Filwkmw2QITIN7G/gi7uPy7H5Wj8jxzcgxr3FZYJ
         kQ7Jj8YX3ghWsJUVFCzr84Eq0boH7+1bH2oKaYKEwOVaiVFpQRdskg1hsx+wS+aASI2z
         efNw==
X-Gm-Message-State: AJIora8Q3m4WVGorp60fYjgM2c4i+0ZoHKqdA4tesvHgDKTHBEcX1AW+
        BEpbDS4t6+QGeb70MXFcDkGbqf05Ov4IyOQ3wDo=
X-Google-Smtp-Source: AGRyM1vZwX/9j0zxDeNWK/kUwAPgULFU7qG8J/00nPnrZg/qF45PRYUI3V3dq8xEhcBmSYrsRfjR+Ysv5M0gTCzqdeo=
X-Received: by 2002:a05:6512:2382:b0:48a:24d:51cc with SMTP id
 c2-20020a056512238200b0048a024d51ccmr1936006lfv.108.1657719355396; Wed, 13
 Jul 2022 06:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220710102110.39748-1-tmaimon77@gmail.com> <20220710102110.39748-3-tmaimon77@gmail.com>
 <95d12b72-be9d-5503-c4ea-801303bb7776@linaro.org>
In-Reply-To: <95d12b72-be9d-5503-c4ea-801303bb7776@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 13 Jul 2022 16:35:43 +0300
Message-ID: <CAP6Zq1geFJsKrdQEN5Vqjw6e8bsiArDe1tzJ-jkQm-2XT-0KyQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

Hi Krzysztof,

Thanks for your comments.

On Tue, 12 Jul 2022 at 12:50, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/07/2022 12:21, Tomer Maimon wrote:
> > Add pinctrl and GPIO controller driver support to Arbel BMC NPCM8XX SoC.
> >
> > Arbel BMC NPCM8XX pinctrl driver based on Poleg NPCM7XX, except the
> > pin mux mapping difference the NPCM8XX GPIO supports adjust debounce
> > period time.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
> (...)
>
> > +
> > +static int npcm8xx_pinctrl_probe(struct platform_device *pdev)
> > +{
> > +     struct npcm8xx_pinctrl *pctrl;
> > +     int ret;
> > +
> > +     pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
> > +     if (!pctrl)
> > +             return -ENOMEM;
> > +
> > +     pctrl->dev = &pdev->dev;
> > +     dev_set_drvdata(&pdev->dev, pctrl);
> > +
> > +     pctrl->gcr_regmap =
> > +             syscon_regmap_lookup_by_compatible("nuvoton,npcm845-gcr");
>
> No. Use property. By this patchset, I would expect that you learnt from
> previous mistakes around this. Why repeating the same trouble second time?
You suggest to use phandle property like nuvoton,sysgcr even that the
NPCM8XX pin controller driver is used only NPCM8XX SoC, so the only
GCR node in the NPCM8XX SoC is nuvoton,npcm845-gcr?
>
> > +     if (IS_ERR(pctrl->gcr_regmap)) {
> > +             dev_err(pctrl->dev, "didn't find nuvoton,npcm845-gcr\n");
> > +             return PTR_ERR(pctrl->gcr_regmap);
> > +     }
> > +
> > +     ret = npcm8xx_gpio_of(pctrl);
> > +     if (ret < 0) {
> > +             dev_err(pctrl->dev, "Failed to gpio dt-binding %u\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     pctrl->pctldev = devm_pinctrl_register(&pdev->dev,
> > +                                            &npcm8xx_pinctrl_desc, pctrl);
> > +     if (IS_ERR(pctrl->pctldev)) {
> > +             dev_err(&pdev->dev, "Failed to register pinctrl device\n");
> > +             return PTR_ERR(pctrl->pctldev);
> > +     }
> > +
> > +     ret = npcm8xx_gpio_register(pctrl);
> > +     if (ret < 0) {
> > +             dev_err(pctrl->dev, "Failed to register gpio %u\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     pr_info("npcm8xx Pinctrl driver probed\n");
>
>
> No pr_ in devices. No success debug messages.
>
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id npcm8xx_pinctrl_match[] = {
> > +     { .compatible = "nuvoton,npcm845-pinctrl" },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, npcm8xx_pinctrl_match);
> > +
> > +static struct platform_driver npcm8xx_pinctrl_driver = {
> > +     .probe = npcm8xx_pinctrl_probe,
> > +     .driver = {
> > +             .name = "npcm8xx-pinctrl",
> > +             .of_match_table = npcm8xx_pinctrl_match,
> > +             .suppress_bind_attrs = true,
> > +     },
> > +};
> > +
> > +static int __init npcm8xx_pinctrl_register(void)
> > +{
> > +     return platform_driver_register(&npcm8xx_pinctrl_driver);
> > +}
> > +arch_initcall(npcm8xx_pinctrl_register);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("tomer.maimon@nuvoton.com");
> > +MODULE_DESCRIPTION("Nuvoton NPCM8XX Pinctrl and GPIO driver");
>
>
> Best regards,
> Krzysztof

Best regards,

Tomer

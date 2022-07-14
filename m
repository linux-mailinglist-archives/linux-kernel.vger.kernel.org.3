Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B2E574ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiGNNPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbiGNNPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:15:15 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686B249B7C;
        Thu, 14 Jul 2022 06:15:14 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31c89111f23so16891557b3.0;
        Thu, 14 Jul 2022 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRwG+zlBQ+kmeFEt4Mjc7sgEiz7bh2APqSKI/QbwyJk=;
        b=JX1n/jFGRiKmk8qdje4WBbxBW3K6poXkLNK7oNx7J1BajqurACE5r7MuoikJsrHlyq
         WHslv+Mhg2/b5ZawLhmhZvZzeegJpH7HlUck0TRMdu7acvWoIq+gPAOuzTUsRCYiTHNh
         051n6kX1f+IRKf2Q8q9/ZOzaF1pclqMdiV/6Yhiq7enWeEqBAon6e353IAhXYMcSAV1m
         QPVdC0p0S8ZN/pChTDD8AqdgwNcSuU33NCm69+6aFXoZ4xJ5eJnp9w13uKcluXfzIY8X
         qu0pJzKokIFX0SjPraAq0RRCAy3dfnqJkxkTlLkji9XSwut6G5rk4PGB2pHVEC58OEqT
         JAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRwG+zlBQ+kmeFEt4Mjc7sgEiz7bh2APqSKI/QbwyJk=;
        b=utmpJ3iSVQe6xU2kqO8q6WvP1HGMvEenQrpW/P6bHUbQW2DfHQt/iWvzZBHDfP6WpV
         3LE6TkdkC+QUG0ZGWNh7YcgQztitIyfc552YetiBYnOAwfks/7NGmQ5+UBh40V2lNpFa
         wcI2iTCplnwzZPuyYiaXd4JwveQo2cvhZoHCzcoItItlAH6lBpWB5z2ub22aoo1qmGHQ
         xfcjp2QHg+aeYfthEQ3trjsLkH4FoppXlzDZaTD1/I5nCPtw0v21z1o7/VYneuGs0xjU
         RcFV+0cWK6dVg3cHP4qtqmL7QPIWojjkEP6rT6fcj3P/EIEXvl3njf6AZ/v6VrU4F5Vf
         dN9w==
X-Gm-Message-State: AJIora/BQLCcVSjvREzDbB7Ib9y8uJX3oBbxzmQh29AQ0iUj6dEcMYTN
        Iean75TzsHluVxqxn/9X0UJdLBYOGe2tICSkkNc=
X-Google-Smtp-Source: AGRyM1tOHS3ptK/ixYVOdGAyBC75qeMAA3UC+i5MULVUHqOlJ3vMz2IdKDCCsZw93xwst9jve/G/9SCD6kW4WehLyT4=
X-Received: by 2002:a81:4986:0:b0:31d:388b:d08d with SMTP id
 w128-20020a814986000000b0031d388bd08dmr9458913ywa.185.1657804513550; Thu, 14
 Jul 2022 06:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220714122322.63663-1-tmaimon77@gmail.com> <20220714122322.63663-3-tmaimon77@gmail.com>
 <b6a0abb7-f31f-0c8a-f65e-8d61b9e72f48@linaro.org>
In-Reply-To: <b6a0abb7-f31f-0c8a-f65e-8d61b9e72f48@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jul 2022 15:14:37 +0200
Message-ID: <CAHp75VepYwx9FCf0-7_MO9r7WNqxiTR7MAQcwSL4oNcdgt8qEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 2:29 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 14/07/2022 14:23, Tomer Maimon wrote:

...

> > +static int npcm8xx_pinctrl_probe(struct platform_device *pdev)
> > +{

Temporary variable, i.e.

  struct device *dev = &pdev->dev;

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
> > +             syscon_regmap_lookup_by_phandle(pctrl->dev->of_node, "nuvoton,sysgcr");
> > +     if (IS_ERR(pctrl->gcr_regmap))
> > +             return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->gcr_regmap), "Failed to find nuvoton,sysgcr property\n");

Will help to shorten the above line(s).

> Please wrap your code according to Linux coding style - @80.

-- 
With Best Regards,
Andy Shevchenko

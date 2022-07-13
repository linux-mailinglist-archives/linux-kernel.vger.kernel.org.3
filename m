Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F87573937
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiGMOvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiGMOvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:51:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DE82B26C;
        Wed, 13 Jul 2022 07:51:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a39so13749750ljq.11;
        Wed, 13 Jul 2022 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkvXwyXw/bzhYex6cozMZMYvSmlbOw/F0RDr0JxPoCw=;
        b=jQh6xeqT+Y6Ki5J436a0Th5YoFQnrEIqTMpRHU8Kce5a+/UIO2lYW5/lFa1+vKHif/
         +vgiXsnypYDq5rqLWPkKY/H2s9pEAvvq+k2Nn9858TvGTxNKoSfgB/2+BmmKtyjlYAE/
         elSX7mcb7soaQVXRiTDheQ+tqwHwksc7vU+uxBH4X4sn9qQ6MtzRMq92WcyTeStczoqx
         fSM5n34/SmQWOTOfxBRkJUMuoEc60KRSxHhSXA93RCJxJU32V6xwFYWBqo0XLCcUVYLu
         lycQEFzMu8MjsuhwNY45beIZaDWKEDh5ZisnCcGU7iakt09piKZmBvTjXdzJdxp3Dajq
         C18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkvXwyXw/bzhYex6cozMZMYvSmlbOw/F0RDr0JxPoCw=;
        b=E4CGYdv86QXrDXKC6LYjmndqSZfd0I3zCceagOdcsa6xtEX6tMyPpQI6UbMrWB83Ca
         ROhtUVqgZ8XULyGWxcwLH5Vbz+vYm8pLLlRF91soxGNX/HslXmCAgLJE842kjSraZ85t
         YpvVElc/tx4Nuw+HWEWsahew2QJ+Ct8KbM9raZ5Teyp1P3Rheb9TzImOcS5imKE4uoQD
         zO38YhsUCiAzLQKkWIrQ75iRa5hWvgDV9Rq/3qSMjsPCegqOiWqgP+0F+QZWvaSzx0B3
         UrOTaRQPNF+PPAGbSRTE+20e822/NTwPDeL4rNYMzkAxowY0Fc8XdPC4TjhGRLx6yJ93
         2JeA==
X-Gm-Message-State: AJIora+zs05hX7+sU2A3MdFUg1i4GVd5/tCBBocT4RIcpPQ+uDP9WaDg
        xg34KMTY5zFyHa5LuKmvARZKHXsvFyYa8E4Cndk=
X-Google-Smtp-Source: AGRyM1vh21YnVuz6etYVlI+CNEjVeXDQ4+b9pRjJCkzY5B8/snbbD68747zNPcfRkAZQlSnUw6MrDr+/TqSgoMhCsaw=
X-Received: by 2002:a2e:9b0b:0:b0:25d:866b:5de7 with SMTP id
 u11-20020a2e9b0b000000b0025d866b5de7mr1941252lji.50.1657723872657; Wed, 13
 Jul 2022 07:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220710102110.39748-1-tmaimon77@gmail.com> <20220710102110.39748-3-tmaimon77@gmail.com>
 <95d12b72-be9d-5503-c4ea-801303bb7776@linaro.org> <CAP6Zq1geFJsKrdQEN5Vqjw6e8bsiArDe1tzJ-jkQm-2XT-0KyQ@mail.gmail.com>
 <d8bc7a14-a9c5-4d34-997a-48a8d27c5edd@linaro.org>
In-Reply-To: <d8bc7a14-a9c5-4d34-997a-48a8d27c5edd@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 13 Jul 2022 17:51:01 +0300
Message-ID: <CAP6Zq1iAPmV9KVrBVqmRix8sTq0zLsw3T1vPo-t1Q+2RgO4qsA@mail.gmail.com>
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

On Wed, 13 Jul 2022 at 17:29, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/07/2022 15:35, Tomer Maimon wrote:
>
> >>> +static int npcm8xx_pinctrl_probe(struct platform_device *pdev)
> >>> +{
> >>> +     struct npcm8xx_pinctrl *pctrl;
> >>> +     int ret;
> >>> +
> >>> +     pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
> >>> +     if (!pctrl)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     pctrl->dev = &pdev->dev;
> >>> +     dev_set_drvdata(&pdev->dev, pctrl);
> >>> +
> >>> +     pctrl->gcr_regmap =
> >>> +             syscon_regmap_lookup_by_compatible("nuvoton,npcm845-gcr");
> >>
> >> No. Use property. By this patchset, I would expect that you learnt from
> >> previous mistakes around this. Why repeating the same trouble second time?
> > You suggest to use phandle property like nuvoton,sysgcr even that the
> > NPCM8XX pin controller driver is used only NPCM8XX SoC, so the only
> > GCR node in the NPCM8XX SoC is nuvoton,npcm845-gcr?
>
> Yes. The previous case (reset driver, AFAIR) was also about driver used
> only in one SoC, wasn't it?
Actually not, the NPCM reset driver serves NPCM7XX and NPCM8XX and
probably other future BMC SoC's
Still, you suggest using the phandle property in the driver even if
the driver serves one SoC?
>
> Best regards,
> Krzysztof

Best regards,

Tomer

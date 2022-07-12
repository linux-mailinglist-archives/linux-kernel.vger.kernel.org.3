Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD415718AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiGLLfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiGLLfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:35:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAABAB7C9;
        Tue, 12 Jul 2022 04:35:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o7so13426157lfq.9;
        Tue, 12 Jul 2022 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAogKIT73o6WsGNfWbcRAMtgA4sSrigPm6Y2Wj+ZIcw=;
        b=qSZV1HITDQyra3oc8/Oct9IzQ3sM8J+s9EtxXRlZ/MQIe5FVJxIrUL14RFtKJwwhqH
         M+oPvCc14LE/E+dTXMIe5VNJUrWornG2dgBWYqkTgZrlC0/RPnGYJJLxEpdoMfx1Og8/
         YBmVAp9iRPVjrqWSHnQxw6klk70DohWWLKOxd72zv9XfYobIbk7wmVMC2qQCqPeDFg1R
         hVJLMG6PEO4Ksd626xiB1Gs2GZ9SeFienidPedvCIj/y3ldJPkI04wQ6duxbwvgKjHFt
         dXPcMHCWi9reAIB141hZFIkaYYovI9Y8ycx4lLB/eJVp/x02Njt2O8TbMivWRn/x2Dwc
         NRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAogKIT73o6WsGNfWbcRAMtgA4sSrigPm6Y2Wj+ZIcw=;
        b=6hCi2XF3Y8Msi8slD1k70TAA2q2wUV5BtwE9tUMbJJyMLC9CatTzATIVdwRwqStpna
         6+TXBfHOzcUVNAMc8sxXN4ZCrHJdrVcQ+vLjYlwMGBab7hWvDaKS3D0CDAyB01sQDpfP
         1NVgOJ22PXlv/yOXxm2JIsjxStTphBsSkSZRdV0QlUw/buLVlufYbV5Hr6tL1o2rtN1D
         LjYzCdsZmgUb2aaDZvhw5YInDmQPVBdV9X71IBBZ9oEC0RsUs/b1r/rycMVtpx7gjWne
         NNcM54vhYOqeRf2tqnlg3RMnbwNzNPCok4dGbYdN0mp86u27bk3lzazg85/fTqDQoWwD
         HpUA==
X-Gm-Message-State: AJIora+FhoFw5H+RORob4lImpB07Xu3A7cLEC20E98W5SYg8LrSYkCUf
        3/z/rl9pyzWPu1XrEslqUdsi45byQ5yBi8Ho2O0=
X-Google-Smtp-Source: AGRyM1u25zmSsKgmzNKlKp3f5zvdI6W3e74UTp2OHlKEAXvvMqdmUpMqS1A3mQZX0T2H0c71x9pVprhZe5mBHdElQZg=
X-Received: by 2002:a05:6512:3f84:b0:489:3345:c459 with SMTP id
 x4-20020a0565123f8400b004893345c459mr14908703lfa.576.1657625704786; Tue, 12
 Jul 2022 04:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220710102110.39748-1-tmaimon77@gmail.com> <20220710102110.39748-3-tmaimon77@gmail.com>
 <95d12b72-be9d-5503-c4ea-801303bb7776@linaro.org>
In-Reply-To: <95d12b72-be9d-5503-c4ea-801303bb7776@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 12 Jul 2022 14:34:53 +0300
Message-ID: <CAP6Zq1h=JjODnmPjwwEbrThGU8kQOX08Z1NipaJx_Gcwg1s1FQ@mail.gmail.com>
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

HI Krzysztof,

Thanks for your comment, they will be addressed next version,

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

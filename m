Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F8457036A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiGKMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiGKMzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:55:23 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CD127FED;
        Mon, 11 Jul 2022 05:55:22 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id r12so273427qvm.3;
        Mon, 11 Jul 2022 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCEF/oXLtompCSo0q/JDXFQDLmqqQqZLZNzkV+0cmDI=;
        b=UWEXMZk3VG/URLle64kq60e7GWp3vFjuL64eT4J9E5C0aDolIuUf9gz8DC9pOI1dlX
         H3nhVV68Y0jgBOBdy7Bu46kE28Bh391JxYr/13tRHNP5hvNlCx4vczBrc+8qK+Ssj62t
         3t6dKtSqorLhsc3/z73wJKuBs0/nOlSM+TS8Tesm9RlpRT8X0RO+6w4ndsoR6WW2Tnj3
         q7UOaKzQXnE4W1pTQlkHrl8VL67wNsQ8aVwhogG7nPugA6M9fzsi5DNIuZO7quqecWEX
         iqeuON/N0HD/Vy0anOB3RmClYXLNfTL+TPOjBhh2y0SxGfR9TOehhwA7rkaVnzo9PORc
         xHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCEF/oXLtompCSo0q/JDXFQDLmqqQqZLZNzkV+0cmDI=;
        b=yYrRhL7HJhxUXy+vDyezKyHL6F6XcwCK489YMK4o7762ADkeUsj3m3XjKoFgGdK5Mv
         1JdVJR4Ggm/BkUlyE0Veg25SLRgT9ebgEAC/77yQACGX30MCcOgbBZzy1WWdmE3Blmk6
         Kx5I4rlKYyDTpdgQyOe+nRtk7tzP6jn6zvl/CE+TqVnTiwynoBqgCgscqyfK79+6VW/E
         7P2yKtN0KEQyeABf01bUIZf7Ygg1i0Nna67hoO1/TtQX0MJqg42JNLDzZWkie4VTKYuq
         vOC1j5i7KIfoXzxjpYritIK3jsJLIuIcW78ujR1DFMkGuT6DiJSRVfnKIugv5eV8G+sH
         wZUQ==
X-Gm-Message-State: AJIora/A5VOhj0ogEk9p8HJSghJ4XKW+KmPVXsrUvprwrDhCgLnRXfZZ
        zPHrk6NrPPO9MGg6Nh664zt20dZ18E2qfw6dfdM=
X-Google-Smtp-Source: AGRyM1uiBRBw8mvvpHhebATGoygOk5tYokyzAf+y43ARJXuXHSNib5B5xEwP9RlqJTxa/ykcZoiwSncF4nZyypMwCAw=
X-Received: by 2002:a0c:e50f:0:b0:472:faa6:98e0 with SMTP id
 l15-20020a0ce50f000000b00472faa698e0mr13043974qvm.50.1657544122173; Mon, 11
 Jul 2022 05:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220711104719.40939-1-robimarko@gmail.com> <20220711104719.40939-6-robimarko@gmail.com>
 <CAA8EJppAdwuXQsvvy9+hT_-mzke5xOaDcTSM5ewjS_cPk3Q+oA@mail.gmail.com>
In-Reply-To: <CAA8EJppAdwuXQsvvy9+hT_-mzke5xOaDcTSM5ewjS_cPk3Q+oA@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 11 Jul 2022 14:55:11 +0200
Message-ID: <CAOX2RU6FMyzGGpnLtzRy=szjBSE+wcvbs+6z6ChZ5Z6g4-9Baw@mail.gmail.com>
Subject: Re: [PATCH 6/6] clk: qcom: apss-ipq-pll: add support for IPQ8074
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, 11 Jul 2022 at 14:51, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 11 Jul 2022 at 14:22, Robert Marko <robimarko@gmail.com> wrote:
> >
> > Add support for IPQ8074 since it uses the same PLL setup, however it does
> > not require the Alpha PLL to be reconfigured.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/clk/qcom/apss-ipq-pll.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> > index bef7899ad0d6..acfb3ec4f142 100644
> > --- a/drivers/clk/qcom/apss-ipq-pll.c
> > +++ b/drivers/clk/qcom/apss-ipq-pll.c
> > @@ -55,6 +55,7 @@ static const struct regmap_config ipq_pll_regmap_config = {
> >  static int apss_ipq_pll_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> > +       struct device_node *node = dev->of_node;
> >         struct regmap *regmap;
> >         void __iomem *base;
> >         int ret;
> > @@ -67,7 +68,8 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
> >         if (IS_ERR(regmap))
> >                 return PTR_ERR(regmap);
> >
> > -       clk_alpha_pll_configure(&ipq_pll, regmap, &ipq_pll_config);
> > +       if (of_device_is_compatible(node, "qcom,ipq6018-a53pll"))
> > +               clk_alpha_pll_configure(&ipq_pll, regmap, &ipq_pll_config);
>
> I'd suggest having the 8074 config here too. It seems logical to me to
> make sure that the pll is configured correctly.

Hi,

I have reworked the driver to use match data so it can be easily provided,
However, I dont have it as the downstream QCA kernel does not
reconfigure the PLL, unlike IPQ6018.
I can probably read the registers from a running board and provide that?

Regards,
Robert
>
> >
> >         ret = devm_clk_register_regmap(dev, &ipq_pll.clkr);
> >         if (ret)
> > @@ -79,6 +81,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
> >
> >  static const struct of_device_id apss_ipq_pll_match_table[] = {
> >         { .compatible = "qcom,ipq6018-a53pll" },
> > +       { .compatible = "qcom,ipq8074-a53pll" },
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
> > --
> > 2.36.1
> >
>
>
> --
> With best wishes
> Dmitry

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E54C8662
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiCAIXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiCAIXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:23:18 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1448021AC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:22:37 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j9-20020a9d7d89000000b005ad5525ba09so11567766otn.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tosKASypLvVXrNr25i9iVdhZeYDT2gXwfp+eHTQoEEc=;
        b=q7IePSd4ZDSr0rC4WaQs2Hck81KsTkOAuEkmg5frbLPNtN1TTPLDw/H8Soa5pgoLaE
         v/JgEr6qOQlPpKQi+w+ayfXsksZm1suQ83beh/Kl0E5clZouPyyi+pLNcD8uWfFfc7lF
         mxb8FDo5WuKX5JfGVkgqcS+smWNAS/fraJZ47zfgjfH2nA5sjpVQpW14+xvOkynO5fHe
         epIWggk+xHt/AKTVqrVuKAQ2ihuaqYt6H8W1/bZQsmhM9nU0TvTqKlhE6X6RxfOKBX8C
         qmtVBoeh+1NfS9uGnBIzwrW87uBmO94rs5s24d7ny0n+h7eqT8udkU9eV7AIyIqYVWOz
         4KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tosKASypLvVXrNr25i9iVdhZeYDT2gXwfp+eHTQoEEc=;
        b=IJLxAEzrviMkerz1ab2aQoSXFZ5/GVtWnvYocuRnWwPm/WVvqLkm7y/rdWTM+v4MVA
         Vs9ofNZa3v3mZiSQO9bVJvH66u9G8zU/w3NVKRqVYKajGhTScQR9E2ouOW1aKdyOXS1Z
         9IRxVcfUQzdXg/UEcyRj7YD6Qi/dVDF0DqjpPvcOHUkd9Ckb/MMboQ57/ayk5YZ6BiuV
         rKJbbdoM9TirhMl+Ai2NibLpM2zh89PEN5ngDKc5xpszUrLYcjtYSsB1afw604lUZMbZ
         f4YLdbcQShjzV9lPNz7eBD3hYsmNCV+Q1+GmA17scVI9dBcM5ehhANcqJ20DPqY1b9RP
         oWiA==
X-Gm-Message-State: AOAM531oYLOvE8vhzHr6E2xPXv73+2uCOBL/VVzRyO3R9uFigX3dZuu+
        B8TmP+dikHKQXGHAN4ZWIZWOg7K9FmMDVPXI94Of8g==
X-Google-Smtp-Source: ABdhPJySTn/ilMv7viVUZTUp94aI8GCiZqiF//jp/oGXCWlvdQoeAbndmnnwQeAkYwB9DYHC69sSdgfPNU5WpkzDfmQ=
X-Received: by 2002:a05:6830:314c:b0:5af:dc8a:d066 with SMTP id
 c12-20020a056830314c00b005afdc8ad066mr9037959ots.28.1646122956336; Tue, 01
 Mar 2022 00:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20220126221725.710167-1-bhupesh.sharma@linaro.org>
 <20220126221725.710167-8-bhupesh.sharma@linaro.org> <CAA8EJpqVP=E8GkO_BYBdPD6k84SDDD7cWduSf4yhG3M9VmbBLw@mail.gmail.com>
In-Reply-To: <CAA8EJpqVP=E8GkO_BYBdPD6k84SDDD7cWduSf4yhG3M9VmbBLw@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 1 Mar 2022 13:52:25 +0530
Message-ID: <CAH=2Ntw5m9zfb4xfySYx71QgdmJwkAgtQ8B1=jXu19GQ84b+rg@mail.gmail.com>
Subject: Re: [PATCH 7/8] clk: qcom: gcc-sm8150: use runtime PM for the clock controller
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, sboyd@kernel.org,
        tdas@codeaurora.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, bjorn.andersson@linaro.org,
        davem@davemloft.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Sorry for the late reply.

On Thu, 27 Jan 2022 at 04:04, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 27 Jan 2022 at 01:19, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> >
> > On sm8150 emac clk registers are powered up by the GDSC power
> > domain. Use runtime PM calls to make sure that required power domain is
> > powered on while we access clock controller's registers.
> >
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  drivers/clk/qcom/gcc-sm8150.c | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> > index ada755ad55f7..2e71afed81fd 100644
> > --- a/drivers/clk/qcom/gcc-sm8150.c
> > +++ b/drivers/clk/qcom/gcc-sm8150.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/bitops.h>
> >  #include <linux/err.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > @@ -3792,19 +3793,41 @@ static const struct of_device_id gcc_sm8150_match_table[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, gcc_sm8150_match_table);
> >
> > +static void gcc_sm8150_pm_runtime_disable(void *data)
> > +{
> > +       pm_runtime_disable(data);
> > +}
> > +
> >  static int gcc_sm8150_probe(struct platform_device *pdev)
> >  {
> >         struct regmap *regmap;
> > +       int ret;
> > +
> > +       pm_runtime_enable(&pdev->dev);
> > +
> > +       ret = devm_add_action_or_reset(&pdev->dev, gcc_sm8150_pm_runtime_disable, &pdev->dev);
> > +       if (ret)
> > +               return ret;
>
> Please use devm_pm_runtime_enable() instead.

Sure, I will fix it in v2.

Thanks,
Bhupesh

> > +
> > +       ret = pm_runtime_resume_and_get(&pdev->dev);
> > +       if (ret)
> > +               return ret;
> >
> >         regmap = qcom_cc_map(pdev, &gcc_sm8150_desc);
> > -       if (IS_ERR(regmap))
> > +       if (IS_ERR(regmap)) {
> > +               pm_runtime_put(&pdev->dev);
> >                 return PTR_ERR(regmap);
> > +       }
> >
> >         /* Disable the GPLL0 active input to NPU and GPU via MISC registers */
> >         regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
> >         regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
> >
> > -       return qcom_cc_really_probe(pdev, &gcc_sm8150_desc, regmap);
> > +       ret = qcom_cc_really_probe(pdev, &gcc_sm8150_desc, regmap);
> > +
> > +       pm_runtime_put(&pdev->dev);
> > +
> > +       return ret;
> >  }
> >
> >  static struct platform_driver gcc_sm8150_driver = {
> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry
